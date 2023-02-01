package com.ankamagames.berilia.interfaces
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   
   public interface IGridRenderer
   {
       
      
      function set grid(param1:Grid) : void;
      
      function render(param1:*, param2:uint, param3:Boolean, param4:uint = 0) : DisplayObject;
      
      function update(param1:*, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint = 0) : void;
      
      function remove(param1:DisplayObject) : void;
      
      function destroy() : void;
      
      function renderModificator(param1:Array) : Array;
      
      function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String;
      
      function getDataLength(param1:*, param2:Boolean) : uint;
   }
}
