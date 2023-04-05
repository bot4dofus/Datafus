package com.ankamagames.dofus.datacenter.breach
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachWorldMapSector implements IDataCenter
   {
      
      public static const MODULE:String = "BreachWorldMapSectors";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreachWorldMapSectorById,getAllBreachWorldMapSectors);
       
      
      public var id:uint;
      
      public var sectorNameId:uint;
      
      public var legendId:uint;
      
      public var sectorIcon:String;
      
      public var minStage:int;
      
      public var maxStage:int;
      
      private var _name:String;
      
      private var _legend:String;
      
      public function BreachWorldMapSector()
      {
         super();
      }
      
      public static function getBreachWorldMapSectorById(id:int) : BreachWorldMapSector
      {
         return GameData.getObject(MODULE,id) as BreachWorldMapSector;
      }
      
      public static function getAllBreachWorldMapSectors() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.sectorNameId);
         }
         return this._name;
      }
      
      public function get legend() : String
      {
         if(!this._legend)
         {
            this._legend = I18n.getText(this.legendId);
         }
         return this._legend;
      }
   }
}
