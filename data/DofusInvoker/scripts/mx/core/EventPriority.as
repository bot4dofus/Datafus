package mx.core
{
   use namespace mx_internal;
   
   public final class EventPriority
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const CURSOR_MANAGEMENT:int = 200;
      
      public static const BINDING:int = 100;
      
      public static const DEFAULT:int = 0;
      
      public static const DEFAULT_HANDLER:int = -50;
      
      public static const EFFECT:int = -100;
       
      
      public function EventPriority()
      {
         super();
      }
   }
}
