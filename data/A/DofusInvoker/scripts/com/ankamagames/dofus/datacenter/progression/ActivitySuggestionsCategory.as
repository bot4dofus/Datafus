package com.ankamagames.dofus.datacenter.progression
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ActivitySuggestionsCategory implements IDataCenter
   {
      
      public static const MODULE:String = "ActivitySuggestionsCategories";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getActivitySuggestionsCategoryById,getActivitySuggestionsCategories);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var parentId:uint;
      
      private var _name:String;
      
      public function ActivitySuggestionsCategory()
      {
         super();
      }
      
      public static function getActivitySuggestionsCategoryById(id:int) : ActivitySuggestionsCategory
      {
         return GameData.getObject(MODULE,id) as ActivitySuggestionsCategory;
      }
      
      public static function getActivitySuggestionsCategories() : Array
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
   }
}
