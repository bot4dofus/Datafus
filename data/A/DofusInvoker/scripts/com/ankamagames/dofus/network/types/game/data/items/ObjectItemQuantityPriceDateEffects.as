package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemQuantityPriceDateEffects extends ObjectItemGenericQuantity implements INetworkType
   {
      
      public static const protocolId:uint = 8474;
       
      
      public var price:Number = 0;
      
      public var effects:ObjectEffects;
      
      public var date:uint = 0;
      
      private var _effectstree:FuncTree;
      
      public function ObjectItemQuantityPriceDateEffects()
      {
         this.effects = new ObjectEffects();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8474;
      }
      
      public function initObjectItemQuantityPriceDateEffects(objectGID:uint = 0, quantity:uint = 0, price:Number = 0, effects:ObjectEffects = null, date:uint = 0) : ObjectItemQuantityPriceDateEffects
      {
         super.initObjectItemGenericQuantity(objectGID,quantity);
         this.price = price;
         this.effects = effects;
         this.date = date;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.price = 0;
         this.effects = new ObjectEffects();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemQuantityPriceDateEffects(output);
      }
      
      public function serializeAs_ObjectItemQuantityPriceDateEffects(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectItemGenericQuantity(output);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
         this.effects.serializeAs_ObjectEffects(output);
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         output.writeInt(this.date);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemQuantityPriceDateEffects(input);
      }
      
      public function deserializeAs_ObjectItemQuantityPriceDateEffects(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._priceFunc(input);
         this.effects = new ObjectEffects();
         this.effects.deserialize(input);
         this._dateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemQuantityPriceDateEffects(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemQuantityPriceDateEffects(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._priceFunc);
         this._effectstree = tree.addChild(this._effectstreeFunc);
         tree.addChild(this._dateFunc);
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of ObjectItemQuantityPriceDateEffects.price.");
         }
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         this.effects = new ObjectEffects();
         this.effects.deserializeAsync(this._effectstree);
      }
      
      private function _dateFunc(input:ICustomDataInput) : void
      {
         this.date = input.readInt();
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element of ObjectItemQuantityPriceDateEffects.date.");
         }
      }
   }
}
