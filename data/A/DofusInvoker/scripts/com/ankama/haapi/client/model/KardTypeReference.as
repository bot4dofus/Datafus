package com.ankama.haapi.client.model
{
   public class KardTypeReference
   {
       
      
      public var id:Number = 0;
      
      public var name:String = null;
      
      public var description:String = null;
      
      public var quantity:Number = 0;
      
      public var type:String = null;
      
      public function KardTypeReference()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "KardTypeReference: ";
         str += " (id: " + this.id + ")";
         str += " (name: " + this.name + ")";
         str += " (description: " + this.description + ")";
         str += " (quantity: " + this.quantity + ")";
         return str + (" (type: " + this.type + ")");
      }
   }
}
