package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.map.TacticalModeCell;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.utils.IFightZoneRenderer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class TacticalModeRenderer implements IFightZoneRenderer
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TacticalModeRenderer));
       
      
      private var _cellsToRender:Vector.<TacticalModeCell>;
      
      private var _cells:Vector.<uint>;
      
      private var _gfxLoader:IResourceLoader;
      
      private var _displayedCells:Vector.<FakeCellContainer>;
      
      private var _mapId:Number;
      
      private var _strata:uint;
      
      public var reachableCells:Vector.<uint>;
      
      public function TacticalModeRenderer(cells:Vector.<TacticalModeCell>, mapId:Number, strata:uint)
      {
         super();
         this._mapId = mapId;
         this._cellsToRender = cells;
         this._strata = strata;
         this._gfxLoader = MapDisplayManager.getInstance().renderer.gfxLoader;
      }
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean = false, updateStrata:Boolean = false) : void
      {
         var tacticModeCell:TacticalModeCell = null;
         var elem:GraphicalElement = null;
         var elementData:NormalGraphicalElementData = null;
         var isJpg:Boolean = false;
         var uri:Uri = null;
         var path:* = null;
         this._cells = cells;
         this._gfxLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
         this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
         this._gfxLoader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded,false,0,true);
         this._gfxLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError,false,0,true);
         var gfxUriPaths:Vector.<String> = new Vector.<String>(0);
         var gfxUri:Array = [];
         for each(tacticModeCell in this._cellsToRender)
         {
            for each(elem in tacticModeCell.elements)
            {
               elementData = Elements.getInstance().getElementData(elem.elementId) as NormalGraphicalElementData;
               isJpg = Elements.getInstance().isJpg(elementData.gfxId);
               if(!isJpg && Atouin.getInstance().options.getOption("pngPathOverride"))
               {
                  path = Atouin.getInstance().options.getOption("pngPathOverride") + "/" + elementData.gfxId + ".png";
               }
               else
               {
                  path = Atouin.getInstance().options.getOption("elementsPath") + "/" + (!!isJpg ? Atouin.getInstance().options.getOption("jpgSubPath") : Atouin.getInstance().options.getOption("pngSubPath")) + "/" + elementData.gfxId + "." + (!!isJpg ? "jpg" : Atouin.getInstance().options.getOption("mapPictoExtension"));
               }
               if(gfxUriPaths.indexOf(path) == -1)
               {
                  gfxUriPaths.push(path);
                  uri = new Uri(path);
                  uri.tag = elementData.gfxId;
                  gfxUri.push(uri);
               }
            }
         }
         this._gfxLoader.load(gfxUri);
      }
      
      public function get currentStrata() : uint
      {
         return 0;
      }
      
      public function set currentStrata(s:uint) : void
      {
      }
      
      public function get showFarmCell() : Boolean
      {
         return false;
      }
      
      public function set showFarmCell(b:Boolean) : void
      {
      }
      
      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void
      {
         var cellContainer:FakeCellContainer = null;
         for each(cellContainer in this._displayedCells)
         {
            cellContainer.remove();
         }
         this._gfxLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
         this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
      }
      
      private function isReachable(cell:MapPoint) : Boolean
      {
         return cell && this.reachableCells.indexOf(cell.cellId) != -1 && MapPoint.isInMap(cell.x,cell.y);
      }
      
      private function onAllGfxLoaded(e:ResourceLoaderProgressEvent) : void
      {
         var cellId:uint = 0;
         var cellToRender:TacticalModeCell = null;
         var index:int = 0;
         var line:int = 0;
         var rnd:PRNG = null;
         var container:FakeCellContainer = null;
         var mask:Shape = null;
         var b:Rectangle = null;
         var vertices:Vector.<Number> = null;
         var currentCell:MapPoint = null;
         var currentY:Number = NaN;
         var numCells:uint = 0;
         var bottomCell:MapPoint = null;
         var leftCell:MapPoint = null;
         var rightCell:MapPoint = null;
         var leftVisible:Boolean = false;
         var rightVisible:Boolean = false;
         var lastRightCellWidthUpdated:Boolean = false;
         var offset:Number = NaN;
         var hoffset:Number = NaN;
         var i:int = 0;
         var skipOffset:Boolean = false;
         var mp:MapPoint = null;
         var offset2:Number = NaN;
         var w:Number = NaN;
         this._gfxLoader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllGfxLoaded);
         this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
         this._displayedCells = new Vector.<FakeCellContainer>(0);
         var groundCell:* = this._mapId == -1;
         if(!groundCell)
         {
            rnd = new ParkMillerCarta();
            rnd.seed(this._mapId + 5435);
         }
         for each(cellId in this._cells)
         {
            container = new FakeCellContainer(cellId);
            this._displayedCells.push(container);
            if(groundCell)
            {
               index = 0;
               if(this._cellsToRender && this._cellsToRender.length > 1)
               {
                  line = Math.floor(cellId / 14);
                  index = line % 2;
               }
               cellToRender = this._cellsToRender[index];
            }
            else
            {
               cellToRender = this._cellsToRender[rnd.nextIntR(0,this._cellsToRender.length - 1)];
            }
            MapDisplayManager.getInstance().renderer.addCellBitmapsElements(cellToRender,container);
            if(!groundCell)
            {
               mask = new Shape();
               b = container.getBounds(container);
               mask.graphics.beginFill(16711935);
               mask.graphics.drawRect(b.left,b.top,b.width,Math.abs(b.top) + AtouinConstants.CELL_HALF_HEIGHT);
               vertices = new Vector.<Number>(0);
               vertices.push(0,AtouinConstants.CELL_HALF_HEIGHT,AtouinConstants.CELL_HALF_WIDTH,AtouinConstants.CELL_HEIGHT,b.width,AtouinConstants.CELL_HALF_HEIGHT);
               currentCell = MapPoint.fromCellId(cellId);
               currentY = AtouinConstants.CELL_HEIGHT;
               numCells = Math.ceil(b.bottom / AtouinConstants.CELL_HEIGHT);
               leftVisible = true;
               rightVisible = true;
               lastRightCellWidthUpdated = false;
               offset = 0;
               hoffset = 0;
               for(i = 0; i < numCells; i++)
               {
                  leftCell = MapPoint.fromCoords(currentCell.x,currentCell.y - 1);
                  if(!MapPoint.isInMap(leftCell.x,leftCell.y))
                  {
                     leftCell = null;
                  }
                  rightCell = MapPoint.fromCoords(currentCell.x + 1,currentCell.y);
                  if(!MapPoint.isInMap(rightCell.x,rightCell.y))
                  {
                     rightCell = null;
                  }
                  bottomCell = MapPoint.fromCoords(currentCell.x + 1,currentCell.y - 1);
                  if(leftCell && (this.isReachable(leftCell) || this._cells.indexOf(leftCell.cellId) != -1))
                  {
                     leftVisible = false;
                  }
                  if(rightCell && (this.isReachable(rightCell) || this._cells.indexOf(rightCell.cellId) != -1))
                  {
                     rightVisible = false;
                     if(!lastRightCellWidthUpdated)
                     {
                        if(vertices.length == 6)
                        {
                           vertices[4] = AtouinConstants.CELL_WIDTH;
                        }
                        else
                        {
                           vertices[vertices.length - 1 - 5] = vertices[vertices.length - 1 - 13] = AtouinConstants.CELL_WIDTH;
                        }
                        lastRightCellWidthUpdated = true;
                     }
                  }
                  if(!(!this.isReachable(bottomCell) && this._cells.indexOf(bottomCell.cellId) == -1))
                  {
                     if(!this.isReachable(rightCell) && rightVisible || i == 0 && rightCell && this._cells.indexOf(rightCell.cellId) != -1)
                     {
                        vertices = vertices.slice(0,vertices.length - 6);
                        if(i > 0 && this.isReachable(MapPoint.fromCoords(currentCell.x - 1,currentCell.y)))
                        {
                           mask.graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_WIDTH,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,currentY);
                           mask.graphics.moveTo(AtouinConstants.CELL_WIDTH,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_WIDTH,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,currentY);
                        }
                        else
                        {
                           mask.graphics.moveTo(0,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_WIDTH,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                           mask.graphics.lineTo(AtouinConstants.CELL_WIDTH,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                        }
                     }
                     if(!this.isReachable(leftCell) && leftVisible)
                     {
                        vertices.push(0,currentY - AtouinConstants.CELL_HALF_HEIGHT,AtouinConstants.CELL_HALF_WIDTH + offset,currentY,0,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                     }
                  }
                  skipOffset = i > 0 && rightCell && this._cells.indexOf(rightCell.cellId) != -1;
                  if(leftVisible)
                  {
                     mp = MapPoint.fromCoords(bottomCell.x + 1,bottomCell.y - 1);
                     offset = rightVisible && this.isReachable(mp) ? Number(0) : Number(2);
                     mask.graphics.moveTo(0,currentY - AtouinConstants.CELL_HALF_HEIGHT);
                     mask.graphics.lineTo(0,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                     hoffset = offset;
                     if(offset != 0 && (this.isReachable(mp) || mp && this._cells.indexOf(mp.cellId) != -1))
                     {
                        hoffset = 0;
                     }
                     offset = !rightVisible && !skipOffset ? Number(offset) : Number(0);
                     mask.graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH + offset,Math.min(currentY + AtouinConstants.CELL_HEIGHT + hoffset,b.bottom));
                     mask.graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH + offset,currentY - 2);
                  }
                  if(rightVisible || !leftVisible && rightCell && this._cells.indexOf(rightCell.cellId) != -1 || skipOffset)
                  {
                     offset2 = !!this.isReachable(MapPoint.fromCoords(bottomCell.x + 1,bottomCell.y - 1)) ? Number(-2) : Number(0);
                     vertices.push(b.width,currentY - AtouinConstants.CELL_HALF_HEIGHT,AtouinConstants.CELL_HALF_WIDTH,currentY,b.width,currentY + AtouinConstants.CELL_HALF_HEIGHT,b.width,currentY + AtouinConstants.CELL_HALF_HEIGHT,AtouinConstants.CELL_HALF_WIDTH,currentY,AtouinConstants.CELL_HALF_WIDTH,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                     w = !!this.isReachable(MapPoint.fromCoords(bottomCell.x + 1,bottomCell.y)) ? Number(AtouinConstants.CELL_WIDTH) : Number(b.width);
                     vertices.push(offset2 != 0 ? AtouinConstants.CELL_WIDTH + offset2 : w,currentY + AtouinConstants.CELL_HALF_HEIGHT,AtouinConstants.CELL_HALF_WIDTH,currentY + AtouinConstants.CELL_HEIGHT + offset2,AtouinConstants.CELL_HALF_WIDTH,currentY + AtouinConstants.CELL_HALF_HEIGHT);
                  }
                  currentY += AtouinConstants.CELL_HEIGHT;
                  currentCell = bottomCell;
               }
               mask.graphics.drawTriangles(vertices);
               mask.graphics.endFill();
               container.addChild(mask);
               container.mask = mask;
            }
            container.display(this._strata);
         }
      }
      
      private function onGfxError(e:ResourceErrorEvent) : void
      {
         _log.error("Unable to load " + e.uri);
      }
   }
}

