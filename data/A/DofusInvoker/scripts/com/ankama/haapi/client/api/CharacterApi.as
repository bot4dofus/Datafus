package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.Character;
   import com.ankama.haapi.client.model.CharacterAddScreenshotResponse;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class CharacterApi extends OpenApi
   {
      
      public static const event_add_screenshot:String = "add_screenshot";
      
      public static const event_characters:String = "characters";
      
      public static const addScreenshot_LangEnum_FR:String = "fr";
      
      public static const addScreenshot_LangEnum_EN:String = "en";
      
      public static const addScreenshot_LangEnum_DE:String = "de";
      
      public static const addScreenshot_LangEnum_ES:String = "es";
      
      public static const addScreenshot_LangEnum_PT:String = "pt";
      
      public static const addScreenshot_LangEnum_JP:String = "jp";
      
      public static const addScreenshot_LangEnum_IT:String = "it";
      
      public static const addScreenshot_LangEnum_NL:String = "nl";
      
      public static const addScreenshot_LangEnum_RU:String = "ru";
      
      public static const addScreenshot_TypeEnum_ENDFIGHT:String = "ENDFIGHT";
      
      public static const addScreenshot_TypeEnum_DEFAULT:String = "DEFAULT";
       
      
      public function CharacterApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
      {
         super(apiCredentials,eventDispatcher);
      }
      
      private static function isValidParam(param:*) : Boolean
      {
         if(param is int || param is uint)
         {
            return true;
         }
         if(param is Number)
         {
            return !isNaN(param);
         }
         return param != null;
      }
      
      public function add_screenshot(screen:String, title:String, lang:String, character:Number, server:Number, map:Number, description:String, type:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Dofus/v3/Character/AddScreenshot".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(screen))
         {
            throw new ApiError(400,"missing required params : screen");
         }
         if(!isValidParam(title))
         {
            throw new ApiError(400,"missing required params : title");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(character))
         {
            throw new ApiError(400,"missing required params : character");
         }
         if(!isValidParam(server))
         {
            throw new ApiError(400,"missing required params : server");
         }
         if(!isValidParam(map))
         {
            throw new ApiError(400,"missing required params : map");
         }
         postParams["screen"] = toPathValue(screen);
         postParams["title"] = toPathValue(title);
         postParams["description"] = toPathValue(description);
         postParams["lang"] = toPathValue(lang);
         postParams["type"] = toPathValue(type);
         postParams["character"] = toPathValue(character);
         postParams["server"] = toPathValue(server);
         postParams["map"] = toPathValue(map);
         var forceImport_CharacterAddScreenshotResponse:CharacterAddScreenshotResponse = undefined;
         var contentTypes:Array = new Array("application/x-www-form-urlencoded");
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"POST",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "add_screenshot";
            _token.returnType = "com.ankama.haapi.client.model.CharacterAddScreenshotResponse";
         });
      }
      
      public function characters(account_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Dofus/v3/Character/Characters".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(account_id))
         {
            throw new ApiError(400,"missing required params : account_id");
         }
         queryParams["account_id"] = toPathValue(account_id);
         var forceImport_Character:Character = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "characters";
            _token.returnType = "com.ankama.haapi.client.model.Character";
         });
      }
   }
}
