package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.AccessToken;
   import com.ankama.haapi.client.model.Account;
   import com.ankama.haapi.client.model.AccountOrigin;
   import com.ankama.haapi.client.model.AccountPublicStatus;
   import com.ankama.haapi.client.model.Avatar;
   import com.ankama.haapi.client.model.SessionAnonymous;
   import com.ankama.haapi.client.model.SessionLogin;
   import com.ankama.haapi.client.model.Token;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class AccountApi extends OpenApi
   {
      
      public static const event_account:String = "account";
      
      public static const event_avatar:String = "avatar";
      
      public static const event_create_guest:String = "create_guest";
      
      public static const event_create_token:String = "create_token";
      
      public static const event_create_token_with_password:String = "create_token_with_password";
      
      public static const event_delete_ghost:String = "delete_ghost";
      
      public static const event_get_access_token:String = "get_access_token";
      
      public static const event_get_access_token_from_ankama_api_key:String = "get_access_token_from_ankama_api_key";
      
      public static const event_origin_with_api_key:String = "origin_with_api_key";
      
      public static const event_send_device_infos:String = "send_device_infos";
      
      public static const event_send_mail_validation:String = "send_mail_validation";
      
      public static const event_set_birth_date:String = "set_birth_date";
      
      public static const event_set_email:String = "set_email";
      
      public static const event_set_identity_with_api_key:String = "set_identity_with_api_key";
      
      public static const event_set_nickname_with_api_key:String = "set_nickname_with_api_key";
      
      public static const event_sign_off_with_api_key:String = "sign_off_with_api_key";
      
      public static const event_sign_on_with_api_key:String = "sign_on_with_api_key";
      
      public static const event_start_anonymous_session:String = "start_anonymous_session";
      
      public static const event_status:String = "status";
      
      public static const event_validate_guest_with_api_key:String = "validate_guest_with_api_key";
      
      public static const createGuest_GameEnum_17:String = "17";
      
      public static const createGuest_LangEnum_FR:String = "fr";
      
      public static const createGuest_LangEnum_EN:String = "en";
      
      public static const createGuest_LangEnum_DE:String = "de";
      
      public static const createGuest_LangEnum_ES:String = "es";
      
      public static const createGuest_LangEnum_PT:String = "pt";
      
      public static const createGuest_LangEnum_JP:String = "jp";
      
      public static const createGuest_LangEnum_IT:String = "it";
      
      public static const createGuest_LangEnum_NL:String = "nl";
      
      public static const createGuest_LangEnum_RU:String = "ru";
      
      public static const createToken_GameEnum_1:String = "1";
      
      public static const createToken_GameEnum_3:String = "3";
      
      public static const createToken_GameEnum_10:String = "10";
      
      public static const createToken_GameEnum_11:String = "11";
      
      public static const createToken_GameEnum_12:String = "12";
      
      public static const createToken_GameEnum_13:String = "13";
      
      public static const createToken_GameEnum_17:String = "17";
      
      public static const createToken_GameEnum_18:String = "18";
      
      public static const createToken_GameEnum_21:String = "21";
      
      public static const createToken_GameEnum_22:String = "22";
      
      public static const createToken_GameEnum_99:String = "99";
      
      public static const createToken_GameEnum_101:String = "101";
      
      public static const createToken_GameEnum_106:String = "106";
      
      public static const createToken_GameEnum_108:String = "108";
      
      public static const createToken_GameEnum_1001:String = "1001";
      
      public static const createToken_GameEnum_3001:String = "3001";
      
      public static const createToken_GameEnum_13001:String = "13001";
      
      public static const createToken_GameEnum_15:String = "15";
      
      public static const createTokenWithPassword_GameEnum_22:String = "22";
      
      public static const createTokenWithPassword_GameEnum_101:String = "101";
      
      public static const deleteGhost_GameEnum_16:String = "16";
      
      public static const getAccessToken_GameEnum_107:String = "107";
      
      public static const sendDeviceInfos_ConnectionTypeEnum_ANKAMA:String = "ANKAMA";
      
      public static const sendDeviceInfos_ConnectionTypeEnum_GUEST:String = "GUEST";
      
      public static const sendDeviceInfos_ConnectionTypeEnum_GHOST:String = "GHOST";
      
      public static const sendDeviceInfos_ConnectionTypeEnum_PARTNER:String = "PARTNER";
      
      public static const sendDeviceInfos_ClientTypeEnum_WEB:String = "WEB";
      
      public static const sendDeviceInfos_ClientTypeEnum_STANDALONE:String = "STANDALONE";
      
      public static const sendDeviceInfos_OsEnum_ANDROID:String = "ANDROID";
      
      public static const sendDeviceInfos_OsEnum_WINDOWS:String = "WINDOWS";
      
      public static const sendDeviceInfos_OsEnum_MACOS:String = "MACOS";
      
      public static const sendDeviceInfos_OsEnum_IOS:String = "IOS";
      
      public static const sendDeviceInfos_OsEnum_LINUX:String = "LINUX";
      
      public static const sendDeviceInfos_OsEnum_WINDOWSPHONE:String = "WINDOWSPHONE";
      
      public static const sendDeviceInfos_DeviceEnum_MOBILE:String = "MOBILE";
      
      public static const sendDeviceInfos_DeviceEnum_TABLET:String = "TABLET";
      
      public static const sendDeviceInfos_DeviceEnum_PC:String = "PC";
      
      public static const sendDeviceInfos_PartnerEnum_BIGPOINT:String = "BIGPOINT";
      
      public static const sendDeviceInfos_PartnerEnum_LIKEVN:String = "LIKEVN";
      
      public static const sendDeviceInfos_PartnerEnum_STEAM:String = "STEAM";
      
      public static const signOffWithApiKey_ConnectionTypeEnum_ANKAMA:String = "ANKAMA";
      
      public static const signOffWithApiKey_ConnectionTypeEnum_GUEST:String = "GUEST";
      
      public static const signOffWithApiKey_ConnectionTypeEnum_GHOST:String = "GHOST";
      
      public static const signOffWithApiKey_ConnectionTypeEnum_PARTNER:String = "PARTNER";
      
      public static const signOffWithApiKey_ClientTypeEnum_WEB:String = "WEB";
      
      public static const signOffWithApiKey_ClientTypeEnum_STANDALONE:String = "STANDALONE";
      
      public static const signOffWithApiKey_OsEnum_ANDROID:String = "ANDROID";
      
      public static const signOffWithApiKey_OsEnum_WINDOWS:String = "WINDOWS";
      
      public static const signOffWithApiKey_OsEnum_MACOS:String = "MACOS";
      
      public static const signOffWithApiKey_OsEnum_IOS:String = "IOS";
      
      public static const signOffWithApiKey_OsEnum_LINUX:String = "LINUX";
      
      public static const signOffWithApiKey_OsEnum_WINDOWSPHONE:String = "WINDOWSPHONE";
      
      public static const signOffWithApiKey_DeviceEnum_MOBILE:String = "MOBILE";
      
      public static const signOffWithApiKey_DeviceEnum_TABLET:String = "TABLET";
      
      public static const signOffWithApiKey_DeviceEnum_PC:String = "PC";
      
      public static const signOffWithApiKey_PartnerEnum_BIGPOINT:String = "BIGPOINT";
      
      public static const signOffWithApiKey_PartnerEnum_LIKEVN:String = "LIKEVN";
      
      public static const signOffWithApiKey_PartnerEnum_STEAM:String = "STEAM";
      
      public static const startAnonymousSession_GameEnum_102:String = "102";
      
      public static const startAnonymousSession_GameEnum_106:String = "106";
       
      
      public function AccountApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
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
      
      public function account() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/Account".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_Account:Account = undefined;
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
            _token.completionEventType = "account";
            _token.returnType = "com.ankama.haapi.client.model.Account";
         });
      }
      
      public function avatar() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/Avatar".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_Avatar:Avatar = undefined;
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
            _token.completionEventType = "avatar";
            _token.returnType = "com.ankama.haapi.client.model.Avatar";
         });
      }
      
      public function create_guest(game:Number, lang:String, web_params:String, captcha_token:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/CreateGuest".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         queryParams["game"] = toPathValue(game);
         queryParams["lang"] = toPathValue(lang);
         queryParams["web_params"] = toPathValue(web_params);
         queryParams["captcha_token"] = toPathValue(captcha_token);
         var forceImport_Account:Account = undefined;
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
            _token.completionEventType = "create_guest";
            _token.returnType = "com.ankama.haapi.client.model.Account";
         });
      }
      
      public function create_token(game:Number, certificate_id:Number, certificate_hash:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/CreateToken".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         queryParams["game"] = toPathValue(game);
         queryParams["certificate_id"] = toPathValue(certificate_id);
         queryParams["certificate_hash"] = toPathValue(certificate_hash);
         var forceImport_Token:Token = undefined;
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
            _token.completionEventType = "create_token";
            _token.returnType = "com.ankama.haapi.client.model.Token";
         });
      }
      
      public function create_token_with_password(login:String, password:String, game:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/CreateTokenWithPassword".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(login))
         {
            throw new ApiError(400,"missing required params : login");
         }
         if(!isValidParam(password))
         {
            throw new ApiError(400,"missing required params : password");
         }
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         postParams["login"] = toPathValue(login);
         postParams["password"] = toPathValue(password);
         postParams["game"] = toPathValue(game);
         var forceImport_Token:Token = undefined;
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
            _token.completionEventType = "create_token_with_password";
            _token.returnType = "com.ankama.haapi.client.model.Token";
         });
      }
      
      public function delete_ghost(game:Number, uid:String, new_uid:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/DeleteGhost".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         if(!isValidParam(uid))
         {
            throw new ApiError(400,"missing required params : uid");
         }
         if(!isValidParam(new_uid))
         {
            throw new ApiError(400,"missing required params : new_uid");
         }
         queryParams["game"] = toPathValue(game);
         queryParams["uid"] = toPathValue(uid);
         queryParams["new_uid"] = toPathValue(new_uid);
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
            _token.completionEventType = "delete_ghost";
            _token.returnType = "null ";
         });
      }
      
      public function get_access_token(login:String, password:String, game:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/GetAccessToken".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(login))
         {
            throw new ApiError(400,"missing required params : login");
         }
         if(!isValidParam(password))
         {
            throw new ApiError(400,"missing required params : password");
         }
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         postParams["login"] = toPathValue(login);
         postParams["password"] = toPathValue(password);
         postParams["game"] = toPathValue(game);
         var forceImport_AccessToken:AccessToken = undefined;
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
            _token.completionEventType = "get_access_token";
            _token.returnType = "com.ankama.haapi.client.model.AccessToken";
         });
      }
      
      public function get_access_token_from_ankama_api_key() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/GetAccessTokenFromAnkamaApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_AccessToken:AccessToken = undefined;
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
            _token.completionEventType = "get_access_token_from_ankama_api_key";
            _token.returnType = "com.ankama.haapi.client.model.AccessToken";
         });
      }
      
      public function origin_with_api_key() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/OriginWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_AccountOrigin:AccountOrigin = undefined;
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
            _token.completionEventType = "origin_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.AccountOrigin";
         });
      }
      
      public function send_device_infos(session_id:Number, connection_type:String, client_type:String, os:String, device:String, partner:String, device_uid:String, session_id_string:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SendDeviceInfos".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         if(!isValidParam(connection_type))
         {
            throw new ApiError(400,"missing required params : connection_type");
         }
         if(!isValidParam(client_type))
         {
            throw new ApiError(400,"missing required params : client_type");
         }
         postParams["session_id"] = toPathValue(session_id);
         postParams["connection_type"] = toPathValue(connection_type);
         postParams["client_type"] = toPathValue(client_type);
         postParams["os"] = toPathValue(os);
         postParams["device"] = toPathValue(device);
         postParams["partner"] = toPathValue(partner);
         postParams["device_uid"] = toPathValue(device_uid);
         postParams["session_id_string"] = toPathValue(session_id_string);
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
            _token.completionEventType = "send_device_infos";
            _token.returnType = "null ";
         });
      }
      
      public function send_mail_validation() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SendMailValidation".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
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
            _token.completionEventType = "send_mail_validation";
            _token.returnType = "null ";
         });
      }
      
      public function set_birth_date(birth_date:String, parent_email:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SetBirthDate".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(birth_date))
         {
            throw new ApiError(400,"missing required params : birth_date");
         }
         postParams["birth_date"] = toPathValue(birth_date);
         postParams["parent_email"] = toPathValue(parent_email);
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
            _token.completionEventType = "set_birth_date";
            _token.returnType = "null ";
         });
      }
      
      public function set_email(email:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SetEmail".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(email))
         {
            throw new ApiError(400,"missing required params : email");
         }
         postParams["email"] = toPathValue(email);
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
            _token.completionEventType = "set_email";
            _token.returnType = "null ";
         });
      }
      
      public function set_identity_with_api_key(firstname:String, lastname:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SetIdentityWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(firstname))
         {
            throw new ApiError(400,"missing required params : firstname");
         }
         if(!isValidParam(lastname))
         {
            throw new ApiError(400,"missing required params : lastname");
         }
         postParams["firstname"] = toPathValue(firstname);
         postParams["lastname"] = toPathValue(lastname);
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
            _token.completionEventType = "set_identity_with_api_key";
            _token.returnType = "null ";
         });
      }
      
      public function set_nickname_with_api_key(nickname:String, lang:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SetNicknameWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(nickname))
         {
            throw new ApiError(400,"missing required params : nickname");
         }
         postParams["nickname"] = toPathValue(nickname);
         postParams["lang"] = toPathValue(lang);
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
            _token.completionEventType = "set_nickname_with_api_key";
            _token.returnType = "null ";
         });
      }
      
      public function sign_off_with_api_key(session_id:Number, connection_type:String, client_type:String, os:String, device:String, partner:String, device_uid:String, date:Date, session_id_string:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SignOffWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(session_id))
         {
            throw new ApiError(400,"missing required params : session_id");
         }
         if(!isValidParam(connection_type))
         {
            throw new ApiError(400,"missing required params : connection_type");
         }
         if(!isValidParam(client_type))
         {
            throw new ApiError(400,"missing required params : client_type");
         }
         postParams["session_id"] = toPathValue(session_id);
         postParams["connection_type"] = toPathValue(connection_type);
         postParams["client_type"] = toPathValue(client_type);
         postParams["os"] = toPathValue(os);
         postParams["device"] = toPathValue(device);
         postParams["partner"] = toPathValue(partner);
         postParams["device_uid"] = toPathValue(device_uid);
         postParams["date"] = toPathValue(date);
         postParams["session_id_string"] = toPathValue(session_id_string);
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
            _token.completionEventType = "sign_off_with_api_key";
            _token.returnType = "null ";
         });
      }
      
      public function sign_on_with_api_key(game:Number, anonymous_session_id:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/SignOnWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         postParams["game"] = toPathValue(game);
         postParams["anonymous_session_id"] = toPathValue(anonymous_session_id);
         var forceImport_SessionLogin:SessionLogin = undefined;
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
            _token.completionEventType = "sign_on_with_api_key";
            _token.returnType = "com.ankama.haapi.client.model.SessionLogin";
         });
      }
      
      public function start_anonymous_session(game:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/StartAnonymousSession".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(game))
         {
            throw new ApiError(400,"missing required params : game");
         }
         postParams["game"] = toPathValue(game);
         var forceImport_SessionAnonymous:SessionAnonymous = undefined;
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
            _token.completionEventType = "start_anonymous_session";
            _token.returnType = "com.ankama.haapi.client.model.SessionAnonymous";
         });
      }
      
      public function status() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/Status".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_AccountPublicStatus:AccountPublicStatus = undefined;
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
            _token.completionEventType = "status";
            _token.returnType = "com.ankama.haapi.client.model.AccountPublicStatus";
         });
      }
      
      public function validate_guest_with_api_key(lang:String, nickname:String, email:String, password:String, birth_date:String, firstname:String, lastname:String, parent_email:String, login:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Account/ValidateGuestWithApiKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(nickname))
         {
            throw new ApiError(400,"missing required params : nickname");
         }
         if(!isValidParam(email))
         {
            throw new ApiError(400,"missing required params : email");
         }
         if(!isValidParam(password))
         {
            throw new ApiError(400,"missing required params : password");
         }
         if(!isValidParam(birth_date))
         {
            throw new ApiError(400,"missing required params : birth_date");
         }
         if(!isValidParam(firstname))
         {
            throw new ApiError(400,"missing required params : firstname");
         }
         if(!isValidParam(lastname))
         {
            throw new ApiError(400,"missing required params : lastname");
         }
         postParams["lang"] = toPathValue(lang);
         postParams["nickname"] = toPathValue(nickname);
         postParams["email"] = toPathValue(email);
         postParams["password"] = toPathValue(password);
         postParams["birth_date"] = toPathValue(birth_date);
         postParams["parent_email"] = toPathValue(parent_email);
         postParams["firstname"] = toPathValue(firstname);
         postParams["lastname"] = toPathValue(lastname);
         postParams["login"] = toPathValue(login);
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
            _token.completionEventType = "validate_guest_with_api_key";
            _token.returnType = "null ";
         });
      }
   }
}
