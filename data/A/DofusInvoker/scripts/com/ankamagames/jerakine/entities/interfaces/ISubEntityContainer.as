package com.ankamagames.jerakine.entities.interfaces
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public interface ISubEntityContainer
   {
       
      
      function addSubEntity(param1:DisplayObject, param2:uint, param3:uint) : void;
      
      function getSubEntitySlot(param1:uint, param2:uint) : DisplayObjectContainer;
   }
}
