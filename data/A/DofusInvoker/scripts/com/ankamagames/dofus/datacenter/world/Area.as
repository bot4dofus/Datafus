package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class Area implements IDataCenter
   {
      
      public static const MODULE:String = "Areas";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Area));
      
      private static var _allAreas:Array;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAreaById,getAllArea);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var superAreaId:int;
      
      public var containHouses:Boolean;
      
      public var containPaddocks:Boolean;
      
      public var bounds:Rectangle;
      
      public var worldmapId:uint;
      
      public var hasWorldMap:Boolean;
      
      public var hasSuggestion:Boolean;
      
      private var _name:String;
      
      private var _undiatricalName:String;
      
      private var _superArea:SuperArea;
      
      private var _hasVisibleSubAreas:Boolean;
      
      private var _hasVisibleSubAreasInitialized:Boolean;
      
      private var _worldMap:WorldMap;
      
      public function Area()
      {
         super();
      }
      
      public static function getAreaById(id:int) : Area
      {
         var area:Area = GameData.getObject(MODULE,id) as Area;
         if(!area || !area.superArea || !area.hasVisibleSubAreas)
         {
            return null;
         }
         return area;
      }
      
      public static function getAllArea() : Array
      {
         if(_allAreas)
         {
            return _allAreas;
         }
         _allAreas = GameData.getObjects(MODULE) as Array;
         return _allAreas;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get undiatricalName() : String
      {
         if(!this._undiatricalName)
         {
            this._undiatricalName = StringUtils.noAccent(this.name).toLowerCase();
         }
         return this._undiatricalName;
      }
      
      public function get superArea() : SuperArea
      {
         if(!this._superArea)
         {
            this._superArea = SuperArea.getSuperAreaById(this.superAreaId);
         }
         return this._superArea;
      }
      
      public function get hasVisibleSubAreas() : Boolean
      {
         if(!this._hasVisibleSubAreasInitialized)
         {
            this._hasVisibleSubAreas = true;
            this._hasVisibleSubAreasInitialized = true;
         }
         return this._hasVisibleSubAreas;
      }
      
      public function get worldmap() : WorldMap
      {
         if(!this._worldMap)
         {
            if(!this.hasWorldMap)
            {
               this._worldMap = this.superArea.worldmap;
            }
            else
            {
               this._worldMap = WorldMap.getWorldMapById(this.worldmapId);
            }
         }
         return this._worldMap;
      }
   }
}
