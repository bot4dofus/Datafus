package com.ankamagames.jerakine.utils.files
{
   public class FileUtils
   {
       
      
      public function FileUtils()
      {
         super();
      }
      
      public static function getExtension(sUrl:String) : String
      {
         if(!sUrl || sUrl.lastIndexOf(".") == -1)
         {
            return null;
         }
         return sUrl.substring(sUrl.lastIndexOf(".") + 1);
      }
      
      public static function getFileName(sUrl:String) : String
      {
         return sUrl.substring(sUrl.lastIndexOf("/") + 1);
      }
      
      public static function getFilePath(sUrl:String) : String
      {
         if(sUrl.indexOf("/") != -1)
         {
            return sUrl.substring(0,sUrl.lastIndexOf("/"));
         }
         if(sUrl.indexOf("\\") != -1)
         {
            return sUrl.substring(0,sUrl.lastIndexOf("\\"));
         }
         return "";
      }
      
      public static function getFilePathStartName(sUrl:String) : String
      {
         return sUrl.substring(0,sUrl.lastIndexOf("."));
      }
      
      public static function getFileStartName(sUrl:String) : String
      {
         return sUrl.substring(sUrl.lastIndexOf("/") + 1,sUrl.lastIndexOf("."));
      }
   }
}
