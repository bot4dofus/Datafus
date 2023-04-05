package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachBoss implements IDataCenter
   {
      
      public static const MODULE:String = "BreachBosses";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBreachBossById,getBreachBosses);
       
      
      public var id:int;
      
      public var monsterId:int;
      
      public var category:int;
      
      public var apparitionCriterion:String;
      
      public var accessCriterion:String;
      
      public var incompatibleBosses:Vector.<int>;
      
      public var rewardId:uint;
      
      public function BreachBoss()
      {
         super();
      }
      
      public static function getBreachBossById(id:int) : BreachBoss
      {
         return GameData.getObject(MODULE,id) as BreachBoss;
      }
      
      public static function getBreachBosses() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
