package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.edit.SelectionState;
   
   public class SelectionEvent extends Event
   {
      
      public static const SELECTION_CHANGE:String = "selectionChange";
       
      
      private var _selectionState:SelectionState;
      
      public function SelectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, selectionState:SelectionState = null)
      {
         this._selectionState = selectionState;
         super(type,bubbles,cancelable);
      }
      
      public function get selectionState() : SelectionState
      {
         return this._selectionState;
      }
      
      public function set selectionState(value:SelectionState) : void
      {
         this._selectionState = value;
      }
      
      override public function clone() : Event
      {
         return new SelectionEvent(type,bubbles,cancelable,this._selectionState);
      }
   }
}
