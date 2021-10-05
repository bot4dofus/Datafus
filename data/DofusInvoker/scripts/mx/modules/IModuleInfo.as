package mx.modules
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import flash.utils.ByteArray;
   import mx.core.IFlexModuleFactory;
   
   [Event(name="unload",type="mx.events.ModuleEvent")]
   [Event(name="setup",type="mx.events.ModuleEvent")]
   [Event(name="ready",type="mx.events.ModuleEvent")]
   [Event(name="progress",type="mx.events.ModuleEvent")]
   [Event(name="error",type="mx.events.ModuleEvent")]
   public interface IModuleInfo extends IEventDispatcher
   {
       
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get error() : Boolean;
      
      function get factory() : IFlexModuleFactory;
      
      function get loaded() : Boolean;
      
      function get ready() : Boolean;
      
      function get setup() : Boolean;
      
      function get url() : String;
      
      function load(param1:ApplicationDomain = null, param2:SecurityDomain = null, param3:ByteArray = null, param4:IFlexModuleFactory = null) : void;
      
      function release() : void;
      
      function unload() : void;
      
      function publish(param1:IFlexModuleFactory) : void;
   }
}
