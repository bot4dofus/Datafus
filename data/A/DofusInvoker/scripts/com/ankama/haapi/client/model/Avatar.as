package com.ankama.haapi.client.model
{
   public class Avatar
   {
       
      
      public var url:String = null;
      
      public function Avatar()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "Avatar: ";
         return str + (" (url: " + this.url + ")");
      }
   }
}
