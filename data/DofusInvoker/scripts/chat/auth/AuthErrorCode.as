package chat.auth
{
   public final class AuthErrorCode
   {
      
      public static const BAD_CREDENTIALS:int = 1;
      
      public static const INVALID_AUTHENTICATION_INFO:int = 2;
      
      public static const SUBSCRIPTION_REQUIRED:int = 3;
      
      public static const ADMIN_RIGHTS_REQUIRED:int = 4;
      
      public static const ACCOUNT_KNOWN_BUT_BANNED:int = 5;
      
      public static const ACCOUNT_KNOWN_BUT_BLOCKED:int = 6;
      
      public static const AP_ADDRESS_REFUSED:int = 7;
      
      public static const BETA_ACCESS_REQUIRED:int = 8;
      
      public static const SERVER_TIMEOUT:int = 9;
      
      public static const SERVER_ERROR:int = 10;
      
      public static const ACCOUNTS_BACKEND_ERROR:int = 11;
      
      public static const NICKNAME_REQUIRED:int = 12;
       
      
      public function AuthErrorCode()
      {
         super();
      }
      
      public static function getError(errCode:int) : String
      {
         var toReturn:String = "";
         switch(errCode)
         {
            case BAD_CREDENTIALS:
               toReturn = "BAD_CREDENTIALS";
               break;
            case INVALID_AUTHENTICATION_INFO:
               toReturn = "INVALID_AUTHENTICATION_INFO";
               break;
            case SUBSCRIPTION_REQUIRED:
               toReturn = "SUBSCRIPTION_REQUIRED";
               break;
            case ADMIN_RIGHTS_REQUIRED:
               toReturn = "ADMIN_RIGHTS_REQUIRED";
               break;
            case ACCOUNT_KNOWN_BUT_BANNED:
               toReturn = "ACCOUNT_KNOWN_BUT_BANNED";
               break;
            case ACCOUNT_KNOWN_BUT_BLOCKED:
               toReturn = "ACCOUNT_KNOWN_BUT_BLOCKED";
               break;
            case AP_ADDRESS_REFUSED:
               toReturn = "AP_ADDRESS_REFUSED";
               break;
            case BETA_ACCESS_REQUIRED:
               toReturn = "BETA_ACCESS_REQUIRED";
               break;
            case SERVER_TIMEOUT:
               toReturn = "SERVER_TIMEOUT";
               break;
            case SERVER_ERROR:
               toReturn = "SERVER_ERROR";
               break;
            case ACCOUNTS_BACKEND_ERROR:
               toReturn = "ACCOUNTS_BACKEND_ERROR";
               break;
            case NICKNAME_REQUIRED:
               toReturn = "NICKNAME_REQUIRED";
         }
         return toReturn;
      }
   }
}
