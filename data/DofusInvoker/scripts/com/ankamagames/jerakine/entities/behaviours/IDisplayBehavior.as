package com.ankamagames.jerakine.entities.behaviours
{
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   
   public interface IDisplayBehavior
   {
       
      
      function getAbsoluteBounds(param1:IDisplayable) : IRectangle;
      
      function display(param1:IDisplayable, param2:uint = 0) : void;
      
      function remove(param1:IDisplayable) : void;
   }
}
