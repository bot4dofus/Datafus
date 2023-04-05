package com.ankama.zaap
{
   import flash.utils.Dictionary;
   import org.apache.thrift.Set;
   
   public class ErrorCode
   {
      
      public static const UNKNOWN:int = 1;
      
      public static const UNAUTHORIZED:int = 2;
      
      public static const INVALID_GAME_SESSION:int = 3;
      
      public static const CONNECTION_FAILED:int = 1001;
      
      public static const INVALID_CREDENTIALS:int = 1002;
      
      public static const AUTH_NOT_LOGGED_IN:int = 2001;
      
      public static const AUTH_BAN:int = 2002;
      
      public static const AUTH_BLACKLIST:int = 2003;
      
      public static const AUTH_LOCKED:int = 2004;
      
      public static const AUTH_DELETED:int = 2005;
      
      public static const AUTH_RESETANKAMA:int = 2006;
      
      public static const AUTH_OTPTIMEFAILED:int = 2007;
      
      public static const AUTH_SECURITYCARD:int = 2008;
      
      public static const AUTH_BRUTEFORCE:int = 2009;
      
      public static const AUTH_FAILED:int = 2010;
      
      public static const AUTH_PARTNER:int = 2011;
      
      public static const AUTH_MAILNOVALID:int = 2012;
      
      public static const AUTH_BETACLOSED:int = 2013;
      
      public static const AUTH_NOACCOUNT:int = 2014;
      
      public static const AUTH_ACCOUNT_LINKED:int = 2015;
      
      public static const AUTH_ACCOUNT_INVALID:int = 2016;
      
      public static const AUTH_ACCOUNT_SHIELDED:int = 2017;
      
      public static const UPDATER_CODE_RANGE:int = 3001;
      
      public static const SETTINGS_KEY_NOT_FOUND:int = 4001;
      
      public static const SETTINGS_INVALID_VALUE:int = 4002;
      
      public static const USER_INFO_UNAVAILABLE:int = 5001;
      
      public static const VALID_VALUES:Set = new Set(UNKNOWN,UNAUTHORIZED,INVALID_GAME_SESSION,CONNECTION_FAILED,INVALID_CREDENTIALS,AUTH_NOT_LOGGED_IN,AUTH_BAN,AUTH_BLACKLIST,AUTH_LOCKED,AUTH_DELETED,AUTH_RESETANKAMA,AUTH_OTPTIMEFAILED,AUTH_SECURITYCARD,AUTH_BRUTEFORCE,AUTH_FAILED,AUTH_PARTNER,AUTH_MAILNOVALID,AUTH_BETACLOSED,AUTH_NOACCOUNT,AUTH_ACCOUNT_LINKED,AUTH_ACCOUNT_INVALID,AUTH_ACCOUNT_SHIELDED,UPDATER_CODE_RANGE,SETTINGS_KEY_NOT_FOUND,SETTINGS_INVALID_VALUE,USER_INFO_UNAVAILABLE);
      
      public static const VALUES_TO_NAMES:Dictionary = new Dictionary();
      
      {
         VALUES_TO_NAMES[UNKNOWN] = "UNKNOWN";
         VALUES_TO_NAMES[UNAUTHORIZED] = "UNAUTHORIZED";
         VALUES_TO_NAMES[INVALID_GAME_SESSION] = "INVALID_GAME_SESSION";
         VALUES_TO_NAMES[CONNECTION_FAILED] = "CONNECTION_FAILED";
         VALUES_TO_NAMES[INVALID_CREDENTIALS] = "INVALID_CREDENTIALS";
         VALUES_TO_NAMES[AUTH_NOT_LOGGED_IN] = "AUTH_NOT_LOGGED_IN";
         VALUES_TO_NAMES[AUTH_BAN] = "AUTH_BAN";
         VALUES_TO_NAMES[AUTH_BLACKLIST] = "AUTH_BLACKLIST";
         VALUES_TO_NAMES[AUTH_LOCKED] = "AUTH_LOCKED";
         VALUES_TO_NAMES[AUTH_DELETED] = "AUTH_DELETED";
         VALUES_TO_NAMES[AUTH_RESETANKAMA] = "AUTH_RESETANKAMA";
         VALUES_TO_NAMES[AUTH_OTPTIMEFAILED] = "AUTH_OTPTIMEFAILED";
         VALUES_TO_NAMES[AUTH_SECURITYCARD] = "AUTH_SECURITYCARD";
         VALUES_TO_NAMES[AUTH_BRUTEFORCE] = "AUTH_BRUTEFORCE";
         VALUES_TO_NAMES[AUTH_FAILED] = "AUTH_FAILED";
         VALUES_TO_NAMES[AUTH_PARTNER] = "AUTH_PARTNER";
         VALUES_TO_NAMES[AUTH_MAILNOVALID] = "AUTH_MAILNOVALID";
         VALUES_TO_NAMES[AUTH_BETACLOSED] = "AUTH_BETACLOSED";
         VALUES_TO_NAMES[AUTH_NOACCOUNT] = "AUTH_NOACCOUNT";
         VALUES_TO_NAMES[AUTH_ACCOUNT_LINKED] = "AUTH_ACCOUNT_LINKED";
         VALUES_TO_NAMES[AUTH_ACCOUNT_INVALID] = "AUTH_ACCOUNT_INVALID";
         VALUES_TO_NAMES[AUTH_ACCOUNT_SHIELDED] = "AUTH_ACCOUNT_SHIELDED";
         VALUES_TO_NAMES[UPDATER_CODE_RANGE] = "UPDATER_CODE_RANGE";
         VALUES_TO_NAMES[SETTINGS_KEY_NOT_FOUND] = "SETTINGS_KEY_NOT_FOUND";
         VALUES_TO_NAMES[SETTINGS_INVALID_VALUE] = "SETTINGS_INVALID_VALUE";
         VALUES_TO_NAMES[USER_INFO_UNAVAILABLE] = "USER_INFO_UNAVAILABLE";
      }
      
      public function ErrorCode()
      {
         super();
      }
   }
}
