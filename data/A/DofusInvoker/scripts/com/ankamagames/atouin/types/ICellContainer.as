package com.ankamagames.atouin.types
{
   public interface ICellContainer
   {
       
      
      function get cellId() : uint;
      
      function set cellId(param1:uint) : void;
      
      function get layerId() : int;
      
      function set layerId(param1:int) : void;
      
      function get cacheAsBitmap() : Boolean;
      
      function set cacheAsBitmap(param1:Boolean) : void;
      
      function get mouseChildren() : Boolean;
      
      function set mouseChildren(param1:Boolean) : void;
      
      function get mouseEnabled() : Boolean;
      
      function set mouseEnabled(param1:Boolean) : void;
      
      function get startX() : int;
      
      function set startX(param1:int) : void;
      
      function get startY() : int;
      
      function set startY(param1:int) : void;
      
      function get depth() : int;
      
      function set depth(param1:int) : void;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function addFakeChild(param1:Object, param2:Object, param3:Object) : void;
   }
}
