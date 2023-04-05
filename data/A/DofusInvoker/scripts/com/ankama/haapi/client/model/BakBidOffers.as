package com.ankama.haapi.client.model
{
   public class BakBidOffers
   {
       
      
      public var type:String = null;
      
      private var _offers_obj_class:Array = null;
      
      public var offers:Vector.<BakBidOffer>;
      
      public function BakBidOffers()
      {
         this.offers = new Vector.<BakBidOffer>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "BakBidOffers: ";
         str += " (type: " + this.type + ")";
         return str + (" (offers: " + this.offers + ")");
      }
   }
}
