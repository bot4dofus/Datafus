package com.ankamagames.jerakine.pathfinding
{
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import mapTools.MapTools;
   
   public class Pathfinding
   {
      
      private static const HV_COST:uint = 10;
      
      private static const DIAG_COST:uint = 15;
      
      private static const HEURISTIC_COST:uint = 10;
      
      private static const INFINITE_COST:int = 99999999;
      
      private static var _isInit:Boolean = false;
      
      private static var _parentOfCell:Vector.<int>;
      
      private static var _costOfCell:Vector.<int>;
      
      private static var _openListWeights:Vector.<int>;
      
      private static var _isCellClosed:Vector.<Boolean>;
      
      private static var _isEntityOnCell:Vector.<Boolean>;
      
      private static var _openList:FastIntArray;
       
      
      public function Pathfinding()
      {
         super();
      }
      
      public static function findPath(map:IDataMapProvider, start:MapPoint, end:MapPoint, allowDiag:Boolean = true, bAllowTroughEntity:Boolean = true, avoidObstacles:Boolean = true) : MovementPath
      {
         var i:uint = 0;
         var minimum:Number = NaN;
         var smallestCostIndex:uint = 0;
         var parentId:int = 0;
         var parentX:int = 0;
         var parentY:int = 0;
         var y:int = 0;
         var cost:Number = NaN;
         var x:int = 0;
         var cellId:int = 0;
         var pointWeight:Number = NaN;
         var movementCost:int = 0;
         var speed:int = 0;
         var cellOnEndColumn:* = false;
         var cellOnStartColumn:* = false;
         var cellOnEndLine:* = false;
         var cellOnStartLine:* = false;
         var distanceTmpToEnd:int = 0;
         var heuristic:Number = NaN;
         var parent:int = 0;
         var grandParent:int = 0;
         var grandGrandParent:int = 0;
         var kX:int = 0;
         var kY:int = 0;
         var nextX:int = 0;
         var nextY:int = 0;
         var interX:int = 0;
         var interY:int = 0;
         var endCellId:int = end.cellId;
         var startCellId:int = start.cellId;
         var endX:int = end.x;
         var endY:int = end.y;
         var endCellAuxId:int = startCellId;
         var distanceToEnd:int = MapTools.getDistance(startCellId,endCellId);
         if(!_isInit)
         {
            _costOfCell = new Vector.<int>(MapTools.mapCountCell,true);
            _openListWeights = new Vector.<int>(MapTools.mapCountCell,true);
            _parentOfCell = new Vector.<int>(MapTools.mapCountCell,true);
            _isCellClosed = new Vector.<Boolean>(MapTools.mapCountCell,true);
            _isEntityOnCell = new Vector.<Boolean>(MapTools.mapCountCell,true);
            _openList = new FastIntArray(40);
            _isInit = true;
         }
         for(i = 0; i < MapTools.mapCountCell; i++)
         {
            _parentOfCell[i] = MapTools.INVALID_CELL_ID;
            _isCellClosed[i] = false;
            _isEntityOnCell[i] = false;
         }
         _openList.clear();
         map.fillEntityOnCellArray(_isEntityOnCell,bAllowTroughEntity);
         _costOfCell[startCellId] = 0;
         _openList.push(startCellId);
         while(_openList.length > 0 && _isCellClosed[endCellId] == false)
         {
            minimum = INFINITE_COST;
            smallestCostIndex = 0;
            for(i = 0; i < _openList.length; i++)
            {
               cost = _openListWeights[_openList.data[i]];
               if(cost <= minimum)
               {
                  minimum = cost;
                  smallestCostIndex = i;
               }
            }
            parentId = _openList.data[smallestCostIndex];
            parentX = MapTools.getCellIdXCoord(parentId);
            parentY = MapTools.getCellIdYCoord(parentId);
            _openList.removeAt(smallestCostIndex);
            _isCellClosed[parentId] = true;
            for(y = parentY - 1; y <= parentY + 1; y++)
            {
               for(x = parentX - 1; x <= parentX + 1; x++)
               {
                  cellId = MapTools.getCellIdByCoord(x,y);
                  if(cellId != MapTools.INVALID_CELL_ID && _isCellClosed[cellId] == false && cellId != parentId && map.pointMov(x,y,bAllowTroughEntity,parentId,endCellId,avoidObstacles) && (y == parentY || x == parentX || allowDiag && (map.pointMov(parentX,y,bAllowTroughEntity,parentId,endCellId,avoidObstacles) || map.pointMov(x,parentY,bAllowTroughEntity,parentId,endCellId,avoidObstacles))))
                  {
                     pointWeight = 0;
                     if(cellId == endCellId)
                     {
                        pointWeight = 1;
                     }
                     else
                     {
                        speed = map.getCellSpeed(cellId);
                        if(bAllowTroughEntity)
                        {
                           if(_isEntityOnCell[cellId])
                           {
                              pointWeight = 20;
                           }
                           else if(speed >= 0)
                           {
                              pointWeight = 6 - speed;
                           }
                           else
                           {
                              pointWeight = 12 + Math.abs(speed);
                           }
                        }
                        else
                        {
                           pointWeight = 1;
                           if(_isEntityOnCell[cellId])
                           {
                              pointWeight += 0.3;
                           }
                           if(MapTools.isValidCoord(x + 1,y) && _isEntityOnCell[MapTools.getCellIdByCoord(x + 1,y)])
                           {
                              pointWeight += 0.3;
                           }
                           if(MapTools.isValidCoord(x,y + 1) && _isEntityOnCell[MapTools.getCellIdByCoord(x,y + 1)])
                           {
                              pointWeight += 0.3;
                           }
                           if(MapTools.isValidCoord(x - 1,y) && _isEntityOnCell[MapTools.getCellIdByCoord(x - 1,y)])
                           {
                              pointWeight += 0.3;
                           }
                           if(MapTools.isValidCoord(x,y - 1) && _isEntityOnCell[MapTools.getCellIdByCoord(x,y - 1)])
                           {
                              pointWeight += 0.3;
                           }
                           if((map.pointSpecialEffects(x,y) & 2) == 2)
                           {
                              pointWeight += 0.2;
                           }
                        }
                     }
                     movementCost = _costOfCell[parentId] + (y == parentY || x == parentX ? HV_COST : DIAG_COST) * pointWeight;
                     if(bAllowTroughEntity)
                     {
                        cellOnEndColumn = x + y == endX + endY;
                        cellOnStartColumn = x + y == start.x + start.y;
                        cellOnEndLine = x - y == endX - endY;
                        cellOnStartLine = x - y == start.x - start.y;
                        if(!cellOnEndColumn && !cellOnEndLine || !cellOnStartColumn && !cellOnStartLine)
                        {
                           movementCost += MapTools.getDistance(cellId,endCellId);
                           movementCost += MapTools.getDistance(cellId,startCellId);
                        }
                        if(x == endX || y == endY)
                        {
                           movementCost -= 3;
                        }
                        if(cellOnEndColumn || cellOnEndLine || x + y == parentX + parentY || x - y == parentX - parentY)
                        {
                           movementCost -= 2;
                        }
                        if(i == start.x || y == start.y)
                        {
                           movementCost -= 3;
                        }
                        if(cellOnStartColumn || cellOnStartLine)
                        {
                           movementCost -= 2;
                        }
                        distanceTmpToEnd = MapTools.getDistance(cellId,endCellId);
                        if(distanceTmpToEnd < distanceToEnd)
                        {
                           endCellAuxId = cellId;
                           distanceToEnd = distanceTmpToEnd;
                        }
                     }
                     if(_parentOfCell[cellId] == MapTools.INVALID_CELL_ID || movementCost < _costOfCell[cellId])
                     {
                        _parentOfCell[cellId] = parentId;
                        _costOfCell[cellId] = movementCost;
                        heuristic = HEURISTIC_COST * Math.sqrt((endY - y) * (endY - y) + (endX - x) * (endX - x));
                        _openListWeights[cellId] = heuristic + movementCost;
                        if(_openList.indexOf(cellId) == -1)
                        {
                           _openList.push(cellId);
                        }
                     }
                  }
               }
            }
         }
         var movPath:MovementPath = new MovementPath();
         movPath.start = start;
         if(_parentOfCell[endCellId] == MapTools.INVALID_CELL_ID)
         {
            endCellId = endCellAuxId;
            movPath.end = MapPoint.fromCellId(endCellId);
         }
         else
         {
            movPath.end = end;
         }
         for(var cursor:int = endCellId; cursor != startCellId; cursor = _parentOfCell[cursor])
         {
            if(allowDiag)
            {
               parent = _parentOfCell[cursor];
               grandParent = parent == MapTools.INVALID_CELL_ID ? int(MapTools.INVALID_CELL_ID) : int(_parentOfCell[parent]);
               grandGrandParent = grandParent == MapTools.INVALID_CELL_ID ? int(MapTools.INVALID_CELL_ID) : int(_parentOfCell[grandParent]);
               kX = MapTools.getCellIdXCoord(cursor);
               kY = MapTools.getCellIdYCoord(cursor);
               if(grandParent != MapTools.INVALID_CELL_ID && MapTools.getDistance(cursor,grandParent) == 1)
               {
                  if(map.pointMov(kX,kY,bAllowTroughEntity,grandParent,endCellId))
                  {
                     _parentOfCell[cursor] = grandParent;
                  }
               }
               else if(grandGrandParent != MapTools.INVALID_CELL_ID && MapTools.getDistance(cursor,grandGrandParent) == 2)
               {
                  nextX = MapTools.getCellIdXCoord(grandGrandParent);
                  nextY = MapTools.getCellIdYCoord(grandGrandParent);
                  interX = kX + Math.round((nextX - kX) / 2);
                  interY = kY + Math.round((nextY - kY) / 2);
                  if(map.pointMov(interX,interY,bAllowTroughEntity,cursor,endCellId) && map.pointWeight(interX,interY) < 2)
                  {
                     _parentOfCell[cursor] = MapTools.getCellIdByCoord(interX,interY);
                  }
               }
               else if(grandParent != MapTools.INVALID_CELL_ID && MapTools.getDistance(cursor,grandParent) == 2)
               {
                  nextX = MapTools.getCellIdXCoord(grandParent);
                  nextY = MapTools.getCellIdYCoord(grandParent);
                  interX = MapTools.getCellIdXCoord(parent);
                  interY = MapTools.getCellIdYCoord(parent);
                  if(kX + kY == nextX + nextY && kX - kY != interX - interY && !map.isChangeZone(MapTools.getCellIdByCoord(kX,kY),MapTools.getCellIdByCoord(interX,interY)) && !map.isChangeZone(MapTools.getCellIdByCoord(interX,interY),MapTools.getCellIdByCoord(nextX,nextY)))
                  {
                     _parentOfCell[cursor] = grandParent;
                  }
                  else if(kX - kY == nextX - nextY && kX - kY != interX - interY && !map.isChangeZone(MapTools.getCellIdByCoord(kX,kY),MapTools.getCellIdByCoord(interX,interY)) && !map.isChangeZone(MapTools.getCellIdByCoord(interX,interY),MapTools.getCellIdByCoord(nextX,nextY)))
                  {
                     _parentOfCell[cursor] = grandParent;
                  }
                  else if(kX == nextX && kX != interX && map.pointWeight(kX,interY) < 2 && map.pointMov(kX,interY,bAllowTroughEntity,cursor,endCellId))
                  {
                     _parentOfCell[cursor] = MapTools.getCellIdByCoord(kX,interY);
                  }
                  else if(kY == nextY && kY != interY && map.pointWeight(interX,kY) < 2 && map.pointMov(interX,kY,bAllowTroughEntity,cursor,endCellId))
                  {
                     _parentOfCell[cursor] = MapTools.getCellIdByCoord(interX,kY);
                  }
               }
            }
            movPath.addPoint(new PathElement(MapPoint.fromCellId(_parentOfCell[cursor]),MapTools.getLookDirection8Exact(_parentOfCell[cursor],cursor)));
         }
         movPath.path.reverse();
         return movPath;
      }
   }
}
