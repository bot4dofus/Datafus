package com.ankamagames.dofus.misc.utils.errormanager
{
   import by.blooddy.crypto.Base64;
   import by.blooddy.crypto.image.JPEGEncoder;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.utils.system.SystemPopupUI;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   
   public class ErrorReport
   {
      
      private static var _htmlTemplate:Class = ErrorReport__htmlTemplate;
      
      private static var ONLINE_REPORT_PLATEFORM:String = "http://utils.dofus.lan/bugs/";
      
      private static var ONLINE_REPORT_SERVICE:String = ONLINE_REPORT_PLATEFORM + "makeReport.php";
       
      
      private var _reportData:Object;
      
      private var _htmlReport:String = "";
      
      private var _fightFrame:FightContextFrame;
      
      public function ErrorReport(reportInfo:Object)
      {
         super();
         this._reportData = reportInfo;
      }
      
      private function makeHtmlReport() : String
      {
         var template:String = null;
         var key:* = null;
         if(this._htmlReport == "")
         {
            template = new _htmlTemplate();
            if(this._reportData.screenshot && this._reportData.screenshot is BitmapData)
            {
               this._reportData.screenshot = Base64.encode(JPEGEncoder.encode(this._reportData.screenshot,80));
            }
            if(this._reportData.stacktrace && this._reportData.stacktrace is String)
            {
               this._reportData.stacktrace = String(this._reportData.stacktrace).replace(/</g,"&lt;").replace(/>/g,"&gt;");
            }
            for(key in this._reportData)
            {
               template = template.replace("{{" + key + "}}",this._reportData[key]);
            }
            this._htmlReport = template;
         }
         return this._htmlReport;
      }
      
      public function saveReport() : void
      {
         var date:Date = new Date();
         var fileName:* = "dofus_bug_report_" + date.date + "-" + (date.month + 1) + "-" + date.fullYear + "_" + date.hours + "h" + date.minutes + "m" + date.seconds + "s.html";
         var file:File = File.desktopDirectory.resolvePath(fileName);
         file.addEventListener(Event.SELECT,this.onFileSelected);
         file.browseForSave("Save report");
      }
      
      private function onFileSelected(e:Event) : void
      {
         var fs:FileStream = null;
         var popup:SystemPopupUI = null;
         (e.target as File).removeEventListener(Event.SELECT,this.onFileSelected);
         try
         {
            fs = new FileStream();
            fs.open(e.target as File,FileMode.WRITE);
            fs.writeUTFBytes(this.makeHtmlReport());
            fs.close();
         }
         catch(err:Error)
         {
            popup = new SystemPopupUI("ReportSaveFail");
            popup.title = "Error";
            popup.content = "An error occurred during report saving :\n" + err.message;
            popup.show();
         }
      }
      
      public function sendReport() : void
      {
         var ur:URLRequest = new URLRequest(ONLINE_REPORT_SERVICE);
         ur.method = URLRequestMethod.POST;
         var reportRawData:ByteArray = new ByteArray();
         reportRawData.writeUTFBytes(this.makeHtmlReport());
         ur.data = new URLVariables();
         URLVariables(ur.data).userName = File.documentsDirectory.nativePath.split(File.separator)[2];
         URLVariables(ur.data).htmlContent = Base64.encode(reportRawData);
         var urlLoader:URLLoader = new URLLoader(ur);
         urlLoader.addEventListener(Event.COMPLETE,this.sendReportComplete);
      }
      
      private function sendReportComplete(e:Event) : void
      {
         var popup2:SystemPopupUI = null;
         (e.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,this.sendReportComplete);
         var response:String = e.currentTarget.data;
         if(response.charAt(0) == "0")
         {
            navigateToURL(new URLRequest(ONLINE_REPORT_PLATEFORM + response.substr(2)));
         }
         else
         {
            popup2 = new SystemPopupUI("exception" + Math.random());
            popup2.width = 300;
            popup2.centerContent = false;
            popup2.title = "Error";
            popup2.content = response.substr(2);
            popup2.buttons = [{
               "label":"OK",
               "callback":trace
            }];
            popup2.show();
         }
         (e.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,this.sendReportComplete);
      }
      
      private function getFightFrame() : FightContextFrame
      {
         if(this._fightFrame == null)
         {
            this._fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         }
         return this._fightFrame;
      }
   }
}
