package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.ZoneClipTile;
   import com.ankamagames.atouin.utils.IFightZoneRenderer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.geom.ColorTransform;
   import flash.utils.getQualifiedClassName;
   
   public class ZoneClipRenderer implements IFightZoneRenderer
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ZoneClipRenderer));
      
      private static var zoneTile:Array = [];
       
      
      private var _uri:Uri;
      
      private var _clipNames:Array;
      
      private var _clipColors:Array;
      
      private var _currentMapId:Number;
      
      private var _needBorders:Boolean;
      
      protected var _aZoneTile:Array;
      
      protected var _aCellTile:Array;
      
      private var _currentStrata:uint = 0;
      
      private var _showFarmCell:Boolean = true;
      
      private var _useStrataOrderHack:Boolean = true;
      
      protected var _cells:Vector.<uint>;
      
      public function ZoneClipRenderer(nStrata:uint, pClipUri:String, pClipNames:Array, pCurrentMap:Number = -1, pNeedBorders:Boolean = false, pUseStrataOrderHack:Boolean = true, pClipColors:Array = null)
      {
         super();
         this._aZoneTile = [];
         this._aCellTile = [];
         if(pClipColors)
         {
            this._clipColors = pClipColors;
         }
         else
         {
            this._clipColors = [];
         }
         this.currentStrata = nStrata;
         this._currentMapId = pCurrentMap;
         this._needBorders = pNeedBorders;
         this._useStrataOrderHack = pUseStrataOrderHack;
         this._uri = new Uri(pClipUri);
         this._clipNames = pClipNames;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      private static function getZoneTile(pUri:Uri, pClipName:String, pNeedBorders:Boolean, color:ColorTransform) : ZoneClipTile
      {
         var zct:ZoneClipTile = null;
         var ct:CachedTile = getData(pUri.fileName,pClipName);
         if(ct.length)
         {
            return ct.shift();
         }
         return new ZoneClipTile(pUri,pClipName,pNeedBorders,color);
      }
      
      private static function destroyZoneTile(zt:ZoneClipTile) : void
      {
         zt.remove();
         var ct:CachedTile = getData(zt.uri.fileName,zt.clipName);
         ct.push(zt);
      }
      
      private static function getData(uri:String, clip:String) : CachedTile
      {
         var i:int = 0;
         var len:int = zoneTile.length;
         for(i = 0; i < len; i += 1)
         {
            if(zoneTile[i].uriName == uri && zoneTile[i].clipName == clip)
            {
               return zoneTile[i] as CachedTile;
            }
         }
         var e:CachedTile = new CachedTile(uri,clip);
         zoneTile.push(e);
         return e;
      }
      
      public function get clipNames() : Array
      {
         return this._clipNames;
      }
      
      public function set clipNames(value:Array) : void
      {
         this._clipNames = value;
      }
      
      public function get currentStrata() : uint
      {
         return this._currentStrata;
      }
      
      public function set currentStrata(value:uint) : void
      {
         this._currentStrata = value;
      }
      
      public function get showFarmCell() : Boolean
      {
         return this._showFarmCell;
      }
      
      public function set showFarmCell(value:Boolean) : void
      {
         this._showFarmCell = value;
      }
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, bAlpha:Boolean = false, updateStrata:Boolean = false) : void
      {
         var j:int = 0;
         var zt:ZoneClipTile = null;
         var color:ColorTransform = null;
         var clipName:String = null;
         var line:int = 0;
         var rnd:PRNG = null;
         var rndNum:int = 0;
         this._cells = cells;
         var num:int = cells.length;
         var index:int = 0;
         if(this._currentMapId > -1)
         {
            rnd = new ParkMillerCarta();
            rnd.seed(this._currentMapId + 5435);
            for(j = 0; j < num; j++)
            {
               if(!(!this.showFarmCell && mapContainer.dataMap.cells[cells[j]].farmCell))
               {
                  zt = this._aZoneTile[j];
                  if(!zt)
                  {
                     rndNum = rnd.nextIntR(0,this._clipNames.length * 8);
                     if(rndNum < 0 || rndNum > this._clipNames.length - 1)
                     {
                        rndNum = 0;
                     }
                     clipName = this._clipNames[rndNum];
                     if(this._clipColors && this._clipColors.length)
                     {
                        color = this._clipColors[rndNum];
                     }
                     zt = getZoneTile(this._uri,clipName,this._needBorders,color);
                     this._aZoneTile[j] = zt;
                     zt.strata = this.currentStrata;
                  }
                  this._aCellTile[j] = cells[j];
                  zt.cellId = cells[j];
                  if(updateStrata)
                  {
                     zt.strata = this.currentStrata;
                  }
                  zt.useStrataOrderHack = this._useStrataOrderHack;
                  zt.display();
               }
            }
         }
         else if(this._currentMapId == -2)
         {
            for(j = 0; j < num; j++)
            {
               if(!(!this.showFarmCell && mapContainer.dataMap.cells[cells[j]].farmCell))
               {
                  for(index = 0; index < this._clipNames.length; index++)
                  {
                     clipName = this._clipNames[index];
                     if(this._clipColors && this._clipColors.length)
                     {
                        color = this._clipColors[index];
                     }
                     zt = getZoneTile(this._uri,clipName,this._needBorders,color);
                     if(!this._aZoneTile[j])
                     {
                        this._aZoneTile[j] = [];
                     }
                     this._aZoneTile[j].push(zt);
                     zt.strata = this.currentStrata;
                     zt.cellId = cells[j];
                     if(updateStrata)
                     {
                        zt.strata = this.currentStrata;
                     }
                     zt.useStrataOrderHack = this._useStrataOrderHack;
                     zt.display();
                  }
                  this._aCellTile[j] = cells[j];
               }
            }
         }
         else
         {
            for(j = 0; j < num; j++)
            {
               if(!(!this.showFarmCell && mapContainer.dataMap.cells[cells[j]].farmCell))
               {
                  zt = this._aZoneTile[j];
                  if(!zt)
                  {
                     index = 0;
                     if(this._clipNames && this._clipNames.length > 1)
                     {
                        line = Math.floor(cells[j] / 14);
                        index = line % 2;
                     }
                     clipName = this._clipNames[index];
                     if(this._clipColors && this._clipColors.length)
                     {
                        color = this._clipColors[index];
                     }
                     zt = getZoneTile(this._uri,clipName,this._needBorders,color);
                     this._aZoneTile[j] = zt;
                     zt.strata = this.currentStrata;
                  }
                  this._aCellTile[j] = cells[j];
                  zt.cellId = cells[j];
                  if(updateStrata)
                  {
                     zt.strata = this.currentStrata;
                  }
                  zt.useStrataOrderHack = this._useStrataOrderHack;
                  zt.display();
               }
            }
         }
         while(j < num)
         {
            zt = this._aZoneTile[j];
            if(zt)
            {
               destroyZoneTile(zt);
            }
            j++;
         }
      }
      
      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void
      {
         var zt:ZoneClipTile = null;
         var cellId:uint = 0;
         var index:int = 0;
         if(!cells)
         {
            return;
         }
         for each(cellId in cells)
         {
            index = this._aCellTile.indexOf(cellId);
            if(index >= 0)
            {
               if(this._aZoneTile[index] is Array)
               {
                  for each(zt in this._aZoneTile[index])
                  {
                     if(zt)
                     {
                        destroyZoneTile(zt);
                     }
                  }
               }
               else
               {
                  zt = this._aZoneTile[index];
                  if(zt)
                  {
                     destroyZoneTile(zt);
                  }
               }
               this._aCellTile.splice(index,1);
               this._aZoneTile.splice(index,1);
            }
         }
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         var zt:ZoneClipTile = null;
         var j:int = 0;
         if(e.propertyName == "transparentOverlayMode")
         {
            for(j = 0; j < this._aZoneTile.length; j++)
            {
               if(this._aZoneTile[j] is Array)
               {
                  for each(zt in this._aZoneTile[j])
                  {
                     if(zt)
                     {
                        zt.remove();
                        zt.display();
                     }
                  }
               }
               else
               {
                  zt = this._aZoneTile[j];
                  zt.remove();
                  zt.display();
               }
            }
         }
      }
   }
}

import com.ankamagames.atouin.types.ZoneClipTile;
import com.ankamagames.jerakine.logger.Log;
import com.ankamagames.jerakine.logger.Logger;
import flash.utils.getQualifiedClassName;

class CachedTile
{
   
   protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CachedTile));
    
   
   public var uriName:String;
   
   public var clipName:String;
   
   private var _list:Vector.<ZoneClipTile>;
   
   function CachedTile(pName:String, pClip:String)
   {
      super();
      this.uriName = pName;
      this.clipName = pClip;
      this._list = new Vector.<ZoneClipTile>();
   }
   
   public function push(value:ZoneClipTile) : void
   {
      this._list.push(value);
   }
   
   public function shift() : ZoneClipTile
   {
      return this._list.shift();
   }
   
   public function get length() : uint
   {
      return this._list.length;
   }
}
