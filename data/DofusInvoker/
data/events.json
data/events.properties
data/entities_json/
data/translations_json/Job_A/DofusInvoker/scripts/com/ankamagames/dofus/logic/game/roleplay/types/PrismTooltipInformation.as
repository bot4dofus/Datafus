package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   
   public class PrismTooltipInformation
   {
       
      
      public var allianceIdentity:AllianceWrapper;
      
      public var checkSuperposition:Boolean;
      
      public var cellId:int;
      
      public function PrismTooltipInformation(pAllianceIdentity:AllianceWrapper, pCheckSuperposition:Boolean = false, pCellId:int = -1)
      {
         super();
         this.allianceIdentity = pAllianceIdentity;
         this.checkSuperposition = pCheckSuperposition;
         this.cellId = pCellId;
      }
   }
}
