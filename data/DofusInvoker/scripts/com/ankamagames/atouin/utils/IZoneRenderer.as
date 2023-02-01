package com.ankamagames.atouin.utils
{
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.jerakine.types.Color;
   
   public interface IZoneRenderer
   {
       
      
      function render(param1:Vector.<uint>, param2:Color, param3:DataMapContainer, param4:Boolean = false, param5:Boolean = false) : void;
      
      function remove(param1:Vector.<uint>, param2:DataMapContainer) : void;
   }
}
