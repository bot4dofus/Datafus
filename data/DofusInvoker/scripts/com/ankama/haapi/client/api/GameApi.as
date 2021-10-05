package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.GameAccount;
   import com.ankama.haapi.client.model.GameAdminRightWithApiKeyResponse;
   import com.ankama.haapi.client.model.GameEnemyModel;
   import com.ankama.haapi.client.model.GameFriendModel;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class GameApi extends OpenApi
   {
      
      public static const event_admin_right_with_api_key:String = "admin_right_with_api_key";
      
      public static const event_end_session_with_api_key:String = "end_session_with_api_key";
      
      public static const event_game_enemies:String = "game_enemies";
      
      public static const event_game_friends:String = "game_friends";
      
      public static const event_list_with_api_key:String = "list_with_api_key";
      
      public static const event_send_event:String = "send_event";
      
      public static const event_send_events:String = "send_events";
      
      public static const event_start_session_with_api_key:String = "start_session_with_api_key";
      
      public static const sendEvent_GameEnum_1:String = "1";
      
      public static const sendEvent_GameEnum_3:String = "3";
      
      public static const sendEvent_GameEnum_11:String = "11";
      
      public static const sendEvent_GameEnum_16:String = "16";
      
      public static const sendEvent_GameEnum_17:String = "17";
      
      public static const sendEvent_GameEnum_18:String = "18";
      
      public static const sendEvent_GameEnum_20:String = "20";
      
      public static const sendEvent_GameEnum_21:String = "21";
      
      public static const sendEvent_GameEnum_22:String = "22";
      
      public static const sendEvent_GameEnum_101:String = "101";
      
      public static const sendEvent_GameEnum_102:String = "102";
      
      public static const sendEvents_GameEnum_1:String = "1";
      
      public static const sendEvents_GameEnum_3:String = "3";
      
      public static const sendEvents_GameEnum_11:String = "11";
      
      public static const sendEvents_GameEnum_16:String = "16";
      
      public static const sendEvents_GameEnum_17:String = "17";
      
      public static const sendEvents_GameEnum_18:String = "18";
      
      public static const sendEvents_GameEnum_20:String = "20";
      
      public static const sendEvents_GameEnum_21:String = "21";
      
      public static const sendEvents_GameEnum_22:String = "22";
      
      public static const sendEvents_GameEnum_101:String = "101";
      
      public static const sendEvents_GameEnum_102:String = "102";
       
      
      public function GameApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function admin_right_with_api_key(game:Number, server:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/AdminRightWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         postParams["game"] = toPathValue(game);
         postParams["server"] = toPathValue(server);
         var forceImport_GameAdminRightWithApiKeyResponse:GameAdminRightWithApiKeyResponse = undefined;
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
            _token.completionEventType = "admin_right_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.GameAdminRightWithApiKeyResponse";
         });
      }
      
      public function end_session_with_api_key(session_id:Number, subscriber:Boolean, close_account_session:Boolean, date:Date) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/EndSessionWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         queryParams["session_id"] = toPathValue(session_id);
         queryParams["subscriber"] = toPathValue(subscriber);
         queryParams["close_account_session"] = toPathValue(close_account_session);
         queryParams["date"] = toPathValue(date);
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
            _token.completionEventType = "end_session_with_api_key";
            _token.returnType = "null ";
         });
      }
      
      public function game_enemies(game_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/GameEnemies".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         queryParams["game_id"] = toPathValue(game_id);
         var forceImport_GameEnemyModel:GameEnemyModel = undefined;
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
            _token.completionEventType = "game_enemies";
            _token.returnType = "com.ankama.haapi.client.model.GameEnemyModel";
         });
      }
      
      public function game_friends(game_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/GameFriends".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         queryParams["game_id"] = toPathValue(game_id);
         var forceImport_GameFriendModel:GameFriendModel = undefined;
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
            _token.completionEventType = "game_friends";
            _token.returnType = "com.ankama.haapi.client.model.GameFriendModel";
         });
      }
      
      public function list_with_api_key() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/ListWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_GameAccount:GameAccount = undefined;
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
            _token.completionEventType = "list_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.GameAccount";
         });
      }
      
      public function send_event(game:Number, session_id:Number, event_id:Number, data:String, date:Date) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/SendEvent".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         if(!isValidParam(event_id))
         {
            throw new ApiError(400,"missing required params : event_id");
         }
         if(!isValidParam(data))
         {
            throw new ApiError(400,"missing required params : data");
         }
         postParams["game"] = toPathValue(game);
         postParams["session_id"] = toPathValue(session_id);
         postParams["event_id"] = toPathValue(event_id);
         postParams["data"] = toPathValue(data);
         postParams["date"] = toPathValue(date);
         var forceImport_Number:Number = undefined;
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
            _token.completionEventType = "send_event";
            _token.returnType = "com.ankama.haapi.client.model.Number";
         });
      }
      
      public function send_events(game:Number, session_id:Number, events:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/SendEvents".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         if(!isValidParam(events))
         {
            throw new ApiError(400,"missing required params : events");
         }
         postParams["game"] = toPathValue(game);
         postParams["session_id"] = toPathValue(session_id);
         postParams["events"] = toPathValue(events);
         var forceImport_Number:Number = undefined;
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
            _token.completionEventType = "send_events";
            _token.returnType = "com.ankama.haapi.client.model.Number";
         });
      }
      
      public function start_session_with_api_key(session_id:Number, server_id:Number, character_id:Number, date:Date, session_id_string:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Game/StartSessionWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         queryParams["session_id"] = toPathValue(session_id);
         queryParams["server_id"] = toPathValue(server_id);
         queryParams["character_id"] = toPathValue(character_id);
         queryParams["date"] = toPathValue(date);
         queryParams["session_id_string"] = toPathValue(session_id_string);
         var forceImport_Number:Number = undefined;
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
            _token.completionEventType = "start_session_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.Number";
         });
      }
   }
}
