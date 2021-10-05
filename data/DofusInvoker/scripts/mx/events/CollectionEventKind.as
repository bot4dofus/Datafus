package mx.events
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public final class CollectionEventKind
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const ADD:String = "add";
      
      public static const MOVE:String = "move";
      
      public static const REFRESH:String = "refresh";
      
      public static const REMOVE:String = "remove";
      
      public static const REPLACE:String = "replace";
      
      mx_internal static const EXPAND:String = "expand";
      
      public static const RESET:String = "reset";
      
      public static const UPDATE:String = "update";
       
      
      public function CollectionEventKind()
      {
         super();
      }
   }
}
