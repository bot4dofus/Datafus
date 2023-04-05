package com.ankamagames.jerakine.utils.system
{
   import flash.system.LoaderContext;
   
   public class AirScanner
   {
       
      
      public function AirScanner()
      {
         super();
      }
      
      public static function allowByteCodeExecution(pContext:LoaderContext, pVal:Boolean) : void
      {
         if(pContext.hasOwnProperty("allowCodeImport"))
         {
            pContext["allowCodeImport"] = pVal;
         }
         else
         {
            pContext["allowLoadBytesCodeExecution"] = pVal;
         }
      }
   }
}
