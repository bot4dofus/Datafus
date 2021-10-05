package org.apache.thrift.meta_data
{
   import org.apache.thrift.protocol.TType;
   
   public class FieldValueMetaData
   {
       
      
      public var type:int;
      
      public function FieldValueMetaData(param1:int)
      {
         super();
         this.type = param1;
      }
      
      public function isStruct() : Boolean
      {
         return this.type == TType.STRUCT;
      }
      
      public function isContainer() : Boolean
      {
         return this.type == TType.LIST || this.type == TType.MAP || this.type == TType.SET;
      }
   }
}
