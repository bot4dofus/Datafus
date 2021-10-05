package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.TextFlow;
   
   public class UpdateCompleteEvent extends Event
   {
      
      public static const UPDATE_COMPLETE:String = "updateComplete";
       
      
      private var _controller:ContainerController;
      
      private var _textFlow:TextFlow;
      
      public function UpdateCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, textFlow:TextFlow = null, controller:ContainerController = null)
      {
         super(type,bubbles,cancelable);
         this.controller = controller;
         this._textFlow = textFlow;
      }
      
      override public function clone() : Event
      {
         return new UpdateCompleteEvent(type,bubbles,cancelable,this._textFlow,this._controller);
      }
      
      public function get controller() : ContainerController
      {
         return this._controller;
      }
      
      public function set controller(c:ContainerController) : void
      {
         this._controller = c;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         this._textFlow = value;
      }
   }
}
