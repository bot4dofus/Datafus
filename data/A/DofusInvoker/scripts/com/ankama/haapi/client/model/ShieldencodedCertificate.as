package com.ankama.haapi.client.model
{
   public class ShieldencodedCertificate
   {
       
      
      public var id:String = null;
      
      public var encodedCertificate:String = null;
      
      public function ShieldencodedCertificate()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShieldencodedCertificate: ";
         str += " (id: " + this.id + ")";
         return str + (" (encodedCertificate: " + this.encodedCertificate + ")");
      }
   }
}
