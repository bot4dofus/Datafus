package com.ankamagames.atouin.utils
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IObstacle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mapTools.MapTools;
   import mapTools.MapToolsConfig;
   
   public class DataMapProvider implements IDataMapProvider
   {
      
      private static const TOLERANCE_ELEVATION:int = 11;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DataMapProvider));
      
      private static var _self:DataMapProvider;
      
      public static var throwSingletonError:Boolean = true;
      
      private static var _playerClass:Class;
       
      
      public var isInFight:Boolean;
      
      public var obstaclesCells:Vector.<uint>;
      
      private var _updatedCell:Dictionary;
      
      private var _specialEffects:Dictionary;
      
      public function DataMapProvider()
      {
         this.obstaclesCells = new Vector.<uint>(0);
         this._updatedCell = new Dictionary();
         this._specialEffects = new Dictionary();
         super();
      }
      
      public static function getInstance() : DataMapProvider
      {
         if(!_self && throwSingletonError)
         {
            throw new SingletonError("Init function wasn\'t call");
         }
         return _self;
      }
      
      public static function init(playerClass:Class) : void
      {
         MapTools.init(MapToolsConfig.DOFUS2_CONFIG);
         _playerClass = playerClass;
         if(!_self)
         {
            _self = new DataMapProvider();
         }
      }
      
      public function pointLos(x:int, y:int, bAllowTroughEntity:Boolean = true) : Boolean
      {
         var cellEntities:Array = null;
         var o:IObstacle = null;
         var cellId:uint = MapTools.getCellIdByCoord(x,y);
         var los:Boolean = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]).los;
         if(this._updatedCell[cellId] != null)
         {
            los = this._updatedCell[cellId];
         }
         if(!bAllowTroughEntity)
         {
            cellEntities = EntitiesManager.getInstance().getEntitiesOnCell(cellId,IObstacle);
            if(cellEntities.length)
            {
               for each(o in cellEntities)
               {
                  if(!IObstacle(o).canSeeThrough())
                  {
                     return false;
                  }
               }
            }
         }
         return los;
      }
      
      public function farmCell(x:int, y:int) : Boolean
      {
         var cellId:uint = MapTools.getCellIdByCoord(x,y);
         return CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]).farmCell;
      }
      
      public function cellByIdIsHavenbagCell(cellId:int) : Boolean
      {
         return CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]).havenbagCell;
      }
      
      public function cellByCoordsIsHavenbagCell(x:int, y:int) : Boolean
      {
         var cellId:uint = MapTools.getCellIdByCoord(x,y);
         return CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]).havenbagCell;
      }
      
      public function isChangeZone(cell1:uint, cell2:uint) : Boolean
      {
         var cellData1:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell1]);
         var cellData2:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell2]);
         var dif:int = Math.abs(Math.abs(cellData1.floor) - Math.abs(cellData2.floor));
         return cellData1.moveZone != cellData2.moveZone && dif == 0;
      }
      
      public function pointMov(x:int, y:int, bAllowTroughEntity:Boolean = true, previousCellId:int = -1, endCellId:int = -1, avoidObstacles:Boolean = true) : Boolean
      {
         var dataMap:Map = null;
         var useNewSystem:Boolean = false;
         var cellId:int = 0;
         var cellData:CellData = null;
         var mov:Boolean = false;
         var previousCellData:CellData = null;
         var dif:int = 0;
         var e:IEntity = null;
         var o:IObstacle = null;
         if(MapPoint.isInMap(x,y))
         {
            dataMap = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
            useNewSystem = dataMap.isUsingNewMovementSystem;
            cellId = MapTools.getCellIdByCoord(x,y);
            cellData = CellData(dataMap.cells[cellId]);
            mov = cellData.mov && (!this.isInFight || !cellData.nonWalkableDuringFight);
            if(this._updatedCell[cellId] != null)
            {
               mov = this._updatedCell[cellId];
            }
            if(mov && useNewSystem && previousCellId != -1 && previousCellId != cellId)
            {
               previousCellData = CellData(dataMap.cells[previousCellId]);
               dif = Math.abs(Math.abs(cellData.floor) - Math.abs(previousCellData.floor));
               if(previousCellData.moveZone != cellData.moveZone && dif > 0 || previousCellData.moveZone == cellData.moveZone && cellData.moveZone == 0 && dif > TOLERANCE_ELEVATION)
               {
                  mov = false;
               }
            }
            if(!bAllowTroughEntity)
            {
               for each(e in EntitiesManager.getInstance().entities)
               {
                  if(e && e is IObstacle && e.position && e.position.cellId == cellId)
                  {
                     o = e as IObstacle;
                     if(!(endCellId == cellId && o.canWalkTo()))
                     {
                        if(!o.canWalkThrough())
                        {
                           return false;
                        }
                     }
                  }
               }
               if(avoidObstacles && (this.obstaclesCells.indexOf(cellId) != -1 && cellId != endCellId))
               {
                  return false;
               }
            }
         }
         else
         {
            mov = false;
         }
         return mov;
      }
      
      public function pointCanStop(x:int, y:int, bAllowTroughEntity:Boolean = true) : Boolean
      {
         var cellId:uint = MapTools.getCellIdByCoord(x,y);
         var cellData:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]);
         return this.pointMov(x,y,bAllowTroughEntity) && (this.isInFight || !cellData.nonWalkableDuringRP);
      }
      
      public function fillEntityOnCellArray(v:Vector.<Boolean>, allowThroughEntity:Boolean) : Vector.<Boolean>
      {
         var e:IEntity = null;
         for each(e in EntitiesManager.getInstance().entities)
         {
            if(e is _playerClass && (!allowThroughEntity || !e["allowMovementThrough"]) && e.position != null)
            {
               v[e.position.cellId] = true;
            }
         }
         return v;
      }
      
      public function pointWeight(x:int, y:int, bAllowTroughEntity:Boolean = true) : Number
      {
         var entity:IEntity = null;
         var weight:Number = 1;
         var cellId:int = MapTools.getCellIdByCoord(x,y);
         var speed:int = this.getCellSpeed(cellId);
         if(bAllowTroughEntity)
         {
            if(speed >= 0)
            {
               weight += 5 - speed;
            }
            else
            {
               weight += 11 + Math.abs(speed);
            }
            entity = EntitiesManager.getInstance().getEntityOnCell(cellId,_playerClass);
            if(entity && !entity["allowMovementThrough"])
            {
               weight = 20;
            }
         }
         else
         {
            if(EntitiesManager.getInstance().getEntityOnCell(cellId,_playerClass) != null)
            {
               weight += 0.3;
            }
            if(EntitiesManager.getInstance().getEntityOnCell(MapTools.getCellIdByCoord(x + 1,y),_playerClass) != null)
            {
               weight += 0.3;
            }
            if(EntitiesManager.getInstance().getEntityOnCell(MapTools.getCellIdByCoord(x,y + 1),_playerClass) != null)
            {
               weight += 0.3;
            }
            if(EntitiesManager.getInstance().getEntityOnCell(MapTools.getCellIdByCoord(x - 1,y),_playerClass) != null)
            {
               weight += 0.3;
            }
            if(EntitiesManager.getInstance().getEntityOnCell(MapTools.getCellIdByCoord(x,y - 1),_playerClass) != null)
            {
               weight += 0.3;
            }
            if((this.pointSpecialEffects(x,y) & 2) == 2)
            {
               weight += 0.2;
            }
         }
         return weight;
      }
      
      public function getCellSpeed(cellId:uint) : int
      {
         return (MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId] as CellData).speed;
      }
      
      public function pointSpecialEffects(x:int, y:int) : uint
      {
         var cellId:uint = MapTools.getCellIdByCoord(x,y);
         if(this._specialEffects[cellId])
         {
            return this._specialEffects[cellId];
         }
         return 0;
      }
      
      public function get width() : int
      {
         return AtouinConstants.MAP_HEIGHT + AtouinConstants.MAP_WIDTH - 2;
      }
      
      public function get height() : int
      {
         return AtouinConstants.MAP_HEIGHT + AtouinConstants.MAP_WIDTH - 1;
      }
      
      public function hasEntity(x:int, y:int, bAllowTroughEntity:Boolean = false) : Boolean
      {
         var o:IObstacle = null;
         var cellEntities:Array = EntitiesManager.getInstance().getEntitiesOnCell(MapTools.getCellIdByCoord(x,y),IObstacle);
         if(cellEntities.length)
         {
            for each(o in cellEntities)
            {
               if(!IObstacle(o).canWalkTo() && (!bAllowTroughEntity || !o.canSeeThrough()))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function updateCellMovLov(cellId:uint, canMove:Boolean) : void
      {
         this._updatedCell[cellId] = canMove;
      }
      
      public function resetUpdatedCell() : void
      {
         this._updatedCell = new Dictionary();
      }
      
      public function setSpecialEffects(cellId:uint, value:uint) : void
      {
         this._specialEffects[cellId] = value;
      }
      
      public function resetSpecialEffects() : void
      {
         this._specialEffects = new Dictionary();
      }
   }
}
