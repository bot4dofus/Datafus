package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AchievementObjective implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AchievementObjective));
      
      public static const MODULE:String = "AchievementObjectives";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAchievementObjectiveById,getAchievementObjectives);
       
      
      public var id:uint;
      
      public var achievementId:uint;
      
      public var order:uint;
      
      public var nameId:uint;
      
      public var criterion:String;
      
      private var _name:String;
      
      public function AchievementObjective()
      {
         super();
      }
      
      public static function getAchievementObjectiveById(id:int) : AchievementObjective
      {
         return GameData.getObject(MODULE,id) as AchievementObjective;
      }
      
      public static function getAchievementObjectives() : Array
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
