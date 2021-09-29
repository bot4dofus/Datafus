package mx.core
{
   import flash.accessibility.AccessibilityProperties;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   
   public interface IFlexDisplayObject extends IBitmapDrawable, IEventDispatcher
   {
       
      
      function get root() : DisplayObject;
      
      function get stage() : Stage;
      
      function get name() : String;
      
      function set name(param1:String) : void;
      
      function get parent() : DisplayObjectContainer;
      
      function get mask() : DisplayObject;
      
      function set mask(param1:DisplayObject) : void;
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function get scaleX() : Number;
      
      function set scaleX(param1:Number) : void;
      
      function get scaleY() : Number;
      
      function set scaleY(param1:Number) : void;
      
      function get mouseX() : Number;
      
      function get mouseY() : Number;
      
      function get rotation() : Number;
      
      function set rotation(param1:Number) : void;
      
      function get alpha() : Number;
      
      function set alpha(param1:Number) : void;
      
      function get width() : Number;
      
      function set width(param1:Number) : void;
      
      function get height() : Number;
      
      function set height(param1:Number) : void;
      
      function get cacheAsBitmap() : Boolean;
      
      function set cacheAsBitmap(param1:Boolean) : void;
      
      function get opaqueBackground() : Object;
      
      function set opaqueBackground(param1:Object) : void;
      
      function get scrollRect() : Rectangle;
      
      function set scrollRect(param1:Rectangle) : void;
      
      function get filters() : Array;
      
      function set filters(param1:Array) : void;
      
      function get blendMode() : String;
      
      function set blendMode(param1:String) : void;
      
      function get transform() : Transform;
      
      function set transform(param1:Transform) : void;
      
      function get scale9Grid() : Rectangle;
      
      function set scale9Grid(param1:Rectangle) : void;
      
      function globalToLocal(param1:Point) : Point;
      
      function localToGlobal(param1:Point) : Point;
      
      function getBounds(param1:DisplayObject) : Rectangle;
      
      function getRect(param1:DisplayObject) : Rectangle;
      
      function get loaderInfo() : LoaderInfo;
      
      function hitTestObject(param1:DisplayObject) : Boolean;
      
      function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean;
      
      function get accessibilityProperties() : AccessibilityProperties;
      
      function set accessibilityProperties(param1:AccessibilityProperties) : void;
      
      function get measuredHeight() : Number;
      
      function get measuredWidth() : Number;
      
      function move(param1:Number, param2:Number) : void;
      
      function setActualSize(param1:Number, param2:Number) : void;
   }
}
