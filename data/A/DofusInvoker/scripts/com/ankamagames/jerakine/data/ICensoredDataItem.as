package com.ankamagames.jerakine.data
{
   public interface ICensoredDataItem
   {
       
      
      function get lang() : String;
      
      function get type() : int;
      
      function get oldValue() : int;
      
      function get newValue() : int;
   }
}
