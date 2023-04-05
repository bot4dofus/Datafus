package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceErrorEvent extends ResourceEvent
   {
      
      public static const ERROR:String = "error";
       
      
      public var uri:Uri;
      
      public var errorMsg:String;
      
      public var errorCode:uint;
      
      public function ResourceErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var re:ResourceErrorEvent = new ResourceErrorEvent(type,bubbles,cancelable);
         re.uri = this.uri;
         re.errorMsg = this.errorMsg;
         re.errorCode = this.errorCode;
         return re;
      }
   }
}
