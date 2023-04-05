package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceProgressEvent extends ResourceEvent
   {
      
      public static const PROGRESS:String = "progress";
       
      
      public var uri:Uri;
      
      public var bytesLoaded:uint;
      
      public var bytesTotal:uint;
      
      public function ResourceProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var re:ResourceProgressEvent = new ResourceProgressEvent(type,bubbles,cancelable);
         re.uri = this.uri;
         re.bytesLoaded = this.bytesLoaded;
         re.bytesTotal = this.bytesTotal;
         return re;
      }
   }
}
