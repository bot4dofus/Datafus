package mx.core
{
   public interface IInvalidating
   {
       
      
      function invalidateProperties() : void;
      
      function invalidateSize() : void;
      
      function invalidateDisplayList() : void;
      
      function validateNow() : void;
   }
}
