package com.ankamagames.dofus.internalDatacenter.lua
{
   public dynamic class PlayerLuaData extends GroupMemberLuaData
   {
       
      
      public var wisdom:int;
      
      public var xpBonusPercent:Number;
      
      public var isRiding:Boolean;
      
      public var rideXPBonus:Number;
      
      public var hasGuild:Boolean;
      
      public var xpGuildGivenPercent:Number;
      
      public var sharedXPCoefficient:Number;
      
      public var unsharedXPCoefficient:Number;
      
      public var bonusMap:Number;
      
      public var bonusAlmanac:Number;
      
      public function PlayerLuaData(pLevel:int, pIsStillPresentInFight:Boolean, pWisdom:int, pBonusMap:Number, pBonusAlmanac:Number, pXpBonusPercent:Number, pIsRiding:Boolean, pRideXpBonus:Number, pHasGuild:Boolean, pXpGuild:Number, pSharedXPCoefficient:Number, pUnsharedXPCoefficient:Number)
      {
         super(pLevel,false,pIsStillPresentInFight);
         this.wisdom = pWisdom;
         this.bonusMap = pBonusMap;
         this.bonusAlmanac = pBonusAlmanac;
         this.xpBonusPercent = pXpBonusPercent;
         this.isRiding = pIsRiding;
         this.hasGuild = pHasGuild;
         this.xpGuildGivenPercent = pXpGuild;
         this.sharedXPCoefficient = pSharedXPCoefficient;
         this.unsharedXPCoefficient = pUnsharedXPCoefficient;
         this.rideXPBonus = pRideXpBonus;
      }
      
      override public function toString() : String
      {
         return super.toString() + "wisdom=" + this.wisdom + ";bonusMap=" + this.bonusMap + ";bonusAlmanach=" + this.bonusAlmanac + ";xpBonusPercent=" + this.xpBonusPercent + ";isRiding=" + this.isRiding + ";hasGuild=" + this.hasGuild + ";xpGuildGivenPercent=" + this.xpGuildGivenPercent + ";sharedXPCoefficient=" + this.sharedXPCoefficient + ";unsharedXPCoefficient=" + this.unsharedXPCoefficient + ";rideXPBonus=" + this.rideXPBonus + ";";
      }
   }
}
