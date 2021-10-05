package org.apache.thrift
{
   import org.apache.thrift.protocol.TField;
   import org.apache.thrift.protocol.TProtocol;
   import org.apache.thrift.protocol.TProtocolUtil;
   import org.apache.thrift.protocol.TStruct;
   import org.apache.thrift.protocol.TType;
   
   public class TApplicationError extends TError
   {
      
      private static const TAPPLICATION_EXCEPTION_STRUCT:TStruct = new TStruct("TApplicationException");
      
      private static const MESSAGE_FIELD:TField = new TField("message",TType.STRING,1);
      
      private static const TYPE_FIELD:TField = new TField("type",TType.I32,2);
      
      public static const UNKNOWN:int = 0;
      
      public static const UNKNOWN_METHOD:int = 1;
      
      public static const INVALID_MESSAGE_TYPE:int = 2;
      
      public static const WRONG_METHOD_NAME:int = 3;
      
      public static const BAD_SEQUENCE_ID:int = 4;
      
      public static const MISSING_RESULT:int = 5;
      
      public static const INTERNAL_ERROR:int = 6;
      
      public static const PROTOCOL_ERROR:int = 7;
      
      public static const INVALID_TRANSFORM:int = 8;
      
      public static const INVALID_PROTOCOL:int = 9;
      
      public static const UNSUPPORTED_CLIENT_TYPE:int = 10;
       
      
      public function TApplicationError(param1:int = 0, param2:String = "")
      {
         super(param2,param1);
      }
      
      public static function read(param1:TProtocol) : TApplicationError
      {
         var _loc2_:TField = null;
         param1.readStructBegin();
         var _loc3_:String = null;
         var _loc4_:int = UNKNOWN;
         while(true)
         {
            _loc2_ = param1.readFieldBegin();
            if(_loc2_.type == TType.STOP)
            {
               break;
            }
            switch(_loc2_.id)
            {
               case 1:
                  if(_loc2_.type == TType.STRING)
                  {
                     _loc3_ = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case 2:
                  if(_loc2_.type == TType.I32)
                  {
                     _loc4_ = param1.readI32();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               default:
                  TProtocolUtil.skip(param1,_loc2_.type);
                  break;
            }
            param1.readFieldEnd();
         }
         param1.readStructEnd();
         return new TApplicationError(_loc4_,_loc3_);
      }
      
      public function write(param1:TProtocol) : void
      {
         param1.writeStructBegin(TAPPLICATION_EXCEPTION_STRUCT);
         if(message != null)
         {
            param1.writeFieldBegin(MESSAGE_FIELD);
            param1.writeString(message);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(TYPE_FIELD);
         param1.writeI32(errorID);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
   }
}
