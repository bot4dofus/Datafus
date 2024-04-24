package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectUseMultipleMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2700;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quantity:uint = 0;
      
      public function ObjectUseMultipleMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2700;
      }
      
      public function initObjectUseMultipleMessage(objectUID:uint = 0, quantity:uint = 0) : ObjectUseMultipleMessage
      {
         super.initObjectUseMessage(objectUID);
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.quantity = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectUseMultipleMessage(output);
      }
      
      public function serializeAs_ObjectUseMultipleMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectUseMessage(output);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectUseMultipleMessage(input);
      }
      
      public function deserializeAs_ObjectUseMultipleMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._quantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectUseMultipleMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectUseMultipleMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectUseMultipleMessage.quantity.");
         }
      }
   }
}
