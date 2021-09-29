package com.ankamagames.berilia.utils.web
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.filesystem.File;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class HttpServer extends EventDispatcher
   {
      
      private static var _self:HttpServer;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServer));
       
      
      private var _server:Object;
      
      private var _sockets:Array;
      
      private var _usedPort:uint;
      
      private var _rootPath:String;
      
      public function HttpServer()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : HttpServer
      {
         if(!_self)
         {
            _self = new HttpServer();
         }
         return _self;
      }
      
      public function get rootPath() : String
      {
         return this._rootPath;
      }
      
      public function init(rootPath:File) : Boolean
      {
         this._rootPath = rootPath.nativePath;
         if(this._usedPort)
         {
            return true;
         }
         this._sockets = [];
         this._server = new (getDefinitionByName("flash.net.ServerSocket") as Class)();
         this._server.addEventListener(Event.CONNECT,this.onConnect);
         var tryCount:uint = 100;
         var currentPort:uint = 1100;
         while(tryCount)
         {
            try
            {
               this._server.bind(currentPort,"127.0.0.1");
               this._server.listen();
               this._usedPort = currentPort;
               _log.warn("Listening on port " + currentPort + "...\n");
               return true;
            }
            catch(e:Error)
            {
               currentPort++;
               tryCount--;
            }
         }
         return false;
      }
      
      public function getUrlTo(target:String) : String
      {
         return "http://localhost:" + this._usedPort + "/" + target;
      }
      
      public function close() : void
      {
         var httpSocket:HttpSocket = null;
         for each(httpSocket in this._sockets)
         {
            httpSocket.tearDown();
         }
         if(this._server != null && this._server.bound)
         {
            this._server.removeEventListener(Event.CONNECT,this.onConnect);
            this._server.close();
            _log.warn("Server closed");
         }
      }
      
      private function onConnect(event:Event) : void
      {
         var htppSocket:HttpSocket = new HttpSocket(Object(event).socket,this._rootPath);
         htppSocket.addEventListener(Event.COMPLETE,this.onHttpSocketComplete);
         this._sockets.push(htppSocket);
      }
      
      private function onHttpSocketComplete(e:Event) : void
      {
         var httpSocketToRemove:HttpSocket = e.target as HttpSocket;
         httpSocketToRemove.removeEventListener(Event.COMPLETE,this.onHttpSocketComplete);
         this._sockets.splice(this._sockets.indexOf(httpSocketToRemove),1);
      }
   }
}
