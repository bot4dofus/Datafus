package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.CmsArticle;
   import com.ankama.haapi.client.model.CmsArticleMeta;
   import com.ankama.haapi.client.model.CmsFeed;
   import com.ankama.haapi.client.model.CmsFlashInfo;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class CmsItemsApi extends OpenApi
   {
      
      public static const event_get:String = "get";
      
      public static const event_get_by_id:String = "get_by_id";
      
      public static const event_get_feeds:String = "get_feeds";
      
      public static const event_get_flash_info:String = "get_flash_info";
      
      public static const get_TemplateKeyEnum_NEWSZAAP:String = "NEWS_ZAAP";
      
      public static const get_TemplateKeyEnum_NEWSHOMEPAGE:String = "NEWS_HOMEPAGE";
      
      public static const get_TemplateKeyEnum_NEWS:String = "NEWS";
      
      public static const get_TemplateKeyEnum_BLOG:String = "BLOG";
      
      public static const get_TemplateKeyEnum_CHANGELOG:String = "CHANGELOG";
       
      
      public function CmsItemsApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function get(template_key:String, site:String, lang:String, page:Number, count:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/Get".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(template_key))
         {
            throw new ApiError(400,"missing required params : template_key");
         }
         if(!isValidParam(site))
         {
            throw new ApiError(400,"missing required params : site");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["template_key"] = toPathValue(template_key);
         queryParams["site"] = toPathValue(site);
         queryParams["lang"] = toPathValue(lang);
         queryParams["page"] = toPathValue(page);
         queryParams["count"] = toPathValue(count);
         var forceImport_CmsArticle:CmsArticle = undefined;
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
            _token.returnType = "com.ankama.haapi.client.model.CmsArticle";
         });
      }
      
      public function get_by_id(site:String, lang:String, id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/GetById".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(site))
         {
            throw new ApiError(400,"missing required params : site");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(id))
         {
            throw new ApiError(400,"missing required params : id");
         }
         queryParams["site"] = toPathValue(site);
         queryParams["lang"] = toPathValue(lang);
         queryParams["id"] = toPathValue(id);
         var forceImport_CmsArticleMeta:CmsArticleMeta = undefined;
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
            _token.completionEventType = "get_by_id";
            _token.returnType = "com.ankama.haapi.client.model.CmsArticleMeta";
         });
      }
      
      public function get_feeds(site:String, lang:String, page:Number, count:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/GetFeeds".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(site))
         {
            throw new ApiError(400,"missing required params : site");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["site"] = toPathValue(site);
         queryParams["lang"] = toPathValue(lang);
         queryParams["page"] = toPathValue(page);
         queryParams["count"] = toPathValue(count);
         var forceImport_CmsFeed:CmsFeed = undefined;
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
            _token.completionEventType = "get_feeds";
            _token.returnType = "com.ankama.haapi.client.model.CmsFeed";
         });
      }
      
      public function get_flash_info(site:String, lang:String, page:Number, count:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/Items/GetFlashInfo".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(site))
         {
            throw new ApiError(400,"missing required params : site");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["site"] = toPathValue(site);
         queryParams["lang"] = toPathValue(lang);
         queryParams["page"] = toPathValue(page);
         queryParams["count"] = toPathValue(count);
         var forceImport_CmsFlashInfo:CmsFlashInfo = undefined;
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
            _token.completionEventType = "get_flash_info";
            _token.returnType = "com.ankama.haapi.client.model.CmsFlashInfo";
         });
      }
   }
}
