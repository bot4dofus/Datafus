package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseGuildRightsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8722;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var guildInfo:GuildInformations;
      
      public var rights:uint = 0;
      
      private var _guildInfotree:FuncTree;
      
      public function HouseGuildRightsMessage()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8722;
      }
      
      public function initHouseGuildRightsMessage(houseId:uint = 0, instanceId:uint = 0, secondHand:Boolean = false, guildInfo:GuildInformations = null, rights:uint = 0) : HouseGuildRightsMessage
      {
         this.houseId = houseId;
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.guildInfo = guildInfo;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.instanceId = 0;
         this.secondHand = false;
         this.guildInfo = new GuildInformations();
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
         this.serializeAs_HouseGuildRightsMessage(output);
      }
      
      public function serializeAs_HouseGuildRightsMessage(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.secondHand);
         this.guildInfo.serializeAs_GuildInformations(output);
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         output.writeVarInt(this.rights);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildRightsMessage(input);
      }
      
      public function deserializeAs_HouseGuildRightsMessage(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
         this._secondHandFunc(input);
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
         this._rightsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseGuildRightsMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseGuildRightsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._secondHandFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
         tree.addChild(this._rightsFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildRightsMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseGuildRightsMessage.instanceId.");
         }
      }
      
      private function _secondHandFunc(input:ICustomDataInput) : void
      {
         this.secondHand = input.readBoolean();
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         this.rights = input.readVarUhInt();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildRightsMessage.rights.");
         }
      }
   }
}
