package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.elements.TextFlow;
   
   public class CompositionCompleteEvent extends Event
   {
      
      public static const COMPOSITION_COMPLETE:String = "compositionComplete";
       
      
      private var _compositionStart:int;
      
      private var _compositionLength:int;
      
      private var _textFlow:TextFlow;
      
      public function CompositionCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, textFlow:TextFlow = null, compositionStart:int = 0, compositionLength:int = 0)
      {
         this._compositionStart = compositionStart;
         this._compositionLength = compositionLength;
         this._textFlow = textFlow;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new CompositionCompleteEvent(type,bubbles,cancelable,this.textFlow,this.compositionStart,this.compositionLength);
      }
      
      public function get compositionStart() : int
      {
         return this._compositionStart;
      }
      
      public function set compositionStart(value:int) : void
      {
         this._compositionStart = value;
      }
      
      public function get compositionLength() : int
      {
         return this._compositionLength;
      }
      
      public function set compositionLength(value:int) : void
      {
         this._compositionLength = value;
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
