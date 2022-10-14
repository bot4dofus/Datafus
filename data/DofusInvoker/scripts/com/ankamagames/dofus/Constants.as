package com.ankamagames.dofus
{
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class Constants
   {
      
      public static const SIGNATURE_KEY_DATA:Class = Constants_SIGNATURE_KEY_DATA;
      
      public static const BOOK_READER_APP:Class = Constants_BOOK_READER_APP;
      
      public static const LOG_UPLOAD_MODE:Boolean = false;
      
      public static var EVENT_MODE:Boolean = false;
      
      public static var EVENT_MODE_PARAM:String = "";
      
      public static var CHARACTER_CREATION_ALLOWED:Boolean = true;
      
      public static var FORCE_MAXIMIZED_WINDOW:Boolean = true;
      
      public static const DATASTORE_COMPUTER_OPTIONS:DataStoreType = new DataStoreType("Dofus_ComputerOptions",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      
      public static const DATASTORE_LANG_VERSION:DataStoreType = new DataStoreType("lastLangVersion",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      
      public static const DATASTORE_CONSOLE_CMD:DataStoreType = new DataStoreType("Dofus_ConsoleCmd",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
      
      public static const DATASTORE_MODULE_DEBUG:DataStoreType = new DataStoreType("Dofus_ModuleDebug",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
      
      public static const DATASTORE_TCHAT:DataStoreType = new DataStoreType("Dofus_Tchat",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      
      public static const DATASTORE_TCHAT_PRIVATE:DataStoreType = new DataStoreType("Dofus_TchatPrivate",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      
      public static const PRE_GAME_MODULE:Array = new Array("Ankama_Connection");
      
      public static const COMMON_GAME_MODULE:Array = new Array("Ankama_Common","Ankama_Config","Ankama_Tooltips","Ankama_Console","Ankama_ContextMenu");
      
      public static const ADMIN_MODULE:Array = new Array("Ankama_Admin");
      
      public static const DETERMINIST_TACKLE:Boolean = true;
       
      
      public function Constants()
      {
         super();
      }
   }
}
