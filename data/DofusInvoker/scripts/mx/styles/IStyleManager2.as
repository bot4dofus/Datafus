package mx.styles
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   
   public interface IStyleManager2 extends IStyleManager
   {
       
      
      function get parent() : IStyleManager2;
      
      function get qualifiedTypeSelectors() : Boolean;
      
      function set qualifiedTypeSelectors(param1:Boolean) : void;
      
      function get selectors() : Array;
      
      function get typeHierarchyCache() : Object;
      
      function set typeHierarchyCache(param1:Object) : void;
      
      function getStyleDeclarations(param1:String) : Object;
      
      function getMergedStyleDeclaration(param1:String) : CSSStyleDeclaration;
      
      function hasPseudoCondition(param1:String) : Boolean;
      
      function hasAdvancedSelectors() : Boolean;
      
      function loadStyleDeclarations2(param1:String, param2:Boolean = true, param3:ApplicationDomain = null, param4:SecurityDomain = null) : IEventDispatcher;
      
      function acceptMediaList(param1:String) : Boolean;
   }
}
