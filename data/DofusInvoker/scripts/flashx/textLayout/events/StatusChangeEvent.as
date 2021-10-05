package flashx.textLayout.events
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flashx.textLayout.elements.FlowElement;
   
   public class StatusChangeEvent extends Event
   {
      
      public static const INLINE_GRAPHIC_STATUS_CHANGE:String = "inlineGraphicStatusChange";
       
      
      private var _element:FlowElement;
      
      private var _status:String;
      
      private var _errorEvent:ErrorEvent;
      
      public function StatusChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, element:FlowElement = null, status:String = null, errorEvent:ErrorEvent = null)
      {
         this._element = element;
         this._status = status;
         this._errorEvent = errorEvent;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new StatusChangeEvent(type,bubbles,cancelable,this._element,this._status,this._errorEvent);
      }
      
      public function get element() : FlowElement
      {
         return this._element;
      }
      
      public function set element(value:FlowElement) : void
      {
         this._element = value;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(value:String) : void
      {
         this._status = value;
      }
      
      public function get errorEvent() : ErrorEvent
      {
         return this._errorEvent;
      }
      
      public function set errorEvent(value:ErrorEvent) : void
      {
         this._errorEvent = value;
      }
   }
}
