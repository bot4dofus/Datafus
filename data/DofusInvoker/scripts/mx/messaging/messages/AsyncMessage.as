package mx.messaging.messages
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import mx.utils.RPCUIDUtil;
   
   public class AsyncMessage extends AbstractMessage implements ISmallMessage
   {
      
      public static const SUBTOPIC_HEADER:String = "DSSubtopic";
      
      private static const CORRELATION_ID_FLAG:uint = 1;
      
      private static const CORRELATION_ID_BYTES_FLAG:uint = 2;
       
      
      private var _correlationId:String;
      
      private var correlationIdBytes:ByteArray;
      
      public function AsyncMessage(body:Object = null, headers:Object = null)
      {
         super();
         this.correlationId = "";
         if(body != null)
         {
            this.body = body;
         }
         if(headers != null)
         {
            this.headers = headers;
         }
      }
      
      public function get correlationId() : String
      {
         return this._correlationId;
      }
      
      public function set correlationId(value:String) : void
      {
         this._correlationId = value;
         this.correlationIdBytes = null;
      }
      
      public function getSmallMessage() : IMessage
      {
         var o:Object = this;
         if(o.constructor == AsyncMessage)
         {
            return new AsyncMessageExt(this);
         }
         return null;
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
               if((flags & CORRELATION_ID_FLAG) != 0)
               {
                  this.correlationId = input.readObject() as String;
               }
               if((flags & CORRELATION_ID_BYTES_FLAG) != 0)
               {
                  this.correlationIdBytes = input.readObject() as ByteArray;
                  this.correlationId = RPCUIDUtil.fromByteArray(this.correlationIdBytes);
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
      
      override public function writeExternal(output:IDataOutput) : void
      {
         super.writeExternal(output);
         if(this.correlationIdBytes == null)
         {
            this.correlationIdBytes = RPCUIDUtil.toByteArray(this._correlationId);
         }
         var flags:uint = 0;
         if(this.correlationId != null && this.correlationIdBytes == null)
         {
            flags |= CORRELATION_ID_FLAG;
         }
         if(this.correlationIdBytes != null)
         {
            flags |= CORRELATION_ID_BYTES_FLAG;
         }
         output.writeByte(flags);
         if(this.correlationId != null && this.correlationIdBytes == null)
         {
            output.writeObject(this.correlationId);
         }
         if(this.correlationIdBytes != null)
         {
            output.writeObject(this.correlationIdBytes);
         }
      }
      
      override protected function addDebugAttributes(attributes:Object) : void
      {
         super.addDebugAttributes(attributes);
         attributes["correlationId"] = this.correlationId;
      }
   }
}
