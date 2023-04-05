package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceLoaderProgressEvent extends ResourceEvent
   {
      
      public static const LOADER_PROGRESS:String = "loaderProgress";
      
      public static const LOADER_COMPLETE:String = "loaderComplete";
       
      
      public var uri:Uri;
      
      public var filesLoaded:uint;
      
      public var filesTotal:uint;
      
      public function ResourceLoaderProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         var re:ResourceLoaderProgressEvent = new ResourceLoaderProgressEvent(type,bubbles,cancelable);
         re.uri = this.uri;
         re.filesLoaded = this.filesLoaded;
         re.filesTotal = this.filesTotal;
         return re;
      }
   }
}
