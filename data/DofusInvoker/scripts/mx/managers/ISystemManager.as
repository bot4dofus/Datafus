package mx.managers
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import mx.core.IChildList;
   import mx.core.IFlexModuleFactory;
   
   public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory
   {
       
      
      function get cursorChildren() : IChildList;
      
      function get document() : Object;
      
      function set document(param1:Object) : void;
      
      function get embeddedFontList() : Object;
      
      function get focusPane() : Sprite;
      
      function set focusPane(param1:Sprite) : void;
      
      function get isProxy() : Boolean;
      
      function get loaderInfo() : LoaderInfo;
      
      function get numModalWindows() : int;
      
      function set numModalWindows(param1:int) : void;
      
      function get popUpChildren() : IChildList;
      
      function get rawChildren() : IChildList;
      
      function get screen() : Rectangle;
      
      function get stage() : Stage;
      
      function get toolTipChildren() : IChildList;
      
      function get topLevelSystemManager() : ISystemManager;
      
      function getDefinitionByName(param1:String) : Object;
      
      function isTopLevel() : Boolean;
      
      function isFontFaceEmbedded(param1:TextFormat) : Boolean;
      
      function isTopLevelRoot() : Boolean;
      
      function getTopLevelRoot() : DisplayObject;
      
      function getSandboxRoot() : DisplayObject;
      
      function getVisibleApplicationRect(param1:Rectangle = null, param2:Boolean = false) : Rectangle;
      
      function deployMouseShields(param1:Boolean) : void;
      
      function invalidateParentSizeAndDisplayList() : void;
   }
}
