package com.ankamagames.dofus.datacenter.bonus
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Bonus implements IDataCenter
   {
      
      public static const MODULE:String = "Bonuses";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getBonusById,null);
       
      
      public var id:int;
      
      public var type:uint;
      
      public var amount:int;
      
      public var criterionsIds:Vector.<int>;
      
      public function Bonus()
      {
         super();
      }
      
      public static function getBonusById(id:int) : Bonus
      {
         return GameData.getObject(MODULE,id) as Bonus;
      }
      
      public function isRespected(... pArgs) : Boolean
      {
         return false;
      }
   }
}
