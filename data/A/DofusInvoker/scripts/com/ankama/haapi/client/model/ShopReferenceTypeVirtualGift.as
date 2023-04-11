package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeVirtualGift
   {
       
      
      public var image:String = null;
      
      public var description:String = null;
      
      public var name:String = null;
      
      public var id:Number = 0;
      
      public function ShopReferenceTypeVirtualGift()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeVirtualGift: ";
         str += " (image: " + this.image + ")";
         str += " (description: " + this.description + ")";
         str += " (name: " + this.name + ")";
         return str + (" (id: " + this.id + ")");
      }
   }
}
