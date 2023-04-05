package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import flash.display.InteractiveObject;
   
   public class DropMessage extends ComponentMessage
   {
       
      
      private var _source:ISlotDataHolder;
      
      public function DropMessage(target:InteractiveObject, source:ISlotDataHolder)
      {
         super(target);
         this._source = source;
      }
      
      public function get source() : ISlotDataHolder
      {
         return this._source;
      }
   }
}
