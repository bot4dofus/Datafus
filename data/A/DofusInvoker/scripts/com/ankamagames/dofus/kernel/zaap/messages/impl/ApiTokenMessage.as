package com.ankamagames.dofus.kernel.zaap.messages.impl
{
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   
   public class ApiTokenMessage implements IZaapInputMessage
   {
       
      
      private var _token:String;
      
      private var _error:int;
      
      public function ApiTokenMessage(token:String = null, error:int = 0)
      {
         super();
         this._token = token;
         this._error = error;
      }
      
      public function get error() : int
      {
         return this._error;
      }
      
      public function getToken() : String
      {
         return this._token;
      }
   }
}
