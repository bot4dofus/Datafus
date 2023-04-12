package com.ankamagames.jerakine.task
{
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.tasking.SplittedTask;
   import com.ankamagames.jerakine.types.LangFile;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class LangXmlParsingTask extends SplittedTask
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LangXmlParsingTask));
       
      
      private var _nCurrentIndex:uint;
      
      private var _aFiles:Array;
      
      private var _sUrlProvider:String;
      
      private var _parseReference:Boolean;
      
      public function LangXmlParsingTask(aFiles:Array, sUrlProvider:String, parseReference:Boolean = true)
      {
         super();
         this._nCurrentIndex = 0;
         this._aFiles = aFiles;
         this._sUrlProvider = sUrlProvider;
         this._parseReference = parseReference;
      }
      
      override public function step(e:Event) : void
      {
         var file:LangFile = null;
         if(this._aFiles.length)
         {
            file = LangFile(this._aFiles.shift());
            this.parseXml(file.content,file.category);
            if(file.metaData && file.metaData.clearFile[file.url])
            {
               LangManager.getInstance().setFileVersion(FileUtils.getFileStartName(this._sUrlProvider) + "." + file.url,file.metaData.clearFile[file.url]);
            }
            dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE,false,false,file.url,this._sUrlProvider));
         }
         if(!this._aFiles.length)
         {
            dispatchEvent(new LangFileEvent(LangFileEvent.ALL_COMPLETE,false,false,this._sUrlProvider,this._sUrlProvider));
         }
      }
      
      override public function stepsPerFrame() : uint
      {
         return 1;
      }
      
      private function parseXml(sXml:String, sCategory:String) : void
      {
         var xml:XML = null;
         var sEntry:String = null;
         var entry:XML = null;
         try
         {
            xml = new XML(sXml);
            LangManager.getInstance().category[sCategory] = true;
            StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,"langCategory",LangManager.getInstance().category);
            for each(entry in xml..entry)
            {
               if(this._parseReference)
               {
                  sEntry = LangManager.getInstance().replaceKey(entry.toString());
               }
               else
               {
                  sEntry = entry.toString();
               }
               LangManager.getInstance().setEntry(sCategory + "." + entry..@key,sEntry,!!entry..@type.toString().length ? entry..@type : null);
            }
         }
         catch(e:TypeError)
         {
            _log.error("Parsing error on category " + sCategory);
         }
      }
   }
}
