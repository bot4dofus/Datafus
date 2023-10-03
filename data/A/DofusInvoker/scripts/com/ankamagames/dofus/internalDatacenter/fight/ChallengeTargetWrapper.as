package com.ankamagames.dofus.internalDatacenter.fight
{
   public class ChallengeTargetWrapper
   {
       
      
      public var targetId:Number = 0;
      
      public var targetCell:int = 0;
      
      public var targetName:String = "";
      
      public var targetLevel:int = 1;
      
      public var attackers:Vector.<Number>;
      
      public function ChallengeTargetWrapper()
      {
         this.attackers = new Vector.<Number>();
         super();
      }
   }
}
