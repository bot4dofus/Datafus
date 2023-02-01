package com.ankamagames.atouin.types
{
   public interface IStackable
   {
       
      
      function get layerId() : int;
      
      function get elementHeight() : uint;
      
      function updateContentY(param1:Number = 0, param2:int = -1) : void;
   }
}
