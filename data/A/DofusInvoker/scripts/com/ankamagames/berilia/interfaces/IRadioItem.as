package com.ankamagames.berilia.interfaces
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public interface IRadioItem extends IDataCenter
   {
       
      
      function get id() : String;
      
      function set value(param1:*) : void;
      
      function get value() : *;
      
      function set selected(param1:Boolean) : void;
      
      function get selected() : Boolean;
   }
}
