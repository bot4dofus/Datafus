package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubscriberGift implements IDataCenter
   {
       
      
      private var _name:String;
      
      private var _price:int;
      
      private var _priceCrossed:String;
      
      private var _visualUri:String;
      
      private var _newTag:Boolean;
      
      private var _promotionTag:Boolean;
      
      private var _redirect:Boolean;
      
      private var _title:String;
      
      private var _onCliqueUri:String;
      
      public function SubscriberGift(name:String, price:int, priceCrossed:String, visualUri:String, newTag:Boolean, promotionTag:Boolean, redirect:Boolean, title:String, onCliqueUri:String)
      {
         super();
         this._name = name;
         this._price = price;
         this._priceCrossed = priceCrossed;
         this._visualUri = visualUri;
         this._newTag = newTag;
         this._promotionTag = promotionTag;
         this._redirect = redirect;
         this._title = title;
         this._onCliqueUri = onCliqueUri;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get price() : int
      {
         return this._price;
      }
      
      public function get priceCrossed() : String
      {
         return this._priceCrossed;
      }
      
      public function get visualUri() : String
      {
         return this._visualUri;
      }
      
      public function get newTag() : Boolean
      {
         return this._newTag;
      }
      
      public function get promotionTag() : Boolean
      {
         return this._promotionTag;
      }
      
      public function get redirect() : Boolean
      {
         return this._redirect;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get onCliqueUri() : String
      {
         return this._onCliqueUri;
      }
   }
}
