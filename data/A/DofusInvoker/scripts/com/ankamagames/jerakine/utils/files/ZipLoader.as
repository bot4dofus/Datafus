package com.ankamagames.jerakine.utils.files
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class ZipLoader extends EventDispatcher
   {
       
      
      private var _zipFile:ZipFile;
      
      private var _files:Array;
      
      private var _filesNames:Array;
      
      private var _oExtraData;
      
      private var _loader:URLLoader;
      
      public var url:String;
      
      public var loaded:Boolean;
      
      public function ZipLoader(fileRequest:URLRequest = null, oExtraData:* = null)
      {
         super();
         this._oExtraData = oExtraData;
         if(fileRequest != null)
         {
            this.load(fileRequest);
         }
      }
      
      public function get extraData() : *
      {
         return this._oExtraData;
      }
      
      public function load(request:URLRequest) : void
      {
         this.loaded = false;
         this._files = new Array();
         this._filesNames = new Array();
         this._zipFile = null;
         this._loader = new URLLoader();
         this._loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.addEventListeners();
         this._loader.load(request);
         this.url = request.url;
      }
      
      private function addEventListeners() : void
      {
         this._loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.addEventListener(Event.OPEN,this.onOpen);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      private function removeEventListeners() : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.removeEventListener(Event.OPEN,this.onOpen);
         this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._loader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      public function getFilesList() : Array
      {
         return this._filesNames;
      }
      
      public function getFileDatas(fileName:String) : ByteArray
      {
         return this._zipFile.getInput(this._files[fileName]);
      }
      
      public function fileExists(fileName:String) : Boolean
      {
         for(var i:uint = 0; i < this._filesNames.length; i++)
         {
            if(this._filesNames[i] == fileName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function destroy() : void
      {
         if(this._loader)
         {
            this.removeEventListeners();
            this._loader.close();
         }
      }
      
      private function onLoadComplete(e:Event) : void
      {
         var entry:ZipEntry = null;
         var zipData:ByteArray = ByteArray(URLLoader(e.target).data);
         this._zipFile = new ZipFile(zipData);
         for(var i:uint = 0; i < this._zipFile.entries.length; i++)
         {
            entry = this._zipFile.entries[i];
            this._files[entry.name] = entry;
            this._filesNames.push(entry.name);
         }
         dispatchEvent(e);
      }
      
      private function onHttpStatus(httpse:HTTPStatusEvent) : void
      {
         dispatchEvent(httpse);
      }
      
      private function onIOError(ioe:IOErrorEvent) : void
      {
         dispatchEvent(ioe);
      }
      
      private function onOpen(e:Event) : void
      {
         dispatchEvent(e);
      }
      
      private function onSecurityError(se:SecurityErrorEvent) : void
      {
         dispatchEvent(se);
      }
      
      private function onProgress(pe:ProgressEvent) : void
      {
         dispatchEvent(pe);
      }
   }
}
