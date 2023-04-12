package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.utils.files.FileUtils;
   
   public class LangMetaData
   {
       
      
      private var _nFileCount:uint = 0;
      
      public var loadAllFile:Boolean = false;
      
      public var clearAllFile:Boolean = false;
      
      public var clearOnlyNotUpToDate:Boolean = true;
      
      public var clearFile:Array;
      
      public function LangMetaData()
      {
         this.clearFile = new Array();
         super();
      }
      
      public static function fromXml(sXml:String, sUrlProvider:String, checkFunction:Function) : LangMetaData
      {
         var file:XML = null;
         var fileName:String = null;
         var fileString:String = null;
         var xml:XML = new XML(sXml);
         var metaData:LangMetaData = new LangMetaData();
         var bHaveVersionData:Boolean = false;
         var filesActions:XMLList = xml.child("filesActions");
         var clearOnlyNotUpToDate:String = filesActions.child("clearOnlyNotUpToDate").toString();
         if(clearOnlyNotUpToDate == "true")
         {
            metaData.clearOnlyNotUpToDate = true;
         }
         else if(clearOnlyNotUpToDate == "false")
         {
            metaData.clearOnlyNotUpToDate = false;
         }
         var LoadAllFile:String = filesActions.child("loadAllFile").toString();
         if(LoadAllFile == "true")
         {
            metaData.loadAllFile = true;
         }
         else if(LoadAllFile == "false")
         {
            metaData.loadAllFile = false;
         }
         var ClearAllFile:String = filesActions.child("clearAllFile").toString();
         if(ClearAllFile == "true")
         {
            metaData.clearAllFile = true;
         }
         else if(ClearAllFile == "false")
         {
            metaData.clearAllFile = false;
         }
         for each(file in xml.child("filesVersions").child("file"))
         {
            bHaveVersionData = true;
            fileName = file.@name;
            fileString = file.toString();
            if(metaData.clearAllFile || !metaData.clearOnlyNotUpToDate || !checkFunction(FileUtils.getFileStartName(sUrlProvider) + "." + fileName,fileString))
            {
               metaData.addFile(fileName,fileString);
            }
         }
         if(!bHaveVersionData)
         {
            metaData.loadAllFile = true;
         }
         return metaData;
      }
      
      public function addFile(sFilename:String, sVersion:String) : void
      {
         ++this._nFileCount;
         this.clearFile[sFilename] = sVersion;
      }
      
      public function get clearFileCount() : uint
      {
         return this._nFileCount;
      }
   }
}
