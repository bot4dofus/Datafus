package com.ankamagames.dofus.internalDatacenter.house
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.elements.GraphicalElementTypes;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.enums.HavenbagLayersEnum;
   import com.ankamagames.berilia.interfaces.ICustomSlotData;
   import com.ankamagames.dofus.datacenter.houses.HavenbagFurniture;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.ColorMultiplicator;
   import com.ankamagames.jerakine.types.Uri;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   public class HavenbagFurnitureWrapper extends HavenbagFurniture implements IDataCenter, ICustomSlotData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFurnitureWrapper));
      
      private static var _unknownElement:NormalGraphicalElementData;
      
      private static var _cache:Array = new Array();
      
      private static var _errorIconUri:Uri;
       
      
      private var _iconUri:Uri;
      
      private var _fullSizeIconUri:Uri;
      
      private var _element:NormalGraphicalElementData;
      
      private var _colorTransform:ColorTransform;
      
      private var _backGroundIconUri:Uri;
      
      public function HavenbagFurnitureWrapper()
      {
         super();
      }
      
      public static function create(furnitureTypeId:int) : HavenbagFurnitureWrapper
      {
         var furniture:HavenbagFurnitureWrapper = null;
         var refFurniture:HavenbagFurniture = null;
         if(!_cache[furnitureTypeId])
         {
            refFurniture = HavenbagFurniture.getFurniture(furnitureTypeId);
            if(!refFurniture)
            {
               _log.error("No furniture found with typeId " + furnitureTypeId + ", using a debug default one");
               refFurniture = new HavenbagFurniture();
               refFurniture.typeId = furnitureTypeId;
               refFurniture.themeId = 1;
               refFurniture.color = int.MAX_VALUE;
               refFurniture.layerId = HavenbagLayersEnum.FLOOR;
               refFurniture.blocksMovement = true;
               refFurniture.isStackable = false;
               refFurniture.elementId = 0;
               refFurniture.cellsWidth = 1;
               refFurniture.cellsHeight = 1;
               refFurniture.order = 0;
            }
            furniture = new HavenbagFurnitureWrapper();
            furniture.typeId = refFurniture.typeId;
            furniture.themeId = refFurniture.themeId;
            furniture.color = refFurniture.color;
            furniture.skillId = refFurniture.skillId;
            furniture.layerId = refFurniture.layerId;
            furniture.blocksMovement = refFurniture.blocksMovement;
            furniture.isStackable = refFurniture.isStackable;
            furniture.elementId = refFurniture.elementId;
            furniture.cellsWidth = refFurniture.cellsWidth;
            furniture.cellsHeight = refFurniture.cellsHeight;
            furniture.order = refFurniture.order;
            _cache[furnitureTypeId] = furniture;
         }
         else
         {
            furniture = _cache[furnitureTypeId];
         }
         return furniture;
      }
      
      public function get colorTransform() : ColorTransform
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         if(color != int.MAX_VALUE && !this._colorTransform)
         {
            r = (color & 16711680) >> 16;
            g = (color & 65280) >> 8;
            b = color & 255;
            this._colorTransform = new ColorTransform(ColorMultiplicator.clamp(r * 2,0,512) / 255,ColorMultiplicator.clamp(g * 2,0,512) / 255,ColorMultiplicator.clamp(b * 2,0,512) / 255);
         }
         return this._colorTransform;
      }
      
      public function get size() : Point
      {
         return this.element.size;
      }
      
      public function get iconUri() : Uri
      {
         if(!this._iconUri)
         {
            if(this.element)
            {
               this._iconUri = new Uri(Atouin.getInstance().options.getOption("elementsPath") + "/" + Atouin.getInstance().options.getOption("pngSubPath") + "/" + this.element.gfxId + "." + Atouin.getInstance().options.getOption("mapPictoExtension"));
            }
            else
            {
               this._iconUri = this.errorIconUri;
            }
         }
         return this._iconUri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return null;
      }
      
      public function get errorIconUri() : Uri
      {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri((XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap") as String).concat("error.png"));
         }
         return _errorIconUri;
      }
      
      public function get backGroundIconUri() : Uri
      {
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri((XmlConfig.getInstance().getEntry("config.ui.skin") as String).concat("texture/slot/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(bgUri:Uri) : void
      {
         this._backGroundIconUri = bgUri;
      }
      
      public function get info1() : String
      {
         return null;
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function get element() : NormalGraphicalElementData
      {
         if(!this._element)
         {
            this._element = Elements.getInstance().getElementData(elementId) as NormalGraphicalElementData;
            if(!this._element)
            {
               _log.error("Couldn\'t find the element " + elementId + " for furniture typeId " + typeId + ", loading default one");
               if(!_unknownElement)
               {
                  _unknownElement = new NormalGraphicalElementData(elementId,GraphicalElementTypes.NORMAL);
                  _unknownElement.gfxId = 0;
                  _unknownElement.height = 0;
                  _unknownElement.horizontalSymmetry = false;
                  _unknownElement.origin = new Point(16,16);
                  _unknownElement.size = new Point(32,32);
               }
               this._element = _unknownElement;
            }
         }
         return this._element;
      }
   }
}
