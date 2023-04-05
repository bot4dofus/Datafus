package com.ankamagames.dofus.misc.utils.events
{
   import flash.events.Event;
   
   public class GameSessionReadyEvent extends Event
   {
      
      public static const READY:String = "com.ankamagames.dofus.misc.utils.events.GameSessionReadyEvent.READY";
       
      
      private var _gameSessionId:Number;
      
      public function GameSessionReadyEvent(gameSessionId:Number, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this._gameSessionId = gameSessionId;
         super(READY,bubbles,cancelable);
      }
      
      public function get gameSessionId() : Number
      {
         return this._gameSessionId;
      }
   }
}
