package com.ankamagames.atouin.utils
{
   import com.ankamagames.atouin.AtouinConstants;
   import flash.geom.Point;
   
   public class CellIdConverter
   {
      
      public static var CELLPOS:Array = new Array();
      
      private static var _bInit:Boolean = false;
       
      
      public function CellIdConverter()
      {
         super();
      }
      
      private static function init() : void
      {
         var b:int = 0;
         _bInit = true;
         var startX:int = 0;
         var startY:int = 0;
         var cell:int = 0;
         for(var a:int = 0; a < AtouinConstants.MAP_HEIGHT; a++)
         {
            for(b = 0; b < AtouinConstants.MAP_WIDTH; b++)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
            }
            startX++;
            for(b = 0; b < AtouinConstants.MAP_WIDTH; b++)
            {
               CELLPOS[cell] = new Point(startX + b,startY + b);
               cell++;
            }
            startY--;
         }
      }
      
      public static function coordToCellId(x:int, y:int) : uint
      {
         if(!_bInit)
         {
            init();
         }
         return (x - y) * AtouinConstants.MAP_WIDTH + y + (x - y) / 2;
      }
      
      public static function cellIdToCoord(cellId:uint) : Point
      {
         if(!_bInit)
         {
            init();
         }
         if(!CELLPOS[cellId])
         {
            return null;
         }
         return CELLPOS[cellId];
      }
   }
}
