package org.openapitools.common
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.messaging.ChannelSet;
   import mx.messaging.channels.DirectHTTPChannel;
   import mx.messaging.messages.HTTPRequestMessage;
   import mx.rpc.AsyncToken;
   import mx.rpc.Fault;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   import org.openapitools.event.ApiClientEvent;
   import org.openapitools.event.Response;
   
   public class ApiInvoker extends EventDispatcher
   {
      
      private static const DELETE_DATA_DUMMY:String = "dummyDataRequiredForDeleteOverride";
      
      private static const X_HTTP_OVERRIDE_KEY:String = "X-HTTP-Method-Override";
      
      private static const CONTENT_TYPE_HEADER_KEY:String = "Content-Type";
      
      private static const SYNTAX_ERROR_STATUS_CODE:int = 422;
       
      
      public var _apiEventNotifier:EventDispatcher;
      
      var _apiProxyServerUrl:String = "";
      
      var _useProxyServer:Boolean = true;
      
      private var _apiUsageCredentials:ApiUserCredentials;
      
      private var _baseUrl:String = "";
      
      private var _proxyHostName:String = "";
      
      private var _apiPath:String = "";
      
      private var _proxyPath:String = "";
      
      public function ApiInvoker(apiUsageCredentials:ApiUserCredentials, eventNotifier:EventDispatcher, useProxy:Boolean = true)
      {
         super();
         this._apiUsageCredentials = apiUsageCredentials;
         this._useProxyServer = useProxy;
         if(this._apiUsageCredentials.hostName != null)
         {
            this._proxyHostName = this._apiUsageCredentials.hostName;
         }
         this._apiPath = this._apiUsageCredentials.apiPath;
         this._proxyPath = this._apiUsageCredentials.proxyPath;
         this._apiProxyServerUrl = this._apiUsageCredentials.apiProxyServerUrl;
         this._apiEventNotifier = eventNotifier;
      }
      
      public function invokeAPI(resourceURL:String, method:String, queryParams:Dictionary, postObject:Object, headerParams:Dictionary, contentType:String = "application/json") : AsyncToken
      {
         var paramValue:Object = null;
         var paramName:* = null;
         var requestHeader:Object = null;
         var key:* = null;
         if(this._useProxyServer)
         {
            resourceURL = this._apiProxyServerUrl + resourceURL;
         }
         else
         {
            resourceURL = "https://" + this._proxyHostName + this._apiPath + resourceURL;
         }
         var counter:int = 0;
         var symbol:String = "&";
         for(paramName in queryParams)
         {
            paramValue = queryParams[paramName];
            symbol = "&";
            if(counter == 0)
            {
               symbol = "?";
            }
            resourceURL = resourceURL + symbol + paramName + "=" + paramValue.toString();
            counter++;
         }
         requestHeader = new Object();
         if(headerParams != null)
         {
            for(key in headerParams)
            {
               requestHeader[key] = headerParams[key];
            }
         }
         resourceURL = ApiUrlHelper.appendTokenInfo(resourceURL,requestHeader,this._apiUsageCredentials);
         return this.doRestCall(resourceURL,this.onApiRequestResult,this.onApiRequestFault,method,postObject,requestHeader,contentType);
      }
      
      public function escapeString(str:String) : String
      {
         return str;
      }
      
      private function doRestCall(url:String, resultFunction:Function, faultFunction:Function = null, restMethod:String = "GET", bodyData:Object = null, headers:Object = null, contentType:String = "application/xml") : AsyncToken
      {
         var channelSet:ChannelSet = null;
         var httpChannel:DirectHTTPChannel = null;
         var httpService:HTTPService = new HTTPService();
         if(headers == null)
         {
            headers = new Object();
         }
         httpService.method = restMethod;
         if(restMethod.toUpperCase() != HTTPRequestMessage.GET_METHOD)
         {
            if(bodyData == null)
            {
               bodyData = new Object();
            }
            if(restMethod == HTTPRequestMessage.DELETE_METHOD)
            {
               headers[X_HTTP_OVERRIDE_KEY] = HTTPRequestMessage.DELETE_METHOD;
               bodyData = DELETE_DATA_DUMMY;
            }
            else if(restMethod == HTTPRequestMessage.PUT_METHOD)
            {
               headers[X_HTTP_OVERRIDE_KEY] = HTTPRequestMessage.PUT_METHOD;
            }
            else
            {
               headers[CONTENT_TYPE_HEADER_KEY] = contentType;
            }
         }
         else
         {
            contentType = null;
         }
         httpService.url = url;
         httpService.contentType = contentType;
         httpService.resultFormat = "text";
         httpService.headers = headers;
         httpService.addEventListener(ResultEvent.RESULT,resultFunction);
         if(faultFunction != null)
         {
            httpService.addEventListener(FaultEvent.FAULT,faultFunction);
         }
         if(this._useProxyServer)
         {
            httpService.useProxy = true;
            channelSet = new ChannelSet();
            httpChannel = new DirectHTTPChannel("");
            httpChannel.uri = ApiUrlHelper.getProxyUrl(this._proxyHostName,this._proxyPath);
            channelSet.addChannel(httpChannel);
            httpService.channelSet = channelSet;
         }
         return httpService.send(bodyData);
      }
      
      private function onApiRequestResult(event:ResultEvent) : void
      {
         var response:Response = null;
         var successEvent:ApiClientEvent = null;
         try
         {
            response = new Response(true,event.statusCode,DeserializeUtil.deserialize(event.result,event.token.returnType));
         }
         catch(e:SyntaxError)
         {
            onApiRequestFault(new FaultEvent("SyntaxError",false,true,new Fault(String(SYNTAX_ERROR_STATUS_CODE),e.message),event.token));
            return;
         }
         response.requestId = event.token.requestId;
         response.headers = event.headers;
         var successEventType:String = event.token.completionEventType != null ? event.token.completionEventType : ApiClientEvent.SUCCESS_EVENT;
         if(this._apiEventNotifier != null)
         {
            successEvent = new ApiClientEvent(ApiClientEvent.SUCCESS_EVENT);
            successEvent.response = response;
            this._apiEventNotifier.dispatchEvent(successEvent);
         }
      }
      
      private function onApiRequestFault(event:FaultEvent) : void
      {
         var failureEvent:ApiClientEvent = null;
         var completionListener:Function = event.token.completionListener;
         var errorObject:Object = null;
         var errorMessage:String = "";
         var statusCode:int = event.statusCode;
         if(event.fault.content)
         {
            try
            {
               errorObject = DeserializeUtil.fromJson(event.fault.content as String);
            }
            catch(e:SyntaxError)
            {
               statusCode = SYNTAX_ERROR_STATUS_CODE;
               errorMessage = e.message;
            }
         }
         var response:Response = new Response(false,statusCode,errorObject,errorObject && errorObject.message ? errorObject.message : event.fault.faultString + " : " + errorMessage);
         if(completionListener != null)
         {
            completionListener.call(null,response);
         }
         var failureEventType:String = event.token.completionEventType != null ? event.token.completionEventType : ApiClientEvent.FAILURE_EVENT;
         if(this._apiEventNotifier != null)
         {
            failureEvent = new ApiClientEvent(ApiClientEvent.FAILURE_EVENT);
            failureEvent.response = response;
            this._apiEventNotifier.dispatchEvent(failureEvent);
         }
      }
      
      private function getArrayEnclosure(arr:Array) : String
      {
         var className:String = null;
         if(arr != null && arr.length > 0)
         {
            className = getQualifiedClassName(arr[0]);
            if(className.indexOf("::") > 0)
            {
               className = className.substr(className.indexOf("::") + 2,className.length);
            }
            return className.substring(0,1).toLowerCase() + className.substring(1,className.length) + "s";
         }
         return "";
      }
   }
}

