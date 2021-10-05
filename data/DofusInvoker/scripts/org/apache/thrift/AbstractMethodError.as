package org.apache.thrift
{
   import flash.errors.IllegalOperationError;
   
   public class AbstractMethodError extends IllegalOperationError
   {
       
      
      public function AbstractMethodError(param1:String = "")
      {
         super("Attempt to call an abstract method");
      }
   }
}
