package mx.utils
{
   import flash.system.Capabilities;
   import flash.utils.getDefinitionByName;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class Platform
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var _instance:Platform;
      
      protected static var _initialized:Boolean;
      
      protected static var _isAndroid:Boolean;
      
      protected static var _isIOS:Boolean;
      
      protected static var _isIPad:Boolean;
      
      protected static var _isBlackBerry:Boolean;
      
      protected static var _isMobile:Boolean;
      
      protected static var _isMac:Boolean;
      
      protected static var _isWindows:Boolean;
      
      protected static var _isLinux:Boolean;
      
      protected static var _isDesktop:Boolean;
      
      protected static var _isBrowser:Boolean;
      
      protected static var _isAir:Boolean;
      
      private static var _osVersion:String = null;
      
      mx_internal static var androidVersionOverride:String;
      
      mx_internal static var iosVersionOverride:String;
       
      
      public function Platform()
      {
         super();
      }
      
      public static function get isIOS() : Boolean
      {
         getPlatforms();
         return _isIOS;
      }
      
      public static function get isIPad() : Boolean
      {
         getPlatforms();
         return _isIPad;
      }
      
      public static function get isBlackBerry() : Boolean
      {
         getPlatforms();
         return _isBlackBerry;
      }
      
      public static function get isAndroid() : Boolean
      {
         getPlatforms();
         return _isAndroid;
      }
      
      public static function get isWindows() : Boolean
      {
         getPlatforms();
         return _isWindows;
      }
      
      public static function get isMac() : Boolean
      {
         getPlatforms();
         return _isMac;
      }
      
      public static function get isLinux() : Boolean
      {
         getPlatforms();
         return _isLinux;
      }
      
      public static function get isDesktop() : Boolean
      {
         getPlatforms();
         return _isDesktop;
      }
      
      public static function get isMobile() : Boolean
      {
         getPlatforms();
         return _isMobile;
      }
      
      public static function get isAir() : Boolean
      {
         getPlatforms();
         return _isAir;
      }
      
      public static function get isBrowser() : Boolean
      {
         getPlatforms();
         return _isBrowser;
      }
      
      public static function get osVersion() : String
      {
         if(_osVersion == null)
         {
            if(mx_internal::androidVersionOverride == null && mx_internal::iosVersionOverride == null)
            {
               _osVersion = computeOSVersionString();
            }
            else if(mx_internal::androidVersionOverride != null)
            {
               _osVersion = mx_internal::androidVersionOverride;
            }
            else if(mx_internal::iosVersionOverride != null)
            {
               _osVersion = mx_internal::iosVersionOverride;
            }
         }
         return _osVersion;
      }
      
      protected static function getPlatforms() : void
      {
         var cap:Class = null;
         var version:String = null;
         var os:String = null;
         var playerType:String = null;
         if(!_initialized)
         {
            cap = Capabilities;
            version = Capabilities.version;
            os = Capabilities.os;
            playerType = Capabilities.playerType;
            _isAndroid = version.indexOf("AND") > -1;
            _isIOS = version.indexOf("IOS") > -1;
            _isBlackBerry = version.indexOf("QNX") > -1;
            _isMobile = _isAndroid || _isIOS || _isBlackBerry;
            _isMac = os.indexOf("Mac OS") != -1;
            _isWindows = os.indexOf("Windows") != -1;
            _isLinux = os.indexOf("Linux") != -1;
            _isIPad = os.indexOf("iPad") > -1;
            _isDesktop = !_isMobile;
            _isAir = playerType == "Desktop";
            _isBrowser = playerType == "PlugIn" || playerType == "ActiveX";
            _initialized = true;
         }
      }
      
      private static function computeOSVersionString() : String
      {
         var osVersionMatch:Array = null;
         var mobileHelperClass:Class = null;
         var os:String = Capabilities.os;
         var version:String = "";
         if(isIOS)
         {
            osVersionMatch = os.match(/iPhone OS\s([\d\.]+)/);
            if(osVersionMatch && osVersionMatch.length == 2)
            {
               version = osVersionMatch[1];
            }
         }
         else if(isAndroid)
         {
            try
            {
               mobileHelperClass = Class(getDefinitionByName("spark.utils::PlatformMobileHelper"));
               if(mobileHelperClass != null)
               {
                  version = mobileHelperClass["computeOSVersionForAndroid"]();
               }
            }
            catch(e:Error)
            {
               trace("Error: " + e.message);
            }
         }
         else
         {
            osVersionMatch = os.match(/[A-Za-z\s]+([\d\.]+)/);
            if(osVersionMatch && osVersionMatch.length == 2)
            {
               version = osVersionMatch[1];
            }
         }
         return version;
      }
   }
}
