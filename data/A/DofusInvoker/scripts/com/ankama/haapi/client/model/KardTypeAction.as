package com.ankama.haapi.client.model
{
   public class KardTypeAction
   {
       
      
      public var id:Number = 0;
      
      public var quantity:Number = 0;
      
      public var name:String = null;
      
      public var title:String = null;
      
      public var description:String = null;
      
      public function KardTypeAction()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeAction: ";
         str += " (id: " + this.id + ")";
         str += " (quantity: " + this.quantity + ")";
         str += " (name: " + this.name + ")";
         str += " (title: " + this.title + ")";
         return str + (" (description: " + this.description + ")");
      }
   }
}
