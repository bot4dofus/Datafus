package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class SandboxMouseEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const CLICK_SOMEWHERE:String = "clickSomewhere";
      
      public static const DOUBLE_CLICK_SOMEWHERE:String = "doubleClickSomewhere";
      
      public static const MOUSE_DOWN_SOMEWHERE:String = "mouseDownSomewhere";
      
      public static const MOUSE_MOVE_SOMEWHERE:String = "mouseMoveSomewhere";
      
      public static const MOUSE_UP_SOMEWHERE:String = "mouseUpSomewhere";
      
      public static const MOUSE_WHEEL_SOMEWHERE:String = "mouseWheelSomewhere";
       
      
      public var altKey:Boolean;
      
      public var buttonDown:Boolean;
      
      public var ctrlKey:Boolean;
      
      public var shiftKey:Boolean;
      
      public function SandboxMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.ctrlKey = ctrlKey;
         this.altKey = altKey;
         this.shiftKey = shiftKey;
         this.buttonDown = buttonDown;
      }
      
      public static function marshal(event:Event) : SandboxMouseEvent
      {
         var eventObj:Object = event;
         return new SandboxMouseEvent(eventObj.type,eventObj.bubbles,eventObj.cancelable,eventObj.ctrlKey,eventObj.altKey,eventObj.shiftKey,eventObj.buttonDown);
      }
      
      override public function clone() : Event
      {
         return new SandboxMouseEvent(type,bubbles,cancelable,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown);
      }
   }
}
