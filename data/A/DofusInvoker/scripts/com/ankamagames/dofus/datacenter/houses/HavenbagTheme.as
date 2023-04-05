package com.ankamagames.dofus.datacenter.houses
{
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class HavenbagTheme implements IDataCenter
   {
      
      public static const MODULE:String = "HavenbagThemes";
      
      private static var _mapIds:Vector.<Number>;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getTheme,getAllThemes);
       
      
      public var id:int;
      
      public var nameId:int;
      
      public var mapId:Number;
      
      private var _name:String;
      
      private var _furnitureIds:Vector.<uint>;
      
      public function HavenbagTheme()
      {
         super();
      }
      
      public static function getTheme(id:int) : HavenbagTheme
      {
         return GameData.getObject(MODULE,id) as HavenbagTheme;
      }
      
      public static function getAllThemes() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function isMapIdInHavenbag(mapId:Number) : Boolean
      {
         var tmpArr:Array = null;
         var i:int = 0;
         if(!_mapIds)
         {
            tmpArr = getAllThemes();
            _mapIds = new Vector.<Number>(tmpArr.length,true);
            for(i = 0; i < tmpArr.length; i++)
            {
               _mapIds[i] = tmpArr[i].mapId;
            }
         }
         return _mapIds.indexOf(mapId) != -1;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get furnitureIds() : Vector.<uint>
      {
         if(!this._furnitureIds)
         {
            this._furnitureIds = GameDataQuery.queryEquals(HavenbagFurniture,"themeId",this.id);
         }
         return this._furnitureIds;
      }
   }
}
