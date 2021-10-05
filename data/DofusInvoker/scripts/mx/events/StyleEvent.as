package mx.events
{
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class StyleEvent extends ProgressEvent
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const COMPLETE:String = "complete";
      
      public static const ERROR:String = "error";
      
      public static const PROGRESS:String = "progress";
       
      
      public var errorText:String;
      
      public function StyleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null)
      {
         super(type,bubbles,cancelable,bytesLoaded,bytesTotal);
         this.errorText = errorText;
      }
      
      override public function clone() : Event
      {
         return new StyleEvent(type,bubbles,cancelable,bytesLoaded,bytesTotal,this.errorText);
      }
   }
}
