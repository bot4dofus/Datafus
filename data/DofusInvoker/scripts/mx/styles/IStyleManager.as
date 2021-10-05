package mx.styles
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   
   public interface IStyleManager
   {
       
      
      function get inheritingStyles() : Object;
      
      function set inheritingStyles(param1:Object) : void;
      
      function get stylesRoot() : Object;
      
      function set stylesRoot(param1:Object) : void;
      
      function get typeSelectorCache() : Object;
      
      function set typeSelectorCache(param1:Object) : void;
      
      function getStyleDeclaration(param1:String) : CSSStyleDeclaration;
      
      function setStyleDeclaration(param1:String, param2:CSSStyleDeclaration, param3:Boolean) : void;
      
      function clearStyleDeclaration(param1:String, param2:Boolean) : void;
      
      function registerInheritingStyle(param1:String) : void;
      
      function isInheritingStyle(param1:String) : Boolean;
      
      function isInheritingTextFormatStyle(param1:String) : Boolean;
      
      function registerSizeInvalidatingStyle(param1:String) : void;
      
      function isSizeInvalidatingStyle(param1:String) : Boolean;
      
      function registerParentSizeInvalidatingStyle(param1:String) : void;
      
      function isParentSizeInvalidatingStyle(param1:String) : Boolean;
      
      function registerParentDisplayListInvalidatingStyle(param1:String) : void;
      
      function isParentDisplayListInvalidatingStyle(param1:String) : Boolean;
      
      function registerColorName(param1:String, param2:uint) : void;
      
      function isColorName(param1:String) : Boolean;
      
      function getColorName(param1:Object) : uint;
      
      function getColorNames(param1:Array) : void;
      
      function isValidStyleValue(param1:*) : Boolean;
      
      function loadStyleDeclarations(param1:String, param2:Boolean = true, param3:Boolean = false, param4:ApplicationDomain = null, param5:SecurityDomain = null) : IEventDispatcher;
      
      function unloadStyleDeclarations(param1:String, param2:Boolean = true) : void;
      
      function initProtoChainRoots() : void;
      
      function styleDeclarationsChanged() : void;
   }
}
