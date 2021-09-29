package org.openapitools.event
{
   public class Response
   {
      
      private static const API_ERROR_MSG:String = "Api error response: ";
       
      
      public var isSuccess:Boolean;
      
      public var payload:Object;
      
      public var errorMessage:String;
      
      public var requestId:String;
      
      public var statusCode:int;
      
      public var headers:Object;
      
      public function Response(isSuccessful:Boolean, statusCode:int, payload:Object = null, errorMessage:String = null, requestId:String = null)
      {
         super();
         this.isSuccess = isSuccessful;
         this.payload = payload;
         this.statusCode = statusCode;
         this.errorMessage = getFriendlyMessage(errorMessage);
      }
      
      private static function getFriendlyMessage(errorMessage:String) : String
      {
         var errorCode:String = null;
         var result:String = errorMessage;
         if(errorMessage == null)
         {
            return null;
         }
         var errorCodeArray:Array = errorMessage.match(/(?<=HTTP\/1.1 )[0-9][0-9][0-9]/);
         if(errorCodeArray != null && errorCodeArray.length == 1)
         {
            errorCode = String(errorCodeArray[0]);
         }
         var msgArray:Array = errorMessage.match(/(?<=HTTP\/1.1 [0-9][0-9][0-9] )[^]*/);
         if(msgArray != null && msgArray.length == 1)
         {
            result = API_ERROR_MSG + String(msgArray[0]);
         }
         return result;
      }
      
      public function toString() : String
      {
         return "Response (requestId:" + this.requestId + "; statusCode:" + this.statusCode + "; isSuccess:" + this.isSuccess + "; errorMessage:" + this.errorMessage + "; payload:" + this.payload + ")";
      }
   }
}
