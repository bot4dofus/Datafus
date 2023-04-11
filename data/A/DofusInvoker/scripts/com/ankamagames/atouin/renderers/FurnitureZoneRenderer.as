package com.ankamagames.atouin.renderers
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.FurnitureZoneTile;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class FurnitureZoneRenderer implements IZoneRenderer
   {
       
      
      private var _aZoneTile:Vector.<FurnitureZoneTile>;
      
      private var _aCellTile:Vector.<uint>;
      
      private var _visible:Boolean;
      
      public var strata:uint;
      
      public var height:int = 0;
      
      public function FurnitureZoneRenderer(nStrata:uint = 10, visible:Boolean = true)
      {
         super();
         this._aZoneTile = new Vector.<FurnitureZoneTile>();
         this._aCellTile = new Vector.<uint>();
         this._visible = visible;
         this.strata = nStrata;
      }
      
      public function render(cells:Vector.<uint>, oColor:Color, mapContainer:DataMapContainer, alpha:Boolean = false, updateStrata:Boolean = false) : void
      {
         var fzt:FurnitureZoneTile = null;
         var cellId:int = 0;
         var daCellId:uint = 0;
         var daPoint:MapPoint = null;
         var zzTop:Boolean = false;
         var zzBottom:Boolean = false;
         var zzRight:Boolean = false;
         var zzLeft:Boolean = false;
         var cid:uint = 0;
         var c1:GraphicCell = null;
         var c2:GraphicCell = null;
         var offset:Point = null;
         var mp:MapPoint = null;
         this._aZoneTile.length = cells.length;
         this._aCellTile.length = cells.length;
         var highestCellId:int = -1;
         if(this.strata == PlacementStrataEnums.STRATA_FURNITURE_ITEM - 1 && cells.length > 1)
         {
            for each(cellId in cells)
            {
               if(cellId > highestCellId)
               {
                  highestCellId = cellId;
               }
            }
         }
         for(var j:int = 0; j < cells.length; j++)
         {
            if(!this._aZoneTile[j])
            {
               (this._aZoneTile[j] = new FurnitureZoneTile()).strata = this.strata;
               fzt.visible = this._visible;
               fzt.filters = [new ColorMatrixFilter([0,0,0,0,oColor.red,0,0,0,0,oColor.green,0,0,0,0,oColor.blue,0,0,0,0.7,0])];
            }
            this._aCellTile[j] = cells[j];
            daCellId = cells[j];
            daPoint = MapPoint.fromCellId(daCellId);
            this._aZoneTile[j].cellId = daCellId;
            this._aZoneTile[j].needFill = this.height != 0;
            if(highestCellId != -1)
            {
               this._aZoneTile[j].cellId = highestCellId;
               if(daCellId != highestCellId)
               {
                  c1 = InteractiveCellManager.getInstance().getCell(daCellId);
                  c2 = InteractiveCellManager.getInstance().getCell(highestCellId);
                  offset = new Point(c2.x - c1.x,c2.y - c1.y);
                  this._aZoneTile[j].offset = offset;
               }
            }
            zzTop = false;
            zzBottom = false;
            zzRight = false;
            zzLeft = false;
            for each(cid in cells)
            {
               if(cid != daCellId)
               {
                  mp = MapPoint.fromCellId(cid);
                  if(mp.x == daPoint.x)
                  {
                     if(mp.y == daPoint.y - 1)
                     {
                        zzTop = true;
                     }
                     else if(mp.y == daPoint.y + 1)
                     {
                        zzBottom = true;
                     }
                  }
                  else if(mp.y == daPoint.y)
                  {
                     if(mp.x == daPoint.x - 1)
                     {
                        zzRight = true;
                     }
                     else if(mp.x == daPoint.x + 1)
                     {
                        zzLeft = true;
                     }
                  }
               }
            }
            this._aZoneTile[j].draw(zzTop,zzRight,zzBottom,zzLeft,this.height);
            this._aZoneTile[j].display(this.strata);
            if(highestCellId != -1)
            {
               this._aZoneTile[j].cellId = daCellId;
            }
         }
         while(j < this._aZoneTile.length)
         {
            if(this._aZoneTile[j])
            {
               this._aZoneTile[j].remove();
            }
            j++;
         }
      }
      
      public function remove(cells:Vector.<uint>, mapContainer:DataMapContainer) : void
      {
         if(!cells)
         {
            return;
         }
         var mapping:Array = new Array();
         for(var j:int = 0; j < cells.length; j++)
         {
            mapping[cells[j]] = true;
         }
         for(j = 0; j < this._aCellTile.length; j++)
         {
            if(mapping[this._aCellTile[j]])
            {
               if(this._aZoneTile[j])
               {
                  this._aZoneTile[j].remove();
               }
               delete this._aZoneTile[j];
               delete this._aCellTile[j];
            }
         }
      }
   }
}
