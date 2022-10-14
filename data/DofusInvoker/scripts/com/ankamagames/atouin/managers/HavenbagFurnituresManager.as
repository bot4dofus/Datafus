package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.HavenbagLayersEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.renderers.FurnitureZoneRenderer;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.IFurniture;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.types.miscs.HavenbagPackedInfos;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class HavenbagFurnituresManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFurnituresManager));
      
      public static const SELECTION_FURNITURE:String = "furnitureZoneSelection";
      
      private static var _self:HavenbagFurnituresManager;
       
      
      private var _furnituresById:Dictionary;
      
      private var _furnituresByCellId:Dictionary;
      
      private var _furnituresOnPreviewedCells:Array;
      
      private var _previewedFurniture:IFurniture;
      
      private var _walkableSupportYOffsetByCellId:Dictionary;
      
      public function HavenbagFurnituresManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : HavenbagFurnituresManager is a singleton class and shoulnd\'t be instancied directly!");
         }
         this._furnituresById = new Dictionary();
         this._furnituresByCellId = new Dictionary();
         this._walkableSupportYOffsetByCellId = new Dictionary();
         this._furnituresOnPreviewedCells = new Array();
      }
      
      public static function getInstance() : HavenbagFurnituresManager
      {
         if(!_self)
         {
            _self = new HavenbagFurnituresManager();
         }
         return _self;
      }
      
      public function addFurniture(furniture:IFurniture) : void
      {
         var gc:GraphicCell = null;
         var cell:MapPoint = null;
         var i:int = 0;
         if(!DataMapProvider.getInstance().cellByIdIsHavenbagCell(furniture.position.cellId))
         {
            return;
         }
         this._previewedFurniture = null;
         this._furnituresOnPreviewedCells.length = 0;
         this._furnituresById[furniture.id] = furniture;
         for each(cell in furniture.cells)
         {
            if(this._furnituresByCellId[cell.cellId] == null)
            {
               this._furnituresByCellId[cell.cellId] = new Vector.<IFurniture>(3,true);
            }
            else
            {
               if(this._furnituresByCellId[cell.cellId][furniture.layerId])
               {
                  this.removeFurniture(this._furnituresByCellId[cell.cellId][furniture.layerId].id);
               }
               for(i = furniture.layerId; i < this._furnituresByCellId[cell.cellId].length; i++)
               {
                  if(this._furnituresByCellId[cell.cellId][i])
                  {
                     if(!furniture.isStackable)
                     {
                        this.removeFurniture(this._furnituresByCellId[cell.cellId][i].id);
                     }
                     else if(furniture.layerId == HavenbagLayersEnum.SUPPORT && this._furnituresByCellId[cell.cellId][i].layerId == HavenbagLayersEnum.OBJECT)
                     {
                        this.displayFurniture(this._furnituresByCellId[cell.cellId][i],Vector.<IFurniture>([null,furniture,this._furnituresByCellId[cell.cellId][i]]));
                     }
                  }
               }
            }
            gc = InteractiveCellManager.getInstance().getCell(cell.cellId);
            if(gc && (furniture.canWalkTo() || furniture.canWalkThrough()) && furniture.elementHeight > 0)
            {
               this._walkableSupportYOffsetByCellId[cell.cellId] = furniture.elementHeight;
               InteractiveCellManager.getInstance().updateCellElevation(cell.cellId,furniture.elementHeight);
            }
            this._furnituresByCellId[cell.cellId][furniture.layerId] = furniture;
            this.updateFurnituresY(cell.cellId);
         }
         this.displayFurniture(furniture);
      }
      
      public function removeFurniture(furnitureId:Number) : void
      {
         var gc:GraphicCell = null;
         var cell:MapPoint = null;
         var cellIsEmpty:Boolean = false;
         var otherFurniture:IFurniture = null;
         var furniture:IFurniture = this._furnituresById[furnitureId];
         if(!furniture)
         {
            _log.error("Failed to remove furniture with id " + furnitureId + ", wasn\'t found furnitures list");
            return;
         }
         delete this._furnituresById[furniture.id];
         for each(cell in furniture.cells)
         {
            this._furnituresByCellId[cell.cellId][furniture.layerId] = null;
            cellIsEmpty = true;
            for each(otherFurniture in this._furnituresByCellId[cell.cellId])
            {
               if(otherFurniture)
               {
                  cellIsEmpty = false;
                  break;
               }
            }
            if(cellIsEmpty)
            {
               InteractiveCellManager.getInstance().updateCell(cell.cellId,true);
            }
            this.updateFurnituresY(cell.cellId);
            gc = InteractiveCellManager.getInstance().getCell(cell.cellId);
            if(gc && (furniture.canWalkTo() || furniture.canWalkThrough()) && furniture.elementHeight > 0 && gc.y < gc.initialElevation)
            {
               InteractiveCellManager.getInstance().updateCellElevation(cell.cellId,0);
               this._walkableSupportYOffsetByCellId[cell.cellId] = 0;
            }
         }
         furniture.destroy();
      }
      
      public function removeFurnituresOnCell(cellId:int) : void
      {
         var i:int = 0;
         if(this._furnituresByCellId[cellId])
         {
            for(i = 0; i < this._furnituresByCellId[cellId].length; i++)
            {
               if(this._furnituresByCellId[cellId][i])
               {
                  this.removeFurniture(this._furnituresByCellId[cellId][i].id);
               }
            }
         }
      }
      
      public function removeAllFurnitures() : void
      {
         var gc:GraphicCell = null;
         var furniture:IFurniture = null;
         for each(furniture in this._furnituresById)
         {
            gc = InteractiveCellManager.getInstance().getCell(furniture.position.cellId);
            if(gc && (furniture.canWalkTo() || furniture.canWalkThrough()) && furniture.elementHeight > 0 && gc.y < gc.initialElevation)
            {
               InteractiveCellManager.getInstance().updateCellElevation(furniture.position.cellId,0);
            }
            furniture.destroy();
         }
         this._furnituresById = new Dictionary();
         this._furnituresByCellId = new Dictionary();
         this._walkableSupportYOffsetByCellId = new Dictionary();
      }
      
      public function previewFurniture(furniture:IFurniture) : void
      {
         var mp:MapPoint = null;
         var previousFurniture:IFurniture = null;
         var cellId:int = 0;
         var mp2:MapPoint = null;
         var supportFurniture:IFurniture = null;
         var cells:Vector.<MapPoint> = null;
         var furnitureCells:Vector.<MapPoint> = null;
         var furnitureToPlace:IFurniture = null;
         var i:int = 0;
         this._previewedFurniture = furniture;
         var cellsToUpdate:Dictionary = new Dictionary();
         for each(mp in this._previewedFurniture.cells)
         {
            cellsToUpdate[mp.cellId] = mp;
         }
         if(this._furnituresByCellId[this._previewedFurniture.position.cellId] && this._furnituresByCellId[this._previewedFurniture.position.cellId][this._previewedFurniture.layerId])
         {
            furnitureCells = this._furnituresByCellId[this._previewedFurniture.position.cellId][this._previewedFurniture.layerId].cells;
            for each(mp in furnitureCells)
            {
               cellsToUpdate[mp.cellId] = mp;
            }
         }
         for each(mp in cellsToUpdate)
         {
            cellId = mp.cellId;
            if(this._furnituresByCellId[cellId])
            {
               for(i = 0; i < this._furnituresByCellId[cellId].length; i++)
               {
                  if(this._furnituresByCellId[cellId][i] && (this._furnituresByCellId[cellId][i].cells.length == 1 || this._previewedFurniture.position.cellId == this._furnituresByCellId[cellId][i].position.cellId))
                  {
                     this._furnituresByCellId[cellId][i].remove();
                  }
                  if(i == HavenbagLayersEnum.SUPPORT && this._previewedFurniture.layerId == HavenbagLayersEnum.OBJECT)
                  {
                     supportFurniture = this._furnituresByCellId[cellId][i];
                  }
               }
            }
            this._furnituresOnPreviewedCells[cellId] = new Vector.<IFurniture>(3,true);
            for(i = 0; i < this._furnituresOnPreviewedCells[cellId].length; i++)
            {
               furnitureToPlace = null;
               if(i == this._previewedFurniture.layerId && this.isFurnitureOnCellId(this._previewedFurniture,cellId))
               {
                  furnitureToPlace = this._previewedFurniture;
               }
               else if(i != this._previewedFurniture.layerId && (this._furnituresByCellId[cellId] && this._furnituresByCellId[cellId][i]))
               {
                  furnitureToPlace = this._furnituresByCellId[cellId][i];
               }
               if(i <= this._previewedFurniture.layerId)
               {
                  this._furnituresOnPreviewedCells[cellId][i] = furnitureToPlace;
               }
               else if(!this._furnituresOnPreviewedCells[cellId][i - 1] || this._furnituresOnPreviewedCells[cellId][i - 1].isStackable)
               {
                  this._furnituresOnPreviewedCells[cellId][i] = furnitureToPlace;
               }
            }
            for(i = 0; i < this._furnituresOnPreviewedCells[cellId].length; i++)
            {
               if(this._furnituresOnPreviewedCells[cellId][i] && (this._furnituresOnPreviewedCells[cellId][i].cells.length == 1 || this._previewedFurniture.position.cellId == this._furnituresOnPreviewedCells[cellId][i].position.cellId))
               {
                  this.displayFurniture(this._furnituresOnPreviewedCells[cellId][i],this._furnituresOnPreviewedCells[cellId]);
               }
            }
            this.updateFurnituresY(cellId,this._furnituresOnPreviewedCells[cellId]);
         }
         cells = !!supportFurniture ? supportFurniture.cells : this._previewedFurniture.cells;
         var height:uint = !!supportFurniture ? uint(supportFurniture.elementHeight) : uint(0);
         this.displayPreviewSelection(cells,height);
      }
      
      public function cancelPreviewFurniture(furniture:IFurniture) : void
      {
         var key:* = null;
         var cellId:int = 0;
         var i:int = 0;
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_FURNITURE);
         if(s)
         {
            s.remove();
         }
         if(!this._furnituresOnPreviewedCells.length)
         {
            return;
         }
         for(key in this._furnituresOnPreviewedCells)
         {
            cellId = parseInt(key);
            if(this._furnituresOnPreviewedCells[cellId])
            {
               for(i = 0; i < this._furnituresOnPreviewedCells[cellId].length; i++)
               {
                  if(this._furnituresOnPreviewedCells[cellId][i] && (this._furnituresOnPreviewedCells[cellId][i].cells.length == 1 || this._previewedFurniture.position.cellId == this._furnituresOnPreviewedCells[cellId][i].position.cellId))
                  {
                     this._furnituresOnPreviewedCells[cellId][i].remove();
                  }
               }
               if(this._furnituresByCellId[cellId])
               {
                  for(i = 0; i < this._furnituresByCellId[cellId].length; i++)
                  {
                     if(this._furnituresByCellId[cellId][i] && (this._furnituresByCellId[cellId][i].cells.length == 1 || this._previewedFurniture.position.cellId == this._furnituresByCellId[cellId][i].position.cellId))
                     {
                        this.displayFurniture(this._furnituresByCellId[cellId][i]);
                     }
                  }
               }
               this.updateFurnituresY(cellId);
            }
         }
         this._previewedFurniture = null;
         this._furnituresOnPreviewedCells.length = 0;
      }
      
      public function getFurnituresOnCellId(cellId:int) : Vector.<IFurniture>
      {
         return this._furnituresByCellId[cellId];
      }
      
      public function getFurnitureById(furnitureId:Number) : IFurniture
      {
         return this._furnituresById[furnitureId];
      }
      
      public function enableMouseEvents() : void
      {
         var furniture:IFurniture = null;
         var cell:MapPoint = null;
         for each(furniture in this._furnituresById)
         {
            furniture.addEventListeners();
            for each(cell in furniture.cells)
            {
               InteractiveCellManager.getInstance().updateCell(cell.cellId,false);
            }
         }
      }
      
      public function disableMouseEvents() : void
      {
         var furniture:IFurniture = null;
         for each(furniture in this._furnituresById)
         {
            furniture.removeEventListeners();
         }
      }
      
      public function allowMovOnFurnitureCells() : void
      {
         var cellId:* = undefined;
         DataMapProvider.getInstance().resetUpdatedCell();
         for(cellId in this._furnituresByCellId)
         {
            DataMapProvider.getInstance().updateCellMovLov(cellId,true);
         }
      }
      
      public function updateMovOnFurnitureCells() : void
      {
         var furnitures:Vector.<IFurniture> = null;
         var mov:Boolean = false;
         var cellId:* = undefined;
         var i:int = 0;
         DataMapProvider.getInstance().resetUpdatedCell();
         InteractiveCellManager.getInstance().resetHavenbagCellsVisibility();
         for(cellId in this._furnituresByCellId)
         {
            furnitures = this._furnituresByCellId[cellId];
            mov = true;
            for(i = 0; i < furnitures.length; i++)
            {
               if(furnitures[i] && furnitures[i].canWalkThrough() == false)
               {
                  mov = false;
                  break;
               }
            }
            InteractiveCellManager.getInstance().updateCell(cellId,mov);
         }
      }
      
      public function restore(furnitures:Vector.<IFurniture> = null) : void
      {
         var furniture:IFurniture = null;
         var furnituresList:* = !!furnitures ? furnitures : this._furnituresById;
         for each(furniture in furnituresList)
         {
            this.addFurniture(furniture);
         }
         this.enableMouseEvents();
         this.updateMovOnFurnitureCells();
      }
      
      public function pack() : HavenbagPackedInfos
      {
         var furniture:IFurniture = null;
         var infos:HavenbagPackedInfos = new HavenbagPackedInfos();
         for each(furniture in this._furnituresById)
         {
            infos.furnitureTypeIds.push(furniture.typeId);
            infos.furnitureCellIds.push(furniture.position.cellId);
            infos.furnitureOrientations.push(furniture.orientation);
         }
         return infos;
      }
      
      public function sortFloorFurnitures(entity:DisplayObject, cellSprite:Sprite) : void
      {
         var f:IEntity = null;
         var cellId:* = undefined;
         var index:int = 0;
         var floorFurnitureCells:Vector.<IEntity> = new Vector.<IEntity>();
         for(cellId in this._furnituresByCellId)
         {
            f = this._furnituresByCellId[cellId][HavenbagLayersEnum.FLOOR] as IEntity;
            if(f)
            {
               floorFurnitureCells.push(f);
            }
         }
         index = floorFurnitureCells.indexOf(entity as IEntity);
         if(index == -1)
         {
            floorFurnitureCells.push(entity as IEntity);
         }
         floorFurnitureCells.sort(function compare(x:IEntity, y:IEntity):Number
         {
            if(x.position.cellId < y.position.cellId)
            {
               return -1;
            }
            if(x.position.cellId > y.position.cellId)
            {
               return 1;
            }
            return 0;
         });
         index = floorFurnitureCells.indexOf(entity as IEntity);
         cellSprite.parent.addChildAt(entity,index);
         if((cellSprite as GraphicCell).initialElevation > 0)
         {
            entity.y -= cellSprite.y - (cellSprite as GraphicCell).initialElevation;
         }
      }
      
      private function displayFurniture(furniture:IFurniture, furnituresOnCell:Vector.<IFurniture> = null) : void
      {
         var lowestCellId:int = 0;
         var highestCellId:int = 0;
         var cell:MapPoint = null;
         var logicalPositionPosition:MapPoint = null;
         var cellId:int = furniture.position.cellId;
         var furnitures:Vector.<IFurniture> = furnituresOnCell == null ? this._furnituresByCellId[cellId] : furnituresOnCell;
         if(furniture.layerId == HavenbagLayersEnum.OBJECT && furnitures && furnitures[HavenbagLayersEnum.SUPPORT] && furnitures[HavenbagLayersEnum.SUPPORT].cells.length > 1)
         {
            lowestCellId = AtouinConstants.MAP_CELLS_COUNT + 1;
            highestCellId = -1;
            for each(cell in furnitures[HavenbagLayersEnum.SUPPORT].cells)
            {
               if(cell.cellId > highestCellId)
               {
                  highestCellId = cell.cellId;
               }
               if(cell.cellId < lowestCellId)
               {
                  lowestCellId = cell.cellId;
               }
            }
            if(cellId != highestCellId)
            {
               logicalPositionPosition = MapPoint.fromCellId(cellId);
               furniture.position = MapPoint.fromCellId(highestCellId);
               furniture.remove();
               furniture.display(PlacementStrataEnums.STRATA_FURNITURE_ITEM + (cellId - lowestCellId));
               furniture.offsetPosition = logicalPositionPosition;
            }
            else
            {
               furniture.offsetPosition = furniture.position;
               furniture.display(PlacementStrataEnums.STRATA_FURNITURE_ITEM + (cellId - lowestCellId));
            }
         }
         else
         {
            furniture.offsetPosition = furniture.position;
            furniture.display();
         }
      }
      
      private function displayPreviewSelection(cells:Vector.<MapPoint>, height:uint) : void
      {
         var mp:MapPoint = null;
         var s:Selection = null;
         var cellIds:Vector.<uint> = new Vector.<uint>();
         for each(mp in cells)
         {
            cellIds.push(mp.cellId);
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_FURNITURE);
         if(!s)
         {
            s = new Selection();
            s.color = new Color(15395562);
            s.renderer = new FurnitureZoneRenderer(this._previewedFurniture.strata - 1);
            s.zone = new Custom(cellIds);
            (s.renderer as FurnitureZoneRenderer).height = height;
            SelectionManager.getInstance().addSelection(s,SELECTION_FURNITURE);
         }
         else
         {
            s.zone = new Custom(cellIds);
            (s.renderer as FurnitureZoneRenderer).strata = this._previewedFurniture.strata - 1;
            (s.renderer as FurnitureZoneRenderer).height = height;
            SelectionManager.getInstance().update(SELECTION_FURNITURE);
         }
      }
      
      private function isFurnitureOnCellId(furniture:IFurniture, cellId:int) : Boolean
      {
         var cells:Vector.<MapPoint> = furniture.cells;
         for(var i:int = 0; i < cells.length; i++)
         {
            if(cells[i].cellId == cellId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateFurnituresY(cellId:int, furnituresOnCell:Vector.<IFurniture> = null) : void
      {
         var furnitures:Vector.<IFurniture> = furnituresOnCell == null ? this._furnituresByCellId[cellId] : furnituresOnCell;
         if(!furnitures)
         {
            return;
         }
         var walkableSupportYOffset:int = 0;
         if(this._walkableSupportYOffsetByCellId[cellId])
         {
            walkableSupportYOffset = this._walkableSupportYOffsetByCellId[cellId];
         }
         if(walkableSupportYOffset == 0)
         {
            if(furnitures[HavenbagLayersEnum.FLOOR])
            {
               furnitures[HavenbagLayersEnum.FLOOR].updateContentY(0,cellId);
            }
            if(furnitures[HavenbagLayersEnum.SUPPORT])
            {
               furnitures[HavenbagLayersEnum.SUPPORT].updateContentY(0);
            }
            if(furnitures[HavenbagLayersEnum.OBJECT])
            {
               if(furnitures[HavenbagLayersEnum.SUPPORT])
               {
                  furnitures[HavenbagLayersEnum.OBJECT].updateContentY(furnitures[HavenbagLayersEnum.SUPPORT].elementHeight);
               }
               else
               {
                  furnitures[HavenbagLayersEnum.OBJECT].updateContentY();
               }
            }
         }
         else
         {
            if(furnitures[HavenbagLayersEnum.SUPPORT])
            {
               furnitures[HavenbagLayersEnum.SUPPORT].updateContentY(-walkableSupportYOffset);
            }
            if(furnitures[HavenbagLayersEnum.OBJECT])
            {
               if(furnitures[HavenbagLayersEnum.SUPPORT])
               {
                  furnitures[HavenbagLayersEnum.OBJECT].updateContentY(furnitures[HavenbagLayersEnum.SUPPORT].elementHeight - walkableSupportYOffset);
               }
               else
               {
                  furnitures[HavenbagLayersEnum.OBJECT].updateContentY(-walkableSupportYOffset);
               }
            }
         }
      }
   }
}
