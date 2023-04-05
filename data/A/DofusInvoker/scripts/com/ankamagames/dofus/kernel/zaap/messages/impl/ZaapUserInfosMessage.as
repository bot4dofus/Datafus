package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   
   public class ZaapUserInfosMessage implements IZaapInputMessage
   {
       
      
      private var _login:String;
      
      private var _error:int;
      
      public function ZaapUserInfosMessage(login:String, error:int = 0)
      {
         super();
         this._login = login;
         this._error = error;
      }
      
      public function get login() : String
      {
         return this._login;
      }
      
      public function get error() : int
      {
         return this._error;
      }
   }
}
