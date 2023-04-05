package com.ankamagames.dofus
{
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.types.Version;
   
   public final class BuildInfos
   {
      
      public static var VERSION:Version = new Version("2.42.0",BuildTypeEnum.RELEASE);
      
      public static var BUILD_DATE:String = "01/Jan/1970";
       
      
      public function BuildInfos()
      {
         super();
      }
      
      public static function get buildTypeName() : String
      {
         return BuildTypeParser.getTypeName(VERSION.buildType);
      }
      
      public static function get BUILD_TYPE() : uint
      {
         return VERSION.buildType;
      }
   }
}
