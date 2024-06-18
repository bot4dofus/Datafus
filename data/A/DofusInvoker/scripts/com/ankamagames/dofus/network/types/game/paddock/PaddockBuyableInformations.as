package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockBuyableInformations implements INetworkType
   {
      
      public static const protocolId:uint = 5612;
       
      
      public var price:Number = 0;
      
      public var locked:Boolean = false;
      
      public function PaddockBuyableInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5612;
      }
      
      public function initPaddockBuyableInformations(price:Number = 0, locked:Boolean = false) : PaddockBuyableInformations
      {
         this.price = price;
         this.locked = locked;
         return this;
      }
      
      public function reset() : void
      {
         this.price = 0;
         this.locked = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockBuyableInformations(output);
      }
      
      public function serializeAs_PaddockBuyableInformations(output:ICustomDataOutput) : void
      {
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
         output.writeBoolean(this.locked);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockBuyableInformations(input);
      }
      
      public function deserializeAs_PaddockBuyableInformations(input:ICustomDataInput) : void
      {
         this._priceFunc(input);
         this._lockedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockBuyableInformations(tree);
      }
      
      public function deserializeAsyncAs_PaddockBuyableInformations(tree:FuncTree) : void
      {
         tree.addChild(this._priceFunc);
         tree.addChild(this._lockedFunc);
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockBuyableInformations.price.");
         }
      }
      
      private function _lockedFunc(input:ICustomDataInput) : void
      {
         this.locked = input.readBoolean();
      }
   }
}
