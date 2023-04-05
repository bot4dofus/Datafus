package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Companion implements IDataCenter
   {
      
      public static const MODULE:String = "Companions";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCompanionById,getCompanions);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var look:String;
      
      public var webDisplay:Boolean;
      
      public var descriptionId:uint;
      
      public var startingSpellLevelId:uint;
      
      public var assetId:uint;
      
      public var characteristics:Vector.<uint>;
      
      public var spells:Vector.<uint>;
      
      public var creatureBoneId:int;
      
      public var visibility:String;
      
      private var _name:String;
      
      private var _desc:String;
      
      public function Companion()
      {
         super();
      }
      
      public static function getCompanionById(id:uint) : Companion
      {
         return GameData.getObject(MODULE,id) as Companion;
      }
      
      public static function getCompanions() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String
      {
         if(!this._desc)
         {
            this._desc = I18n.getText(this.descriptionId);
         }
         return this._desc;
      }
      
      public function get visible() : Boolean
      {
         if(!this.visibility)
         {
            return true;
         }
         var gic:GroupItemCriterion = new GroupItemCriterion(this.visibility);
         return gic.isRespected;
      }
   }
}
