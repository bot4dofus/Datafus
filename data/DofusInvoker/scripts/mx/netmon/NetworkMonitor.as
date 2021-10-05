package mx.netmon
{
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class NetworkMonitor
   {
      
      public static var isMonitoringImpl:Function;
      
      public static var adjustURLRequestImpl:Function;
      
      public static var adjustNetConnectionURLImpl:Function;
      
      public static var monitorEventImpl:Function;
      
      public static var monitorInvocationImpl:Function;
      
      public static var monitorResultImpl:Function;
      
      public static var monitorFaultImpl:Function;
       
      
      public function NetworkMonitor()
      {
         super();
      }
      
      public static function isMonitoring() : Boolean
      {
         return isMonitoringImpl != null ? Boolean(isMonitoringImpl()) : false;
      }
      
      public static function adjustURLRequest(urlRequest:URLRequest, rootURL:String, correlationID:String) : void
      {
         if(adjustURLRequestImpl != null)
         {
            adjustURLRequestImpl(urlRequest,rootURL,correlationID);
         }
      }
      
      public static function adjustNetConnectionURL(rootUrl:String, url:String) : String
      {
         if(adjustNetConnectionURLImpl != null)
         {
            return adjustNetConnectionURLImpl(rootUrl,url);
         }
         return null;
      }
      
      public static function monitorEvent(event:Event, correlationID:String) : void
      {
         if(monitorEventImpl != null)
         {
            monitorEventImpl(event,correlationID);
         }
      }
      
      public static function monitorInvocation(id:String, invocationMessage:Object, messageAgent:Object) : void
      {
         if(monitorInvocationImpl != null)
         {
            monitorInvocationImpl(id,invocationMessage,messageAgent);
         }
      }
      
      public static function monitorResult(resultMessage:Object, actualResult:Object) : void
      {
         if(monitorResultImpl != null)
         {
            monitorResultImpl(resultMessage,actualResult);
         }
      }
      
      public static function monitorFault(faultMessage:Object, actualFault:Object) : void
      {
         if(monitorFaultImpl != null)
         {
            monitorFaultImpl(faultMessage,actualFault);
         }
      }
   }
}
