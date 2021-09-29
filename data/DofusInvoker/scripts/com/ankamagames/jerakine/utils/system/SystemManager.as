package com.ankamagames.jerakine.utils.system
{
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.enum.WebBrowserEnum;
   import flash.desktop.DockIcon;
   import flash.desktop.NativeApplication;
   import flash.desktop.NotificationType;
   import flash.display.NativeWindow;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   
   public class SystemManager
   {
      
      private static var _singleton:SystemManager;
       
      
      private var _os:String;
      
      private var _version:String;
      
      private var _cpu:String;
      
      private var _browser:String;
      
      private var _browserVersion:String;
      
      public function SystemManager()
      {
         super();
         this.parseSystemInfo();
      }
      
      public static function getSingleton() : SystemManager
      {
         if(!_singleton)
         {
            _singleton = new SystemManager();
         }
         return _singleton;
      }
      
      public function get os() : String
      {
         return this._os;
      }
      
      public function get version() : String
      {
         return this._version;
      }
      
      public function get cpu() : String
      {
         return this._cpu;
      }
      
      public function get browser() : String
      {
         var userAgent:String = null;
         if(!this._browser)
         {
            if(!ExternalInterface.available)
            {
               this._browser = WebBrowserEnum.NONE;
               return this._browser;
            }
            try
            {
               userAgent = (ExternalInterface.call("window.navigator.userAgent.toString") as String).toLowerCase();
               switch(true)
               {
                  case userAgent.indexOf("chrome") != -1:
                     this._browser = WebBrowserEnum.CHROME;
                     break;
                  case userAgent.indexOf("firefox") != -1:
                     this._browser = WebBrowserEnum.FIREFOX;
                     break;
                  case userAgent.indexOf("msie") != -1:
                     this._browser = WebBrowserEnum.INTERNET_EXPLORER;
                     break;
                  case userAgent.indexOf("safari") != -1:
                     this._browser = WebBrowserEnum.SAFARI;
                     break;
                  case userAgent.indexOf("opera") != -1:
                     this._browser = WebBrowserEnum.OPERA;
                     break;
                  default:
                     this._browser = WebBrowserEnum.UNKNOWN;
               }
            }
            catch(e:Error)
            {
               _browser = WebBrowserEnum.UNIDENTIFIABLE;
            }
         }
         return this._browser;
      }
      
      public function get browserVersion() : String
      {
         if(!this._browserVersion)
         {
            if(!ExternalInterface.available)
            {
               this._browserVersion = "-1";
               return this._browserVersion;
            }
            try
            {
               this._browserVersion = ExternalInterface.call(String(<![CDATA[
						function get_browser_version(){
							var ua=navigator.userAgent,tem,M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];                                                                                                                         
							if(/trident/i.test(M[1])){
								tem=/\brv[ :]+(\d+)/g.exec(ua) || [];
								return 'IE '+(tem[1]||'');
							}
							if(M[1]==='Chrome'){
								tem=ua.match(/\bOPR\/(\d+)/)
								if(tem!=null)   {return 'Opera '+tem[1];}
							}   
							M=M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
							if((tem=ua.match(/version\/(\d+)/i))!=null) {M.splice(1,1,tem[1]);}
							return M[1];
						}
					]]>));
            }
            catch(e:Error)
            {
               _browserVersion = "0";
            }
         }
         return this._browserVersion;
      }
      
      public function notifyUser(always:Boolean = false) : void
      {
         var currentWindow:NativeWindow = null;
         try
         {
            currentWindow = NativeApplication.nativeApplication.openedWindows[0];
            if(always || !currentWindow.active)
            {
               if(this.os == OperatingSystem.MAC_OS)
               {
                  DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
               }
               else
               {
                  currentWindow.notifyUser(NotificationType.CRITICAL);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function parseSystemInfo() : void
      {
         var cos:String = Capabilities.os;
         if(cos == OperatingSystem.LINUX)
         {
            this._os = OperatingSystem.LINUX;
            this._version = "unknown";
         }
         else if(cos.substr(0,OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
         {
            this._os = OperatingSystem.MAC_OS;
            this._version = cos.substr(OperatingSystem.MAC_OS.length + 1);
         }
         else if(cos.substr(0,OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
         {
            this._os = OperatingSystem.WINDOWS;
            this._version = cos.substr(OperatingSystem.WINDOWS.length + 1);
         }
         this._cpu = Capabilities.cpuArchitecture;
      }
   }
}
