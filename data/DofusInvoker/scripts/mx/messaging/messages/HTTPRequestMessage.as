package mx.messaging.messages
{
   public class HTTPRequestMessage extends AbstractMessage
   {
      
      public static const CONTENT_TYPE_XML:String = "application/xml";
      
      public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
      
      public static const CONTENT_TYPE_SOAP_XML:String = "text/xml; charset=utf-8";
      
      public static const POST_METHOD:String = "POST";
      
      public static const GET_METHOD:String = "GET";
      
      public static const PUT_METHOD:String = "PUT";
      
      public static const HEAD_METHOD:String = "HEAD";
      
      public static const DELETE_METHOD:String = "DELETE";
      
      public static const OPTIONS_METHOD:String = "OPTIONS";
      
      public static const TRACE_METHOD:String = "TRACE";
      
      private static const VALID_METHODS:String = "POST,PUT,GET,HEAD,DELETE,OPTIONS,TRACE";
       
      
      public var contentType:String;
      
      public var httpHeaders:Object;
      
      public var recordHeaders:Boolean;
      
      [Inspectable(defaultValue="undefined",category="General")]
      public var url:String;
      
      private var _method:String;
      
      public function HTTPRequestMessage()
      {
         super();
         this._method = GET_METHOD;
      }
      
      [Inspectable(category="General")]
      public function get method() : String
      {
         return this._method;
      }
      
      public function set method(value:String) : void
      {
         this._method = value;
      }
   }
}
