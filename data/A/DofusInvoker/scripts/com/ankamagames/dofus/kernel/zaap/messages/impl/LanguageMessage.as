package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   
   public class LanguageMessage implements IZaapInputMessage
   {
       
      
      private var _language:String;
      
      private var _error:int;
      
      public function LanguageMessage(language:String = null, error:int = 0)
      {
         super();
         this._language = language;
         this._error = error;
      }
      
      public function get error() : int
      {
         return this._error;
      }
      
      public function getLanguage() : String
      {
         return this._language;
      }
   }
}
