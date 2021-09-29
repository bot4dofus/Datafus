package mx.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import mx.managers.ISystemManager;
   
   public interface IUIComponent extends IFlexDisplayObject
   {
       
      
      function get baselinePosition() : Number;
      
      function get document() : Object;
      
      function set document(param1:Object) : void;
      
      function get enabled() : Boolean;
      
      function set enabled(param1:Boolean) : void;
      
      function get explicitHeight() : Number;
      
      function set explicitHeight(param1:Number) : void;
      
      function get explicitMaxHeight() : Number;
      
      function get explicitMaxWidth() : Number;
      
      function get explicitMinHeight() : Number;
      
      function get explicitMinWidth() : Number;
      
      function get explicitWidth() : Number;
      
      function set explicitWidth(param1:Number) : void;
      
      function get focusPane() : Sprite;
      
      function set focusPane(param1:Sprite) : void;
      
      function get includeInLayout() : Boolean;
      
      function set includeInLayout(param1:Boolean) : void;
      
      function get isPopUp() : Boolean;
      
      function set isPopUp(param1:Boolean) : void;
      
      function get maxHeight() : Number;
      
      function get maxWidth() : Number;
      
      function get measuredMinHeight() : Number;
      
      function set measuredMinHeight(param1:Number) : void;
      
      function get measuredMinWidth() : Number;
      
      function set measuredMinWidth(param1:Number) : void;
      
      function get minHeight() : Number;
      
      function get minWidth() : Number;
      
      function get owner() : DisplayObjectContainer;
      
      function set owner(param1:DisplayObjectContainer) : void;
      
      function get percentHeight() : Number;
      
      function set percentHeight(param1:Number) : void;
      
      function get percentWidth() : Number;
      
      function set percentWidth(param1:Number) : void;
      
      function get systemManager() : ISystemManager;
      
      function set systemManager(param1:ISystemManager) : void;
      
      function get tweeningProperties() : Array;
      
      function set tweeningProperties(param1:Array) : void;
      
      function initialize() : void;
      
      function parentChanged(param1:DisplayObjectContainer) : void;
      
      function getExplicitOrMeasuredWidth() : Number;
      
      function getExplicitOrMeasuredHeight() : Number;
      
      function setVisible(param1:Boolean, param2:Boolean = false) : void;
      
      function owns(param1:DisplayObject) : Boolean;
   }
}
