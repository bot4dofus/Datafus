package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.KardKard;
   import com.ankama.haapi.client.model.KardKardStock;
   import com.ankama.haapi.client.model.KardTicket;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class KardApi extends OpenApi
   {
      
      public static const event_consume_by_code:String = "consume_by_code";
      
      public static const event_consume_by_id:String = "consume_by_id";
      
      public static const event_consume_by_order_id:String = "consume_by_order_id";
      
      public static const event_get_by_account_id_with_api_key:String = "get_by_account_id_with_api_key";
      
      public static const consumeById_GameIdEnum_1:String = "1";
      
      public static const consumeById_GameIdEnum_18:String = "18";
      
      public static const consumeById_GameIdEnum_13:String = "13";
      
      public static const consumeById_GameIdEnum_101:String = "101";
       
      
      public function KardApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function consume_by_code(code:String, lang:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Kard/ConsumeByCode".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(code))
         {
            throw new ApiError(400,"missing required params : code");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["code"] = toPathValue(code);
         queryParams["lang"] = toPathValue(lang);
         var forceImport_KardTicket:KardTicket = undefined;
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
            _token.completionEventType = "consume_by_code";
            _token.returnType = "com.ankama.haapi.client.model.KardTicket";
         });
      }
      
      public function consume_by_id(lang:String, id:Number, game_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Kard/ConsumeById".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(id))
         {
            throw new ApiError(400,"missing required params : id");
         }
         if(!isValidParam(game_id))
         {
            throw new ApiError(400,"missing required params : game_id");
         }
         queryParams["lang"] = toPathValue(lang);
         queryParams["id"] = toPathValue(id);
         queryParams["game_id"] = toPathValue(game_id);
         var forceImport_KardKard:KardKard = undefined;
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
            _token.completionEventType = "consume_by_id";
            _token.returnType = "com.ankama.haapi.client.model.KardKard";
         });
      }
      
      public function consume_by_order_id(lang:String, order_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Kard/ConsumeByOrderId".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(order_id))
         {
            throw new ApiError(400,"missing required params : order_id");
         }
         queryParams["lang"] = toPathValue(lang);
         queryParams["order_id"] = toPathValue(order_id);
         var forceImport_KardKard:KardKard = undefined;
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
            _token.completionEventType = "consume_by_order_id";
            _token.returnType = "com.ankama.haapi.client.model.KardKard";
         });
      }
      
      public function get_by_account_id_with_api_key(lang:String, collection_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Kard/GetByAccountIdWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["lang"] = toPathValue(lang);
         queryParams["collection_id"] = toPathValue(collection_id);
         var forceImport_KardKardStock:KardKardStock = undefined;
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
            _token.completionEventType = "get_by_account_id_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.KardKardStock";
         });
      }
   }
}
