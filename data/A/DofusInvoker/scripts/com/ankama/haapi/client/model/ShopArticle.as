package com.ankama.haapi.client.model
{
   public class ShopArticle
   {
      
      public static const AvailabilityEnum_NORMAL:String = "NORMAL";
      
      public static const AvailabilityEnum_PREORDER:String = "PREORDER";
      
      public static const AvailabilityEnum_SOON_AVAILABLE:String = "SOON_AVAILABLE";
       
      
      public var id:Number = 0;
      
      public var key:String = null;
      
      public var name:String = null;
      
      public var subtitle:String = null;
      
      public var description:String = null;
      
      public var currency:String = null;
      
      public var original_price:Number = 0.0;
      
      public var price:Number = 0.0;
      
      public var startdate:Date = null;
      
      public var enddate:Date = null;
      
      public var showCountDown:Boolean = false;
      
      public var stock:Number = 0;
      
      public var is_free:Boolean = false;
      
      private var _image_obj_class:Array = null;
      
      public var image:Vector.<ShopImage>;
      
      private var _references_obj_class:Array = null;
      
      public var references:Vector.<ShopReference>;
      
      private var _promo_obj_class:Array = null;
      
      public var promo:Vector.<ShopPromo>;
      
      private var _media_obj_class:Array = null;
      
      public var media:Vector.<ShopMedia>;
      
      private var _metas_obj_class:Array = null;
      
      public var metas:Vector.<ShopMetaGroup>;
      
      private var _pricelist_obj_class:Array = null;
      
      public var pricelist:Vector.<ShopPrice>;
      
      public var most_precise_category_id:Number = 0;
      
      public var flag:ShopFlag = null;
      
      public var availability:String = null;
      
      public var marketing_display:ShopMarketingDisplay = null;
      
      public function ShopArticle()
      {
         this.image = new Vector.<ShopImage>();
         this.references = new Vector.<ShopReference>();
         this.promo = new Vector.<ShopPromo>();
         this.media = new Vector.<ShopMedia>();
         this.metas = new Vector.<ShopMetaGroup>();
         this.pricelist = new Vector.<ShopPrice>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "ShopArticle: ";
         str += " (id: " + this.id + ")";
         str += " (key: " + this.key + ")";
         str += " (name: " + this.name + ")";
         str += " (subtitle: " + this.subtitle + ")";
         str += " (description: " + this.description + ")";
         str += " (currency: " + this.currency + ")";
         str += " (original_price: " + this.original_price + ")";
         str += " (price: " + this.price + ")";
         str += " (startdate: " + this.startdate + ")";
         str += " (enddate: " + this.enddate + ")";
         str += " (showCountDown: " + this.showCountDown + ")";
         str += " (stock: " + this.stock + ")";
         str += " (is_free: " + this.is_free + ")";
         str += " (image: " + this.image + ")";
         str += " (references: " + this.references + ")";
         str += " (promo: " + this.promo + ")";
         str += " (media: " + this.media + ")";
         str += " (metas: " + this.metas + ")";
         str += " (pricelist: " + this.pricelist + ")";
         str += " (most_precise_category_id: " + this.most_precise_category_id + ")";
         str += " (flag: " + this.flag + ")";
         str += " (availability: " + this.availability + ")";
         return str + (" (marketing_display: " + this.marketing_display + ")");
      }
   }
}
