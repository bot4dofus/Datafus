package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.GiftGift;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class GiftApi extends OpenApi
   {
      
      public static const event_get_with_api_key:String = "get_with_api_key";
      
      public static const getWithApiKey_GameIdEnum_1:String = "1";
      
      public static const getWithApiKey_GameIdEnum_18:String = "18";
       
      
      public function GiftApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function get_with_api_key(game_id:Number, lang:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Gift/GetWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game_id))
         {
            throw new ApiError(400,"missing required params : game_id");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["game_id"] = toPathValue(game_id);
         queryParams["lang"] = toPathValue(lang);
         var forceImport_GiftGift:GiftGift = undefined;
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
            _token.completionEventType = "get_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.GiftGift";
         });
      }
   }
}
