package com.ankamagames.jerakine.network.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.ServerConnection;
   
   public class ServerConnectionFailedMessage implements Message
   {
       
      
      private var _failedConnection:ServerConnection;
      
      private var _errorMessage:String;
      
      public function ServerConnectionFailedMessage(failedConnection:ServerConnection, errorMessage:String)
      {
         super();
         this._errorMessage = errorMessage;
         this._failedConnection = failedConnection;
      }
      
      public function get failedConnection() : ServerConnection
      {
         return this._failedConnection;
      }
      
      public function get errorMessage() : String
      {
         return this._errorMessage;
      }
   }
}