import com.ankamagames.atouin.Atouin;
import com.ankamagames.atouin.enums.PlacementStrataEnums;
import com.ankamagames.atouin.managers.EntitiesDisplayManager;
import com.ankamagames.atouin.managers.InteractiveCellManager;
import com.ankamagames.atouin.types.CellContainer;
import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
import com.ankamagames.jerakine.interfaces.IRectangle;
import com.ankamagames.jerakine.types.positions.MapPoint;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

class FakeCellContainer extends CellContainer implements IDisplayable
{
   
   private static var no_z_render_strata:Sprite = new Sprite();
    
   
   private var _strata:uint;
   
   function FakeCellContainer(cellId:uint)
   {
      super(cellId);
      mouseEnabled = false;
      mouseChildren = false;
   }
   
   public function get displayBehaviors() : IDisplayBehavior
   {
      return null;
   }
   
   public function set displayBehaviors(oValue:IDisplayBehavior) : void
   {
   }
   
   public function get displayed() : Boolean
   {
      return false;
   }
   
   public function get absoluteBounds() : IRectangle
   {
      return null;
   }
   
   public function display(strata:uint = 0) : void
   {
      var selectionCtr:DisplayObjectContainer = null;
      this._strata = strata;
      var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(cellId);
      if(this._strata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
      {
         x = cellSprite.x;
         y = cellSprite.y;
         no_z_render_strata.addChild(this);
         selectionCtr = Atouin.getInstance().selectionContainer;
         if(selectionCtr != null && !selectionCtr.contains(no_z_render_strata))
         {
            selectionCtr.addChildAt(no_z_render_strata,0);
            no_z_render_strata.cacheAsBitmap = true;
         }
      }
      else
      {
         EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(cellId),this._strata,false);
         x -= cellSprite.width / 2 - 1;
         y -= cellSprite.height / 2 - 1;
      }
   }
   
   public function remove() : void
   {
      if(this._strata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
      {
         if(no_z_render_strata.contains(this))
         {
            no_z_render_strata.removeChild(this);
         }
         if(no_z_render_strata.numChildren <= 0 && Atouin.getInstance().selectionContainer && Atouin.getInstance().selectionContainer.contains(no_z_render_strata))
         {
            Atouin.getInstance().selectionContainer.removeChild(no_z_render_strata);
         }
      }
      else
      {
         EntitiesDisplayManager.getInstance().removeEntity(this);
      }
   }
}
