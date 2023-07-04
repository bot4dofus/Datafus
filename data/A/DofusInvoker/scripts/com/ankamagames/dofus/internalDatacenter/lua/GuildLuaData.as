package com.ankamagames.dofus.internalDatacenter.lua
{
   public dynamic class GuildLuaData
   {
       
      
      public var level:int;
      
      public var coefficient:Number;
      
      public function GuildLuaData(pLevel:int = 1, pCoefficient:Number = 0)
      {
         super();
         this.level = pLevel;
         this.coefficient = pCoefficient;
      }
      
      public function toString() : String
      {
         return "level=" + this.level + ";coefficient=" + this.coefficient + ";";
      }
   }
}
