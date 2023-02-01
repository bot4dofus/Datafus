package com.ankamagames.dofus.kernel.zaap
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestApiTokenMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestLanguageMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapNeedUpdateMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapPayArticleMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapSettingMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.RequestZaapUserInfosMessage;
   import com.ankamagames.dofus.misc.utils.GameID;
   
   public class ZaapApi implements IApi
   {
      
      public static var zaapConnection:ZaapConnectionHelper = new ZaapConnectionHelper();
       
      
      public function ZaapApi(handler:IZaapMessageHandler)
      {
         super();
         zaapConnection.addObserver(handler);
      }
      
      public static function init() : void
      {
         zaapConnection.connect();
      }
      
      public static function isConnected() : Boolean
      {
         return zaapConnection.isConnected();
      }
      
      public static function isUsingZaap() : Boolean
      {
         return zaapConnection.isUsingZaap();
      }
      
      public static function isUsingZaapLogin() : Boolean
      {
         return zaapConnection.isUsingZaapLogin();
      }
      
      public static function canLoginWithZaap() : Boolean
      {
         return zaapConnection.canLoginWithZaap();
      }
      
      public static function isDisconnected() : Boolean
      {
         return zaapConnection.isDisconnected();
      }
      
      public static function disableZaapLogin() : void
      {
         zaapConnection.disableZaapLogin();
      }
      
      public static function requestZaapRestart(callback:Function) : void
      {
         zaapConnection.requestZaapRestart(callback);
      }
      
      public function detach(handler:IZaapMessageHandler) : void
      {
         zaapConnection.removeObserver(handler);
      }
      
      public function getLanguage() : void
      {
         zaapConnection.sendMessage(new RequestLanguageMessage());
      }
      
      public function getZaapSetting(name:String) : void
      {
         zaapConnection.sendMessage(new RequestZaapSettingMessage(name));
      }
      
      public function getUserInfos() : void
      {
         zaapConnection.sendMessage(new RequestZaapUserInfosMessage());
      }
      
      public function getNeedZaapUpdate() : void
      {
         zaapConnection.sendMessage(new RequestZaapNeedUpdateMessage());
      }
      
      public function payArticle(apiKey:String, articleId:int) : void
      {
         zaapConnection.sendMessage(new RequestZaapPayArticleMessage(apiKey,articleId));
      }
      
      public function getIdentificationToken() : void
      {
         zaapConnection.sendMessage(new RequestApiTokenMessage(GameID.current));
      }
   }
}
