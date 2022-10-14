package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   
   public interface IInventoryView
   {
       
      
      function initialize(param1:Vector.<ItemWrapper>) : void;
      
      function get name() : String;
      
      function get content() : Vector.<ItemWrapper>;
      
      function addItem(param1:ItemWrapper, param2:int, param3:Boolean = true) : void;
      
      function removeItem(param1:ItemWrapper, param2:int) : void;
      
      function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void;
      
      function isListening(param1:ItemWrapper) : Boolean;
      
      function updateView() : void;
      
      function empty() : void;
   }
}
