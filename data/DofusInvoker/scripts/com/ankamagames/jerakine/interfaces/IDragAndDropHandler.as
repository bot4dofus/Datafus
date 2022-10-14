package com.ankamagames.jerakine.interfaces
{
   public interface IDragAndDropHandler
   {
       
      
      function set dropValidator(param1:Function) : void;
      
      function get dropValidator() : Function;
      
      function set removeDropSource(param1:Function) : void;
      
      function get removeDropSource() : Function;
      
      function set processDrop(param1:Function) : void;
      
      function get processDrop() : Function;
   }
}
