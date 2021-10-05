package mx.styles
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.SecurityDomain;
   import flash.utils.Dictionary;
   import mx.core.IFlexModuleFactory;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.managers.SystemManagerGlobals;
   
   use namespace mx_internal;
   
   public class StyleManager
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      public static const NOT_A_COLOR:uint = 4294967295;
      
      private static var implClassDependency:StyleManagerImpl;
      
      private static var _impl:IStyleManager2;
      
      private static var styleManagerDictionary:Dictionary;
       
      
      public function StyleManager()
      {
         super();
      }
      
      private static function get impl() : IStyleManager2
      {
         if(!_impl)
         {
            _impl = IStyleManager2(Singleton.getInstance("mx.styles::IStyleManager2"));
         }
         return _impl;
      }
      
      public static function getStyleManager(moduleFactory:IFlexModuleFactory) : IStyleManager2
      {
         var styleManager:IStyleManager2 = null;
         var o:* = null;
         if(!moduleFactory)
         {
            moduleFactory = SystemManagerGlobals.topLevelSystemManagers[0];
         }
         if(!styleManagerDictionary)
         {
            styleManagerDictionary = new Dictionary(true);
         }
         var dictionary:Dictionary = styleManagerDictionary[moduleFactory];
         if(dictionary == null)
         {
            styleManager = IStyleManager2(moduleFactory.getImplementation("mx.styles::IStyleManager2"));
            if(styleManager == null)
            {
               styleManager = impl;
            }
            dictionary = new Dictionary(true);
            styleManagerDictionary[moduleFactory] = dictionary;
            dictionary[styleManager] = 1;
         }
         else
         {
            var _loc5_:int = 0;
            var _loc6_:* = dictionary;
            for(o in _loc6_)
            {
               styleManager = o as IStyleManager2;
            }
         }
         return styleManager;
      }
      
      mx_internal static function get stylesRoot() : Object
      {
         return impl.stylesRoot;
      }
      
      mx_internal static function set stylesRoot(value:Object) : void
      {
         impl.stylesRoot = value;
      }
      
      mx_internal static function get inheritingStyles() : Object
      {
         return impl.inheritingStyles;
      }
      
      mx_internal static function set inheritingStyles(value:Object) : void
      {
         impl.inheritingStyles = value;
      }
      
      mx_internal static function get typeHierarchyCache() : Object
      {
         return impl.typeHierarchyCache;
      }
      
      mx_internal static function set typeHierarchyCache(value:Object) : void
      {
         impl.typeHierarchyCache = value;
      }
      
      mx_internal static function get typeSelectorCache() : Object
      {
         return impl.typeSelectorCache;
      }
      
      mx_internal static function set typeSelectorCache(value:Object) : void
      {
         impl.typeSelectorCache = value;
      }
      
      mx_internal static function initProtoChainRoots() : void
      {
         impl.initProtoChainRoots();
      }
      
      public static function get selectors() : Array
      {
         return impl.selectors;
      }
      
      public static function getStyleDeclaration(selector:String) : CSSStyleDeclaration
      {
         return impl.getStyleDeclaration(selector);
      }
      
      public static function setStyleDeclaration(selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean) : void
      {
         impl.setStyleDeclaration(selector,styleDeclaration,update);
      }
      
      public static function clearStyleDeclaration(selector:String, update:Boolean) : void
      {
         impl.clearStyleDeclaration(selector,update);
      }
      
      mx_internal static function styleDeclarationsChanged() : void
      {
         impl.styleDeclarationsChanged();
      }
      
      public static function registerInheritingStyle(styleName:String) : void
      {
         impl.registerInheritingStyle(styleName);
      }
      
      public static function isInheritingStyle(styleName:String) : Boolean
      {
         return impl.isInheritingStyle(styleName);
      }
      
      public static function isInheritingTextFormatStyle(styleName:String) : Boolean
      {
         return impl.isInheritingTextFormatStyle(styleName);
      }
      
      public static function registerSizeInvalidatingStyle(styleName:String) : void
      {
         impl.registerSizeInvalidatingStyle(styleName);
      }
      
      public static function isSizeInvalidatingStyle(styleName:String) : Boolean
      {
         return impl.isSizeInvalidatingStyle(styleName);
      }
      
      public static function registerParentSizeInvalidatingStyle(styleName:String) : void
      {
         impl.registerParentSizeInvalidatingStyle(styleName);
      }
      
      public static function isParentSizeInvalidatingStyle(styleName:String) : Boolean
      {
         return impl.isParentSizeInvalidatingStyle(styleName);
      }
      
      public static function registerParentDisplayListInvalidatingStyle(styleName:String) : void
      {
         impl.registerParentDisplayListInvalidatingStyle(styleName);
      }
      
      public static function isParentDisplayListInvalidatingStyle(styleName:String) : Boolean
      {
         return impl.isParentDisplayListInvalidatingStyle(styleName);
      }
      
      public static function registerColorName(colorName:String, colorValue:uint) : void
      {
         impl.registerColorName(colorName,colorValue);
      }
      
      public static function isColorName(colorName:String) : Boolean
      {
         return impl.isColorName(colorName);
      }
      
      public static function getColorName(colorName:Object) : uint
      {
         return impl.getColorName(colorName);
      }
      
      public static function getColorNames(colors:Array) : void
      {
         impl.getColorNames(colors);
      }
      
      public static function isValidStyleValue(value:*) : Boolean
      {
         return impl.isValidStyleValue(value);
      }
      
      public static function loadStyleDeclarations(url:String, update:Boolean = true, trustContent:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null) : IEventDispatcher
      {
         return impl.loadStyleDeclarations2(url,update,applicationDomain,securityDomain);
      }
      
      public static function unloadStyleDeclarations(url:String, update:Boolean = true) : void
      {
         impl.unloadStyleDeclarations(url,update);
      }
   }
}
