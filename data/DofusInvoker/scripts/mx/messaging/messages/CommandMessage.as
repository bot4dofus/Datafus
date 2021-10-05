package mx.messaging.messages
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class CommandMessage extends AsyncMessage
   {
      
      public static const SUBSCRIBE_OPERATION:uint = 0;
      
      public static const UNSUBSCRIBE_OPERATION:uint = 1;
      
      public static const POLL_OPERATION:uint = 2;
      
      public static const CLIENT_SYNC_OPERATION:uint = 4;
      
      public static const CLIENT_PING_OPERATION:uint = 5;
      
      public static const CLUSTER_REQUEST_OPERATION:uint = 7;
      
      public static const LOGIN_OPERATION:uint = 8;
      
      public static const LOGOUT_OPERATION:uint = 9;
      
      public static const MESSAGING_VERSION:String = "DSMessagingVersion";
      
      public static const SUBSCRIPTION_INVALIDATE_OPERATION:uint = 10;
      
      public static const MULTI_SUBSCRIBE_OPERATION:uint = 11;
      
      public static const DISCONNECT_OPERATION:uint = 12;
      
      public static const TRIGGER_CONNECT_OPERATION:uint = 13;
      
      public static const UNKNOWN_OPERATION:uint = 10000;
      
      public static const AUTHENTICATION_MESSAGE_REF_TYPE:String = "flex.messaging.messages.AuthenticationMessage";
      
      public static const SELECTOR_HEADER:String = "DSSelector";
      
      public static const PRESERVE_DURABLE_HEADER:String = "DSPreserveDurable";
      
      public static const NEEDS_CONFIG_HEADER:String = "DSNeedsConfig";
      
      public static const ADD_SUBSCRIPTIONS:String = "DSAddSub";
      
      public static const REMOVE_SUBSCRIPTIONS:String = "DSRemSub";
      
      public static const SUBTOPIC_SEPARATOR:String = "_;_";
      
      public static const POLL_WAIT_HEADER:String = "DSPollWait";
      
      public static const NO_OP_POLL_HEADER:String = "DSNoOpPoll";
      
      public static const CREDENTIALS_CHARSET_HEADER:String = "DSCredentialsCharset";
      
      public static const MAX_FREQUENCY_HEADER:String = "DSMaxFrequency";
      
      public static const HEARTBEAT_HEADER:String = "DS<3";
      
      private static const OPERATION_FLAG:uint = 1;
      
      private static var operationTexts:Object = null;
       
      
      public var operation:uint;
      
      public function CommandMessage()
      {
         super();
         this.operation = UNKNOWN_OPERATION;
      }
      
      public static function getOperationAsString(op:uint) : String
      {
         if(operationTexts == null)
         {
            operationTexts = {};
            operationTexts[SUBSCRIBE_OPERATION] = "subscribe";
            operationTexts[UNSUBSCRIBE_OPERATION] = "unsubscribe";
            operationTexts[POLL_OPERATION] = "poll";
            operationTexts[CLIENT_SYNC_OPERATION] = "client sync";
            operationTexts[CLIENT_PING_OPERATION] = "client ping";
            operationTexts[CLUSTER_REQUEST_OPERATION] = "cluster request";
            operationTexts[LOGIN_OPERATION] = "login";
            operationTexts[LOGOUT_OPERATION] = "logout";
            operationTexts[SUBSCRIPTION_INVALIDATE_OPERATION] = "subscription invalidate";
            operationTexts[MULTI_SUBSCRIBE_OPERATION] = "multi-subscribe";
            operationTexts[DISCONNECT_OPERATION] = "disconnect";
            operationTexts[TRIGGER_CONNECT_OPERATION] = "trigger connect";
            operationTexts[UNKNOWN_OPERATION] = "unknown";
         }
         var result:* = operationTexts[op];
         return result == undefined ? op.toString() : String(result);
      }
      
      override public function getSmallMessage() : IMessage
      {
         if(this.operation == POLL_OPERATION)
         {
            return new CommandMessageExt(this);
         }
         return null;
      }
      
      override protected function addDebugAttributes(attributes:Object) : void
      {
         super.addDebugAttributes(attributes);
         attributes["operation"] = getOperationAsString(this.operation);
      }
      
      override public function toString() : String
      {
         return getDebugString();
      }
      
      override public function readExternal(input:IDataInput) : void
      {
         var flags:uint = 0;
         var reservedPosition:uint = 0;
         var j:uint = 0;
         super.readExternal(input);
         var flagsArray:Array = readFlags(input);
         for(var i:uint = 0; i < flagsArray.length; i++)
         {
            flags = flagsArray[i] as uint;
            reservedPosition = 0;
            if(i == 0)
            {
               if((flags & OPERATION_FLAG) != 0)
               {
                  this.operation = input.readObject() as uint;
               }
               reservedPosition = 1;
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
      
      override public function writeExternal(output:IDataOutput) : void
      {
         super.writeExternal(output);
         var flags:uint = 0;
         if(this.operation != 0)
         {
            flags |= OPERATION_FLAG;
         }
         output.writeByte(flags);
         if(this.operation != 0)
         {
            output.writeObject(this.operation);
         }
      }
   }
}
