package mx.messaging.messages
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.getQualifiedClassName;
   import mx.core.mx_internal;
   import mx.utils.RPCObjectUtil;
   import mx.utils.RPCStringUtil;
   import mx.utils.RPCUIDUtil;
   
   use namespace mx_internal;
   
   public class AbstractMessage implements IMessage
   {
      
      public static const DESTINATION_CLIENT_ID_HEADER:String = "DSDstClientId";
      
      public static const ENDPOINT_HEADER:String = "DSEndpoint";
      
      public static const FLEX_CLIENT_ID_HEADER:String = "DSId";
      
      public static const PRIORITY_HEADER:String = "DSPriority";
      
      public static const REMOTE_CREDENTIALS_HEADER:String = "DSRemoteCredentials";
      
      public static const REMOTE_CREDENTIALS_CHARSET_HEADER:String = "DSRemoteCredentialsCharset";
      
      public static const REQUEST_TIMEOUT_HEADER:String = "DSRequestTimeout";
      
      public static const STATUS_CODE_HEADER:String = "DSStatusCode";
      
      private static const HAS_NEXT_FLAG:uint = 128;
      
      private static const BODY_FLAG:uint = 1;
      
      private static const CLIENT_ID_FLAG:uint = 2;
      
      private static const DESTINATION_FLAG:uint = 4;
      
      private static const HEADERS_FLAG:uint = 8;
      
      private static const MESSAGE_ID_FLAG:uint = 16;
      
      private static const TIMESTAMP_FLAG:uint = 32;
      
      private static const TIME_TO_LIVE_FLAG:uint = 64;
      
      private static const CLIENT_ID_BYTES_FLAG:uint = 1;
      
      private static const MESSAGE_ID_BYTES_FLAG:uint = 2;
       
      
      private var _body:Object;
      
      private var _clientId:String;
      
      private var clientIdBytes:ByteArray;
      
      private var _destination:String = "";
      
      private var _headers:Object;
      
      private var _messageId:String;
      
      private var messageIdBytes:ByteArray;
      
      private var _timestamp:Number = 0;
      
      private var _timeToLive:Number = 0;
      
      public function AbstractMessage()
      {
         this._body = {};
         super();
      }
      
      public function get body() : Object
      {
         return this._body;
      }
      
      public function set body(value:Object) : void
      {
         this._body = value;
      }
      
      public function get clientId() : String
      {
         return this._clientId;
      }
      
      public function set clientId(value:String) : void
      {
         this._clientId = value;
         this.clientIdBytes = null;
      }
      
      public function get destination() : String
      {
         return this._destination;
      }
      
      public function set destination(value:String) : void
      {
         this._destination = value;
      }
      
      public function get headers() : Object
      {
         if(this._headers == null)
         {
            this._headers = {};
         }
         return this._headers;
      }
      
      public function set headers(value:Object) : void
      {
         this._headers = value;
      }
      
      public function get messageId() : String
      {
         if(this._messageId == null)
         {
            this._messageId = RPCUIDUtil.createUID();
         }
         return this._messageId;
      }
      
      public function set messageId(value:String) : void
      {
         this._messageId = value;
         this.messageIdBytes = null;
      }
      
      public function get timestamp() : Number
      {
         return this._timestamp;
      }
      
      public function set timestamp(value:Number) : void
      {
         this._timestamp = value;
      }
      
      public function get timeToLive() : Number
      {
         return this._timeToLive;
      }
      
      public function set timeToLive(value:Number) : void
      {
         this._timeToLive = value;
      }
      
      public function readExternal(input:IDataInput) : void
      {
         var flags:uint = 0;
         var reservedPosition:uint = 0;
         var j:uint = 0;
         var flagsArray:Array = this.readFlags(input);
         for(var i:uint = 0; i < flagsArray.length; i++)
         {
            flags = flagsArray[i] as uint;
            reservedPosition = 0;
            if(i == 0)
            {
               if((flags & BODY_FLAG) != 0)
               {
                  this.readExternalBody(input);
               }
               else
               {
                  this.body = null;
               }
               if((flags & CLIENT_ID_FLAG) != 0)
               {
                  this.clientId = input.readObject();
               }
               if((flags & DESTINATION_FLAG) != 0)
               {
                  this.destination = input.readObject() as String;
               }
               if((flags & HEADERS_FLAG) != 0)
               {
                  this.headers = input.readObject();
               }
               if((flags & MESSAGE_ID_FLAG) != 0)
               {
                  this.messageId = input.readObject() as String;
               }
               if((flags & TIMESTAMP_FLAG) != 0)
               {
                  this.timestamp = input.readObject() as Number;
               }
               if((flags & TIME_TO_LIVE_FLAG) != 0)
               {
                  this.timeToLive = input.readObject() as Number;
               }
               reservedPosition = 7;
            }
            else if(i == 1)
            {
               if((flags & CLIENT_ID_BYTES_FLAG) != 0)
               {
                  this.clientIdBytes = input.readObject() as ByteArray;
                  this.clientId = RPCUIDUtil.fromByteArray(this.clientIdBytes);
               }
               if((flags & MESSAGE_ID_BYTES_FLAG) != 0)
               {
                  this.messageIdBytes = input.readObject() as ByteArray;
                  this.messageId = RPCUIDUtil.fromByteArray(this.messageIdBytes);
               }
               reservedPosition = 2;
            }
            if(flags >> reservedPosition != 0)
            {
               for(j = reservedPosition; j < 6; j++)
               {
                  if((flags >> j & 1) != 0)
                  {
                     input.readObject();
                  }
               }
            }
         }
      }
      
      public function toString() : String
      {
         return RPCObjectUtil.toString(this);
      }
      
      public function writeExternal(output:IDataOutput) : void
      {
         var flags:uint = 0;
         var checkForMessageId:String = this.messageId;
         if(this.clientIdBytes == null)
         {
            this.clientIdBytes = RPCUIDUtil.toByteArray(this._clientId);
         }
         if(this.messageIdBytes == null)
         {
            this.messageIdBytes = RPCUIDUtil.toByteArray(this._messageId);
         }
         if(this.body != null)
         {
            flags |= BODY_FLAG;
         }
         if(this.clientId != null && this.clientIdBytes == null)
         {
            flags |= CLIENT_ID_FLAG;
         }
         if(this.destination != null)
         {
            flags |= DESTINATION_FLAG;
         }
         if(this.headers != null)
         {
            flags |= HEADERS_FLAG;
         }
         if(this.messageId != null && this.messageIdBytes == null)
         {
            flags |= MESSAGE_ID_FLAG;
         }
         if(this.timestamp != 0)
         {
            flags |= TIMESTAMP_FLAG;
         }
         if(this.timeToLive != 0)
         {
            flags |= TIME_TO_LIVE_FLAG;
         }
         if(this.clientIdBytes != null || this.messageIdBytes != null)
         {
            flags |= HAS_NEXT_FLAG;
         }
         output.writeByte(flags);
         flags = 0;
         if(this.clientIdBytes != null)
         {
            flags |= CLIENT_ID_BYTES_FLAG;
         }
         if(this.messageIdBytes != null)
         {
            flags |= MESSAGE_ID_BYTES_FLAG;
         }
         if(flags != 0)
         {
            output.writeByte(flags);
         }
         if(this.body != null)
         {
            this.writeExternalBody(output);
         }
         if(this.clientId != null && this.clientIdBytes == null)
         {
            output.writeObject(this.clientId);
         }
         if(this.destination != null)
         {
            output.writeObject(this.destination);
         }
         if(this.headers != null)
         {
            output.writeObject(this.headers);
         }
         if(this.messageId != null && this.messageIdBytes == null)
         {
            output.writeObject(this.messageId);
         }
         if(this.timestamp != 0)
         {
            output.writeObject(this.timestamp);
         }
         if(this.timeToLive != 0)
         {
            output.writeObject(this.timeToLive);
         }
         if(this.clientIdBytes != null)
         {
            output.writeObject(this.clientIdBytes);
         }
         if(this.messageIdBytes != null)
         {
            output.writeObject(this.messageIdBytes);
         }
      }
      
      protected function addDebugAttributes(attributes:Object) : void
      {
         attributes["body"] = this.body;
         attributes["clientId"] = this.clientId;
         attributes["destination"] = this.destination;
         attributes["headers"] = this.headers;
         attributes["messageId"] = this.messageId;
         attributes["timestamp"] = this.timestamp;
         attributes["timeToLive"] = this.timeToLive;
      }
      
      protected final function getDebugString() : String
      {
         var propertyName:* = null;
         var length:int = 0;
         var i:uint = 0;
         var name:String = null;
         var value:String = null;
         var result:* = "(" + getQualifiedClassName(this) + ")";
         var attributes:Object = {};
         this.addDebugAttributes(attributes);
         var propertyNames:Array = [];
         for(propertyName in attributes)
         {
            propertyNames.push(propertyName);
         }
         propertyNames.sort();
         length = propertyNames.length;
         for(i = 0; i < length; i++)
         {
            name = String(propertyNames[i]);
            value = RPCObjectUtil.toString(attributes[name]);
            result += RPCStringUtil.substitute("\n  {0}={1}",name,value);
         }
         return result;
      }
      
      protected function readExternalBody(input:IDataInput) : void
      {
         this.body = input.readObject();
      }
      
      protected function readFlags(input:IDataInput) : Array
      {
         var flags:uint = 0;
         var hasNextFlag:Boolean = true;
         var flagsArray:Array = [];
         while(hasNextFlag && input.bytesAvailable > 0)
         {
            flags = input.readUnsignedByte();
            flagsArray.push(flags);
            if((flags & HAS_NEXT_FLAG) != 0)
            {
               hasNextFlag = true;
            }
            else
            {
               hasNextFlag = false;
            }
         }
         return flagsArray;
      }
      
      protected function writeExternalBody(output:IDataOutput) : void
      {
         output.writeObject(this.body);
      }
   }
}
