package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseGuildRightsViewMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9956;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public function HouseGuildRightsViewMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9956;
      }
      
      public function initHouseGuildRightsViewMessage(houseId:uint = 0, instanceId:uint = 0) : HouseGuildRightsViewMessage
      {
         this.houseId = houseId;
         this.instanceId = instanceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.instanceId = 0;
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
         this.serializeAs_HouseGuildRightsViewMessage(output);
      }
      
      public function serializeAs_HouseGuildRightsViewMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseGuildRightsViewMessage(input);
      }
      
      public function deserializeAs_HouseGuildRightsViewMessage(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseGuildRightsViewMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseGuildRightsViewMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildRightsViewMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseGuildRightsViewMessage.instanceId.");
         }
      }
   }
}
