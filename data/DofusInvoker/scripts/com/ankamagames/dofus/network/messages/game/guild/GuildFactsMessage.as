package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalGuildPublicInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFactsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1819;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infos:GuildFactSheetInformations;
      
      public var creationDate:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var members:Vector.<CharacterMinimalGuildPublicInformations>;
      
      private var _infostree:FuncTree;
      
      private var _memberstree:FuncTree;
      
      public function GuildFactsMessage()
      {
         this.infos = new GuildFactSheetInformations();
         this.members = new Vector.<CharacterMinimalGuildPublicInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1819;
      }
      
      public function initGuildFactsMessage(infos:GuildFactSheetInformations = null, creationDate:uint = 0, nbTaxCollectors:uint = 0, members:Vector.<CharacterMinimalGuildPublicInformations> = null) : GuildFactsMessage
      {
         this.infos = infos;
         this.creationDate = creationDate;
         this.nbTaxCollectors = nbTaxCollectors;
         this.members = members;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new GuildFactSheetInformations();
         this.nbTaxCollectors = 0;
         this.members = new Vector.<CharacterMinimalGuildPublicInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildFactsMessage(output);
      }
      
      public function serializeAs_GuildFactsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeInt(this.creationDate);
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
         }
         output.writeVarShort(this.nbTaxCollectors);
         output.writeShort(this.members.length);
         for(var _i4:uint = 0; _i4 < this.members.length; _i4++)
         {
            (this.members[_i4] as CharacterMinimalGuildPublicInformations).serializeAs_CharacterMinimalGuildPublicInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFactsMessage(input);
      }
      
      public function deserializeAs_GuildFactsMessage(input:ICustomDataInput) : void
      {
         var _item4:CharacterMinimalGuildPublicInformations = null;
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(GuildFactSheetInformations,_id1);
         this.infos.deserialize(input);
         this._creationDateFunc(input);
         this._nbTaxCollectorsFunc(input);
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _membersLen; _i4++)
         {
            _item4 = new CharacterMinimalGuildPublicInformations();
            _item4.deserialize(input);
            this.members.push(_item4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFactsMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFactsMessage(tree:FuncTree) : void
      {
         this._infostree = tree.addChild(this._infostreeFunc);
         tree.addChild(this._creationDateFunc);
         tree.addChild(this._nbTaxCollectorsFunc);
         this._memberstree = tree.addChild(this._memberstreeFunc);
      }
      
      private function _infostreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(GuildFactSheetInformations,_id);
         this.infos.deserializeAsync(this._infostree);
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildFactsMessage.creationDate.");
         }
      }
      
      private function _nbTaxCollectorsFunc(input:ICustomDataInput) : void
      {
         this.nbTaxCollectors = input.readVarUhShort();
         if(this.nbTaxCollectors < 0)
         {
            throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildFactsMessage.nbTaxCollectors.");
         }
      }
      
      private function _memberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._memberstree.addChild(this._membersFunc);
         }
      }
      
      private function _membersFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterMinimalGuildPublicInformations = new CharacterMinimalGuildPublicInformations();
         _item.deserialize(input);
         this.members.push(_item);
      }
   }
}
