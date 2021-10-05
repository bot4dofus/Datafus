package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.events.ErrorReportedEvent;
   import com.ankamagames.jerakine.utils.errors.Result;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.EventDispatcher;
   import flash.events.UncaughtErrorEvent;
   import flash.utils.getQualifiedClassName;
   
   public class ErrorManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ErrorManager));
      
      public static var showPopup:Boolean = false;
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function ErrorManager()
      {
         super();
      }
      
      public static function tryFunction(fct:Function, params:Array = null, complementaryInformations:String = "", context:Object = null) : Result
      {
         var result:Result = null;
         var tags:Object = null;
         var i:int = 0;
         var param:* = undefined;
         var paramToString:String = null;
         result = new Result();
         if(!eventDispatcher.hasEventListener(ErrorReportedEvent.ERROR))
         {
            result.result = fct.apply(context,params);
            result.success = true;
         }
         else
         {
            try
            {
               result.result = fct.apply(context,params);
               result.success = true;
            }
            catch(e:Error)
            {
               result.success = false;
               result.stackTrace = e.message + " : \n" + e.getStackTrace();
               tags = {};
               if(params)
               {
                  i = 0;
                  while(i < params.length)
                  {
                     param = params[i];
                     paramToString = !!param ? param.toString() : "null";
                     if(!paramToString)
                     {
                        paramToString = "\"\"";
                     }
                     tags["param" + int(i + 1)] = paramToString.replace("\n","\\n");
                     i++;
                  }
               }
               addError(complementaryInformations,e,showPopup,tags);
            }
         }
         return result;
      }
      
      public static function addError(txt:String = "", error:Error = null, show:Boolean = true, tags:Object = null) : void
      {
         var dynamicVar:* = null;
         if(!error)
         {
            error = new Error();
         }
         eventDispatcher.dispatchEvent(new ErrorReportedEvent(error,txt,show,tags));
         var errorLog:* = "Error : \'" + txt + "\'";
         if(tags)
         {
            errorLog += " with parameters : [";
            for(dynamicVar in tags)
            {
               errorLog += tags[dynamicVar] + ",";
            }
            errorLog = errorLog.substr(0,errorLog.length - 1) + "]";
         }
         _log.warn(errorLog);
      }
      
      public static function registerLoaderInfo(loaderInfo:LoaderInfo) : void
      {
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,onUncaughtError,false,0,true);
      }
      
      public static function onUncaughtError(event:UncaughtErrorEvent) : void
      {
         var text:String = null;
         var error:Error = null;
         event.preventDefault();
         if(event.error is Error)
         {
            text = Error(event.error).message;
            error = event.error;
         }
         else if(event.error is ErrorEvent)
         {
            text = ErrorEvent(event.error).text;
            error = new Error(text);
         }
         else
         {
            text = event.error.toString();
            error = new Error(text);
         }
         addError(text,error,showPopup);
      }
   }
}
