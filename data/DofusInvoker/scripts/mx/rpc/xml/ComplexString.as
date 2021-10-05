package mx.rpc.xml
{
   [ExcludeClass]
   dynamic class ComplexString
   {
       
      
      public var value:String;
      
      function ComplexString(val:String)
      {
         super();
         this.value = val;
      }
      
      public function toString() : String
      {
         return this.value;
      }
      
      public function valueOf() : Object
      {
         return SimpleXMLDecoder.simpleType(this.value);
      }
   }
}
