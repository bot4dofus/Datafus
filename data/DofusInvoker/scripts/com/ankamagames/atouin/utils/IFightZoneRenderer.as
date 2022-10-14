package com.ankamagames.atouin.utils
{
   public interface IFightZoneRenderer extends IZoneRenderer
   {
       
      
      function get currentStrata() : uint;
      
      function set currentStrata(param1:uint) : void;
      
      function get showFarmCell() : Boolean;
      
      function set showFarmCell(param1:Boolean) : void;
   }
}
