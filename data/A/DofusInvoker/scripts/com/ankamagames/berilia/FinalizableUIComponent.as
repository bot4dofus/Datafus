package com.ankamagames.berilia
{
   public interface FinalizableUIComponent extends UIComponent
   {
       
      
      function get finalized() : Boolean;
      
      function set finalized(param1:Boolean) : void;
      
      function finalize() : void;
   }
}
