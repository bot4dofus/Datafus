package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.Shielddomain;
   import com.ankama.haapi.client.model.ShieldencodedCertificate;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class ShieldApi extends OpenApi
   {
      
      public static const event_migrate:String = "migrate";
      
      public static const event_security_code:String = "security_code";
      
      public static const event_validate_code:String = "validate_code";
       
      
      public function ShieldApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function migrate(key:String, game:Number, version:Number, certificateId:Number, certificate:String, hm1:String, hm2:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shield/Migrate".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(key))
         {
            throw new ApiError(400,"missing required params : key");
         }
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         if(!isValidParam(version))
         {
            throw new ApiError(400,"missing required params : version");
         }
         if(!isValidParam(certificateId))
         {
            throw new ApiError(400,"missing required params : certificateId");
         }
         if(!isValidParam(certificate))
         {
            throw new ApiError(400,"missing required params : certificate");
         }
         if(!isValidParam(hm1))
         {
            throw new ApiError(400,"missing required params : hm1");
         }
         if(!isValidParam(hm2))
         {
            throw new ApiError(400,"missing required params : hm2");
         }
         queryParams["key"] = toPathValue(key);
         queryParams["game"] = toPathValue(game);
         queryParams["version"] = toPathValue(version);
         queryParams["certificateId"] = toPathValue(certificateId);
         queryParams["certificate"] = toPathValue(certificate);
         queryParams["hm1"] = toPathValue(hm1);
         queryParams["hm2"] = toPathValue(hm2);
         var forceImport_ShieldencodedCertificate:ShieldencodedCertificate = undefined;
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
            _token.completionEventType = "migrate";
            _token.returnType = "com.ankama.haapi.client.model.ShieldencodedCertificate";
         });
      }
      
      public function security_code() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shield/SecurityCode".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_Shielddomain:Shielddomain = undefined;
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
            _token.completionEventType = "security_code";
            _token.returnType = "com.ankama.haapi.client.model.Shielddomain";
         });
      }
      
      public function validate_code(game_id:Number, code:String, hm1:String, hm2:String, name:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shield/ValidateCode".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game_id))
         {
            throw new ApiError(400,"missing required params : game_id");
         }
         if(!isValidParam(code))
         {
            throw new ApiError(400,"missing required params : code");
         }
         if(!isValidParam(hm1))
         {
            throw new ApiError(400,"missing required params : hm1");
         }
         if(!isValidParam(hm2))
         {
            throw new ApiError(400,"missing required params : hm2");
         }
         queryParams["game_id"] = toPathValue(game_id);
         queryParams["code"] = toPathValue(code);
         queryParams["hm1"] = toPathValue(hm1);
         queryParams["hm2"] = toPathValue(hm2);
         queryParams["name"] = toPathValue(name);
         var forceImport_ShieldencodedCertificate:ShieldencodedCertificate = undefined;
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
            _token.completionEventType = "validate_code";
            _token.returnType = "com.ankama.haapi.client.model.ShieldencodedCertificate";
         });
      }
   }
}
