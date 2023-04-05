package com.ankamagames.jerakine.lua
{
   import flash.events.Event;
   
   public class LuaPlayerEvent extends Event
   {
      
      public static const PLAY_SUCCESS:String = "LuaPlayerEvent.PLAY_SUCCESS";
      
      public static const PLAY_ERROR:String = "LuaPlayerEvent.PLAY_ERROR";
      
      public static const PLAY_COMPLETE:String = "LuaPlayerEvent.PLAY_COMPLETE";
       
      
      public var stackTrace:String;
      
      public function LuaPlayerEvent(pType:String, pBubbles:Boolean = false, pCancelable:Boolean = false)
      {
         super(pType,pBubbles,pCancelable);
      }
   }
}
