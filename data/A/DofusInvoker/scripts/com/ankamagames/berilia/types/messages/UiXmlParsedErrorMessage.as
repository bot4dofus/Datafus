package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class UiXmlParsedErrorMessage implements Message
   {
       
      
      private var _url:String;
      
      private var _msg:String;
      
      public function UiXmlParsedErrorMessage(url:String, msg:String)
      {
         super();
         this._url = url;
         this._msg = msg;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get msg() : String
      {
         return this._msg;
      }
   }
}
