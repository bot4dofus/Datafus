package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.ZoneTile;
   import com.ankamagames.atouin.utils.IFightZoneRenderer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import flash.utils.getQualifiedClassName;
   
   public class ZoneDARenderer implements IFightZoneRenderer
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ZoneDARenderer));
      
      private static var zoneTileCache:Array = new Array();
       
      
      protected var _cells:Vector.<uint>;
      
      protected var _aZoneTile:Array;
      
      protected var _aCellTile:Array;
      
      private var _alpha:Number = 0.7;
      
      protected var _fixedStrata:Boolean;
      
      protected var _strata:uint;
      
      private var _currentStrata:uint = 0;
      
      private var _showFarmCell:Boolean = true;
      
      public function ZoneDARenderer(nStrata:uint = 0, alpha:Number = 1, fixedStrata:Boolean = false)
      {
         super();
         this._aZoneTile = new Array();
         this._aCellTile = new Array();
         this._strata = nStrata;
         this._fixedStrata = fixedStrata;
         this.currentStrata = !this._fixedStrata && Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(this._strata);
         this._alpha = alpha;
      }
      
      private static function getZoneTile() : ZoneTile
      {
         if(zoneTileCache.length)
         {
            return zoneTileCache.shift();
         }
         return new ZoneTile();
      }
      
      private static function destroyZoneTile(zt:ZoneTile) : void
      {
         zt.remove();
         zoneTileCache.push(zt);
      }
      
      public function get showFarmCell() : Boolean
      {
         return this._showFarmCell;
      }
      
      public function set showFarmCell(value:Boolean) : void
      {
         this._showFarmCell = value;
      }
      
      public function get currentStrata() : uint
      {
         return this._currentStrata;
      }
      
      public function set currentStrata(value:uint) : void
      {
         this._currentStrata = value;
      }
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, bAlpha:Boolean = false, updateStrata:Boolean = false) : void
      {
         var j:int = 0;
         var zt:ZoneTile = null;
         var cellData:CellData = null;
         this._cells = cells;
         var num:int = cells.length;
         var dataMap:Map = MapDisplayManager.getInstance().getDataMapContainer().dataMap;
         for(j = 0; j < num; j++)
         {
            cellData = dataMap.cells[cells[j]];
            if(!(!this.showFarmCell && cellData.farmCell))
            {
               zt = this._aZoneTile[j];
               if(!zt)
               {
                  zt = getZoneTile();
                  this._aZoneTile[j] = zt;
                  zt.strata = this.currentStrata;
               }
               this._aCellTile[j] = cells[j];
               zt.cellId = cells[j];
               zt.text = this.getText(j);
               zt.color = oColor;
               if(updateStrata || EntitiesDisplayManager.getInstance()._dStrataRef[zt] != this.currentStrata)
               {
                  zt.strata = EntitiesDisplayManager.getInstance()._dStrataRef[zt] = this.currentStrata;
               }
               zt.display();
               zt.alpha = this._alpha;
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
      
      protected function getText(count:int) : String
      {
         return null;
      }
      
      public function updateDisplay() : void
      {
         for(var j:int = 0; j < this._aZoneTile.length; j++)
         {
            if(this._aZoneTile[j])
            {
               this._aZoneTile[j].display(this._strata);
            }
         }
      }
      
      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void
      {
         var j:int = 0;
         var zt:ZoneTile = null;
         if(!cells)
         {
            return;
         }
         var count:int = 0;
         var mapping:Array = new Array();
         var num:int = cells.length;
         for(j = 0; j < num; j++)
         {
            mapping[cells[j]] = true;
         }
         num = this._aCellTile.length;
         for(var i:int = 0; i < num; i++)
         {
            if(mapping[this._aCellTile[i]])
            {
               count++;
               zt = this._aZoneTile[i];
               if(zt)
               {
                  destroyZoneTile(zt);
               }
               this._aCellTile.splice(i,1);
               this._aZoneTile.splice(i,1);
               i--;
               num--;
            }
         }
      }
      
      public function get fixedStrata() : Boolean
      {
         return this._fixedStrata;
      }
      
      public function set fixedStrata(value:Boolean) : void
      {
         this._fixedStrata = value;
      }
      
      public function restoreStrata() : void
      {
         this.currentStrata = this._strata;
      }
   }
}
