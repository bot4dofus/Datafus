package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.dofus.types.enums.HintPriorityEnum;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.IPostInit;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Hint implements IDataCenter, IPostInit
   {
      
      public static const MODULE:String = "Hints";
      
      private static var _allHints:Array;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getHintById,getHints);
       
      
      public var id:int;
      
      public var gfx:uint;
      
      public var nameId:uint;
      
      public var mapId:Number;
      
      public var realMapId:Number;
      
      public var x:int;
      
      public var y:int;
      
      public var outdoor:Boolean;
      
      public var subareaId:int;
      
      public var worldMapId:int;
      
      public var level:uint;
      
      private var _categoryId:uint;
      
      private var _priority:uint;
      
      private var _name:String;
      
      private var _undiatricalName:String;
      
      private var _subArea:SubArea;
      
      public function Hint()
      {
         super();
      }
      
      public static function getHintById(id:int) : Hint
      {
         return GameData.getObject(MODULE,id) as Hint;
      }
      
      public static function getHints() : Array
      {
         if(!_allHints)
         {
            _allHints = GameData.getObjects(MODULE);
         }
         return _allHints;
      }
      
      public function get categoryId() : uint
      {
         return this._categoryId;
      }
      
      public function set categoryId(value:uint) : void
      {
         this._categoryId = value;
         switch(this._categoryId)
         {
            case DataEnum.HINT_CATEGORY_TEMPLES:
               this._priority = HintPriorityEnum.TEMPLES;
               break;
            case DataEnum.HINT_CATEGORY_BIDHOUSE:
            case DataEnum.HINT_CATEGORY_MISC:
               this._priority = HintPriorityEnum.MISC;
               break;
            case DataEnum.HINT_CATEGORY_CRAFT_HOUSES:
               this._priority = HintPriorityEnum.CRAFT_HOUSES;
               break;
            case DataEnum.HINT_CATEGORY_DUNGEONS:
               this._priority = HintPriorityEnum.DUNGEONS;
               break;
            case DataEnum.HINT_CATEGORY_TRANSPORTATIONS:
               this._priority = HintPriorityEnum.TRANSPORTS;
         }
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId).replace(" \\n ","\n");
         }
         return this._name;
      }
      
      public function get undiatricalName() : String
      {
         if(!this._undiatricalName)
         {
            this._undiatricalName = I18n.getUnDiacriticalText(this.nameId).replace(" \\n ","\n");
         }
         return this._undiatricalName;
      }
      
      public function get subArea() : SubArea
      {
         if(!this._subArea)
         {
            this._subArea = SubArea.getSubAreaByMapId(this.mapId);
         }
         return this._subArea;
      }
      
      public function get priority() : uint
      {
         return this._priority;
      }
      
      public function postInit() : void
      {
         this.name;
         this.undiatricalName;
      }
   }
}
