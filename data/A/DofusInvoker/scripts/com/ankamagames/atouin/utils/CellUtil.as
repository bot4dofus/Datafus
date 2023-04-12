package com.ankamagames.atouin.utils
{
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CellUtil
   {
      
      public static const MAX_CELL_ID:int = 559;
      
      public static const MIN_CELL_ID:int = 0;
       
      
      public function CellUtil()
      {
         super();
      }
      
      public static function getPixelXFromMapPoint(p:MapPoint) : int
      {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
         return cellSprite.x + cellSprite.width / 2;
      }
      
      public static function getPixelYFromMapPoint(p:MapPoint) : int
      {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
         return cellSprite.y + cellSprite.height / 2;
      }
      
      public static function getPixelsPointFromMapPoint(p:MapPoint, pivotInCenter:Boolean = true) : Point
      {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
         return new Point(!!pivotInCenter ? Number(cellSprite.x + cellSprite.width / 2) : Number(cellSprite.x),!!pivotInCenter ? Number(cellSprite.y + cellSprite.height / 2) : Number(cellSprite.y));
      }
      
      public static function isLeftCol(cellId:int) : Boolean
      {
         return cellId % 14 == 0;
      }
      
      public static function isRightCol(cellId:int) : Boolean
      {
         return isLeftCol(cellId + 1);
      }
      
      public static function isTopRow(cellId:int) : Boolean
      {
         return cellId < 28;
      }
      
      public static function isBottomRow(cellId:int) : Boolean
      {
         return cellId > 531;
      }
      
      public static function isEvenRow(cellId:int) : Boolean
      {
         return Math.floor(cellId / 14) % 2 == 0;
      }
      
      public static function isValidCellIndex(cellId:int) : Boolean
      {
         return Boolean(cellId >= 0 && cellId < MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells.length);
      }
   }
}
