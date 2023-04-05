package com.ankamagames.dofus.datacenter.progression
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FeatureDescription implements IDataCenter
   {
      
      public static const MODULE:String = "FeatureDescriptions";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getFeatureDescriptionById,getFeatureDescriptions);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var priority:uint;
      
      public var parentId:uint;
      
      public var children:Vector.<int>;
      
      public var criterion:String;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _canBeDisplayed:Boolean;
      
      public function FeatureDescription()
      {
         super();
      }
      
      public static function getFeatureDescriptionById(id:int) : FeatureDescription
      {
         return GameData.getObject(MODULE,id) as FeatureDescription;
      }
      
      public static function getFeatureDescriptions() : Array
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
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get canBeDisplayed() : Boolean
      {
         if(!this.criterion || this.criterion && this._canBeDisplayed)
         {
            return true;
         }
         var gic:GroupItemCriterion = new GroupItemCriterion(this.criterion);
         this._canBeDisplayed = gic.isRespected;
         return this._canBeDisplayed;
      }
   }
}
