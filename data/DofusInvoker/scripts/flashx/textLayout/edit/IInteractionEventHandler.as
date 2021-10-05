package flashx.textLayout.edit
{
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IMEEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public interface IInteractionEventHandler
   {
       
      
      function editHandler(param1:Event) : void;
      
      function keyDownHandler(param1:KeyboardEvent) : void;
      
      function keyUpHandler(param1:KeyboardEvent) : void;
      
      function keyFocusChangeHandler(param1:FocusEvent) : void;
      
      function textInputHandler(param1:TextEvent) : void;
      
      function imeStartCompositionHandler(param1:IMEEvent) : void;
      
      function softKeyboardActivatingHandler(param1:Event) : void;
      
      function mouseDownHandler(param1:MouseEvent) : void;
      
      function mouseMoveHandler(param1:MouseEvent) : void;
      
      function mouseUpHandler(param1:MouseEvent) : void;
      
      function mouseDoubleClickHandler(param1:MouseEvent) : void;
      
      function mouseOverHandler(param1:MouseEvent) : void;
      
      function mouseOutHandler(param1:MouseEvent) : void;
      
      function focusInHandler(param1:FocusEvent) : void;
      
      function focusOutHandler(param1:FocusEvent) : void;
      
      function activateHandler(param1:Event) : void;
      
      function deactivateHandler(param1:Event) : void;
      
      function focusChangeHandler(param1:FocusEvent) : void;
      
      function menuSelectHandler(param1:ContextMenuEvent) : void;
      
      function mouseWheelHandler(param1:MouseEvent) : void;
   }
}
