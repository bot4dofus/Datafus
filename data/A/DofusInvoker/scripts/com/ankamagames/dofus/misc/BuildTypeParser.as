package com.ankamagames.dofus.misc
{
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class BuildTypeParser
   {
       
      
      public function BuildTypeParser()
      {
         super();
      }
      
      public static function getTypeName(type:uint) : String
      {
         switch(type)
         {
            case BuildTypeEnum.RELEASE:
               return "Release";
            case BuildTypeEnum.BETA:
               return "Beta";
            case BuildTypeEnum.ALPHA:
               return "Alpha";
            case BuildTypeEnum.TESTING:
               return "Testing";
            case BuildTypeEnum.INTERNAL:
               return "Local";
            case BuildTypeEnum.DEBUG:
               return "Debug";
            case BuildTypeEnum.DRAFT:
               return "Draft";
            default:
               return "UNKNOWN";
         }
      }
      
      public static function getTypeColor(type:uint) : uint
      {
         switch(type)
         {
            case BuildTypeEnum.RELEASE:
               return 10079232;
            case BuildTypeEnum.BETA:
               return 16763904;
            case BuildTypeEnum.ALPHA:
               return 16750848;
            case BuildTypeEnum.TESTING:
               return 16737792;
            case BuildTypeEnum.INTERNAL:
               return 6724095;
            case BuildTypeEnum.DEBUG:
               return 10053375;
            case BuildTypeEnum.DRAFT:
               return 10053375;
            default:
               return 16777215;
         }
      }
   }
}
