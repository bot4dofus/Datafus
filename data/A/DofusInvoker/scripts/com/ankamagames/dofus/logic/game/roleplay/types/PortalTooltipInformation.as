package com.ankamagames.dofus.logic.game.roleplay.types
{
   public class PortalTooltipInformation
   {
       
      
      public var areaId:int;
      
      public var checkSuperposition:Boolean;
      
      public var cellId:int;
      
      public function PortalTooltipInformation(pAreaId:int, pCheckSuperposition:Boolean = false, pCellId:int = -1)
      {
         super();
         this.areaId = pAreaId;
         this.checkSuperposition = pCheckSuperposition;
         this.cellId = pCellId;
      }
   }
}
