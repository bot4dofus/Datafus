package com.ankamagames.jerakine.resources
{
   public class ResourceType
   {
      
      public static const RESOURCE_BINARY:uint = 1;
      
      public static const RESOURCE_BITMAP:uint = 2;
      
      public static const RESOURCE_DX:uint = 3;
      
      public static const RESOURCE_SWF:uint = 4;
      
      public static const RESOURCE_SWL:uint = 5;
      
      public static const RESOURCE_XML:uint = 6;
      
      public static const RESOURCE_ZIP:uint = 7;
      
      public static const RESOURCE_TXT:uint = 8;
      
      public static const RESOURCE_ASWF:uint = 9;
      
      public static const RESOURCE_MP3:uint = 16;
      
      public static const RESOURCE_SIGNED_FILE:uint = 17;
      
      public static const RESOURCE_JSON:uint = 18;
      
      public static const RESOURCE_NONE:uint = 255;
       
      
      public function ResourceType()
      {
         super();
      }
      
      public static function getName(type:uint) : String
      {
         switch(type)
         {
            case RESOURCE_BINARY:
               return "binary";
            case RESOURCE_BITMAP:
               return "bitmap";
            case RESOURCE_DX:
               return "dx";
            case RESOURCE_SWF:
               return "swf";
            case RESOURCE_SWL:
               return "swl";
            case RESOURCE_XML:
               return "xml";
            case RESOURCE_MP3:
               return "mp3";
            case RESOURCE_SIGNED_FILE:
               return "signedFile";
            case RESOURCE_NONE:
               return "none";
            default:
               return "unknown";
         }
      }
   }
}
