package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObtainedItemWithBonusMessage extends ObtainedItemMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7133;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bonusQuantity:uint = 0;
      
      public function ObtainedItemWithBonusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7133;
      }
      
      public function initObtainedItemWithBonusMessage(genericId:uint = 0, baseQuantity:uint = 0, bonusQuantity:uint = 0) : ObtainedItemWithBonusMessage
      {
         super.initObtainedItemMessage(genericId,baseQuantity);
         this.bonusQuantity = bonusQuantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.bonusQuantity = 0;
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
         this.serializeAs_ObtainedItemWithBonusMessage(output);
      }
      
      public function serializeAs_ObtainedItemWithBonusMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObtainedItemMessage(output);
         if(this.bonusQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.bonusQuantity + ") on element bonusQuantity.");
         }
         output.writeVarInt(this.bonusQuantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObtainedItemWithBonusMessage(input);
      }
      
      public function deserializeAs_ObtainedItemWithBonusMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._bonusQuantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObtainedItemWithBonusMessage(tree);
      }
      
      public function deserializeAsyncAs_ObtainedItemWithBonusMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._bonusQuantityFunc);
      }
      
      private function _bonusQuantityFunc(input:ICustomDataInput) : void
      {
         this.bonusQuantity = input.readVarUhInt();
         if(this.bonusQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.bonusQuantity + ") on element of ObtainedItemWithBonusMessage.bonusQuantity.");
         }
      }
   }
}
