package mx.managers
{
   import mx.core.Singleton;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class CursorManager
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const NO_CURSOR:int = 0;
      
      private static var implClassDependency:CursorManagerImpl;
      
      private static var _impl:ICursorManager;
       
      
      public function CursorManager()
      {
         super();
      }
      
      private static function get impl() : ICursorManager
      {
         if(!_impl)
         {
            _impl = ICursorManager(Singleton.getInstance("mx.managers::ICursorManager"));
         }
         return _impl;
      }
      
      public static function getInstance() : ICursorManager
      {
         return impl;
      }
      
      public static function get currentCursorID() : int
      {
         return impl.currentCursorID;
      }
      
      public static function set currentCursorID(value:int) : void
      {
         impl.currentCursorID = value;
      }
      
      public static function get currentCursorXOffset() : Number
      {
         return impl.currentCursorXOffset;
      }
      
      public static function set currentCursorXOffset(value:Number) : void
      {
         impl.currentCursorXOffset = value;
      }
      
      public static function get currentCursorYOffset() : Number
      {
         return impl.currentCursorYOffset;
      }
      
      public static function set currentCursorYOffset(value:Number) : void
      {
         impl.currentCursorYOffset = value;
      }
      
      public static function showCursor() : void
      {
         impl.showCursor();
      }
      
      public static function hideCursor() : void
      {
         impl.hideCursor();
      }
      
      public static function setCursor(cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0) : int
      {
         return impl.setCursor(cursorClass,priority,xOffset,yOffset);
      }
      
      public static function removeCursor(cursorID:int) : void
      {
         impl.removeCursor(cursorID);
      }
      
      public static function removeAllCursors() : void
      {
         impl.removeAllCursors();
      }
      
      public static function setBusyCursor() : void
      {
         impl.setBusyCursor();
      }
      
      public static function removeBusyCursor() : void
      {
         impl.removeBusyCursor();
      }
      
      mx_internal static function registerToUseBusyCursor(source:Object) : void
      {
         impl.registerToUseBusyCursor(source);
      }
      
      mx_internal static function unRegisterToUseBusyCursor(source:Object) : void
      {
         impl.unRegisterToUseBusyCursor(source);
      }
   }
}
