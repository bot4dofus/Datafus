package com.ankama.haapi.client.model
{
   public class KardTypeGameAction
   {
       
      
      public var quantity:Number = 0;
      
      private var _definition_obj_class:Array = null;
      
      public var definition:Vector.<String>;
      
      public function KardTypeGameAction()
      {
         this.definition = new Vector.<String>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeGameAction: ";
         str += " (quantity: " + this.quantity + ")";
         return str + (" (definition: " + this.definition + ")");
      }
   }
}
