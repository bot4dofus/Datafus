package com.ankamagames.jerakine.BalanceManager
{
   import com.ankamagames.jerakine.BalanceManager.events.BalanceEvent;
   import com.ankamagames.jerakine.BalanceManager.type.BalancedObject;
   
   public class BalanceManager
   {
       
      
      private var _balancedObjects:Vector.<BalancedObject>;
      
      private var _nbCall:uint = 0;
      
      public function BalanceManager(pItems:Array = null)
      {
         var item:Object = null;
         super();
         this.init();
         if(pItems != null)
         {
            for each(item in pItems)
            {
               this.addItem(item);
            }
         }
      }
      
      public function get nbCall() : uint
      {
         return this._nbCall;
      }
      
      public function getItemNbCall(pItem:Object) : int
      {
         var obt:BalancedObject = null;
         for each(obt in this._balancedObjects)
         {
            if(pItem == obt.item)
            {
               return obt.nbCall;
            }
         }
         return -1;
      }
      
      public function setItemBalance(pItem:Object, pNewBalance:uint) : void
      {
         var bo:BalancedObject = null;
         for each(bo in this._balancedObjects)
         {
            if(pItem == bo.item)
            {
               bo.nbCall = pNewBalance;
               return;
            }
         }
      }
      
      public function addItem(pItem:Object, pReset:Boolean = false) : void
      {
         this._balancedObjects.push(new BalancedObject(pItem));
         if(pReset)
         {
            this._nbCall = 0;
            this.resetBalance();
         }
         this.balanceItems();
      }
      
      public function addItemWithBalance(pItem:Object, pBalance:uint) : void
      {
         var newBO:BalancedObject = new BalancedObject(pItem);
         newBO.nbCall = pBalance;
         this._balancedObjects.push(newBO);
         this._nbCall += pBalance;
         this.balanceItems();
      }
      
      public function callItem() : Object
      {
         var objetEnCours:BalancedObject = null;
         var random:uint = Math.random() * 10000;
         var itemIndex:uint = 0;
         var objectToReturn:Object = null;
         if(this._balancedObjects.length == 0)
         {
            return objectToReturn;
         }
         objetEnCours = this._balancedObjects[0] as BalancedObject;
         if(random < objetEnCours.chanceToBeCall * 100)
         {
            objetEnCours.increment();
            objectToReturn = objetEnCours.item;
         }
         itemIndex++;
         for(var total:Number = objetEnCours.chanceToBeCall * 100; itemIndex < this._balancedObjects.length; )
         {
            objetEnCours = this._balancedObjects[itemIndex] as BalancedObject;
            if(objectToReturn == null)
            {
               if(this._balancedObjects.length == itemIndex + 1)
               {
                  objetEnCours.increment();
                  objectToReturn = objetEnCours.item;
               }
               else
               {
                  if(random > total && random < total + objetEnCours.chanceToBeCall * 100)
                  {
                     objetEnCours.increment();
                     objectToReturn = objetEnCours.item;
                  }
                  total += objetEnCours.chanceToBeCall * 100;
               }
            }
            itemIndex++;
         }
         ++this._nbCall;
         this.balanceItems();
         return objectToReturn;
      }
      
      public function removeItem(pItem:Object) : void
      {
         var bo:BalancedObject = null;
         for each(bo in this._balancedObjects)
         {
            if(bo.item == pItem)
            {
               this._balancedObjects.splice(this._balancedObjects.indexOf(bo),1);
            }
         }
         this.balanceItems();
      }
      
      public function reset() : void
      {
         var bo:BalancedObject = null;
         for each(bo in this._balancedObjects)
         {
            this.setItemBalance(bo.item,0);
         }
         this.balanceItems();
      }
      
      private function balanceItems() : void
      {
         var objectToCall:BalancedObject = null;
         var objectToCall2:BalancedObject = null;
         var temp:Number = NaN;
         var objectToCall3:BalancedObject = null;
         var objectToCall4:BalancedObject = null;
         if(this._nbCall == 0)
         {
            for each(objectToCall in this._balancedObjects)
            {
               objectToCall.chanceToBeCall = 1 / this._balancedObjects.length * 100;
            }
         }
         else
         {
            for each(objectToCall2 in this._balancedObjects)
            {
               objectToCall2.chanceToBeNonCall = (objectToCall2.nbCall + 1) / (this._nbCall + this._balancedObjects.length) * 100;
            }
            temp = 0;
            for each(objectToCall3 in this._balancedObjects)
            {
               temp += 1 / objectToCall3.chanceToBeNonCall;
            }
            for each(objectToCall4 in this._balancedObjects)
            {
               objectToCall4.chanceToBeCall = 1 / objectToCall4.chanceToBeNonCall / temp * 100;
            }
         }
      }
      
      private function init() : void
      {
         this._balancedObjects = new Vector.<BalancedObject>();
      }
      
      private function resetBalance() : void
      {
         var bo:BalancedObject = null;
         for each(bo in this._balancedObjects)
         {
            bo.nbCall = 0;
         }
      }
      
      private function onBalanceUpdate(pEvent:BalanceEvent) : void
      {
         this._nbCall += pEvent.newBalance - pEvent.previousBalance;
      }
   }
}
