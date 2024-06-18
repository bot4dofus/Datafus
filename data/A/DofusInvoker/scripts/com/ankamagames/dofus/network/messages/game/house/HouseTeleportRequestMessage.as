package com.ankamagames.dofus.network.messages.game.house
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseTeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3189;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var houseInstanceId:uint = 0;
      
      public function HouseTeleportRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3189;
      }
      
      public function initHouseTeleportRequestMessage(houseId:uint = 0, houseInstanceId:uint = 0) : HouseTeleportRequestMessage
      {
         this.houseId = houseId;
         this.houseInstanceId = houseInstanceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.houseInstanceId = 0;
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
         this.serializeAs_HouseTeleportRequestMessage(output);
      }
      
      public function serializeAs_HouseTeleportRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.houseInstanceId < 0)
         {
            throw new Error("Forbidden value (" + this.houseInstanceId + ") on element houseInstanceId.");
         }
         output.writeInt(this.houseInstanceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseTeleportRequestMessage(input);
      }
      
      public function deserializeAs_HouseTeleportRequestMessage(input:ICustomDataInput) : void
      {
         this._houseIdFunc(input);
         this._houseInstanceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseTeleportRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseTeleportRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._houseInstanceIdFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseTeleportRequestMessage.houseId.");
         }
      }
      
      private function _houseInstanceIdFunc(input:ICustomDataInput) : void
      {
         this.houseInstanceId = input.readInt();
         if(this.houseInstanceId < 0)
         {
            throw new Error("Forbidden value (" + this.houseInstanceId + ") on element of HouseTeleportRequestMessage.houseInstanceId.");
         }
      }
   }
}