import by.blooddy.crypto.serialization.JSON;
import flash.system.ApplicationDomain;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import mx.formatters.DateFormatter;
import mx.utils.DescribeTypeCache;
import mx.utils.DescribeTypeCacheRecord;

class DeserializeUtil
{
    
   
   function DeserializeUtil()
   {
      super();
   }
   
   public static function deserialize(data:*, returnObjectType:String) : *
   {
      var returnObject:* = undefined;
      data = fromJson(data as String);
      if(returnObjectType != "null" && returnObjectType != "" && ApplicationDomain.currentDomain.hasDefinition(returnObjectType))
      {
         returnObject = getTypedObject(data,returnObjectType);
      }
      else
      {
         returnObject = data;
      }
      return returnObject;
   }
   
   private static function getTypedObject(data:*, returnObjectType:String) : *
   {
      var variable:XML = null;
      var dateVar:Date = null;
      var resultArray:Array = null;
      var resultObject:* = undefined;
      var object:* = undefined;
      var itemType:String = null;
      if(!data)
      {
         return;
      }
      if(data.hasOwnProperty("length"))
      {
         if(data is String)
         {
            return data;
         }
         resultArray = new Array();
         for each(resultObject in data)
         {
            resultArray.push(getTypedObject(resultObject,returnObjectType));
         }
         return resultArray;
      }
      var objectType:Class = getDefinitionByName(returnObjectType) as Class;
      var returnObject:* = new objectType();
      var description:DescribeTypeCacheRecord = DescribeTypeCache.describeType(returnObject);
      var variables:XMLList = description.typeDescription.variable;
      for each(variable in variables)
      {
         if(variable.@type == "Date")
         {
            dateVar = DateFormatter.parseDateString(data[variable.@name]);
            returnObject[variable.@name] = dateVar;
         }
         else if(variable.@type == "flash.utils::Dictionary")
         {
            for(object in data[variable.@name])
            {
               returnObject[variable.@name] = new Dictionary();
               returnObject[variable.@name][object] = data[variable.@name][object];
            }
         }
         else if(variable.@type.indexOf("Vector") != -1)
         {
            for(object in data[variable.@name])
            {
               itemType = variable.@type.split("<")[1].split(">")[0];
               returnObject[variable.@name].push(getTypedObject(data[variable.@name][object],itemType));
            }
         }
         else if(variable.@type.indexOf("com.ankama.haapi.client.model") != -1 && (ApplicationDomain.currentDomain.hasDefinition(returnObjectType) && data[variable.@name] != null))
         {
            returnObject[variable.@name] = getTypedObject(data[variable.@name],variable.@type);
         }
         else if(data)
         {
            returnObject[variable.@name] = data[variable.@name];
         }
      }
      return returnObject;
   }
   
   public static function fromJson(json:String) : Object
   {
      return by.blooddy.crypto.serialization.JSON.decode(json);
   }
}
