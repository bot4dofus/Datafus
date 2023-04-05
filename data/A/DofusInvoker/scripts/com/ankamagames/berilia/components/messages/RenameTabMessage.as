package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class RenameTabMessage extends ComponentMessage
   {
       
      
      private var _index:int;
      
      private var _name:String;
      
      public function RenameTabMessage(target:InteractiveObject, index:int, name:String)
      {
         super(target);
         this._index = index;
         this._name = name;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
