package com.ankamagames.dofus.internalDatacenter.monsters
{
   public dynamic class MonstersGroupData
   {
       
      
      public var level:int;
      
      public var group:Array;
      
      public var xpSolo:Number;
      
      public var xpGroup:Number;
      
      public function MonstersGroupData(pLevel:int, pGroup:Array, pXpSolo:Number, pXpGroup:Number)
      {
         super();
         this.level = pLevel;
         this.group = pGroup;
         this.xpSolo = pXpSolo;
         this.xpGroup = pXpGroup;
      }
   }
}
