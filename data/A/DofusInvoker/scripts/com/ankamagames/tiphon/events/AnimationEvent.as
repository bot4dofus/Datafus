package com.ankamagames.tiphon.events
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const EVENT:String = "animationEventEvent";
      
      public static const ANIM:String = "animationAnimEvent";
       
      
      private var _id:String;
      
      public function AnimationEvent(type:String, pId:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._id = pId;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      override public function clone() : Event
      {
         return new AnimationEvent(type,this.id,bubbles,cancelable);
      }
   }
}
