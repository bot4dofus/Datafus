package mx.events
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public final class PropertyChangeEventKind
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const UPDATE:String = "update";
      
      public static const DELETE:String = "delete";
       
      
      public function PropertyChangeEventKind()
      {
         super();
      }
   }
}
