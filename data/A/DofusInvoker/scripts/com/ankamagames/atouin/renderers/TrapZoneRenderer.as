package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.TrapZoneTile;
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.Dictionary;
   
   public class TrapZoneRenderer implements IZoneRenderer
   {
      
      private static const COLOR_ALPHA:Number = 1;
      
      private static var _sharedZoneTiles:Dictionary = new Dictionary();
      
      private static var _sharedZoneTileRefCounts:Dictionary = new Dictionary();
       
      
      public var strata:uint;
      
      private var _sharedZoneTileBorders:Dictionary;
      
      private var _trapZoneTiles:Dictionary;
      
      private var _tileCellIds:Vector.<uint>;
      
      private var _isVisible:Boolean;
      
      private var _isThickLine:Boolean;
      
      private var _colorMatrixFilter:ColorMatrixFilter = null;
      
      private var _mapPointsByCellId:Dictionary;
      
      private var _hasRendered:Boolean = false;
      
      public function TrapZoneRenderer(strata:uint = 10, isVisible:Boolean = true, isThickLine:Boolean = false)
      {
         this._sharedZoneTileBorders = new Dictionary();
         super();
         this._trapZoneTiles = new Dictionary();
         this._tileCellIds = new Vector.<uint>(0);
         this._isVisible = isVisible;
         this._isThickLine = isThickLine;
         this.strata = strata;
      }
      
      private static function addColor(colorToAdd:Number, alphaToAdd:Number, currentColor:Number, currentAlpha:Number, newAlpha:Number) : Number
      {
         return (colorToAdd * alphaToAdd + currentColor * currentAlpha * (1 - alphaToAdd)) / newAlpha;
      }
      
      private static function addAlpha(alphaToAdd:Number, currentAlpha:Number) : Number
      {
         return alphaToAdd + currentAlpha * (1 - alphaToAdd);
      }
      
      private static function recomputeColorMatrixFilter(trapZoneTile:TrapZoneTile) : void
      {
         var trapZoneRenderer:TrapZoneRenderer = null;
         var trapZoneRenderers:Vector.<TrapZoneRenderer> = trapZoneTile.trapZoneRenderers;
         var areBaseValuesAdded:Boolean = false;
         var red:Number = 0;
         var green:Number = 0;
         var blue:Number = 0;
         var tileAlpha:Number = 0;
         var redToAdd:Number = 0;
         var greenToAdd:Number = 0;
         var blueToAdd:Number = 0;
         var alphaToAdd:Number = 0;
         var newAlpha:Number = 0;
         for each(trapZoneRenderer in trapZoneRenderers)
         {
            if(trapZoneRenderer.colorMatrixFilter !== null)
            {
               if(!areBaseValuesAdded)
               {
                  red = trapZoneRenderer.colorMatrixFilter.matrix[4];
                  green = trapZoneRenderer.colorMatrixFilter.matrix[9];
                  blue = trapZoneRenderer.colorMatrixFilter.matrix[14];
                  tileAlpha = TrapZoneTile.BASE_ALPHA;
                  areBaseValuesAdded = true;
               }
               else
               {
                  redToAdd = trapZoneRenderer.colorMatrixFilter.matrix[4];
                  greenToAdd = trapZoneRenderer.colorMatrixFilter.matrix[9];
                  blueToAdd = trapZoneRenderer.colorMatrixFilter.matrix[14];
                  alphaToAdd = TrapZoneTile.BASE_ALPHA;
                  newAlpha = addAlpha(alphaToAdd,tileAlpha);
                  red = addColor(redToAdd,alphaToAdd,red,tileAlpha,newAlpha);
                  green = addColor(greenToAdd,alphaToAdd,green,tileAlpha,newAlpha);
                  blue = addColor(blueToAdd,alphaToAdd,blue,tileAlpha,newAlpha);
                  tileAlpha = newAlpha;
               }
            }
         }
         trapZoneTile.filters = [new ColorMatrixFilter([0,0,0,0,red,0,0,0,0,green,0,0,0,0,blue,0,0,0,COLOR_ALPHA,0])];
         trapZoneTile.tileAlpha = tileAlpha;
      }
      
      public function get colorMatrixFilter() : ColorMatrixFilter
      {
         return this._colorMatrixFilter;
      }
      
      public function render(selectionCells:Vector.<uint>, trapZoneColor:Color, dataMapContainer:DataMapContainer, isAlpha:Boolean = false, isUpdateStrata:Boolean = false) : void
      {
         var trapZoneTile:TrapZoneTile = null;
         var currentMapPoint:MapPoint = null;
         var currentCellId:uint = 0;
         var index:uint = 0;
         var relatedTrapZoneTile:TrapZoneTile = null;
         var bordersDescr:BordersDescr = null;
         var areBordersRefreshed:Boolean = false;
         var currentColorMatrixFilter:ColorMatrixFilter = null;
         var currentRed:Number = NaN;
         var currentGreen:Number = NaN;
         var currentBlue:Number = NaN;
         var currentAlpha:Number = NaN;
         var newAlpha:Number = NaN;
         var newColorMatrixFilter:ColorMatrixFilter = null;
         if(this._hasRendered)
         {
            this.remove(selectionCells,dataMapContainer);
            this._hasRendered = false;
         }
         var selectionCellsNumber:int = selectionCells.length;
         this._colorMatrixFilter = new ColorMatrixFilter([0,0,0,0,trapZoneColor.red,0,0,0,0,trapZoneColor.green,0,0,0,0,trapZoneColor.blue,0,0,0,COLOR_ALPHA,0]);
         this._mapPointsByCellId = new Dictionary();
         for(index = 0; index < selectionCellsNumber; index++)
         {
            this._mapPointsByCellId[selectionCells[index]] = MapPoint.fromCellId(selectionCells[index]);
         }
         for(index = 0; index < selectionCellsNumber; index++)
         {
            currentCellId = selectionCells[index];
            trapZoneTile = this._trapZoneTiles[index];
            if(trapZoneTile === null)
            {
               if(!(currentCellId in _sharedZoneTiles))
               {
                  _sharedZoneTiles[currentCellId] = this._trapZoneTiles[index] = trapZoneTile = new TrapZoneTile();
                  trapZoneTile.mouseChildren = false;
                  trapZoneTile.mouseEnabled = false;
                  trapZoneTile.strata = this.strata;
                  trapZoneTile.visible = this._isVisible;
                  trapZoneTile.filters = [this._colorMatrixFilter];
                  _sharedZoneTileRefCounts[currentCellId] = 0;
               }
               else
               {
                  currentColorMatrixFilter = (this._trapZoneTiles[index] = _sharedZoneTiles[currentCellId]).filters[0] as ColorMatrixFilter;
                  currentRed = currentColorMatrixFilter.matrix[4];
                  currentGreen = currentColorMatrixFilter.matrix[9];
                  currentBlue = currentColorMatrixFilter.matrix[14];
                  currentAlpha = trapZoneTile.tileAlpha;
                  newAlpha = addAlpha(TrapZoneTile.BASE_ALPHA,currentAlpha);
                  newColorMatrixFilter = new ColorMatrixFilter([0,0,0,0,addColor(trapZoneColor.red,TrapZoneTile.BASE_ALPHA,currentRed,currentAlpha,newAlpha),0,0,0,0,addColor(trapZoneColor.green,TrapZoneTile.BASE_ALPHA,currentGreen,currentAlpha,newAlpha),0,0,0,0,addColor(trapZoneColor.blue,TrapZoneTile.BASE_ALPHA,currentBlue,currentAlpha,newAlpha),0,0,0,COLOR_ALPHA,0]);
                  trapZoneTile.filters = [newColorMatrixFilter];
                  trapZoneTile.tileAlpha = newAlpha;
               }
            }
            trapZoneTile.addTrapZoneRenderer(this);
            ++_sharedZoneTileRefCounts[currentCellId];
            this._tileCellIds[index] = selectionCells[index];
            currentMapPoint = this._mapPointsByCellId[currentCellId];
            trapZoneTile.cellId = currentCellId;
            relatedTrapZoneTile = TrapZoneTile(this._trapZoneTiles[index]);
            bordersDescr = this._sharedZoneTileBorders[currentCellId] = this.resolveBorders(currentCellId,relatedTrapZoneTile,selectionCells);
            areBordersRefreshed = false;
            if(bordersDescr.isTopBorder)
            {
               relatedTrapZoneTile.addTopBorderRef(this);
               areBordersRefreshed = true;
            }
            if(bordersDescr.isBottomBorder)
            {
               relatedTrapZoneTile.addBottomBorderRef(this);
               areBordersRefreshed = true;
            }
            if(bordersDescr.isLeftBorder)
            {
               relatedTrapZoneTile.addLeftBorderRef(this);
               areBordersRefreshed = true;
            }
            if(bordersDescr.isRightBorder)
            {
               relatedTrapZoneTile.addRightBorderRef(this);
               areBordersRefreshed = true;
            }
            if(areBordersRefreshed)
            {
               relatedTrapZoneTile.refreshBorders(this._isThickLine);
            }
            relatedTrapZoneTile.display(this.strata);
         }
         for(var trapZoneTilesNumber:int = this._trapZoneTiles.length; index < trapZoneTilesNumber; )
         {
            if(index in this._trapZoneTiles)
            {
               (this._trapZoneTiles[index] as TrapZoneTile).remove();
            }
            index++;
         }
         this._hasRendered = true;
      }
      
      public function updateDisplay() : void
      {
         var index:* = null;
         for(index in this._trapZoneTiles)
         {
            (this._trapZoneTiles[index] as TrapZoneTile).display(this.strata);
         }
      }
      
      public function remove(cellsToRemove:Vector.<uint>, dataMapContainer:DataMapContainer) : void
      {
         var index:uint = 0;
         var trapZoneTile:TrapZoneTile = null;
         var areBordersRefreshed:Boolean = false;
         var bordersDescr:BordersDescr = null;
         if(cellsToRemove === null || cellsToRemove.length <= 0)
         {
            return;
         }
         var cellsToRemoveByCellId:Dictionary = new Dictionary();
         for(index = 0; index < cellsToRemove.length; index++)
         {
            cellsToRemoveByCellId[cellsToRemove[index]] = true;
         }
         for(index = 0; index < this._tileCellIds.length; index++)
         {
            if(cellsToRemoveByCellId[this._tileCellIds[index]])
            {
               trapZoneTile = TrapZoneTile(this._trapZoneTiles[index]);
               if(bordersDescr !== null)
               {
                  areBordersRefreshed = false;
                  bordersDescr = this._sharedZoneTileBorders[trapZoneTile.cellId];
                  trapZoneTile.removeTrapZoneRenderer(this);
                  if(bordersDescr !== null)
                  {
                     if(bordersDescr.isLeftBorder)
                     {
                        trapZoneTile.removeLeftBorderRef(this);
                        areBordersRefreshed = true;
                     }
                     if(bordersDescr.isBottomBorder)
                     {
                        trapZoneTile.removeBottomBorderRef(this);
                        areBordersRefreshed = true;
                     }
                     if(bordersDescr.isTopBorder)
                     {
                        trapZoneTile.removeTopBorderRef(this);
                        areBordersRefreshed = true;
                     }
                     if(bordersDescr.isRightBorder)
                     {
                        trapZoneTile.removeRightBorderRef(this);
                        areBordersRefreshed = true;
                     }
                  }
                  --_sharedZoneTileRefCounts[trapZoneTile.cellId];
                  delete this._sharedZoneTileBorders[trapZoneTile.cellId];
                  if(_sharedZoneTileRefCounts[trapZoneTile.cellId] <= 0)
                  {
                     delete _sharedZoneTileRefCounts[trapZoneTile.cellId];
                     delete _sharedZoneTiles[trapZoneTile.cellId];
                     trapZoneTile.remove();
                  }
                  else
                  {
                     recomputeColorMatrixFilter(trapZoneTile);
                     if(areBordersRefreshed)
                     {
                        trapZoneTile.refreshBorders(this._isThickLine);
                     }
                     trapZoneTile.display(this.strata);
                  }
               }
               delete this._trapZoneTiles[index];
               delete this._tileCellIds[index];
            }
         }
      }
      
      private function resolveBorders(cellId:uint, trapZoneTile:TrapZoneTile, cells:Vector.<uint>) : BordersDescr
      {
         var cellsNumber:uint = cells.length;
         var isTopNeighbor:Boolean = false;
         var isBottomNeighbor:Boolean = false;
         var isLeftNeighbor:Boolean = false;
         var isRightNeighbor:Boolean = false;
         var relatedMapPoint:MapPoint = null;
         var mapPoint:MapPoint = this._mapPointsByCellId[cellId];
         for(var index:uint = 0; index < cellsNumber; index++)
         {
            if(cells[index] !== cellId)
            {
               relatedMapPoint = this._mapPointsByCellId[cells[index]];
               if(relatedMapPoint.x === mapPoint.x)
               {
                  if(relatedMapPoint.y === mapPoint.y - 1)
                  {
                     isTopNeighbor = true;
                  }
                  else if(relatedMapPoint.y === mapPoint.y + 1)
                  {
                     isBottomNeighbor = true;
                  }
               }
               else if(relatedMapPoint.y === mapPoint.y)
               {
                  if(relatedMapPoint.x === mapPoint.x - 1)
                  {
                     isRightNeighbor = true;
                  }
                  else if(relatedMapPoint.x === mapPoint.x + 1)
                  {
                     isLeftNeighbor = true;
                  }
               }
            }
         }
         return new BordersDescr(!isTopNeighbor,!isBottomNeighbor,!isLeftNeighbor,!isRightNeighbor);
      }
   }
}

class BordersDescr
{
    
   
   private var _isTopBorder:Boolean = false;
   
   private var _isBottomBorder:Boolean = false;
   
   private var _isLeftBorder:Boolean = false;
   
   private var _isRightBorder:Boolean = false;
   
   function BordersDescr(isTopBorder:Boolean, isBottomBorder:Boolean, isLeftBorder:Boolean, isRightBorder:Boolean)
   {
      super();
      this._isTopBorder = isTopBorder;
      this._isBottomBorder = isBottomBorder;
      this._isLeftBorder = isLeftBorder;
      this._isRightBorder = isRightBorder;
   }
   
   public function get isTopBorder() : Boolean
   {
      return this._isTopBorder;
   }
   
   public function get isBottomBorder() : Boolean
   {
      return this._isBottomBorder;
   }
   
   public function get isLeftBorder() : Boolean
   {
      return this._isLeftBorder;
   }
   
   public function get isRightBorder() : Boolean
   {
      return this._isRightBorder;
   }
}
