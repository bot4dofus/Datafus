package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapOutputMessage;
   
   public class RequestZaapPayArticleMessage implements IZaapOutputMessage
   {
       
      
      private var _shopApiKey:String;
      
      private var _articleId:int;
      
      public function RequestZaapPayArticleMessage(shopApiKey:String, articleId:int)
      {
         super();
         this._shopApiKey = shopApiKey;
         this._articleId = articleId;
      }
      
      public function get apiKey() : String
      {
         return this._shopApiKey;
      }
      
      public function get articleId() : int
      {
         return this._articleId;
      }
   }
}
