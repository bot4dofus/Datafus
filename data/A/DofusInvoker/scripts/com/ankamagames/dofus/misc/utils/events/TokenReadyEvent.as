package com.ankamagames.dofus.misc.utils.events
{
   import flash.events.Event;
   
   public class TokenReadyEvent extends Event
   {
      
      public static const READY:String = "com.ankamagames.dofus.misc.utils.events.TokenReadyEvent.READY";
       
      
      private var _gameId:int;
      
      public function TokenReadyEvent(gameId:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this._gameId = gameId;
         super(READY,bubbles,cancelable);
      }
      
      public function get gameId() : int
      {
         return this._gameId;
      }
   }
}
