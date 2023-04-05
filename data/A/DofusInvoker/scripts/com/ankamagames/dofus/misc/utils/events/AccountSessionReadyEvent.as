package com.ankamagames.dofus.misc.utils.events
{
   import flash.events.Event;
   
   public class AccountSessionReadyEvent extends Event
   {
      
      public static const READY:String = "com.ankamagames.dofus.misc.utils.events.AccountSessionReadyEvent.READY";
       
      
      private var _accountSessionId:String;
      
      public function AccountSessionReadyEvent(accountSessionId:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this._accountSessionId = accountSessionId;
         super(READY,bubbles,cancelable);
      }
      
      public function get accountSessionId() : String
      {
         return this._accountSessionId;
      }
   }
}
