package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class HookEvent extends Event
   {
      
      public static const DISPATCHED:String = "hooDispatched";
       
      
      private var _hook:String;
      
      public function HookEvent(type:String, hook:String)
      {
         super(type,false,false);
         this._hook = hook;
      }
      
      public function get hook() : String
      {
         return this._hook;
      }
   }
}
