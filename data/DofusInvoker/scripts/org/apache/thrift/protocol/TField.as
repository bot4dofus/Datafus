package org.apache.thrift.protocol
{
   public class TField
   {
       
      
      public var name:String;
      
      public var type:int;
      
      public var id:int;
      
      public function TField(param1:String = "", param2:int = 0, param3:int = 0)
      {
         super();
         this.name = param1;
         this.type = param2;
         this.id = param3;
      }
      
      public function toString() : String
      {
         return "<TField name:\'" + this.name + "\' type:" + this.type + " field-id:" + this.id + ">";
      }
      
      public function equals(param1:TField) : Boolean
      {
         return this.type == param1.type && this.id == param1.id;
      }
   }
}
