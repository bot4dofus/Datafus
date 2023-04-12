package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.TextLogEvent;
   import flash.events.Event;
   import flash.net.XMLSocket;
   
   public class SOSTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      private static var _socket:XMLSocket = new XMLSocket();
      
      private static var _history:Array = [];
      
      private static var _connecting:Boolean = false;
      
      public static var enabled:Boolean = true;
      
      public static var serverHost:String = "localhost";
      
      public static var serverPort:int = 4444;
       
      
      public function SOSTarget()
      {
         super();
      }
      
      private static function send(level:int, message:String, subMessage:String) : void
      {
         var he:LoggerHistoryElement = null;
         if(_socket.connected)
         {
            if(level != LogLevel.COMMANDS)
            {
               if(subMessage)
               {
                  _socket.send("!SOS<showFoldMessage key=\"" + getKeyName(level) + "\"><title><![CDATA[" + message + "]]></title><message><![CDATA[" + subMessage + "]]></message></showFoldMessage>");
               }
               else
               {
                  _socket.send("!SOS<showMessage key=\"" + getKeyName(level) + "\"><![CDATA[" + message + "]]></showMessage>");
               }
            }
            else
            {
               _socket.send("!SOS<" + message + "/>");
            }
         }
         else
         {
            if(!_socket.hasEventListener("connect"))
            {
               addEventListeners();
            }
            if(!_connecting)
            {
               _socket.connect(serverHost,serverPort);
               _connecting = true;
            }
            he = new LoggerHistoryElement(level,message,subMessage);
            _history.push(he);
         }
      }
      
      private static function getKeyName(level:int) : String
      {
         switch(level)
         {
            case LogLevel.TRACE:
               return "trace";
            case LogLevel.DEBUG:
               return "debug";
            case LogLevel.INFO:
               return "info";
            case LogLevel.WARN:
               return "warning";
            case LogLevel.ERROR:
               return "error";
            case LogLevel.FATAL:
               return "fatal";
            default:
               return "severe";
         }
      }
      
      private static function onSocket(e:Event) : void
      {
         var o:LoggerHistoryElement = null;
         removeEventListeners();
         _connecting = false;
         for each(o in _history)
         {
            send(o.level,o.message,o.subMessage);
         }
         _history = [];
      }
      
      private static function onSocketError(e:Event) : void
      {
         removeEventListeners();
         _connecting = false;
      }
      
      private static function addEventListeners() : void
      {
         _socket.addEventListener("connect",onSocket);
         _socket.addEventListener("ioError",onSocketError);
         _socket.addEventListener("securityError",onSocketError);
      }
      
      private static function removeEventListeners() : void
      {
         _socket.removeEventListener("connect",onSocket);
         _socket.removeEventListener("ioError",onSocketError);
         _socket.removeEventListener("securityError",onSocketError);
      }
      
      public function get socket() : XMLSocket
      {
         return _socket;
      }
      
      public function get connected() : Boolean
      {
         return _connecting;
      }
      
      override public function logEvent(event:LogEvent) : void
      {
         var msg:String = null;
         if(enabled && event is TextLogEvent)
         {
            msg = event.message;
            if(event.level == LogLevel.COMMANDS)
            {
               switch(msg)
               {
                  case "clear":
                     msg = "<clear/>";
               }
            }
            send(event.level,event.message,event.stackTrace);
         }
      }
      
      public function configure(config:XML) : void
      {
         if(config..server.@host != undefined)
         {
            serverHost = String(config..server.@host);
         }
         if(config..server.@port != undefined)
         {
            serverPort = int(config..server.@port);
         }
      }
   }
}
