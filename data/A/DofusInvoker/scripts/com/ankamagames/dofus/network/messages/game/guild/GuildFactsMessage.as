package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalSocialPublicInformations;
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
      
      public static const protocolId:uint = 1149;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infos:GuildFactSheetInformations;
      
      public var creationDate:uint = 0;
      
      public var members:Vector.<CharacterMinimalSocialPublicInformations>;
      
      private var _infostree:FuncTree;
      
      private var _memberstree:FuncTree;
      
      public function GuildFactsMessage()
      {
         this.infos = new GuildFactSheetInformations();
         this.members = new Vector.<CharacterMinimalSocialPublicInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1149;
      }
      
      public function initGuildFactsMessage(infos:GuildFactSheetInformations = null, creationDate:uint = 0, members:Vector.<CharacterMinimalSocialPublicInformations> = null) : GuildFactsMessage
      {
         this.infos = infos;
         this.creationDate = creationDate;
         this.members = members;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new GuildFactSheetInformations();
         this.members = new Vector.<CharacterMinimalSocialPublicInformations>();
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
         output.writeShort(this.members.length);
         for(var _i3:uint = 0; _i3 < this.members.length; _i3++)
         {
            (this.members[_i3] as CharacterMinimalSocialPublicInformations).serializeAs_CharacterMinimalSocialPublicInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFactsMessage(input);
      }
      
      public function deserializeAs_GuildFactsMessage(input:ICustomDataInput) : void
      {
         var _item3:CharacterMinimalSocialPublicInformations = null;
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(GuildFactSheetInformations,_id1);
         this.infos.deserialize(input);
         this._creationDateFunc(input);
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _membersLen; _i3++)
         {
            _item3 = new CharacterMinimalSocialPublicInformations();
            _item3.deserialize(input);
            this.members.push(_item3);
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
         var _item:CharacterMinimalSocialPublicInformations = new CharacterMinimalSocialPublicInformations();
         _item.deserialize(input);
         this.members.push(_item);
      }
   }
}
