package org.apache.thrift.meta_data
{
   import flash.utils.Dictionary;
   
   public class FieldMetaData
   {
      
      private static var structMap:Dictionary = new Dictionary();
       
      
      public var fieldName:String;
      
      public var requirementType:int;
      
      public var valueMetaData:FieldValueMetaData;
      
      public function FieldMetaData(param1:String, param2:int, param3:FieldValueMetaData)
      {
         super();
         this.fieldName = param1;
         this.requirementType = param2;
         this.valueMetaData = param3;
      }
      
      public static function addStructMetaDataMap(param1:Class, param2:Dictionary) : void
      {
         structMap[param1] = param2;
      }
      
      public static function getStructMetaDataMap(param1:Class) : Dictionary
      {
         return structMap[param1];
      }
   }
}
