package com.ankamagames.jerakine.map
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.Dofus2Line;
   import flash.utils.getQualifiedClassName;
   
   public class LosDetector
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LosDetector));
       
      
      public function LosDetector()
      {
         super();
      }
      
      public static function getCell(mapData:IDataMapProvider, range:Vector.<uint>, refPosition:MapPoint) : Vector.<uint>
      {
         var i:uint = 0;
         var line:Array = null;
         var los:Boolean = false;
         var currentPoint:String = null;
         var p:MapPoint = null;
         var j:int = 0;
         var orderedCell:Array = new Array();
         var mp:MapPoint = null;
         for(i = 0; i < range.length; i++)
         {
            mp = MapPoint.fromCellId(range[i]);
            orderedCell.push({
               "p":mp,
               "dist":refPosition.distanceToCell(mp)
            });
         }
         orderedCell.sortOn("dist",Array.DESCENDING | Array.NUMERIC);
         var tested:Object = new Object();
         var result:Vector.<uint> = new Vector.<uint>();
         for(i = 0; i < orderedCell.length; i++)
         {
            p = MapPoint(orderedCell[i].p);
            if(!(tested[p.x + "_" + p.y] != null && refPosition.x + refPosition.y != p.x + p.y && refPosition.x - refPosition.y != p.x - p.y))
            {
               line = Dofus2Line.getLine(refPosition.cellId,p.cellId);
               if(line.length == 0)
               {
                  result.push(p.cellId);
               }
               else
               {
                  los = true;
                  for(j = 0; j < line.length; j++)
                  {
                     currentPoint = Math.floor(line[j].x) + "_" + Math.floor(line[j].y);
                     if(MapPoint.isInMap(line[j].x,line[j].y))
                     {
                        if(j > 0 && mapData.hasEntity(Math.floor(line[j - 1].x),Math.floor(line[j - 1].y),true))
                        {
                           los = false;
                        }
                        else if(line[j].x + line[j].y == refPosition.x + refPosition.y || line[j].x - line[j].y == refPosition.x - refPosition.y)
                        {
                           los = los && mapData.pointLos(Math.floor(line[j].x),Math.floor(line[j].y),true);
                        }
                        else if(tested[currentPoint] == null)
                        {
                           los = los && mapData.pointLos(Math.floor(line[j].x),Math.floor(line[j].y),true);
                        }
                        else
                        {
                           los = los && tested[currentPoint];
                        }
                     }
                  }
                  tested[currentPoint] = los;
               }
            }
         }
         for(i = 0; i < range.length; i++)
         {
            mp = MapPoint.fromCellId(range[i]);
            if(tested[mp.x + "_" + mp.y])
            {
               result.push(mp.cellId);
            }
         }
         return result;
      }
   }
}
