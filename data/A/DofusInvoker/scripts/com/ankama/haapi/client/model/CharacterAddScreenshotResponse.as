package com.ankama.haapi.client.model
{
   public class CharacterAddScreenshotResponse
   {
       
      
      public var status:Boolean = false;
      
      public var item_id:Number = 0;
      
      public var url:String = null;
      
      public function CharacterAddScreenshotResponse()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CharacterAddScreenshotResponse: ";
         str += " (status: " + this.status + ")";
         str += " (item_id: " + this.item_id + ")";
         return str + (" (url: " + this.url + ")");
      }
   }
}
