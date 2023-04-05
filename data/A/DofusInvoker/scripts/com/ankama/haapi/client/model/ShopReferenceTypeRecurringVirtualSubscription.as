package com.ankama.haapi.client.model
{
   public class ShopReferenceTypeRecurringVirtualSubscription
   {
       
      
      public var recurring_article:Number = 0;
      
      public var recurring_duration:String = null;
      
      public var recurring_missingday_article:Number = 0;
      
      public function ShopReferenceTypeRecurringVirtualSubscription()
      {
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopReferenceTypeRecurringVirtualSubscription: ";
         str += " (recurring_article: " + this.recurring_article + ")";
         str += " (recurring_duration: " + this.recurring_duration + ")";
         return str + (" (recurring_missingday_article: " + this.recurring_missingday_article + ")");
      }
   }
}
