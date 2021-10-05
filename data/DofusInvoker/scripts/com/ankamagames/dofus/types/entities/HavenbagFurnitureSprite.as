package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.enums.HavenbagLayersEnum;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.HavenbagFurnituresManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.IFurniture;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.internalDatacenter.house.HavenbagFurnitureWrapper;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.FiltersManager;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HavenbagFurnitureSprite extends Sprite implements IFurniture
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFurnitureSprite));
      
      private static const _highlightFilter:GlowFilter = new GlowFilter(16777215,0.6,8,8);
      
      private static const _multiCellsHighlightFilter:GlowFilter = new GlowFilter(16777215,0.6,8,8,2,1,false,true);
      
      private static const _errorGlowFilter:GlowFilter = new GlowFilter(15073280,0.8,8,8,8,1);
      
      private static const _errorColorFilter:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,0,0,0.5,0,0,0,0,0,0.5,0,0,0,0,0,0.6,0]);
       
      
      private var _id:Number;
      
      private var _data:HavenbagFurnitureWrapper;
      
      private var _mp:MapPoint;
      
      private var _gfxLoader:IResourceLoader;
      
      private var _content:Bitmap;
      
      private var _uri:Uri;
      
      private var _layerId:int = 0;
      
      private var _strata:uint;
      
      private var _orientation:uint = 0;
      
      private var _onDisplayedCallback:Function;
      
      private var _cells:Vector.<MapPoint>;
      
      private var _subSprites:Vector.<HavenbagFurnitureSubSprite>;
      
      private var _cutOnLoaded:Boolean = false;
      
      private var _originalBitmapData:BitmapData;
      
      private var _offsetY:Number = 0;
      
      private var _offsetPosition:MapPoint;
      
      private var _offsetPositionPixels:Point;
      
      public function HavenbagFurnitureSprite(furnitureTypeId:int, onDisplayedCallback:Function = null)
      {
         this._offsetPositionPixels = new Point();
         super();
         this._data = HavenbagFurnitureWrapper.create(furnitureTypeId);
         this._layerId = this._data.layerId;
         this._strata = PlacementStrataEnums.STRATA_DEFAULT + this._layerId + 1;
         this._mp = new MapPoint();
         this._content = new Bitmap(null,PixelSnapping.NEVER);
         this._content.x = -this.element.origin.x;
         this._content.y = -this.element.origin.y;
         addChild(this._content);
         this._onDisplayedCallback = onDisplayedCallback;
         if(this.element.gfxId)
         {
            this._uri = new Uri(Atouin.getInstance().options.getOption("elementsPath") + "/" + Atouin.getInstance().options.getOption("pngSubPath") + "/" + this.element.gfxId + "." + Atouin.getInstance().options.getOption("mapPictoExtension"));
            this._gfxLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._gfxLoader.addEventListener(ResourceLoadedEvent.LOADED,this.onGfxLoaded);
            this._gfxLoader.addEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
            this._gfxLoader.load(this._uri);
         }
         else
         {
            this.onGfxError(null);
         }
         mouseEnabled = false;
         mouseChildren = false;
         if(this._data.colorTransform)
         {
            this._content.transform.colorTransform = this._data.colorTransform;
         }
      }
      
      public function get element() : NormalGraphicalElementData
      {
         return this._data.element;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function get layerId() : int
      {
         return this._layerId;
      }
      
      public function get isStackable() : Boolean
      {
         return this._data.isStackable;
      }
      
      public function get cellsWidth() : uint
      {
         return this.orientation % 2 == 0 ? uint(this._data.cellsWidth) : uint(this._data.cellsHeight);
      }
      
      public function get cellsHeight() : uint
      {
         return this.orientation % 2 == 0 ? uint(this._data.cellsHeight) : uint(this._data.cellsWidth);
      }
      
      public function set offsetPosition(mp:MapPoint) : void
      {
         var c1:GraphicCell = null;
         var c2:GraphicCell = null;
         this._offsetPosition = mp;
         if(this._offsetPositionPixels)
         {
            this._content.x += this._offsetPositionPixels.x;
            this._content.y += this._offsetPositionPixels.y;
         }
         if(this._offsetPosition != this.position)
         {
            c1 = InteractiveCellManager.getInstance().getCell(this._offsetPosition.cellId);
            c2 = InteractiveCellManager.getInstance().getCell(this.position.cellId);
            this._offsetPositionPixels.x = c2.x - c1.x;
            this._offsetPositionPixels.y = c2.y - c1.y;
            this._content.x -= this._offsetPositionPixels.x;
            this._content.y -= this._offsetPositionPixels.y;
            this.position = mp;
         }
         else
         {
            this._offsetPositionPixels.x = 0;
            this._offsetPositionPixels.y = 0;
         }
      }
      
      public function get offsetPosition() : MapPoint
      {
         return this._offsetPosition;
      }
      
      public function destroy() : void
      {
         this.remove();
         if(this._subSprites)
         {
            while(this._subSprites.length)
            {
               this._subSprites.pop().destroy();
            }
            this._subSprites = null;
         }
         this._originalBitmapData = null;
         this._cells = null;
         filters = [];
         this._data = null;
         this._mp = null;
         this._content.bitmapData = null;
         this._content = null;
         this._uri = null;
         this._offsetY = 0;
         this.destroyLoader();
      }
      
      public function addEventListeners() : void
      {
         var i:int = 0;
         buttonMode = true;
         mouseEnabled = true;
         if(this._subSprites)
         {
            for(i = 0; i < this._subSprites.length; i++)
            {
               this._subSprites[i].mouseEnabled = true;
               this._subSprites[i].buttonMode = true;
            }
         }
      }
      
      public function removeEventListeners() : void
      {
         var i:int = 0;
         buttonMode = false;
         mouseEnabled = false;
         if(this._subSprites)
         {
            for(i = 0; i < this._subSprites.length; i++)
            {
               this._subSprites[i].mouseEnabled = false;
               this._subSprites[i].buttonMode = false;
            }
         }
      }
      
      public function displayHighlight(display:Boolean) : void
      {
         var bdShape:BitmapData = null;
         if(display)
         {
            if(this._subSprites && this._subSprites.length > 1)
            {
               this._originalBitmapData = this._content.bitmapData.clone();
               bdShape = this._content.bitmapData.clone();
               bdShape.threshold(bdShape,bdShape.rect,new Point(),">",4278190080,4278190080,4294967295);
               this._content.alpha = 1;
               this._content.bitmapData = bdShape;
               FiltersManager.getInstance().addEffect(this,_multiCellsHighlightFilter);
            }
            else
            {
               FiltersManager.getInstance().addEffect(this,_highlightFilter);
            }
         }
         else if(this._originalBitmapData)
         {
            this._content.alpha = 0;
            this._content.bitmapData = this._originalBitmapData;
            this._originalBitmapData = null;
            FiltersManager.getInstance().removeEffect(this,_multiCellsHighlightFilter);
         }
         else
         {
            FiltersManager.getInstance().removeEffect(this,_highlightFilter);
         }
      }
      
      public function set orientation(v:uint) : void
      {
         if(v == 1)
         {
            this._orientation = 1;
            this._content.scaleX = -1;
            this._content.x = this.element.origin.x - this._offsetPositionPixels.x;
            this._content.y = -this.element.origin.y - this._offsetY - this._offsetPositionPixels.y;
            this._content.x += (this.cellsWidth > this.cellsHeight ? this.cellsWidth : this.cellsHeight) * AtouinConstants.CELL_WIDTH - AtouinConstants.CELL_WIDTH;
            if(this.cellsWidth != this.cellsHeight)
            {
               this._content.x -= AtouinConstants.CELL_HALF_WIDTH;
               if(this._data.cellsWidth < this._data.cellsHeight)
               {
                  this._content.y += AtouinConstants.CELL_HALF_HEIGHT;
               }
               else
               {
                  this._content.y -= AtouinConstants.CELL_HALF_HEIGHT;
               }
            }
            if(this._subSprites && this._subSprites.length)
            {
               this._subSprites.reverse();
               this.reorderSubSprites();
               if(this._data.cellsWidth != this._data.cellsHeight)
               {
                  this._cells = null;
               }
               if(this._content.alpha == 1)
               {
                  this.displayAsError();
               }
            }
         }
         else
         {
            this._orientation = 0;
            this._content.scaleX = 1;
            this._content.x = -this.element.origin.x - this._offsetPositionPixels.x;
            this._content.y = -this.element.origin.y - this._offsetY - this._offsetPositionPixels.y;
            if(this._subSprites && this._subSprites.length)
            {
               this._subSprites.reverse();
               this.reorderSubSprites();
               if(this._data.cellsWidth != this._data.cellsHeight)
               {
                  this._cells = null;
               }
               if(this._content.alpha == 1)
               {
                  this.displayAsError();
               }
            }
         }
      }
      
      public function get orientation() : uint
      {
         return this._orientation;
      }
      
      public function get hasHorizontalSymmetry() : Boolean
      {
         return this._orientation % 2 != 0;
      }
      
      public function get strata() : uint
      {
         return this._strata;
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
         return this._content && this._content.parent;
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return EntitiesDisplayManager.getInstance().getAbsoluteBounds(this);
      }
      
      public function get cells() : Vector.<MapPoint>
      {
         var cellIdx:int = 0;
         var i:int = 0;
         var j:int = 0;
         if(!this._cells)
         {
            this._cells = new Vector.<MapPoint>(this._data.cellsWidth * this._data.cellsHeight,true);
            this._cells[0] = new MapPoint();
         }
         if(this._cells[0].cellId != this.position.cellId)
         {
            this._cells[0].cellId = this.position.cellId;
            cellIdx = -1;
            for(i = 0; i < this.cellsWidth; i++)
            {
               for(j = 0; j < this.cellsHeight; j++)
               {
                  cellIdx++;
                  if(cellIdx != 0)
                  {
                     this._cells[cellIdx] = MapPoint.fromCoords(this.position.x + i,this.position.y + j);
                  }
               }
            }
         }
         return this._cells;
      }
      
      public function display(strata:uint = 0) : void
      {
         if(this._layerId != HavenbagLayersEnum.FLOOR)
         {
            EntitiesDisplayManager.getInstance().displayEntity(this,this.position,!!strata ? uint(strata) : uint(this._strata),false);
         }
         else
         {
            EntitiesDisplayManager.getInstance().displayEntity(this,this.position,this._strata,false,HavenbagFurnituresManager.getInstance().sortFloorFurnitures);
         }
         if(this._data.cellsWidth != 1 || this._data.cellsHeight != 1)
         {
            if(this._content.bitmapData)
            {
               this.cutGfx();
            }
            else
            {
               this._cutOnLoaded = true;
            }
         }
         FiltersManager.getInstance().removeEffect(this,_errorColorFilter);
         FiltersManager.getInstance().removeEffect(this,_errorGlowFilter);
      }
      
      public function displayAsError() : void
      {
         this.remove();
         var s:Selection = SelectionManager.getInstance().getSelection(HavenbagFurnituresManager.SELECTION_FURNITURE);
         if(s)
         {
            s.remove();
         }
         this._content.alpha = 1;
         if(FiltersManager.getInstance().indexOf(this,_errorColorFilter) == -1)
         {
            FiltersManager.getInstance().addEffect(this,_errorGlowFilter);
            FiltersManager.getInstance().addEffect(this,_errorColorFilter);
         }
         EntitiesDisplayManager.getInstance().displayEntity(this,this.position,PlacementStrataEnums.STRATA_NO_Z_ORDER,false);
      }
      
      public function remove() : void
      {
         var i:int = 0;
         this.displayHighlight(false);
         if(this._subSprites)
         {
            for(i = 0; i < this._subSprites.length; i++)
            {
               this._subSprites[i].remove();
            }
         }
         EntitiesDisplayManager.getInstance().removeEntity(this);
         FiltersManager.getInstance().removeEffect(this,_errorColorFilter);
         FiltersManager.getInstance().removeEffect(this,_errorGlowFilter);
      }
      
      public function canSeeThrough() : Boolean
      {
         return false;
      }
      
      public function canWalkThrough() : Boolean
      {
         return !this._data.blocksMovement;
      }
      
      public function canWalkTo() : Boolean
      {
         return !this._data.blocksMovement;
      }
      
      public function set id(value:Number) : void
      {
         throw new IllegalOperationError("Furniture id are automatically generated with EntitiesManager.getInstance().getFreeEntityId()");
      }
      
      public function get id() : Number
      {
         if(!this._id)
         {
            this._id = EntitiesManager.getInstance().getFreeEntityId();
         }
         return this._id;
      }
      
      public function get typeId() : int
      {
         return this._data.typeId;
      }
      
      public function get position() : MapPoint
      {
         return this._mp;
      }
      
      public function set position(oValue:MapPoint) : void
      {
         this._mp = oValue;
      }
      
      public function get elementHeight() : uint
      {
         return this.element.height * 10;
      }
      
      public function updateContentY(offsetY:Number = 0, cellId:int = -1) : void
      {
         var sub:HavenbagFurnitureSubSprite = null;
         this._offsetY = offsetY;
         this._content.y = -this.element.origin.y - this._offsetY - this._offsetPositionPixels.y;
         if(this.hasHorizontalSymmetry && this.cellsWidth != this.cellsHeight)
         {
            if(this._data.cellsWidth < this._data.cellsHeight)
            {
               this._content.y += AtouinConstants.CELL_HALF_HEIGHT;
            }
            else
            {
               this._content.y -= AtouinConstants.CELL_HALF_HEIGHT;
            }
         }
         if(cellId > -1 && this._subSprites)
         {
            for each(sub in this._subSprites)
            {
               if(sub.position.cellId == cellId)
               {
                  sub.y -= offsetY;
                  return;
               }
            }
         }
      }
      
      private function onGfxLoaded(e:ResourceLoadedEvent) : void
      {
         this._content.bitmapData = e.resource;
         this._content.smoothing = Atouin.getInstance().options.getOption("useSmooth");
         if(this._cutOnLoaded)
         {
            this.cutGfx();
         }
         this.destroyLoader();
      }
      
      private function onGfxError(e:ResourceErrorEvent) : void
      {
         _log.error("Failed to load GFX for furniture " + this.id);
         this._content.bitmapData = new BitmapData(this.element.size.x,this.element.size.y,false,16711935);
         this.destroyLoader();
      }
      
      private function destroyLoader() : void
      {
         if(this._gfxLoader)
         {
            this._gfxLoader.removeEventListener(ResourceLoadedEvent.LOADED,this.onGfxLoaded);
            this._gfxLoader.removeEventListener(ResourceErrorEvent.ERROR,this.onGfxError);
            this._gfxLoader = null;
         }
         if(this._onDisplayedCallback != null)
         {
            this._onDisplayedCallback();
            this._onDisplayedCallback = null;
         }
      }
      
      private function reorderSubSprites() : void
      {
         var mp:MapPoint = null;
         var subSpriteOrder:int = -1;
         var subSpriteIdx:uint = 0;
         var cellInBottomCorner:MapPoint = this.position;
         for(var i:int = 0; i < this.cellsWidth; i++)
         {
            subSpriteOrder++;
            mp = MapPoint.fromCoords(this.position.x + i,this.position.y);
            if(subSpriteIdx == this._subSprites.length)
            {
               break;
            }
            if((!!this.hasHorizontalSymmetry ? this.cellsWidth + this.cellsHeight - 2 - this._subSprites[subSpriteIdx].order : this._subSprites[subSpriteIdx].order) == subSpriteOrder)
            {
               this._subSprites[subSpriteIdx].position = mp;
               if(this.hasHorizontalSymmetry)
               {
                  this._subSprites[subSpriteIdx].scaleX = -1;
               }
               else
               {
                  this._subSprites[subSpriteIdx].scaleX = 1;
               }
               this._subSprites[subSpriteIdx].display();
               subSpriteIdx++;
            }
            cellInBottomCorner = mp;
         }
         for(var j:int = 1; j < this.cellsHeight; j++)
         {
            subSpriteOrder++;
            mp = MapPoint.fromCoords(cellInBottomCorner.x,cellInBottomCorner.y + j);
            if(subSpriteIdx == this._subSprites.length)
            {
               break;
            }
            if(subSpriteIdx < this._subSprites.length && (!!this.hasHorizontalSymmetry ? this.cellsWidth + this.cellsHeight - 2 - this._subSprites[subSpriteIdx].order : this._subSprites[subSpriteIdx].order) == subSpriteOrder)
            {
               this._subSprites[subSpriteIdx].position = mp;
               if(this.hasHorizontalSymmetry)
               {
                  this._subSprites[subSpriteIdx].scaleX = -1;
                  if(this.cellsHeight != this.cellsWidth)
                  {
                     this._subSprites[subSpriteIdx].getChildAt(0).x = this._subSprites[subSpriteIdx].getChildAt(0).x + (this.cellsHeight < this.cellsWidth ? -1 : 1) * AtouinConstants.CELL_HALF_WIDTH;
                     this._subSprites[subSpriteIdx].getChildAt(0).y = this._subSprites[subSpriteIdx].getChildAt(0).y - (this.cellsHeight < this.cellsWidth ? -1 : 1) * AtouinConstants.CELL_HALF_HEIGHT;
                  }
               }
               else
               {
                  this._subSprites[subSpriteIdx].scaleX = 1;
               }
               this._subSprites[subSpriteIdx].display();
               subSpriteIdx++;
            }
         }
      }
      
      private function cutGfx() : void
      {
         var stripBounds:Rectangle = null;
         var totalStripsWidth:uint = 0;
         var mp:MapPoint = null;
         var strip:Bitmap = null;
         var bd:BitmapData = null;
         var subSprite:HavenbagFurnitureSubSprite = null;
         var leftOverX:Number = NaN;
         var leftOverOffset:Number = NaN;
         var cellInBottomCorner:MapPoint = null;
         var i:int = 0;
         var j:int = 0;
         var gCellPos:Point = null;
         var gContentPos:Point = null;
         this._cutOnLoaded = false;
         var subSpriteOrder:int = -1;
         var originCellRow:uint = Math.floor(this.position.cellId / 14);
         var actualOrientation:uint = this._orientation;
         if(this._subSprites && this._subSprites.length)
         {
            this.reorderSubSprites();
            this._content.alpha = 0;
         }
         else
         {
            if(this.hasHorizontalSymmetry)
            {
               this.orientation = 0;
            }
            totalStripsWidth = 0;
            leftOverX = 0;
            leftOverOffset = 0;
            cellInBottomCorner = this.position;
            this._subSprites = new Vector.<HavenbagFurnitureSubSprite>();
            for(i = 0; i < this._data.cellsWidth; i++)
            {
               subSpriteOrder++;
               mp = MapPoint.fromCoords(this.position.x + i,this.position.y);
               stripBounds = new Rectangle();
               stripBounds.x = totalStripsWidth;
               stripBounds.y = 0;
               stripBounds.height = this._content.bitmapData.height;
               strip = new Bitmap(null,PixelSnapping.NEVER);
               if(this._data.colorTransform)
               {
                  strip.transform.colorTransform = this._data.colorTransform;
               }
               if(i == 0)
               {
                  gCellPos = InteractiveCellManager.getInstance().getCell(mp.cellId).localToGlobal(new Point(0,0));
                  gContentPos = this._content.localToGlobal(new Point(0,0));
                  stripBounds.width = Math.floor((gCellPos.x - gContentPos.x) / Atouin.getInstance().currentZoom + AtouinConstants.CELL_HALF_WIDTH);
                  strip.x = -stripBounds.width;
                  if(this.cellsWidth == 1)
                  {
                     stripBounds.width += AtouinConstants.CELL_HALF_WIDTH;
                  }
                  if(stripBounds.width <= 0)
                  {
                     leftOverX -= stripBounds.width;
                     leftOverOffset += AtouinConstants.CELL_WIDTH - leftOverX;
                     continue;
                  }
                  leftOverOffset += Math.floor(AtouinConstants.CELL_HALF_WIDTH + this._content.x);
               }
               else if(i == this._data.cellsWidth - 1)
               {
                  stripBounds.width = AtouinConstants.CELL_WIDTH + leftOverX;
                  strip.x = -stripBounds.width / 2;
               }
               else
               {
                  stripBounds.width = !!leftOverX ? Number(leftOverX) : Number(AtouinConstants.CELL_HALF_WIDTH);
                  strip.x = -stripBounds.width;
               }
               leftOverX = 0;
               totalStripsWidth += stripBounds.width;
               ++stripBounds.width;
               bd = new BitmapData(stripBounds.width,stripBounds.height,true,0);
               bd.copyPixels(this._content.bitmapData,stripBounds,new Point());
               strip.bitmapData = bd;
               strip.smoothing = Atouin.getInstance().options.getOption("useSmooth");
               strip.x -= this.element.origin.x - AtouinConstants.CELL_HALF_WIDTH + leftOverOffset;
               strip.y -= this.element.origin.y + i * AtouinConstants.CELL_HALF_HEIGHT;
               subSprite = new HavenbagFurnitureSubSprite(strip,this,mp,subSpriteOrder);
               if(!actualOrientation)
               {
                  subSprite.display();
               }
               this._subSprites.push(subSprite);
               cellInBottomCorner = mp;
            }
            for(j = 1; j < this._data.cellsHeight; j++)
            {
               subSpriteOrder++;
               mp = MapPoint.fromCoords(cellInBottomCorner.x,cellInBottomCorner.y + j);
               stripBounds = new Rectangle();
               stripBounds.x = totalStripsWidth;
               stripBounds.y = 0;
               stripBounds.height = this._content.bitmapData.height;
               strip = new Bitmap(null,PixelSnapping.NEVER);
               if(this._data.colorTransform)
               {
                  strip.transform.colorTransform = this._data.colorTransform;
               }
               if(j == this.cellsHeight - 1)
               {
                  stripBounds.width = this._content.bitmapData.width - stripBounds.x;
                  if(stripBounds.width <= 0)
                  {
                     continue;
                  }
               }
               else
               {
                  stripBounds.width = AtouinConstants.CELL_HALF_WIDTH;
               }
               totalStripsWidth += stripBounds.width;
               ++stripBounds.width;
               bd = new BitmapData(stripBounds.width,stripBounds.height,true,0);
               bd.copyPixels(this._content.bitmapData,stripBounds,new Point());
               strip.bitmapData = bd;
               strip.smoothing = Atouin.getInstance().options.getOption("useSmooth");
               strip.x -= this.element.origin.x - AtouinConstants.CELL_HALF_WIDTH + leftOverOffset;
               strip.y -= this.element.origin.y - (originCellRow - Math.floor(mp.cellId / 14)) * AtouinConstants.CELL_HALF_HEIGHT;
               subSprite = new HavenbagFurnitureSubSprite(strip,this,mp,subSpriteOrder);
               if(!actualOrientation)
               {
                  subSprite.display();
               }
               this._subSprites.push(subSprite);
            }
            this._content.alpha = 0;
            if(actualOrientation)
            {
               this.orientation = actualOrientation;
            }
         }
      }
   }
}
