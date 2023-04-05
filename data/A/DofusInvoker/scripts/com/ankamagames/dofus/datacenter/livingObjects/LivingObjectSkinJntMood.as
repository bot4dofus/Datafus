package com.ankamagames.dofus.datacenter.livingObjects
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class LivingObjectSkinJntMood implements IDataCenter
   {
      
      public static const MODULE:String = "LivingObjectSkinJntMood";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpeakingItemText));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getLivingObjectSkin,getLivingObjectSkins);
       
      
      public var skinId:int;
      
      public var moods:Vector.<Vector.<int>>;
      
      public function LivingObjectSkinJntMood()
      {
         super();
      }
      
      public static function getLivingObjectSkin(objectId:int, moodId:int, skinId:int) : int
      {
         var losjm:LivingObjectSkinJntMood = GameData.getObject(MODULE,objectId) as LivingObjectSkinJntMood;
         if(!losjm || !losjm.moods[moodId])
         {
            return 0;
         }
         var ve:Vector.<int> = losjm.moods[moodId] as Vector.<int>;
         if(skinId <= ve.length)
         {
            return ve[Math.max(0,skinId - 1)];
         }
         return -1;
      }
      
      public static function getLivingObjectSkins() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
