package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementCategory implements IDataCenter
   {
      
      public static const MODULE:String = "AchievementCategories";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAchievementCategoryById,getAchievementCategories);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var parentId:uint;
      
      public var icon:String;
      
      public var order:uint;
      
      public var color:String;
      
      public var achievementIds:Vector.<uint>;
      
      public var visibilityCriterion:String;
      
      private var _name:String;
      
      private var _achievements:Vector.<Achievement>;
      
      public function AchievementCategory()
      {
         super();
      }
      
      public static function getAchievementCategoryById(id:int) : AchievementCategory
      {
         return GameData.getObject(MODULE,id) as AchievementCategory;
      }
      
      public static function getAchievementCategories() : Array
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
      
      public function get achievements() : Vector.<Achievement>
      {
         var i:int = 0;
         var len:int = 0;
         if(!this._achievements)
         {
            len = this.achievementIds.length;
            this._achievements = new Vector.<Achievement>(len,true);
            for(i = 0; i < len; i++)
            {
               this._achievements[i] = Achievement.getAchievementById(this.achievementIds[i]);
            }
         }
         return this._achievements;
      }
      
      public function get visible() : Boolean
      {
         var gic:GroupItemCriterion = new GroupItemCriterion(this.visibilityCriterion);
         return gic.isRespected;
      }
   }
}
