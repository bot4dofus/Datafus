package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeVideo
   {
       
      
      public var duration:Number = 0;
      
      public var media_id:Number = 0;
      
      public var cid:String = null;
      
      public function ShopReferenceTypeVideo()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeVideo: ";
         str += " (duration: " + this.duration + ")";
         str += " (media_id: " + this.media_id + ")";
         return str + (" (cid: " + this.cid + ")");
      }
   }
}
