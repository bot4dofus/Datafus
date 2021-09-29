package org.openapitools.common
{
   public class ApiUserCredentials
   {
       
      
      public var apiToken:String;
      
      public var authToken:String;
      
      public var userId:Number;
      
      public var hostName:String;
      
      public var apiPath:String;
      
      public var proxyPath:String;
      
      public var apiProxyServerUrl:String;
      
      public function ApiUserCredentials(hostName:String, apiPath:String, apiToken:String, authToken:String = null, userId:Number = -1, apiProxyServerUrl:String = "", proxyPath:String = null)
      {
         super();
         this.hostName = hostName;
         this.apiToken = apiToken;
         this.authToken = authToken;
         this.userId = userId;
         this.apiPath = apiPath;
         this.apiProxyServerUrl = apiProxyServerUrl;
         this.proxyPath = proxyPath;
      }
   }
}
