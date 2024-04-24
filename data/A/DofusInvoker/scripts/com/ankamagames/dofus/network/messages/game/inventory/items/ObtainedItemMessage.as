package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObtainedItemMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 426;
       
      
      private var _isInitialized:Boolean = false;
      
      public var genericId:uint = 0;
      
      public var baseQuantity:uint = 0;
      
      public function ObtainedItemMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 426;
      }
      
      public function initObtainedItemMessage(genericId:uint = 0, baseQuantity:uint = 0) : ObtainedItemMessage
      {
         this.genericId = genericId;
         this.baseQuantity = baseQuantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.genericId = 0;
         this.baseQuantity = 0;
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
         this.serializeAs_ObtainedItemMessage(output);
      }
      
      public function serializeAs_ObtainedItemMessage(output:ICustomDataOutput) : void
      {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         output.writeVarInt(this.genericId);
         if(this.baseQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.baseQuantity + ") on element baseQuantity.");
         }
         output.writeVarInt(this.baseQuantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObtainedItemMessage(input);
      }
      
      public function deserializeAs_ObtainedItemMessage(input:ICustomDataInput) : void
      {
         this._genericIdFunc(input);
         this._baseQuantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObtainedItemMessage(tree);
      }
      
      public function deserializeAsyncAs_ObtainedItemMessage(tree:FuncTree) : void
      {
         tree.addChild(this._genericIdFunc);
         tree.addChild(this._baseQuantityFunc);
      }
      
      private function _genericIdFunc(input:ICustomDataInput) : void
      {
         this.genericId = input.readVarUhInt();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ObtainedItemMessage.genericId.");
         }
      }
      
      private function _baseQuantityFunc(input:ICustomDataInput) : void
      {
         this.baseQuantity = input.readVarUhInt();
         if(this.baseQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.baseQuantity + ") on element of ObtainedItemMessage.baseQuantity.");
         }
      }
   }
}
