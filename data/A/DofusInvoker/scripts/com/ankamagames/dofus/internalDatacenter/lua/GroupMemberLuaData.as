package com.ankamagames.dofus.internalDatacenter.lua
{
   public dynamic class GroupMemberLuaData
   {
       
      
      public var level:int;
      
      public var isCompanion:Boolean;
      
      public var isStillPresentInFight:Boolean;
      
      public function GroupMemberLuaData(pLevel:int, pIsCompanion:Boolean, pIsStillPresentInFight:Boolean)
      {
         super();
         this.level = pLevel;
         this.isCompanion = pIsCompanion;
         this.isStillPresentInFight = pIsStillPresentInFight;
      }
      
      public function toString() : String
      {
         return "level=" + this.level + ";isCompanion=" + this.isCompanion + ";isStillPresentInFight=" + this.isStillPresentInFight + ";";
      }
   }
}
