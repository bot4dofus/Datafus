package mx.managers
{
   [ExcludeClass]
   public interface ICursorManager
   {
       
      
      function get currentCursorID() : int;
      
      function set currentCursorID(param1:int) : void;
      
      function get currentCursorXOffset() : Number;
      
      function set currentCursorXOffset(param1:Number) : void;
      
      function get currentCursorYOffset() : Number;
      
      function set currentCursorYOffset(param1:Number) : void;
      
      function showCursor() : void;
      
      function hideCursor() : void;
      
      function setCursor(param1:Class, param2:int = 2, param3:Number = 0, param4:Number = 0) : int;
      
      function removeCursor(param1:int) : void;
      
      function removeAllCursors() : void;
      
      function setBusyCursor() : void;
      
      function removeBusyCursor() : void;
      
      function registerToUseBusyCursor(param1:Object) : void;
      
      function unRegisterToUseBusyCursor(param1:Object) : void;
   }
}
