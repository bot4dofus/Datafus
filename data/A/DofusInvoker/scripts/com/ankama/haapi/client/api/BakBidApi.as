package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.BakBid;
   import com.ankama.haapi.client.model.BakBidOffers;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class BakBidApi extends OpenApi
   {
      
      public static const event_get_account_bids:String = "get_account_bids";
      
      public static const event_get_offers_kamas:String = "get_offers_kamas";
      
      public static const event_get_offers_ogrines:String = "get_offers_ogrines";
      
      public static const getAccountBids_StatusEnum_OPEN:String = "open";
      
      public static const getAccountBids_StatusEnum_CLOSED:String = "closed";
      
      public static const getAccountBids_StatusEnum_CANCELED:String = "canceled";
      
      public static const getAccountBids_StatusEnum_FRAUD:String = "fraud";
      
      public static const getOffersKamas_OrderByEnum_GIVE:String = "give";
      
      public static const getOffersKamas_OrderByEnum_WANT:String = "want";
      
      public static const getOffersKamas_OrderByEnum_RATE:String = "rate";
      
      public static const getOffersKamas_OrderDirEnum_A:String = "A";
      
      public static const getOffersKamas_OrderDirEnum_D:String = "D";
      
      public static const getOffersOgrines_OrderByEnum_GIVE:String = "give";
      
      public static const getOffersOgrines_OrderByEnum_WANT:String = "want";
      
      public static const getOffersOgrines_OrderByEnum_RATE:String = "rate";
      
      public static const getOffersOgrines_OrderDirEnum_A:String = "A";
      
      public static const getOffersOgrines_OrderDirEnum_D:String = "D";
       
      
      public function BakBidApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function get_account_bids(status:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Dofus/v3/Bak/Bid/GetAccountBids".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         queryParams["status"] = toPathValue(status);
         var forceImport_BakBid:BakBid = undefined;
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
            _token.completionEventType = "get_account_bids";
            _token.returnType = "com.ankama.haapi.client.model.BakBid";
         });
      }
      
      public function get_offers_kamas(server_id:Number, order_by:String, order_dir:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Dofus/v3/Bak/Bid/GetOffersKamas".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(server_id))
         {
            throw new ApiError(400,"missing required params : server_id");
         }
         queryParams["server_id"] = toPathValue(server_id);
         queryParams["order_by"] = toPathValue(order_by);
         queryParams["order_dir"] = toPathValue(order_dir);
         var forceImport_BakBidOffers:BakBidOffers = undefined;
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
            _token.completionEventType = "get_offers_kamas";
            _token.returnType = "com.ankama.haapi.client.model.BakBidOffers";
         });
      }
      
      public function get_offers_ogrines(server_id:Number, order_by:String, order_dir:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Dofus/v3/Bak/Bid/GetOffersOgrines".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(server_id))
         {
            throw new ApiError(400,"missing required params : server_id");
         }
         queryParams["server_id"] = toPathValue(server_id);
         queryParams["order_by"] = toPathValue(order_by);
         queryParams["order_dir"] = toPathValue(order_dir);
         var forceImport_BakBidOffers:BakBidOffers = undefined;
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
            _token.completionEventType = "get_offers_ogrines";
            _token.returnType = "com.ankama.haapi.client.model.BakBidOffers";
         });
      }
   }
}
