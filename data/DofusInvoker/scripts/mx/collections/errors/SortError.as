package mx.collections.errors
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class SortError extends Error
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function SortError(message:String)
      {
         super(message);
      }
   }
}
