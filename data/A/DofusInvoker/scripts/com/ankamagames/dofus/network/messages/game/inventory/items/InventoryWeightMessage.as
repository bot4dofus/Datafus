package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InventoryWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9175;
       
      
      private var _isInitialized:Boolean = false;
      
      public var inventoryWeight:uint = 0;
      
      public var weightMax:uint = 0;
      
      public function InventoryWeightMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9175;
      }
      
      public function initInventoryWeightMessage(inventoryWeight:uint = 0, weightMax:uint = 0) : InventoryWeightMessage
      {
         this.inventoryWeight = inventoryWeight;
         this.weightMax = weightMax;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.inventoryWeight = 0;
         this.weightMax = 0;
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
         this.serializeAs_InventoryWeightMessage(output);
      }
      
      public function serializeAs_InventoryWeightMessage(output:ICustomDataOutput) : void
      {
         if(this.inventoryWeight < 0)
         {
            throw new Error("Forbidden value (" + this.inventoryWeight + ") on element inventoryWeight.");
         }
         output.writeVarInt(this.inventoryWeight);
         if(this.weightMax < 0)
         {
            throw new Error("Forbidden value (" + this.weightMax + ") on element weightMax.");
         }
         output.writeVarInt(this.weightMax);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InventoryWeightMessage(input);
      }
      
      public function deserializeAs_InventoryWeightMessage(input:ICustomDataInput) : void
      {
         this._inventoryWeightFunc(input);
         this._weightMaxFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InventoryWeightMessage(tree);
      }
      
      public function deserializeAsyncAs_InventoryWeightMessage(tree:FuncTree) : void
      {
         tree.addChild(this._inventoryWeightFunc);
         tree.addChild(this._weightMaxFunc);
      }
      
      private function _inventoryWeightFunc(input:ICustomDataInput) : void
      {
         this.inventoryWeight = input.readVarUhInt();
         if(this.inventoryWeight < 0)
         {
            throw new Error("Forbidden value (" + this.inventoryWeight + ") on element of InventoryWeightMessage.inventoryWeight.");
         }
      }
      
      private function _weightMaxFunc(input:ICustomDataInput) : void
      {
         this.weightMax = input.readVarUhInt();
         if(this.weightMax < 0)
         {
            throw new Error("Forbidden value (" + this.weightMax + ") on element of InventoryWeightMessage.weightMax.");
         }
      }
   }
}
