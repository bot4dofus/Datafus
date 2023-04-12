package com.ankamagames.jerakine.resources
{
   public class ResourceErrorCode
   {
      
      public static const UNKNOWN_ERROR:uint = 255;
      
      public static const RESOURCE_NOT_FOUND:uint = 1;
      
      public static const SUB_RESOURCE_NOT_FOUND:uint = 2;
      
      public static const DX_MALFORMED_SCRIPT:uint = 16;
      
      public static const DX_MALFORMED_BINARY:uint = 17;
      
      public static const DX_SECURITY_ERROR:uint = 18;
      
      public static const DX_NO_SCRIPT_INSIDE:uint = 19;
      
      public static const SWL_MALFORMED_LIBRARY:uint = 32;
      
      public static const SWL_MALFORMED_BINARY:uint = 33;
      
      public static const XML_MALFORMED_FILE:uint = 48;
      
      public static const ZIP_FILE_NOT_FOUND_IN_ARCHIVE:uint = 64;
      
      public static const ZIP_NOT_FOUND:uint = 65;
      
      public static const MALFORMED_MAP_FILE:uint = 80;
      
      public static const MALFORMED_ELE_FILE:uint = 81;
      
      public static const FILE_NOT_FOUND_IN_PAK:uint = 96;
      
      public static const PAK_NOT_FOUND:uint = 97;
      
      public static const INCOMPATIBLE_ADAPTER:uint = 98;
      
      public static const INVALID_SIGNATURE:uint = 99;
       
      
      public function ResourceErrorCode()
      {
         super();
      }
   }
}
