package com.ankamagames.jerakine.messages
{
   public class LangFileLoadedMessage implements Message
   {
       
      
      private var _sFile:String;
      
      private var _bSuccess:Boolean;
      
      private var _sUrlProvider:String;
      
      public function LangFileLoadedMessage(sFile:String, bSucces:Boolean, sUrlProvider:String)
      {
         super();
         this._sFile = sFile;
         this._bSuccess = bSucces;
         this._sUrlProvider = sUrlProvider;
      }
      
      public function get urlProvider() : String
      {
         return this._sUrlProvider;
      }
      
      public function get file() : String
      {
         return this._sFile;
      }
      
      public function get success() : Boolean
      {
         return this._bSuccess;
      }
   }
}
