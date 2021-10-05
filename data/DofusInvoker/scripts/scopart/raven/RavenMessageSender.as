package scopart.raven
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.system.Security;
   import flash.utils.Dictionary;
   
   public class RavenMessageSender
   {
       
      
      private var _config:RavenConfig;
      
      private var _errorCallback:Function;
      
      private var _httpStatus:Dictionary;
      
      public function RavenMessageSender(config:RavenConfig, errorCallback:Function)
      {
         super();
         this._config = config;
         this._errorCallback = errorCallback;
         this._httpStatus = new Dictionary();
         Security.loadPolicyFile(this._config.uri + "api/" + this._config.projectID + "/crossdomain.xml");
      }
      
      public function send(message:String, timestamp:Number) : void
      {
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFail);
         var request:URLRequest = new URLRequest(this._config.uri + "api/" + this._config.projectID + "/store/");
         request.method = URLRequestMethod.POST;
         request.requestHeaders.push(new URLRequestHeader("X-Sentry-Auth",this.buildAuthHeader(timestamp)));
         request.requestHeaders.push(new URLRequestHeader("Content-Type","application/octet-stream"));
         request.data = message;
         loader.load(request);
      }
      
      private function buildAuthHeader(timestamp:Number) : String
      {
         var header:* = "Sentry sentry_version=7";
         header += ", sentry_timestamp=";
         header += timestamp;
         header += ", sentry_client=";
         header += RavenClient.NAME + "/" + RavenClient.VERSION;
         header += ", sentry_key=";
         header += this._config.publicKey;
         if(this._config.privateKey)
         {
            header += ", sentry_secret=" + this._config.privateKey;
         }
         return header;
      }
      
      private function onLoadFail(event:IOErrorEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         var httpStatus:int = this._httpStatus[loader];
         if(this._errorCallback != null)
         {
            this._errorCallback("Error reporting Sentry error " + (!!httpStatus ? "(HTTP status : " + httpStatus + ")" : "") + " : " + event.text + " : " + loader.data,event);
         }
         this.removeListeners(loader);
      }
      
      private function onLoadComplete(event:Event) : void
      {
         this.removeListeners(URLLoader(event.target));
      }
      
      private function onHttpStatus(event:HTTPStatusEvent) : void
      {
         var loader:URLLoader = URLLoader(event.target);
         this._httpStatus[loader] = event.status;
      }
      
      private function removeListeners(loader:URLLoader) : void
      {
         loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadFail);
         loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         delete this._httpStatus[loader];
      }
   }
}
