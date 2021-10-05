package org.apache.thrift.protocol
{
   import org.apache.thrift.TError;
   
   public class TProtocolUtil
   {
      
      private static var maxSkipDepth:int = int.MAX_VALUE;
       
      
      public function TProtocolUtil()
      {
         super();
      }
      
      public static function skip(param1:TProtocol, param2:int) : void
      {
         skipMaxDepth(param1,param2,maxSkipDepth);
      }
      
      public static function skipMaxDepth(param1:TProtocol, param2:int, param3:int) : void
      {
         var _loc4_:TField = null;
         var _loc5_:TMap = null;
         var _loc6_:int = 0;
         var _loc7_:TSet = null;
         var _loc8_:int = 0;
         var _loc9_:TList = null;
         var _loc10_:int = 0;
         if(param3 <= 0)
         {
            throw new TError("Maximum skip depth exceeded");
         }
         switch(param2)
         {
            case TType.BOOL:
               param1.readBool();
               break;
            case TType.BYTE:
               param1.readByte();
               break;
            case TType.I16:
               param1.readI16();
               break;
            case TType.I32:
               param1.readI32();
               break;
            case TType.DOUBLE:
               param1.readDouble();
               break;
            case TType.STRING:
               param1.readBinary();
               break;
            case TType.STRUCT:
               param1.readStructBegin();
               while(true)
               {
                  _loc4_ = param1.readFieldBegin();
                  if(_loc4_.type == TType.STOP)
                  {
                     break;
                  }
                  skipMaxDepth(param1,_loc4_.type,param3 - 1);
                  param1.readFieldEnd();
               }
               param1.readStructEnd();
               break;
            case TType.MAP:
               _loc5_ = param1.readMapBegin();
               _loc6_ = 0;
               while(_loc6_ < _loc5_.size)
               {
                  skipMaxDepth(param1,_loc5_.keyType,param3 - 1);
                  skipMaxDepth(param1,_loc5_.valueType,param3 - 1);
                  _loc6_++;
               }
               param1.readMapEnd();
               break;
            case TType.SET:
               _loc7_ = param1.readSetBegin();
               _loc8_ = 0;
               while(_loc8_ < _loc7_.size)
               {
                  skipMaxDepth(param1,_loc7_.elemType,param3 - 1);
                  _loc8_++;
               }
               param1.readSetEnd();
               break;
            case TType.LIST:
               _loc9_ = param1.readListBegin();
               _loc10_ = 0;
               while(_loc10_ < _loc9_.size)
               {
                  skipMaxDepth(param1,_loc9_.elemType,param3 - 1);
                  _loc10_++;
               }
               param1.readListEnd();
         }
      }
      
      public function setMaxSkipDepth(param1:int) : void
      {
         maxSkipDepth = param1;
      }
   }
}
