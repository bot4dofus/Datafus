package mx.styles
{
   public interface IStyleClient extends ISimpleStyleClient
   {
       
      
      function get className() : String;
      
      function get inheritingStyles() : Object;
      
      function set inheritingStyles(param1:Object) : void;
      
      function get nonInheritingStyles() : Object;
      
      function set nonInheritingStyles(param1:Object) : void;
      
      function get styleDeclaration() : CSSStyleDeclaration;
      
      function set styleDeclaration(param1:CSSStyleDeclaration) : void;
      
      function getStyle(param1:String) : *;
      
      function setStyle(param1:String, param2:*) : void;
      
      function clearStyle(param1:String) : void;
      
      function getClassStyleDeclarations() : Array;
      
      function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void;
      
      function regenerateStyleCache(param1:Boolean) : void;
      
      function registerEffects(param1:Array) : void;
   }
}
