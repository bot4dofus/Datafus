package com.ankamagames.dofus.datacenter.progression
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ActivitySuggestion implements IDataCenter
   {
      
      public static const MODULE:String = "ActivitySuggestions";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getActivitySuggestionById,getActivitySuggestions);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var categoryId:int;
      
      public var level:uint;
      
      public var mapId:Number;
      
      public var isLarge:Boolean;
      
      public var startDate:Number;
      
      public var endDate:Number;
      
      public var icon:String;
      
      private var _name:String;
      
      private var _description:String;
      
      public function ActivitySuggestion()
      {
         super();
      }
      
      public static function getActivitySuggestionById(id:int) : ActivitySuggestion
      {
         return GameData.getObject(MODULE,id) as ActivitySuggestion;
      }
      
      public static function getActivitySuggestions() : Array
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
   }
}
