package com.ankamagames.dofus.console.debug
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.network.Metadata;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import flash.utils.ByteArray;
   
   public class VersionInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function VersionInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "version":
               switch(args[0])
               {
                  case "number":
                     console.output("Build number : " + BuildInfos.VERSION.toString());
                     break;
                  case "date":
                     console.output("Build date     : " + BuildInfos.BUILD_DATE);
                     break;
                  case "protocol":
                     console.output("Protocol       : " + Metadata.PROTOCOL_BUILD + " (" + Metadata.PROTOCOL_DATE + ")");
                     break;
                  case "visionneuse":
                     console.output("Visioneuse md5 : " + MD5.hashBytes(new Constants.BOOK_READER_APP() as ByteArray));
                     break;
                  case undefined:
                     console.output("DOFUS v" + BuildInfos.VERSION + " (" + BuildInfos.buildTypeName + ")");
                     console.output("MD5 visionneuse : " + MD5.hashBytes(new Constants.BOOK_READER_APP() as ByteArray));
                     break;
                  default:
                     console.output("Unknown argument : " + args[0]);
               }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "version":
               return "Get the client version.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         switch(cmd)
         {
            case "version":
               return ["revision","build","date","protocol","visionneuse"];
            default:
               return [];
         }
      }
   }
}
