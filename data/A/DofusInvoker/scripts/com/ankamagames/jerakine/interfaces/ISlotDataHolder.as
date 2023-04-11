package com.ankamagames.jerakine.interfaces
{
   public interface ISlotDataHolder extends IDragAndDropHandler
   {
       
      
      function refresh() : void;
      
      function set data(param1:*) : void;
      
      function get data() : *;
   }
}
