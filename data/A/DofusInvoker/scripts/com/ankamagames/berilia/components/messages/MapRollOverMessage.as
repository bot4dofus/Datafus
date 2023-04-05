package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class MapRollOverMessage extends ComponentMessage
   {
       
      
      private var _x:int;
      
      private var _y:int;
      
      public function MapRollOverMessage(target:InteractiveObject, x:int, y:int)
      {
         super(target);
         this._x = x;
         this._y = y;
      }
      
      public function get x() : int
      {
         return this._x;
      }
      
      public function get y() : int
      {
         return this._y;
      }
   }
}
