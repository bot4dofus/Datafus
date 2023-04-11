package com.ankama.haapi.client.model
{
   public class ShopMeta
   {
       
      
      public var id:Number = 0;
      
      public var key:String = null;
      
      public var name:String = null;
      
      public function ShopMeta()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopMeta: ";
         str += " (id: " + this.id + ")";
         str += " (key: " + this.key + ")";
         return str + (" (name: " + this.name + ")");
      }
   }
}
