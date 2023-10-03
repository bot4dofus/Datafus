package com.ankamagames.dofus.internalDatacenter.lua
{
   public dynamic class MonsterLuaData
   {
       
      
      public var level:int;
      
      public var xp:int;
      
      public var hiddenLevel:uint;
      
      public var bonusFamily:Number = 1;
      
      public var bonusAlmanac:Number = 1;
      
      public var alive:Boolean;
      
      public function MonsterLuaData(pLevel:int, pXp:int, pHiddenLevel:uint, pBonusFamily:Number, pBonusAlmanac:Number, pAlive:Boolean)
      {
         super();
         this.level = pLevel;
         this.xp = pXp;
         this.hiddenLevel = pHiddenLevel;
         this.bonusFamily = pBonusFamily;
         this.bonusAlmanac = pBonusAlmanac;
         this.alive = pAlive;
      }
      
      public function toString() : String
      {
         return "level=" + this.level + ";xp=" + this.xp + ";hiddenLevel=" + this.hiddenLevel + ";bonusFamily=" + this.bonusFamily + ";bonusAlmanach=" + this.bonusAlmanac + ";alive=" + this.alive + ";";
      }
   }
}
