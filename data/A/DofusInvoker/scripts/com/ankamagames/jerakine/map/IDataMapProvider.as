package com.ankamagames.jerakine.map
{
   public interface IDataMapProvider
   {
       
      
      function get width() : int;
      
      function get height() : int;
      
      function pointLos(param1:int, param2:int, param3:Boolean = true) : Boolean;
      
      function pointMov(param1:int, param2:int, param3:Boolean = true, param4:int = -1, param5:int = -1, param6:Boolean = true) : Boolean;
      
      function farmCell(param1:int, param2:int) : Boolean;
      
      function pointSpecialEffects(param1:int, param2:int) : uint;
      
      function pointWeight(param1:int, param2:int, param3:Boolean = true) : Number;
      
      function hasEntity(param1:int, param2:int, param3:Boolean = false) : Boolean;
      
      function updateCellMovLov(param1:uint, param2:Boolean) : void;
      
      function isChangeZone(param1:uint, param2:uint) : Boolean;
      
      function getCellSpeed(param1:uint) : int;
      
      function fillEntityOnCellArray(param1:Vector.<Boolean>, param2:Boolean) : Vector.<Boolean>;
   }
}
