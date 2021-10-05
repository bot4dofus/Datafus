package flashx.textLayout.events
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flashx.textLayout.elements.FlowElement;
   
   public class FlowElementMouseEvent extends Event
   {
      
      public static const MOUSE_DOWN:String = "mouseDown";
      
      public static const MOUSE_UP:String = "mouseUp";
      
      public static const MOUSE_MOVE:String = "mouseMove";
      
      public static const ROLL_OVER:String = "rollOver";
      
      public static const ROLL_OUT:String = "rollOut";
      
      public static const CLICK:String = "click";
       
      
      private var _flowElement:FlowElement;
      
      private var _originalEvent:MouseEvent;
      
      public function FlowElementMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, flowElement:FlowElement = null, originalEvent:MouseEvent = null)
      {
         super(type,bubbles,cancelable);
         this._flowElement = flowElement;
         this._originalEvent = originalEvent;
      }
      
      public function get flowElement() : FlowElement
      {
         return this._flowElement;
      }
      
      public function set flowElement(value:FlowElement) : void
      {
         this._flowElement = value;
      }
      
      public function get originalEvent() : MouseEvent
      {
         return this._originalEvent;
      }
      
      public function set originalEvent(value:MouseEvent) : void
      {
         this._originalEvent = value;
      }
      
      override public function clone() : Event
      {
         return new FlowElementMouseEvent(type,bubbles,cancelable,this.flowElement,this.originalEvent);
      }
   }
}
