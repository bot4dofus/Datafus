package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class Request extends Event
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const GET_PARENT_FLEX_MODULE_FACTORY_REQUEST:String = "getParentFlexModuleFactoryRequest";
       
      
      public var value:Object;
      
      public function Request(type:String, bubbles:Boolean = false, cancelable:Boolean = false, value:Object = null)
      {
         super(type,bubbles,cancelable);
         this.value = value;
      }
      
      override public function clone() : Event
      {
         return new Request(type,bubbles,cancelable,this.value);
      }
   }
}
