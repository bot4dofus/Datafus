package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.elements.TextFlow;
   
   public class DamageEvent extends Event
   {
      
      public static const DAMAGE:String = "damage";
       
      
      private var _textFlow:TextFlow;
      
      private var _damageAbsoluteStart:int;
      
      private var _damageLength:int;
      
      public function DamageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, textFlow:TextFlow = null, damageAbsoluteStart:int = 0, damageLength:int = 0)
      {
         this._textFlow = textFlow;
         this._damageAbsoluteStart = damageAbsoluteStart;
         this._damageLength = damageLength;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new DamageEvent(type,bubbles,cancelable,this._textFlow,this._damageAbsoluteStart,this._damageLength);
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function get damageAbsoluteStart() : int
      {
         return this._damageAbsoluteStart;
      }
      
      public function get damageLength() : int
      {
         return this._damageLength;
      }
   }
}
