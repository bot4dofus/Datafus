package com.ankamagames.atouin.data.map
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.DataFormatError;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.errors.IllegalOperationError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class Map
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Map));
      
      private static var decryptionKey:ByteArray = null;
       
      
      public var mapVersion:int;
      
      public var encrypted:Boolean;
      
      public var encryptionVersion:uint;
      
      public var groundCRC:int;
      
      public var zoomScale:Number = 1;
      
      public var zoomOffsetX:int;
      
      public var zoomOffsetY:int;
      
      public var groundCacheCurrentlyUsed:int = 0;
      
      public var id:Number;
      
      public var relativeId:int;
      
      public var mapType:int;
      
      public var backgroundsCount:int;
      
      public var backgroundFixtures:Vector.<Fixture>;
      
      public var foregroundsCount:int;
      
      public var foregroundFixtures:Vector.<Fixture>;
      
      public var subareaId:int;
      
      public var shadowBonusOnEntities:int;
      
      public var gridColor:uint;
      
      public var backgroundColor:uint;
      
      public var backgroundRed:int;
      
      public var backgroundGreen:int;
      
      public var backgroundBlue:int;
      
      public var backgroundAlpha:int = 0;
      
      public var topNeighbourId:Number;
      
      public var bottomNeighbourId:Number;
      
      public var leftNeighbourId:Number;
      
      public var rightNeighbourId:Number;
      
      public var cellsCount:int;
      
      public var layersCount:int;
      
      public var isUsingNewMovementSystem:Boolean = false;
      
      public var layers:Vector.<Layer>;
      
      public var cells:Vector.<CellData>;
      
      public var topArrowCell:Vector.<uint>;
      
      public var leftArrowCell:Vector.<uint>;
      
      public var bottomArrowCell:Vector.<uint>;
      
      public var rightArrowCell:Vector.<uint>;
      
      private var _parsed:Boolean;
      
      private var _failed:Boolean;
      
      private var _gfxList:Vector.<NormalGraphicalElementData>;
      
      private var _gfxCount:Array;
      
      public var tacticalModeTemplateId:int;
      
      public function Map()
      {
         this.topArrowCell = new Vector.<uint>();
         this.leftArrowCell = new Vector.<uint>();
         this.bottomArrowCell = new Vector.<uint>();
         this.rightArrowCell = new Vector.<uint>();
         super();
      }
      
      public function get parsed() : Boolean
      {
         return this._parsed;
      }
      
      public function get failed() : Boolean
      {
         return this._failed;
      }
      
      public function getGfxList(skipBackground:Boolean = false) : Vector.<NormalGraphicalElementData>
      {
         if(!this._gfxList)
         {
            this.computeGfxList(skipBackground);
         }
         return this._gfxList;
      }
      
      public function getGfxCount(gfxId:uint) : uint
      {
         if(!this._gfxList)
         {
            this.computeGfxList();
         }
         return this._gfxCount[gfxId];
      }
      
      public function fromRaw(raw:IDataInput) : void
      {
         var i:int = 0;
         var header:int = 0;
         var bg:Fixture = null;
         var la:Layer = null;
         var _oldMvtSystem:uint = 0;
         var cd:CellData = null;
         var dataLen:uint = 0;
         var encryptedData:ByteArray = null;
         var readColor:int = 0;
         var gridAlpha:int = 0;
         var gridRed:int = 0;
         var gridGreen:int = 0;
         var gridBlue:int = 0;
         var fg:Fixture = null;
         if(decryptionKey == null)
         {
            decryptionKey = new ByteArray();
            decryptionKey.writeMultiByte("649ae451ca33ec53bbcbcc33becf15f4","ascii");
         }
         try
         {
            header = raw.readByte();
            if(header != 77)
            {
               throw new DataFormatError("Unknown file format");
            }
            this.mapVersion = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Map version : " + this.mapVersion);
            }
            this.id = raw.readUnsignedInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Map id : " + this.id);
            }
            if(this.mapVersion >= 7)
            {
               this.encrypted = raw.readBoolean();
               this.encryptionVersion = raw.readByte();
               dataLen = raw.readInt();
               if(this.encrypted)
               {
                  if(!decryptionKey)
                  {
                     throw new IllegalOperationError("Map decryption key is empty");
                  }
                  encryptedData = new ByteArray();
                  raw.readBytes(encryptedData,0,dataLen);
                  for(i = 0; i < encryptedData.length; i++)
                  {
                     encryptedData[i] ^= decryptionKey[i % decryptionKey.length];
                  }
                  encryptedData.position = 0;
                  var raw:IDataInput = encryptedData;
               }
            }
            this.relativeId = raw.readUnsignedInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Map relativeId: " + this.relativeId);
            }
            this.mapType = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Map type : " + this.mapType);
            }
            this.subareaId = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Subarea id : " + this.subareaId);
            }
            this.topNeighbourId = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("topNeighbourId : " + this.topNeighbourId);
            }
            this.bottomNeighbourId = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("bottomNeighbourId : " + this.bottomNeighbourId);
            }
            this.leftNeighbourId = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("leftNeighbourId : " + this.leftNeighbourId);
            }
            this.rightNeighbourId = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("rightNeighbourId : " + this.rightNeighbourId);
            }
            this.shadowBonusOnEntities = raw.readUnsignedInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("ShadowBonusOnEntities : " + this.shadowBonusOnEntities);
            }
            if(this.mapVersion >= 9)
            {
               readColor = raw.readInt();
               this.backgroundAlpha = (readColor & 4278190080) >> 32;
               this.backgroundRed = (readColor & 16711680) >> 16;
               this.backgroundGreen = (readColor & 65280) >> 8;
               this.backgroundBlue = readColor & 255;
               readColor = raw.readUnsignedInt();
               gridAlpha = (readColor & 4278190080) >> 32;
               gridRed = (readColor & 16711680) >> 16;
               gridGreen = (readColor & 65280) >> 8;
               gridBlue = readColor & 255;
               this.gridColor = (gridAlpha & 255) << 32 | (gridRed & 255) << 16 | (gridGreen & 255) << 8 | gridBlue & 255;
            }
            else if(this.mapVersion >= 3)
            {
               this.backgroundRed = raw.readByte();
               this.backgroundGreen = raw.readByte();
               this.backgroundBlue = raw.readByte();
            }
            this.backgroundColor = (this.backgroundAlpha & 255) << 32 | (this.backgroundRed & 255) << 16 | (this.backgroundGreen & 255) << 8 | this.backgroundBlue & 255;
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("BackgroundColor : " + this.backgroundRed + "," + this.backgroundGreen + "," + this.backgroundBlue);
            }
            if(this.mapVersion >= 4)
            {
               this.zoomScale = raw.readUnsignedShort() / 100;
               this.zoomOffsetX = raw.readShort();
               this.zoomOffsetY = raw.readShort();
               if(this.zoomScale < 1)
               {
                  this.zoomScale = 1;
                  this.zoomOffsetX = this.zoomOffsetY = 0;
               }
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Zoom auto : " + this.zoomScale + "," + this.zoomOffsetX + "," + this.zoomOffsetY);
               }
            }
            if(this.mapVersion > 10)
            {
               this.tacticalModeTemplateId = raw.readInt();
            }
            this.backgroundsCount = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Backgrounds count : " + this.backgroundsCount);
            }
            this.backgroundFixtures = new Vector.<Fixture>(this.backgroundsCount,true);
            for(i = 0; i < this.backgroundsCount; i++)
            {
               bg = new Fixture(this);
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Background at index " + i + " :");
               }
               bg.fromRaw(raw);
               this.backgroundFixtures[i] = bg;
            }
            this.foregroundsCount = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Foregrounds count : " + this.foregroundsCount);
            }
            this.foregroundFixtures = new Vector.<Fixture>(this.foregroundsCount,true);
            for(i = 0; i < this.foregroundsCount; i++)
            {
               fg = new Fixture(this);
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Foreground at index " + i + " :");
               }
               fg.fromRaw(raw);
               this.foregroundFixtures[i] = fg;
            }
            this.cellsCount = AtouinConstants.MAP_CELLS_COUNT;
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Cells count : " + this.cellsCount);
            }
            raw.readInt();
            this.groundCRC = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("groundCRC : " + this.groundCRC);
            }
            this.layersCount = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("Layers count : " + this.layersCount);
            }
            this.layers = new Vector.<Layer>(this.layersCount,true);
            for(i = 0; i < this.layersCount; i++)
            {
               la = new Layer(this);
               if(AtouinConstants.DEBUG_FILES_PARSING)
               {
                  _log.debug("Layer at index " + i + " :");
               }
               la.fromRaw(raw,this.mapVersion);
               this.layers[i] = la;
            }
            this.cells = new Vector.<CellData>(this.cellsCount,true);
            for(i = 0; i < this.cellsCount; i++)
            {
               cd = new CellData(this,i);
               cd.fromRaw(raw);
               if(!_oldMvtSystem)
               {
                  _oldMvtSystem = cd.moveZone;
               }
               if(cd.moveZone != _oldMvtSystem)
               {
                  this.isUsingNewMovementSystem = true;
               }
               this.cells[i] = cd;
            }
            this.topArrowCell.fixed = true;
            this.leftArrowCell.fixed = true;
            this.bottomArrowCell.fixed = true;
            this.rightArrowCell.fixed = true;
            if(!AtouinConstants.DEBUG_FILES_PARSING)
            {
            }
            this._parsed = true;
         }
         catch(e:*)
         {
            _failed = true;
            throw e;
         }
      }
      
      private function computeGfxList(skipBackground:Boolean = false) : void
      {
         var l:int = 0;
         var c:int = 0;
         var e:int = 0;
         var lsCell:Vector.<Cell> = null;
         var numCell:int = 0;
         var lsElement:Vector.<BasicElement> = null;
         var numElement:int = 0;
         var layer:Layer = null;
         var cell:Cell = null;
         var element:BasicElement = null;
         var elementId:int = 0;
         var elementData:GraphicalElementData = null;
         var graphicalElementData:NormalGraphicalElementData = null;
         var gfx:NormalGraphicalElementData = null;
         var ele:Elements = Elements.getInstance();
         var gfxList:Array = new Array();
         this._gfxCount = new Array();
         var numLayer:int = this.layers.length;
         for(l = 0; l < numLayer; l++)
         {
            layer = this.layers[l];
            if(!(skipBackground && l == 0))
            {
               lsCell = layer.cells;
               numCell = lsCell.length;
               for(c = 0; c < numCell; c++)
               {
                  cell = lsCell[c];
                  lsElement = cell.elements;
                  numElement = lsElement.length;
                  for(e = 0; e < numElement; e++)
                  {
                     element = lsElement[e];
                     if(element.elementType == ElementTypesEnum.GRAPHICAL)
                     {
                        elementId = GraphicalElement(element).elementId;
                        elementData = ele.getElementData(elementId);
                        if(elementData == null)
                        {
                           _log.error("Unknown graphical element ID " + elementId);
                        }
                        else if(elementData is NormalGraphicalElementData)
                        {
                           graphicalElementData = elementData as NormalGraphicalElementData;
                           gfxList[graphicalElementData.gfxId] = graphicalElementData;
                           if(this._gfxCount[graphicalElementData.gfxId])
                           {
                              ++this._gfxCount[graphicalElementData.gfxId];
                           }
                           else
                           {
                              this._gfxCount[graphicalElementData.gfxId] = 1;
                           }
                        }
                     }
                  }
               }
            }
         }
         this._gfxList = new Vector.<NormalGraphicalElementData>();
         for each(gfx in gfxList)
         {
            this._gfxList.push(gfx);
         }
         this._gfxList.fixed = true;
      }
   }
}
