package com.ankamagames.berilia.types.shortcut
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class LocalizedKeyboard
   {
       
      
      private var _uri:Uri;
      
      private var _locale:String;
      
      private var _description:String;
      
      public function LocalizedKeyboard(uri:Uri, locale:String, description:String)
      {
         super();
         this._uri = uri;
         this._locale = locale;
         this._description = description;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      public function get locale() : String
      {
         return this._locale;
      }
      
      public function get description() : String
      {
         return this._description;
      }
   }
}
