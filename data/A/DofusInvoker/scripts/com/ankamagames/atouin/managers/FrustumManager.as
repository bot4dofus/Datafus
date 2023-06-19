package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.atouin.types.FrustumShape;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   public class FrustumManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FrustumManager));
      
      private static const SHAPE_INSIDE_PADDING:Number = 30;
      
      private static var _self:FrustumManager;
       
      
      private var _frustumContainer:DisplayObjectContainer;
      
      private var _shapeTop:FrustumShape;
      
      private var _shapeRight:FrustumShape;
      
      private var _shapeBottom:FrustumShape;
      
      private var _shapeLeft:FrustumShape;
      
      private var _frustrum:Frustum;
      
      private var _lastCellId:int;
      
      private var _enable:Boolean;
      
      public function FrustumManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : FrustumManager
      {
         if(!_self)
         {
            _self = new FrustumManager();
         }
         return _self;
      }
      
      public function init(frustumContainer:DisplayObjectContainer) : void
      {
         this._frustumContainer = frustumContainer;
         this._shapeTop = new FrustumShape(DirectionsEnum.UP);
         this._shapeRight = new FrustumShape(DirectionsEnum.RIGHT);
         this._shapeBottom = new FrustumShape(DirectionsEnum.DOWN);
         this._shapeLeft = new FrustumShape(DirectionsEnum.LEFT);
         this._frustumContainer.addChild(this._shapeLeft);
         this._frustumContainer.addChild(this._shapeTop);
         this._frustumContainer.addChild(this._shapeRight);
         this._frustumContainer.addChild(this._shapeBottom);
         this._shapeLeft.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeTop.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeRight.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeBottom.addEventListener(MouseEvent.CLICK,this.click);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_OVER,this.mouseMove);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this._shapeLeft.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeTop.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeRight.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this._shapeBottom.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this.setBorderInteraction(false);
         this._lastCellId = -1;
      }
      
      public function setBorderInteraction(enable:Boolean) : void
      {
         this._enable = enable;
         this._shapeTop.mouseEnabled = enable;
         this._shapeRight.mouseEnabled = enable;
         this._shapeBottom.mouseEnabled = enable;
         this._shapeLeft.mouseEnabled = enable;
         this.updateMap();
      }
      
      public function updateMap() : void
      {
         this._lastCellId = -1;
         if(this._enable)
         {
            this._shapeTop.mouseEnabled = this.findNearestCell(this._shapeTop).cell != -1;
            this._shapeRight.mouseEnabled = this.findNearestCell(this._shapeRight).cell != -1;
            this._shapeBottom.mouseEnabled = this.findNearestCell(this._shapeBottom).cell != -1;
            this._shapeLeft.mouseEnabled = this.findNearestCell(this._shapeLeft).cell != -1;
         }
      }
      
      public function getShape(direction:int) : Sprite
      {
         switch(direction)
         {
            case DirectionsEnum.UP:
               return this._shapeTop;
            case DirectionsEnum.LEFT:
               return this._shapeLeft;
            case DirectionsEnum.RIGHT:
               return this._shapeRight;
            case DirectionsEnum.DOWN:
               return this._shapeBottom;
            default:
               return null;
         }
      }
      
      public function set frustum(rFrustum:Frustum) : void
      {
         this._frustrum = rFrustum;
         this._shapeLeft.graphics.beginFill(0,1);
         this._shapeLeft.graphics.drawRect(SHAPE_INSIDE_PADDING,0,-512,StageShareManager.startHeight);
         this._shapeLeft.graphics.endFill();
         this._shapeRight.graphics.beginFill(0,1);
         this._shapeRight.graphics.drawRect(StageShareManager.startWidth - SHAPE_INSIDE_PADDING,0,512,StageShareManager.startHeight);
         this._shapeRight.graphics.endFill();
         this._shapeTop.graphics.beginFill(0,1);
         this._shapeTop.graphics.drawRect(SHAPE_INSIDE_PADDING,SHAPE_INSIDE_PADDING - 13,StageShareManager.startWidth - SHAPE_INSIDE_PADDING * 2,-512);
         this._shapeTop.graphics.endFill();
         this._shapeBottom.graphics.beginFill(0,1);
         this._shapeBottom.graphics.drawRect(SHAPE_INSIDE_PADDING,this.frustum.bottom - SHAPE_INSIDE_PADDING / 2 - 5,StageShareManager.startWidth - SHAPE_INSIDE_PADDING * 2,this.frustum.marginBottom + SHAPE_INSIDE_PADDING * 2);
         this._shapeBottom.graphics.endFill();
      }
      
      public function get frustum() : Frustum
      {
         return this._frustrum;
      }
      
      private function click(e:MouseEvent) : void
      {
         var destMapId:Number = NaN;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         switch(e.target)
         {
            case this._shapeRight:
               destMapId = currentMap.rightNeighbourId;
               break;
            case this._shapeLeft:
               destMapId = currentMap.leftNeighbourId;
               break;
            case this._shapeBottom:
               destMapId = currentMap.bottomNeighbourId;
               break;
            case this._shapeTop:
               destMapId = currentMap.topNeighbourId;
         }
         var localMousePosition:Point = new Point(!!isNaN(e.localX) ? Number(Sprite(e.target).mouseX) : Number(e.localX),!!isNaN(e.localY) ? Number(Sprite(e.target).mouseY) : Number(e.localY));
         var cellData:Object = this.findNearestCell(e.target as Sprite,localMousePosition);
         if(cellData.cell == -1)
         {
            return;
         }
         if(!cellData.custom)
         {
            this.sendClickAdjacentMsg(destMapId,cellData.cell);
         }
         else
         {
            this.sendCellClickMsg(destMapId,cellData.cell);
         }
      }
      
      private function findCustomNearestCell(direction:int, localMousePosition:Point = null) : Object
      {
         var cellList:Vector.<uint> = null;
         var p:Point = null;
         var d:Number = NaN;
         var floor:int = 0;
         var cellId:uint = 0;
         var currentCellId:uint = 0;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var x:uint = 0;
         var y:uint = 0;
         switch(direction)
         {
            case DirectionsEnum.RIGHT:
               y = 1;
               cellList = currentMap.rightArrowCell;
               break;
            case DirectionsEnum.LEFT:
               y = 1;
               cellList = currentMap.leftArrowCell;
               break;
            case DirectionsEnum.DOWN:
               x = 1;
               cellList = currentMap.bottomArrowCell;
               break;
            case DirectionsEnum.UP:
               x = 1;
               cellList = currentMap.topArrowCell;
         }
         if(!cellList || !cellList.length)
         {
            return {
               "cell":-1,
               "distance":Number.MAX_VALUE
            };
         }
         var currentDist:Number = Number.MAX_VALUE;
         for(var i:uint = 0; i < cellList.length; i++)
         {
            cellId = cellList[i];
            p = Cell.cellPixelCoords(cellId);
            floor = CellData(currentMap.cells[cellId]).floor;
            if(y == 1)
            {
               d = Math.abs(localMousePosition.x - this._frustrum.y - (p.y - floor + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
            }
            if(x == 1)
            {
               d = Math.abs(localMousePosition.x - this._frustrum.x - (p.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
            }
            if(d < currentDist)
            {
               currentDist = d;
               currentCellId = cellId;
            }
         }
         return {
            "cell":currentCellId,
            "distance":currentDist
         };
      }
      
      private function findNearestCell(target:Sprite, localMousePosition:Point = null) : Object
      {
         var direction:int = 0;
         if(!localMousePosition)
         {
            localMousePosition = new Point(target.mouseX,target.mouseY);
         }
         switch(target)
         {
            case this._shapeRight:
               direction = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               direction = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               direction = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               direction = DirectionsEnum.UP;
         }
         return this.findNearestBorderCellFromPoint(direction,localMousePosition);
      }
      
      public function findNearestBorderCellFromPoint(direction:int, fromCellPoint:Point) : Object
      {
         var currentlyCheckedCellX:int = 0;
         var currentlyCheckedCellY:int = 0;
         var closestCellX:int = 0;
         var closestCellY:int = 0;
         var currentCellPixelPoint:Point = null;
         var currentCellZ:int = 0;
         var currentDistance:Number = NaN;
         var i:uint = 0;
         var maxI:uint = 0;
         var currentCellId:int = 0;
         var cellData:CellData = null;
         var mapChangeData:uint = 0;
         var currentMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         var lastSmallestDistance:Number = Number.MAX_VALUE;
         switch(direction)
         {
            case DirectionsEnum.RIGHT:
               currentlyCheckedCellX = AtouinConstants.MAP_WIDTH - 1;
               currentlyCheckedCellY = AtouinConstants.MAP_WIDTH - 1;
               break;
            case DirectionsEnum.LEFT:
               currentlyCheckedCellX = 0;
               currentlyCheckedCellY = 0;
               break;
            case DirectionsEnum.DOWN:
               currentlyCheckedCellX = AtouinConstants.MAP_HEIGHT - 1;
               currentlyCheckedCellY = -(AtouinConstants.MAP_HEIGHT - 1);
               break;
            case DirectionsEnum.UP:
               currentlyCheckedCellX = 0;
               currentlyCheckedCellY = 0;
         }
         var closestCustomCellData:Object = this.findCustomNearestCell(direction,fromCellPoint);
         if(closestCustomCellData.cell != -1)
         {
            lastSmallestDistance = closestCustomCellData.distance;
            closestCellX = CellIdConverter.cellIdToCoord(closestCustomCellData.cell).x;
            closestCellY = CellIdConverter.cellIdToCoord(closestCustomCellData.cell).y;
         }
         if(direction == DirectionsEnum.RIGHT || direction == DirectionsEnum.LEFT)
         {
            maxI = AtouinConstants.MAP_HEIGHT * 2;
            for(i = 0; i < maxI; i++)
            {
               currentCellId = CellIdConverter.coordToCellId(currentlyCheckedCellX,currentlyCheckedCellY);
               currentCellPixelPoint = Cell.cellPixelCoords(currentCellId);
               currentCellZ = CellData(currentMap.cells[currentCellId]).floor;
               currentDistance = Math.abs(fromCellPoint.y - this._frustrum.y - (currentCellPixelPoint.y - currentCellZ + AtouinConstants.CELL_HALF_HEIGHT) * this._frustrum.scale);
               if(currentDistance < lastSmallestDistance)
               {
                  cellData = currentMap.cells[currentCellId] as CellData;
                  mapChangeData = cellData.mapChangeData;
                  if(mapChangeData && (direction == DirectionsEnum.RIGHT && (mapChangeData & 1 || (currentCellId + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && mapChangeData & 2 || (currentCellId + 1) % (AtouinConstants.MAP_WIDTH * 2) == 0 && mapChangeData & 128) || direction == DirectionsEnum.LEFT && (currentlyCheckedCellX == -currentlyCheckedCellY && mapChangeData & 8 || mapChangeData & 16 || currentlyCheckedCellX == -currentlyCheckedCellY && mapChangeData & 32)))
                  {
                     closestCellX = currentlyCheckedCellX;
                     closestCellY = currentlyCheckedCellY;
                     lastSmallestDistance = currentDistance;
                  }
               }
               if(!(i % 2))
               {
                  currentlyCheckedCellX++;
               }
               else
               {
                  currentlyCheckedCellY--;
               }
            }
         }
         else
         {
            for(i = 0; i < AtouinConstants.MAP_WIDTH * 2; i++)
            {
               currentCellId = CellIdConverter.coordToCellId(currentlyCheckedCellX,currentlyCheckedCellY);
               currentCellPixelPoint = Cell.cellPixelCoords(currentCellId);
               currentDistance = Math.abs(fromCellPoint.x - this._frustrum.x - (currentCellPixelPoint.x + AtouinConstants.CELL_HALF_WIDTH) * this._frustrum.scale);
               if(currentDistance < lastSmallestDistance)
               {
                  cellData = currentMap.cells[currentCellId] as CellData;
                  mapChangeData = cellData.mapChangeData;
                  if(mapChangeData && (direction == DirectionsEnum.UP && (currentCellId < AtouinConstants.MAP_WIDTH && mapChangeData & 32 || mapChangeData & 64 || currentCellId < AtouinConstants.MAP_WIDTH && mapChangeData & 128) || direction == DirectionsEnum.DOWN && (currentCellId >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && mapChangeData & 2 || mapChangeData & 4 || currentCellId >= AtouinConstants.MAP_CELLS_COUNT - AtouinConstants.MAP_WIDTH && mapChangeData & 8)))
                  {
                     closestCellX = currentlyCheckedCellX;
                     closestCellY = currentlyCheckedCellY;
                     lastSmallestDistance = currentDistance;
                  }
               }
               if(!(i % 2))
               {
                  currentlyCheckedCellX++;
               }
               else
               {
                  currentlyCheckedCellY++;
               }
            }
         }
         if(lastSmallestDistance != Number.MAX_VALUE)
         {
            return {
               "cell":CellIdConverter.coordToCellId(closestCellX,closestCellY),
               "custom":lastSmallestDistance == closestCustomCellData.distance
            };
         }
         return {
            "cell":-1,
            "custom":false
         };
      }
      
      private function sendClickAdjacentMsg(mapId:Number, cellId:uint) : void
      {
         var msg:AdjacentMapClickMessage = new AdjacentMapClickMessage();
         msg.cellId = cellId;
         msg.adjacentMapId = mapId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function sendCellClickMsg(mapId:Number, cellId:uint) : void
      {
         var msg:CellClickMessage = new CellClickMessage();
         msg.cellId = cellId;
         msg.id = mapId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function out(e:MouseEvent) : void
      {
         var n:uint = 0;
         Sprite(e.target).alpha = 0;
         switch(e.target)
         {
            case this._shapeRight:
               n = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               n = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               n = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               n = DirectionsEnum.UP;
         }
         this._lastCellId = -1;
         var msg:AdjacentMapOutMessage = new AdjacentMapOutMessage(n,DisplayObject(e.target));
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mouseMove(e:MouseEvent) : void
      {
         var n:uint = 0;
         if(e.type == MouseEvent.MOUSE_OVER)
         {
            Sprite(e.target).alpha = 0.1;
         }
         switch(e.target)
         {
            case this._shapeRight:
               n = DirectionsEnum.RIGHT;
               break;
            case this._shapeLeft:
               n = DirectionsEnum.LEFT;
               break;
            case this._shapeBottom:
               n = DirectionsEnum.DOWN;
               break;
            case this._shapeTop:
               n = DirectionsEnum.UP;
         }
         var cellId:int = this.findNearestCell(e.target as Sprite).cell;
         if(cellId == -1 || cellId == this._lastCellId)
         {
            return;
         }
         this._lastCellId = cellId;
         var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId] as CellData;
         var msg:AdjacentMapOverMessage = new AdjacentMapOverMessage(n,DisplayObject(e.target),cellId,cellData);
         Atouin.getInstance().handler.process(msg);
      }
   }
}
