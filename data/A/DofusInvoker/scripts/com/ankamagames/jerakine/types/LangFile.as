package com.ankamagames.jerakine.types
{
   public class LangFile
   {
       
      
      public var content:String;
      
      public var url:String;
      
      public var category:String;
      
      public var metaData:LangMetaData;
      
      public function LangFile(sContent:String, sCategory:String, sUrl:String, oMeta:LangMetaData = null)
      {
         super();
         this.content = sContent;
         this.url = sUrl;
         this.category = sCategory;
         this.metaData = oMeta;
      }
   }
}
