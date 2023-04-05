package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class QuestObjectiveType implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestObjectiveType));
      
      public static const MODULE:String = "QuestObjectiveTypes";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getQuestObjectiveTypeById,getQuestObjectiveTypes);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function QuestObjectiveType()
      {
         super();
      }
      
      public static function getQuestObjectiveTypeById(id:int) : QuestObjectiveType
      {
         return GameData.getObject(MODULE,id) as QuestObjectiveType;
      }
      
      public static function getQuestObjectiveTypes() : Array
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
