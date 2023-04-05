package com.ankamagames.jerakine.BalanceManager.type
{
   import com.ankamagames.jerakine.BalanceManager.events.BalanceEvent;
   import flash.events.EventDispatcher;
   
   public class BalancedObject extends EventDispatcher
   {
       
      
      public var item:Object;
      
      private var _nbCall:uint;
      
      public var chanceToBeNonCall:Number;
      
      public var chanceToBeCall:Number;
      
      public function BalancedObject(pItem:Object)
      {
         super();
         this.item = pItem;
         this.nbCall = 0;
      }
      
      public function increment() : uint
      {
         this.nbCall = this._nbCall + 1;
         return this._nbCall;
      }
      
      public function set nbCall(pNbCall:uint) : void
      {
         var previousNbCall:uint = this._nbCall;
         this._nbCall = pNbCall;
         var be:BalanceEvent = new BalanceEvent(BalanceEvent.BALANCE_UPDATE);
         be.previousBalance = previousNbCall;
         be.newBalance = this._nbCall;
         be.item = this.item;
         dispatchEvent(be);
      }
      
      public function get nbCall() : uint
      {
         return this._nbCall;
      }
   }
}
