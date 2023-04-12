package com.ankamagames.jerakine.benchmark
{
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.ObjectEncoding;
   import mx.utils.UIDUtil;
   
   public class LogInFile
   {
      
      private static var _self:LogInFile;
      
      private static const FILENAME:String = "BenchmarkTimers_";
       
      
      private var sessionUID:String;
      
      private var _file:File;
      
      private var _fileStream:FileStream;
      
      private var _isFeatureEnabled:Boolean = false;
      
      private var _featureManagerChecked:Boolean = false;
      
      private var _logQueue:Array;
      
      public function LogInFile()
      {
         this._logQueue = [];
         super();
         this.sessionUID = UIDUtil.getUID(this);
         this._fileStream = new FileStream();
      }
      
      public static function getInstance() : LogInFile
      {
         if(!_self)
         {
            _self = new LogInFile();
         }
         return _self;
      }
      
      public function logLine(line:String, filePrefix:String) : void
      {
         var dirPath:String = null;
         var file:File = null;
         if(!this._isFeatureEnabled)
         {
            if(!this._featureManagerChecked)
            {
               this._logQueue.push({
                  "line":line,
                  "filePrefix":filePrefix
               });
            }
            return;
         }
         try
         {
            dirPath = CustomSharedObject.getCustomSharedObjectDirectory();
            file = new File(dirPath + File.separator + filePrefix + this.sessionUID + ".txt");
            this._fileStream.objectEncoding = ObjectEncoding.AMF3;
            this._fileStream.open(file,FileMode.APPEND);
            this._fileStream.writeUTFBytes(this.formatTime() + " " + line + "\n");
            this._fileStream.close();
         }
         catch(e:Error)
         {
            if(_fileStream)
            {
               _fileStream.close();
            }
         }
      }
      
      private function formatTime() : String
      {
         var date:Date = new Date();
         var day:Number = date.getDay();
         var month:Number = date.getMonth() + 1;
         var hours:Number = date.getHours();
         var minutes:Number = date.getMinutes();
         var seconds:Number = date.getSeconds();
         var format:* = "[";
         if(day < 10)
         {
            format += "0";
         }
         format += day + "/";
         if(month < 10)
         {
            format += "0";
         }
         format += month + "/" + date.getFullYear() + " - ";
         if(hours < 10)
         {
            format += "0";
         }
         format += hours + ":";
         if(minutes < 10)
         {
            format += "0";
         }
         format += minutes + ":";
         if(seconds < 10)
         {
            format += "0";
         }
         return format + (seconds + "]");
      }
      
      public function enableFeature(enabled:Boolean) : void
      {
         this._isFeatureEnabled = enabled;
         this._featureManagerChecked = true;
         if(this._isFeatureEnabled)
         {
            this.logQueue();
         }
         else
         {
            this._logQueue = [];
         }
      }
      
      public function onFeatureManagerInitializationFinished() : void
      {
         if(this._featureManagerChecked)
         {
            return;
         }
         this.enableFeature(false);
      }
      
      private function logQueue() : void
      {
         var log:Object = null;
         for each(log in this._logQueue)
         {
            this.logLine(log.line,log.filePrefix);
         }
      }
   }
}
