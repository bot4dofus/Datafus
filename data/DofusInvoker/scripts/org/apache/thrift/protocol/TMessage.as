package org.apache.thrift.protocol
{
   public class TMessage
   {
       
      
      public var name:String;
      
      public var type:int;
      
      public var seqid:int;
      
      public function TMessage(param1:String = "", param2:int = 0, param3:int = 0)
      {
         super();
         this.name = param1;
         this.type = param2;
         this.seqid = param3;
      }
      
      public function toString() : String
      {
         return "<TMessage name:\'" + this.name + "\' type: " + this.type + " seqid:" + this.seqid + ">";
      }
      
      public function equals(param1:TMessage) : Boolean
      {
         return this.name == param1.name && this.type == param1.type && this.seqid == param1.seqid;
      }
   }
}
