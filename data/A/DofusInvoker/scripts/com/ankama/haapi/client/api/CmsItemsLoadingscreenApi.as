package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.CmsLoadingscreensList;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class CmsItemsLoadingscreenApi extends OpenApi
   {
      
      public static const event_get:String = "get";
      
      public static const event_get_default:String = "get_default";
      
      public static const get_LangEnum_FR:String = "fr";
      
      public static const get_LangEnum_EN:String = "en";
      
      public static const get_LangEnum_DE:String = "de";
      
      public static const get_LangEnum_ES:String = "es";
      
      public static const get_LangEnum_PT:String = "pt";
      
      public static const get_LangEnum_JP:String = "jp";
      
      public static const get_LangEnum_IT:String = "it";
      
      public static const get_LangEnum_NL:String = "nl";
      
      public static const get_LangEnum_RU:String = "ru";
      
      public static const getDefault_LangEnum_FR:String = "fr";
      
      public static const getDefault_LangEnum_EN:String = "en";
      
      public static const getDefault_LangEnum_DE:String = "de";
      
      public static const getDefault_LangEnum_ES:String = "es";
      
      public static const getDefault_LangEnum_PT:String = "pt";
      
      public static const getDefault_LangEnum_JP:String = "jp";
      
      public static const getDefault_LangEnum_IT:String = "it";
      
      public static const getDefault_LangEnum_NL:String = "nl";
      
      public static const getDefault_LangEnum_RU:String = "ru";
       
      
      public function CmsItemsLoadingscreenApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function get(lang:String, page:Number, count:Number, accountId:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/Loadingscreen/Get".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["lang"] = toPathValue(lang);
         queryParams["page"] = toPathValue(page);
         queryParams["count"] = toPathValue(count);
         queryParams["accountId"] = toPathValue(accountId);
         var forceImport_CmsLoadingscreensList:CmsLoadingscreensList = undefined;
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
            _token.completionEventType = "get";
            _token.returnType = "com.ankama.haapi.client.model.CmsLoadingscreensList";
         });
      }
      
      public function get_default(lang:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/Loadingscreen/GetDefault".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["lang"] = toPathValue(lang);
         var forceImport_CmsLoadingscreensList:CmsLoadingscreensList = undefined;
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
            _token.completionEventType = "get_default";
            _token.returnType = "com.ankama.haapi.client.model.CmsLoadingscreensList";
         });
      }
   }
}
