package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemGenericQuantity extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 8155;
       
      
      public var objectGID:uint = 0;
      
      public var quantity:uint = 0;
      
      public function ObjectItemGenericQuantity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8155;
      }
      
      public function initObjectItemGenericQuantity(objectGID:uint = 0, quantity:uint = 0) : ObjectItemGenericQuantity
      {
         this.objectGID = objectGID;
         this.quantity = quantity;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemGenericQuantity(output);
      }
      
      public function serializeAs_ObjectItemGenericQuantity(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemGenericQuantity(input);
      }
      
      public function deserializeAs_ObjectItemGenericQuantity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._objectGIDFunc(input);
         this._quantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemGenericQuantity(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemGenericQuantity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._objectGIDFunc);
         tree.addChild(this._quantityFunc);
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemGenericQuantity.objectGID.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemGenericQuantity.quantity.");
         }
      }
   }
}
