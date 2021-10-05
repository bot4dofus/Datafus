package mx.logging.errors
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class InvalidCategoryError extends Error
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function InvalidCategoryError(message:String)
      {
         super(message);
      }
      
      public function toString() : String
      {
         return String(message);
      }
   }
}
