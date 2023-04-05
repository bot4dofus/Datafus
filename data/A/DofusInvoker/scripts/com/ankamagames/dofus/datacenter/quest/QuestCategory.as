package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class QuestCategory implements IDataCenter
   {
      
      public static const MODULE:String = "QuestCategory";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getQuestCategoryById,getQuestCategories);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var order:uint;
      
      public var questIds:Vector.<uint>;
      
      private var _name:String;
      
      private var _quests:Vector.<Quest>;
      
      public function QuestCategory()
      {
         super();
      }
      
      public static function getQuestCategoryById(id:int) : QuestCategory
      {
         return GameData.getObject(MODULE,id) as QuestCategory;
      }
      
      public static function getQuestCategories() : Array
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
      
      public function get quests() : Vector.<Quest>
      {
         var i:int = 0;
         var len:int = 0;
         if(!this._quests)
         {
            len = this.questIds.length;
            this._quests = new Vector.<Quest>(len,true);
            for(i = 0; i < len; i += 1)
            {
               this._quests[i] = Quest.getQuestById(this.questIds[i]);
            }
         }
         return this._quests;
      }
   }
}
