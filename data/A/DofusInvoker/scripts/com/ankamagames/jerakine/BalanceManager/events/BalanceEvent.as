package com.ankamagames.jerakine.BalanceManager.events
{
   import flash.events.Event;
   
   public class BalanceEvent extends Event
   {
      
      public static const BALANCE_UPDATE:String = "balance_update";
       
      
      public var item:Object;
      
      public var newBalance:uint;
      
      public var previousBalance:uint;
      
      public function BalanceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
