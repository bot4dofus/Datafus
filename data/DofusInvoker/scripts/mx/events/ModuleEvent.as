package mx.events
{
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import mx.core.mx_internal;
   import mx.modules.IModuleInfo;
   
   use namespace mx_internal;
   
   public class ModuleEvent extends ProgressEvent
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const ERROR:String = "error";
      
      public static const PROGRESS:String = "progress";
      
      public static const READY:String = "ready";
      
      public static const SETUP:String = "setup";
      
      public static const UNLOAD:String = "unload";
       
      
      public var errorText:String;
      
      private var _module:IModuleInfo;
      
      public function ModuleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null, module:IModuleInfo = null)
      {
         super(type,bubbles,cancelable,bytesLoaded,bytesTotal);
         this.errorText = errorText;
         this._module = module;
      }
      
      public function get module() : IModuleInfo
      {
         if(this._module)
         {
            return this._module;
         }
         return target as IModuleInfo;
      }
      
      override public function clone() : Event
      {
         return new ModuleEvent(type,bubbles,cancelable,bytesLoaded,bytesTotal,this.errorText,this.module);
      }
   }
}
