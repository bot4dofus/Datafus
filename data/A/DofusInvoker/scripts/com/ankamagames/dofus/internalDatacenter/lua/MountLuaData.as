package com.ankamagames.dofus.internalDatacenter.lua
{
   public dynamic class MountLuaData
   {
       
      
      public var level:int;
      
      public var coefficient:Number;
      
      public var bonusAlmanac:Number;
      
      public var wise:Number;
      
      public function MountLuaData(pLevel:int = 0, pCoefficient:Number = 0, pBonusAlmanac:Number = 0, pWise:Number = 1)
      {
         super();
         this.level = pLevel;
         this.coefficient = pCoefficient;
         this.bonusAlmanac = pBonusAlmanac;
         this.wise = pWise;
      }
      
      public function toString() : String
      {
         return "level=" + this.level + ";coefficient=" + this.coefficient + ";bonusAlmanach=" + this.bonusAlmanac + ";wise=" + this.wise + ";";
      }
   }
}
