package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFactsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5026;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infos:AllianceFactSheetInformations;
      
      public var guilds:Vector.<GuildInAllianceInformations>;
      
      public var controlledSubareaIds:Vector.<uint>;
      
      public var leaderCharacterId:Number = 0;
      
      public var leaderCharacterName:String = "";
      
      private var _infostree:FuncTree;
      
      private var _guildstree:FuncTree;
      
      private var _controlledSubareaIdstree:FuncTree;
      
      public function AllianceFactsMessage()
      {
         this.infos = new AllianceFactSheetInformations();
         this.guilds = new Vector.<GuildInAllianceInformations>();
         this.controlledSubareaIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5026;
      }
      
      public function initAllianceFactsMessage(infos:AllianceFactSheetInformations = null, guilds:Vector.<GuildInAllianceInformations> = null, controlledSubareaIds:Vector.<uint> = null, leaderCharacterId:Number = 0, leaderCharacterName:String = "") : AllianceFactsMessage
      {
         this.infos = infos;
         this.guilds = guilds;
         this.controlledSubareaIds = controlledSubareaIds;
         this.leaderCharacterId = leaderCharacterId;
         this.leaderCharacterName = leaderCharacterName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new AllianceFactSheetInformations();
         this.controlledSubareaIds = new Vector.<uint>();
         this.leaderCharacterId = 0;
         this.leaderCharacterName = "";
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
         this.serializeAs_AllianceFactsMessage(output);
      }
      
      public function serializeAs_AllianceFactsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
         output.writeShort(this.guilds.length);
         for(var _i2:uint = 0; _i2 < this.guilds.length; _i2++)
         {
            (this.guilds[_i2] as GuildInAllianceInformations).serializeAs_GuildInAllianceInformations(output);
         }
         output.writeShort(this.controlledSubareaIds.length);
         for(var _i3:uint = 0; _i3 < this.controlledSubareaIds.length; _i3++)
         {
            if(this.controlledSubareaIds[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.controlledSubareaIds[_i3] + ") on element 3 (starting at 1) of controlledSubareaIds.");
            }
            output.writeVarShort(this.controlledSubareaIds[_i3]);
         }
         if(this.leaderCharacterId < 0 || this.leaderCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderCharacterId + ") on element leaderCharacterId.");
         }
         output.writeVarLong(this.leaderCharacterId);
         output.writeUTF(this.leaderCharacterName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFactsMessage(input);
      }
      
      public function deserializeAs_AllianceFactsMessage(input:ICustomDataInput) : void
      {
         var _item2:GuildInAllianceInformations = null;
         var _val3:uint = 0;
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(AllianceFactSheetInformations,_id1);
         this.infos.deserialize(input);
         var _guildsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _guildsLen; _i2++)
         {
            _item2 = new GuildInAllianceInformations();
            _item2.deserialize(input);
            this.guilds.push(_item2);
         }
         var _controlledSubareaIdsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _controlledSubareaIdsLen; _i3++)
         {
            _val3 = input.readVarUhShort();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of controlledSubareaIds.");
            }
            this.controlledSubareaIds.push(_val3);
         }
         this._leaderCharacterIdFunc(input);
         this._leaderCharacterNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFactsMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFactsMessage(tree:FuncTree) : void
      {
         this._infostree = tree.addChild(this._infostreeFunc);
         this._guildstree = tree.addChild(this._guildstreeFunc);
         this._controlledSubareaIdstree = tree.addChild(this._controlledSubareaIdstreeFunc);
         tree.addChild(this._leaderCharacterIdFunc);
         tree.addChild(this._leaderCharacterNameFunc);
      }
      
      private function _infostreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(AllianceFactSheetInformations,_id);
         this.infos.deserializeAsync(this._infostree);
      }
      
      private function _guildstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._guildstree.addChild(this._guildsFunc);
         }
      }
      
      private function _guildsFunc(input:ICustomDataInput) : void
      {
         var _item:GuildInAllianceInformations = new GuildInAllianceInformations();
         _item.deserialize(input);
         this.guilds.push(_item);
      }
      
      private function _controlledSubareaIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._controlledSubareaIdstree.addChild(this._controlledSubareaIdsFunc);
         }
      }
      
      private function _controlledSubareaIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of controlledSubareaIds.");
         }
         this.controlledSubareaIds.push(_val);
      }
      
      private function _leaderCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.leaderCharacterId = input.readVarUhLong();
         if(this.leaderCharacterId < 0 || this.leaderCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderCharacterId + ") on element of AllianceFactsMessage.leaderCharacterId.");
         }
      }
      
      private function _leaderCharacterNameFunc(input:ICustomDataInput) : void
      {
         this.leaderCharacterName = input.readUTF();
      }
   }
}
