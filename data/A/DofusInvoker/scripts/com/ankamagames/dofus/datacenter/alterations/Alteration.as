package com.ankamagames.dofus.datacenter.alterations
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Alteration implements IDataCenter
   {
      
      public static const MODULE:String = "Alterations";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlterationById,getAlterations);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var categoryId:uint;
      
      public var iconId:uint;
      
      public var isVisible:Boolean;
      
      public var criteria:String;
      
      public var isWebDisplay:Boolean;
      
      public var possibleEffects:Vector.<EffectInstance> = null;
      
      private var _name:String = null;
      
      private var _description:String = null;
      
      private var _category:String = null;
      
      private var _conditions:GroupItemCriterion;
      
      public function Alteration()
      {
         super();
      }
      
      public static function getAlterationById(id:int) : Alteration
      {
         return GameData.getObject(MODULE,id) as Alteration;
      }
      
      public static function getAlterations() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(this._name === null)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get description() : String
      {
         if(this._description === null)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get category() : String
      {
         var exportedCategory:AlterationCategory = null;
         if(this._category === null)
         {
            exportedCategory = AlterationCategory.getAlterationCategoryById(this.categoryId);
            if(exportedCategory !== null)
            {
               this._category = exportedCategory.name;
            }
         }
         return this._category;
      }
      
      public function get conditions() : GroupItemCriterion
      {
         if(!this.criteria)
         {
            return null;
         }
         if(this._conditions === null)
         {
            this._conditions = new GroupItemCriterion(this.criteria);
         }
         return this._conditions;
      }
   }
}
