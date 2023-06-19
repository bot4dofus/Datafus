package com.ankamagames.dofus.console.debug
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.crypto.CRC32;
   import flash.utils.ByteArray;
   
   public class CryptoInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function CryptoInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var crc32:CRC32 = null;
         var buffer:ByteArray = null;
         switch(cmd)
         {
            case "crc32":
               crc32 = new CRC32();
               buffer = new ByteArray();
               buffer.writeUTFBytes(args.join(" "));
               crc32.update(buffer);
               console.output("CRC32 checksum : " + crc32.getValue().toString(16));
               break;
            case "md5":
               console.output("MD5 hash : " + MD5.hash(args.join(" ")));
         }
      }
      
      public function getArgs(cmd:String) : Array
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return [];
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "crc32":
               return "Calculate the CRC32 checksum of a given string.";
            case "md5":
               return "Calculate the MD5 hash of a given string.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getMan(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noMan",[cmd]);
      }
      
      public function getExamples(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noExample",[cmd]);
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}
