package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemToSellInNpcShop extends ObjectItemMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5301;
       
      
      public var objectPrice:Number = 0;
      
      public var buyCriterion:String = "";
      
      public function ObjectItemToSellInNpcShop()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5301;
      }
      
      public function initObjectItemToSellInNpcShop(objectGID:uint = 0, effects:Vector.<ObjectEffect> = null, objectPrice:Number = 0, buyCriterion:String = "") : ObjectItemToSellInNpcShop
      {
         super.initObjectItemMinimalInformation(objectGID,effects);
         this.objectPrice = objectPrice;
         this.buyCriterion = buyCriterion;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objectPrice = 0;
         this.buyCriterion = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemToSellInNpcShop(output);
      }
      
      public function serializeAs_ObjectItemToSellInNpcShop(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectItemMinimalInformation(output);
         if(this.objectPrice < 0 || this.objectPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
         }
         output.writeVarLong(this.objectPrice);
         output.writeUTF(this.buyCriterion);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemToSellInNpcShop(input);
      }
      
      public function deserializeAs_ObjectItemToSellInNpcShop(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._objectPriceFunc(input);
         this._buyCriterionFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemToSellInNpcShop(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemToSellInNpcShop(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._objectPriceFunc);
         tree.addChild(this._buyCriterionFunc);
      }
      
      private function _objectPriceFunc(input:ICustomDataInput) : void
      {
         this.objectPrice = input.readVarUhLong();
         if(this.objectPrice < 0 || this.objectPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInNpcShop.objectPrice.");
         }
      }
      
      private function _buyCriterionFunc(input:ICustomDataInput) : void
      {
         this.buyCriterion = input.readUTF();
      }
   }
}
