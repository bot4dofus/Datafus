package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeMusic
   {
       
      
      public var preview_path:String = null;
      
      public var complete_path:String = null;
      
      public function ShopReferenceTypeMusic()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeMusic: ";
         str += " (preview_path: " + this.preview_path + ")";
         return str + (" (complete_path: " + this.complete_path + ")");
      }
   }
}
