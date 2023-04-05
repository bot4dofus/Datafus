package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class SelectItemMessage extends ComponentMessage
   {
       
      
      private var _method:uint;
      
      private var _isNewSelection:Boolean;
      
      public function SelectItemMessage(target:InteractiveObject, selectMethod:uint = 7, isNewSelection:Boolean = true)
      {
         super(target);
         this._method = selectMethod;
         this._isNewSelection = isNewSelection;
      }
      
      public function get selectMethod() : uint
      {
         return this._method;
      }
      
      public function get isNewSelection() : Boolean
      {
         return this._isNewSelection;
      }
   }
}
