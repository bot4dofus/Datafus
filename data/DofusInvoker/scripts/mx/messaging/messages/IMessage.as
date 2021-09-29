package mx.messaging.messages
{
   public interface IMessage
   {
       
      
      function get body() : Object;
      
      function set body(param1:Object) : void;
      
      function get clientId() : String;
      
      function set clientId(param1:String) : void;
      
      function get destination() : String;
      
      function set destination(param1:String) : void;
      
      function get headers() : Object;
      
      function set headers(param1:Object) : void;
      
      function get messageId() : String;
      
      function set messageId(param1:String) : void;
      
      function get timestamp() : Number;
      
      function set timestamp(param1:Number) : void;
      
      function get timeToLive() : Number;
      
      function set timeToLive(param1:Number) : void;
      
      function toString() : String;
   }
}
