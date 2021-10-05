package com.ankama.haapi.client.model
{
   public class ShopPromo
   {
       
      
      public var name:String = null;
      
      public var description:String = null;
      
      public var image:String = null;
      
      public var start_date:Date = null;
      
      public var end_date:Date = null;
      
      private var _gifts_obj_class:Array = null;
      
      public var gifts:Vector.<ShopArticle>;
      
      public var flag:ShopFlag = null;
      
      private var _discounts_obj_class:Array = null;
      
      public var discounts:Vector.<ShopDiscount>;
      
      private var _conditions_obj_class:Array = null;
      
      public var conditions:Vector.<ShopCondition>;
      
      public var show_percent:Boolean = false;
      
      public var show_countdown:Boolean = false;
      
      public function ShopPromo()
      {
         this.gifts = new Vector.<ShopArticle>();
         this.discounts = new Vector.<ShopDiscount>();
         this.conditions = new Vector.<ShopCondition>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopPromo: ";
         str += " (name: " + this.name + ")";
         str += " (description: " + this.description + ")";
         str += " (image: " + this.image + ")";
         str += " (start_date: " + this.start_date + ")";
         str += " (end_date: " + this.end_date + ")";
         str += " (gifts: " + this.gifts + ")";
         str += " (flag: " + this.flag + ")";
         str += " (discounts: " + this.discounts + ")";
         str += " (conditions: " + this.conditions + ")";
         str += " (show_percent: " + this.show_percent + ")";
         return str + (" (show_countdown: " + this.show_countdown + ")");
      }
   }
}
