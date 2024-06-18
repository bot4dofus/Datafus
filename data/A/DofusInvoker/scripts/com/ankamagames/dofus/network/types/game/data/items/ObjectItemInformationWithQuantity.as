package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemInformationWithQuantity extends ObjectItemMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8098;
       
      
      public var quantity:uint = 0;
      
      public function ObjectItemInformationWithQuantity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8098;
      }
      
      public function initObjectItemInformationWithQuantity(objectGID:uint = 0, effects:Vector.<ObjectEffect> = null, quantity:uint = 0) : ObjectItemInformationWithQuantity
      {
         super.initObjectItemMinimalInformation(objectGID,effects);
         this.quantity = quantity;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.quantity = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemInformationWithQuantity(output);
      }
      
      public function serializeAs_ObjectItemInformationWithQuantity(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectItemMinimalInformation(output);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemInformationWithQuantity(input);
      }
      
      public function deserializeAs_ObjectItemInformationWithQuantity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._quantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemInformationWithQuantity(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemInformationWithQuantity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemInformationWithQuantity.quantity.");
         }
      }
   }
}
