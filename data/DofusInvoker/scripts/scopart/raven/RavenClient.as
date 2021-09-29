package scopart.raven
{
   import com.adobe.serialization.json.JSONEncoder;
   import flash.utils.ByteArray;
   
   public class RavenClient
   {
      
      public static const DEBUG:uint = 10;
      
      public static const INFO:uint = 20;
      
      public static const WARN:uint = 30;
      
      public static const ERROR:uint = 40;
      
      public static const FATAL:uint = 50;
      
      public static const VERSION:String = "ankama";
      
      public static const NAME:String = "raven-as3";
       
      
      private var _config:RavenConfig;
      
      private var _sender:RavenMessageSender;
      
      private var _lastID:String;
      
      private var _tags:Object;
      
      private var _extras:Object;
      
      private var _user:Object;
      
      public function RavenClient(sentryDSN:String, release:String, environment:String, errorCallback:Function = null)
      {
         super();
         if(sentryDSN == null || sentryDSN.length == 0)
         {
            throw new ArgumentError("You must provide a DSN to RavenClient");
         }
         this._config = new RavenConfig(sentryDSN,release,environment);
         this._sender = new RavenMessageSender(this._config,errorCallback);
      }
      
      public function setTags(tags:Object = null) : void
      {
         this._tags = tags;
      }
      
      public function setExtras(extras:Object = null) : void
      {
         this._extras = extras;
      }
      
      public function setUserInfos(user:Object = null) : void
      {
         this._user = user;
      }
      
      public function getConfig() : RavenConfig
      {
         return this._config;
      }
      
      public function captureMessage(message:String, logger:String = "root", level:int = 40, culprit:String = null) : String
      {
         var now:Date = new Date();
         var messageBody:String = this.buildMessage(message,RavenUtils.formatTimestamp(now),logger,level,culprit,null);
         this._tags = {};
         this._extras = {};
         this._user = {};
         this._sender.send(messageBody,now.time);
         return this._lastID;
      }
      
      public function captureException(error:Error, message:String = null, logger:String = "root", level:int = 40, culprit:String = null) : String
      {
         var now:Date = new Date();
         var messageBody:String = this.buildMessage(message || error.message,RavenUtils.formatTimestamp(now),logger,level,culprit,error);
         this._tags = {};
         this._extras = {};
         this._user = {};
         this._sender.send(messageBody,now.time);
         return this._lastID;
      }
      
      private function buildMessage(message:String, timeStamp:String, logger:String, level:int, culprit:String, error:Error) : String
      {
         var json:String = this.buildJSON(message,timeStamp,logger,level,culprit,error);
         var byteArray:ByteArray = new ByteArray();
         byteArray.writeMultiByte(json,"utf-8");
         return RavenBase64.encode(byteArray);
      }
      
      private function buildJSON(message:String, timeStamp:String, logger:String, level:int, culprit:String, error:Error) : String
      {
         var fingerprint:String = null;
         this._lastID = RavenUtils.uuid4();
         var object:Object = new Object();
         object["message"] = message;
         object["event_id"] = this._lastID;
         object["platform"] = "as3";
         object["sdk"] = {
            "name":NAME,
            "version":VERSION
         };
         object["environment"] = this._config.environment;
         object["release"] = this._config.release;
         object["user"] = this._user;
         if(error == null)
         {
            object["culprit"] = culprit;
         }
         else
         {
            if(error.getStackTrace())
            {
               fingerprint = this.determineCulprit(error);
               object["culprit"] = fingerprint;
               object["fingerprint"] = [fingerprint];
               object["sentry.interfaces.Stacktrace"] = this.buildStacktrace(error);
            }
            object["sentry.interfaces.Exception"] = this.buildException(error,message);
         }
         object["timestamp"] = timeStamp;
         object["project"] = this._config.projectID;
         object["level"] = level;
         object["logger"] = logger;
         object["tags"] = this._tags;
         object["extra"] = this._extras;
         var encoder:JSONEncoder = new JSONEncoder(object);
         return encoder.getString();
      }
      
      private function buildException(error:Error, message:String) : Object
      {
         var object:Object = new Object();
         object["type"] = RavenUtils.getClassName(error);
         object["value"] = !!error.message ? error.message : message;
         object["module"] = RavenUtils.getModuleName(error);
         return object;
      }
      
      private function buildStacktrace(error:Error) : Object
      {
         var result:Object = new Object();
         result["frames"] = RavenUtils.parseStackTrace(error);
         return result;
      }
      
      private function determineCulprit(error:Error) : String
      {
         return RavenUtils.getFirstStackTraceLine(error);
      }
   }
}
