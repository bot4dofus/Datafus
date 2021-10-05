package com.ankamagames.atouin.types
{
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.zones.IZone;
   import flash.utils.getQualifiedClassName;
   
   public class Selection
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Selection));
       
      
      private var _mapId:Number;
      
      public var renderer:IZoneRenderer;
      
      public var zone:IZone;
      
      public var cells:Vector.<uint>;
      
      public var color:Color;
      
      public var alpha:Boolean = true;
      
      public var cellId:uint;
      
      public var visible:Boolean;
      
      public function Selection()
      {
         super();
      }
      
      public function set mapId(id:Number) : void
      {
         this._mapId = id;
      }
      
      public function get mapId() : Number
      {
         if(isNaN(this._mapId))
         {
            return MapDisplayManager.getInstance().currentMapPoint.mapId;
         }
         return this._mapId;
      }
      
      public function update(pUpdateStrata:Boolean = false) : void
      {
         if(this.renderer)
         {
            this.renderer.render(this.cells,this.color,MapDisplayManager.getInstance().getDataMapContainer(),this.alpha,pUpdateStrata);
         }
         this.visible = true;
      }
      
      public function remove(aCells:Vector.<uint> = null) : void
      {
         if(this.renderer)
         {
            if(!aCells || aCells == this.cells)
            {
               this.renderer.remove(this.cells,MapDisplayManager.getInstance().getDataMapContainer());
               this.visible = false;
            }
            else
            {
               this.renderer.remove(aCells,MapDisplayManager.getInstance().getDataMapContainer());
            }
         }
      }
      
      public function isInside(cellId:uint) : Boolean
      {
         if(!this.cells)
         {
            return false;
         }
         for(var i:uint = 0; i < this.cells.length; i++)
         {
            if(this.cells[i] == cellId)
            {
               return true;
            }
         }
         return false;
      }
   }
}
