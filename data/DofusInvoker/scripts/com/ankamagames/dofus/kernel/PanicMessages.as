package com.ankamagames.dofus.kernel
{
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   
   public final class PanicMessages
   {
      
      private static const _i18nFile:Class = PanicMessages__i18nFile;
      
      private static const _bytes:ByteArray = new _i18nFile() as ByteArray;
      
      private static const _i18n = by.blooddy.crypto.serialization.JSON.decode(_bytes.readUTFBytes(_bytes.bytesAvailable));
      
      private static const SUPPORT_URL:String = "https://support.ankama.com/";
      
      public static const CONFIG_LOADING_FAILED:uint = 1;
      
      public static const I18N_LOADING_FAILED:uint = 2;
      
      public static const WRONG_CONTEXT_CREATED:uint = 3;
      
      public static const PROTOCOL_TOO_OLD:uint = 4;
      
      public static const PROTOCOL_TOO_NEW:uint = 5;
      
      public static const TOO_MANY_CLIENTS:uint = 6;
      
      public static const UNABLE_TO_GET_FLASHKEY:uint = 7;
      
      public static const OUT_OF_MEMORY:uint = 8;
      
      public static const MALFORMED_PROTOCOL:uint = 9;
      
      public static const PROTOCOL_MISMATCH:uint = 10;
       
      
      public function PanicMessages()
      {
         super();
      }
      
      public static function getMessage(errorId:uint, args:Array) : String
      {
         var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
         if(!lang)
         {
            lang = Capabilities.language;
         }
         lang = !_i18n[lang] ? "en" : lang;
         var errorKey:String = "error" + errorId;
         var message:String = !_i18n[lang][errorKey] ? _i18n[lang]["unknown"] : _i18n[lang][errorKey];
         if(errorId != PanicMessages.OUT_OF_MEMORY)
         {
            if(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE && errorId != PanicMessages.PROTOCOL_TOO_OLD && errorId != PanicMessages.TOO_MANY_CLIENTS && errorId != PanicMessages.PROTOCOL_TOO_NEW)
            {
               message += "\n" + _i18n[lang]["support"] + " <a href=\'" + SUPPORT_URL + "\'><font color=\'#ffd376\'><b>" + SUPPORT_URL + "</b></font></a>";
            }
            else
            {
               message += "\n" + _i18n[lang]["update"];
            }
         }
         return !!message ? ParamsDecoder.applyParams(message,args) : "";
      }
   }
}
