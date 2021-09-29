package chat.auth
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class AuthResponse extends JsonifiedMessage
   {
       
      
      public var success:Boolean;
      
      public var errCode:int;
      
      public function AuthResponse()
      {
         super();
      }
      
      public static function createFromJson(json:String) : AuthResponse
      {
         var obj:Object = decodePooled(json,false);
         var authResponse:AuthResponse = new AuthResponse();
         if(obj.hasOwnProperty("success"))
         {
            authResponse.success = obj.success;
         }
         if(obj.hasOwnProperty("errCode"))
         {
            authResponse.errCode = obj.errCode;
         }
         return authResponse;
      }
   }
}
