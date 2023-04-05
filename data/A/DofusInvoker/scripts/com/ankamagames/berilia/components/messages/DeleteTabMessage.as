package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class DeleteTabMessage extends ComponentMessage
   {
       
      
      private var _deletedIndex:int;
      
      public function DeleteTabMessage(target:InteractiveObject, deletedIndex:int)
      {
         super(target);
         this._deletedIndex = deletedIndex;
      }
      
      public function get deletedIndex() : int
      {
         return this._deletedIndex;
      }
   }
}
