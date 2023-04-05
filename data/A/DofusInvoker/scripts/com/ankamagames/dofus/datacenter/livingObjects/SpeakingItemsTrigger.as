package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SpeakingItemsTrigger implements IDataCenter
   {
      
      public static const MODULE:String = "SpeakingItemsTriggers";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemsTrigger));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSpeakingItemsTriggerById,getSpeakingItemsTriggers);
       
      
      public var triggersId:int;
      
      public var textIds:Vector.<int>;
      
      public var states:Vector.<int>;
      
      public function SpeakingItemsTrigger()
      {
         super();
      }
      
      public static function getSpeakingItemsTriggerById(id:int) : SpeakingItemsTrigger
      {
         return GameData.getObject(MODULE,id) as SpeakingItemsTrigger;
      }
      
      public static function getSpeakingItemsTriggers() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
