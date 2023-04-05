package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterBonusCharacteristics implements IDataCenter
   {
       
      
      public var lifePoints:int;
      
      public var strength:int;
      
      public var wisdom:int;
      
      public var chance:int;
      
      public var agility:int;
      
      public var intelligence:int;
      
      public var earthResistance:int;
      
      public var fireResistance:int;
      
      public var waterResistance:int;
      
      public var airResistance:int;
      
      public var neutralResistance:int;
      
      public var tackleEvade:int;
      
      public var tackleBlock:int;
      
      public var bonusEarthDamage:int;
      
      public var bonusFireDamage:int;
      
      public var bonusWaterDamage:int;
      
      public var bonusAirDamage:int;
      
      public var APRemoval:int;
      
      public function MonsterBonusCharacteristics()
      {
         super();
      }
   }
}
