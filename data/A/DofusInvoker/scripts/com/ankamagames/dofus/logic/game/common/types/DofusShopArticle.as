package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankama.haapi.client.model.ShopMedia;
   import com.ankama.haapi.client.model.ShopPrice;
   import com.ankama.haapi.client.model.ShopPromo;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.TimerEvent;
   
   public class DofusShopArticle extends DofusShopObject implements IDataCenter
   {
      
      private static const date_regexp:RegExp = new RegExp(/\-/g);
      
      private static const _currenciesSymbols:Object = {
         "EUR":"€",
         "JPY":"¥",
         "GBP":"£"
      };
      
      private static const ARTICLE_PERCENT_DISCOUNT:String = "ARTICLE-PERCENT";
       
      
      private var _subtitle:String;
      
      private var _prices:Vector.<ShopPrice>;
      
      private var _originalPrice:Number;
      
      private var _endDate:Date;
      
      private var _currency:String;
      
      private var _stock:int;
      
      private var _imgSmall:String;
      
      private var _imgNormal:String;
      
      private var _imgSwf:Uri;
      
      private var _references:Array;
      
      private var _promo:Vector.<ShopPromo>;
      
      private var _endTimer:BenchmarkTimer;
      
      private var _gids:Array;
      
      private var _isNew:Boolean;
      
      private var _hasExpired:Boolean;
      
      private var _media:Vector.<ShopMedia>;
      
      private var _category:int;
      
      private var _isFree:Boolean;
      
      private var _fanion:DofusShopFanion = null;
      
      private var _discountPercent:int = 0;
      
      private var _timerDisplay:String = "";
      
      protected var _availability:String;
      
      public function DofusShopArticle(data:Object)
      {
         super(data);
      }
      
      override public function init(data:Object) : void
      {
         var price:Object = null;
         var currentTime:Number = NaN;
         var dateStr:String = null;
         var expirationTime:Number = NaN;
         var remainingTime:Number = NaN;
         var ref:Object = null;
         var startDate:Date = null;
         var dofReferenceV:Object = null;
         var dofReferenceG:Object = null;
         var kards:Array = null;
         var kard:Object = null;
         var iw:ItemWrapper = null;
         super.init(data);
         this._subtitle = data.subtitle;
         this._prices = data.pricelist;
         this._originalPrice = data.original_price;
         this._media = data.media;
         this._category = data.most_precise_category_id;
         this._isFree = data.is_free;
         this._availability = data.availability;
         if(data.marketing_display.flag)
         {
            this._fanion = DofusShopFanion.createFromData(data.marketing_display.flag);
         }
         this._discountPercent = parseInt(data.marketing_display.discount_percent);
         if(data.marketing_display.countdown)
         {
            this._timerDisplay = data.marketing_display.countdown;
         }
         for each(price in this.prices)
         {
            if(_currenciesSymbols[price.currency])
            {
               price.currency = _currenciesSymbols[price.currency];
            }
         }
         this._isNew = false;
         currentTime = new Date().getTime();
         if(data.startdate)
         {
            startDate = this.webStringToDate(data.startdate);
            expirationTime = startDate.getTime();
            remainingTime = currentTime - expirationTime;
            this._isNew = remainingTime > 0 && remainingTime < 864000000;
         }
         if(data.enddate)
         {
            this._endDate = this.webStringToDate(data.enddate);
            expirationTime = this._endDate.getTime();
            remainingTime = expirationTime - currentTime;
            if(remainingTime <= 0)
            {
               this._hasExpired = true;
            }
            else if(remainingTime <= 43200000)
            {
               this._endTimer = new BenchmarkTimer(remainingTime,1,"DofusShopArticle._endTimer");
               this._endTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
               this._endTimer.start();
            }
         }
         this._currency = data.currency;
         this._stock = data.stock == null ? -1 : int(data.stock);
         this._references = new Array();
         this._gids = [];
         for each(ref in data.references)
         {
            if(ref && typeof ref == "object" && ref.type)
            {
               if(ref.type.toUpperCase() == "VIRTUALGIFT")
               {
                  this._references.push(new DofusShopArticleReference(ref));
                  for each(dofReferenceV in ref.reference_virtualgift)
                  {
                     this._gids.push(parseInt(dofReferenceV.id));
                  }
               }
               else if(ref.type.toUpperCase() == "GAMEACTION")
               {
                  for each(dofReferenceG in ref.reference_gameaction.definition.actions)
                  {
                     if(dofReferenceG.item_id)
                     {
                        this._references.push(new DofusShopArticleReference(ref));
                        break;
                     }
                     if(dofReferenceG.type == "DofusHavenBagTheme" || dofReferenceG.type == "DofusHavenBagRoom")
                     {
                        this._references.push(new DofusShopArticleReference({
                           "image":ref.image,
                           "quantity":dofReferenceG.quantity,
                           "type":dofReferenceG.type,
                           "id":ref.reference_gameaction.definition.id,
                           "name":ref.name,
                           "description":ref.description
                        }));
                     }
                  }
               }
               else if(ref.type.toUpperCase() == "VIRTUALSUBSCRIPTION")
               {
                  this._references.push(new DofusShopArticleReference(ref));
               }
               else if(ref.type.toUpperCase() == "KARD")
               {
                  kards = [];
                  for each(kard in ref.reference_kard[0].kards)
                  {
                     kards.push({
                        "kard":new DofusShopArticleReference({
                           "image":kard.kard.image,
                           "quantity":1,
                           "type":kard.kard.type,
                           "id":kard.kard.id,
                           "name":kard.kard.name,
                           "description":kard.kard.description,
                           "kards":kard.kard.kards
                        }),
                        "probability":kard.probability,
                        "rarity":kard.rarity
                     });
                  }
                  this._references.push(new DofusShopArticleReference({
                     "image":ref.image,
                     "quantity":ref.quantity,
                     "type":ref.type,
                     "id":ref.reference_kard[0].id,
                     "name":ref.name,
                     "description":ref.description,
                     "kards":kards
                  }));
               }
            }
         }
         if(this._gids.length == 1)
         {
            iw = ItemWrapper.create(0,0,this._gids[0],1,null,false);
            this._imgSwf = iw.getIconUri(false);
         }
         if(data.image && data.image.length)
         {
            this._imgSmall = data.image[0].url;
            this._imgNormal = data.image[1].url;
         }
         this._promo = data.promo;
      }
      
      private function webStringToDate(dateStr:String) : Date
      {
         dateStr = dateStr.replace(date_regexp,"/");
         dateStr = dateStr.replace("T"," ");
         dateStr = dateStr.replace("+"," GMT-");
         dateStr = dateStr.slice(0,dateStr.lastIndexOf(":")) + dateStr.slice(dateStr.lastIndexOf(":") + 1);
         return new Date(Date.parse(dateStr));
      }
      
      protected function onEndDate(event:TimerEvent) : void
      {
         this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
         DofusShopManager.getInstance().updateAfterExpiredArticle(id);
      }
      
      override public function free() : void
      {
         if(this._endTimer)
         {
            this._endTimer.stop();
            this._endTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onEndDate);
            this._endTimer = null;
         }
         this._subtitle = null;
         this._prices = null;
         this._originalPrice = 0;
         this._endDate = null;
         this._currency = null;
         this._stock = 0;
         this._imgSmall = null;
         this._imgNormal = null;
         this._references = null;
         this._promo = null;
         this._gids = null;
         super.free();
      }
      
      public function get subtitle() : String
      {
         return this._subtitle;
      }
      
      public function get prices() : Vector.<ShopPrice>
      {
         return this._prices;
      }
      
      public function get originalPrice() : Number
      {
         return this._originalPrice;
      }
      
      public function get endDate() : Date
      {
         return this._endDate;
      }
      
      public function get currency() : String
      {
         return this._currency;
      }
      
      public function get stock() : int
      {
         return this._stock;
      }
      
      public function get imageSmall() : String
      {
         return this._imgSmall;
      }
      
      public function get imageSwf() : Uri
      {
         return this._imgSwf;
      }
      
      public function get imageNormal() : String
      {
         return this._imgNormal;
      }
      
      public function get references() : Array
      {
         return this._references;
      }
      
      public function get gids() : Array
      {
         return this._gids;
      }
      
      public function get promo() : Vector.<ShopPromo>
      {
         return this._promo;
      }
      
      public function get isNew() : Boolean
      {
         return this._isNew;
      }
      
      public function get hasExpired() : Boolean
      {
         return this._hasExpired;
      }
      
      public function get media() : Vector.<ShopMedia>
      {
         return this._media;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function set subtitle(sub:String) : void
      {
         this._subtitle = sub;
      }
      
      public function set gids(newGids:Array) : void
      {
         this._gids = newGids;
      }
      
      public function get isFree() : Boolean
      {
         return this._isFree;
      }
      
      public function get fanion() : DofusShopFanion
      {
         return this._fanion;
      }
      
      public function get discountPercent() : int
      {
         return this._discountPercent;
      }
      
      public function get timerDisplay() : String
      {
         return this._timerDisplay;
      }
      
      public function get availability() : String
      {
         return this._availability;
      }
   }
}
