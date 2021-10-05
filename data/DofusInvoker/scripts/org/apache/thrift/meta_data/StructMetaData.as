package org.apache.thrift.meta_data
{
   public class StructMetaData extends FieldValueMetaData
   {
       
      
      public var structClass:Class;
      
      public function StructMetaData(param1:int, param2:Class)
      {
         super(param1);
         this.structClass = param2;
      }
   }
}
