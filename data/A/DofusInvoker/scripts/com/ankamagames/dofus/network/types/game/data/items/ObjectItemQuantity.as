package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemQuantity extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 6363;
       
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      public function ObjectItemQuantity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6363;
      }
      
      public function initObjectItemQuantity(objectUID:uint = 0, quantity:uint = 0) : ObjectItemQuantity
      {
         this.objectUID = objectUID;
         this.quantity = quantity;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemQuantity(output);
      }
      
      public function serializeAs_ObjectItemQuantity(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemQuantity(input);
      }
      
      public function deserializeAs_ObjectItemQuantity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._objectUIDFunc(input);
         this._quantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemQuantity(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemQuantity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._quantityFunc);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemQuantity.objectUID.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemQuantity.quantity.");
         }
      }
   }
}
