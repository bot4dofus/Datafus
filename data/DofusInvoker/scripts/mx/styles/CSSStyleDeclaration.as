package mx.styles
{
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.managers.ISystemManager;
   import mx.managers.SystemManagerGlobals;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class CSSStyleDeclaration extends EventDispatcher
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static const NOT_A_COLOR:uint = 4294967295;
      
      private static const FILTERMAP_PROP:String = "__reserved__filterMap";
      
      private static function emptyObjectFactory():void
      {
      } 
      
      private var clones:Dictionary;
      
      mx_internal var selectorRefCount:int = 0;
      
      public var selectorIndex:int = 0;
      
      mx_internal var effects:Array;
      
      private var styleManager:IStyleManager2;
      
      private var _defaultFactory:Function;
      
      private var _factory:Function;
      
      private var _overrides:Object;
      
      private var _selector:CSSSelector;
      
      private var _selectorString:String;
      
      public function CSSStyleDeclaration(selector:Object = null, styleManager:IStyleManager2 = null, autoRegisterWithStyleManager:Boolean = true)
      {
         this.clones = new Dictionary(true);
         super();
         if(!styleManager)
         {
            styleManager = Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2;
         }
         this.styleManager = styleManager;
         if(selector)
         {
            if(selector is CSSSelector)
            {
               this.selector = selector as CSSSelector;
            }
            else
            {
               this.selectorString = selector.toString();
            }
            if(autoRegisterWithStyleManager)
            {
               styleManager.setStyleDeclaration(this.selectorString,this,false);
            }
         }
      }
      
      [Inspectable(environment="none")]
      public function get defaultFactory() : Function
      {
         return this._defaultFactory;
      }
      
      public function set defaultFactory(f:Function) : void
      {
         this._defaultFactory = f;
      }
      
      [Inspectable(environment="none")]
      public function get factory() : Function
      {
         return this._factory;
      }
      
      public function set factory(f:Function) : void
      {
         this._factory = f;
      }
      
      public function get overrides() : Object
      {
         return this._overrides;
      }
      
      public function set overrides(o:Object) : void
      {
         this._overrides = o;
      }
      
      public function get selector() : CSSSelector
      {
         return this._selector;
      }
      
      public function set selector(value:CSSSelector) : void
      {
         this._selector = value;
         this._selectorString = null;
      }
      
      mx_internal function get selectorString() : String
      {
         if(this._selectorString == null && this._selector != null)
         {
            this._selectorString = this._selector.toString();
         }
         return this._selectorString;
      }
      
      mx_internal function set selectorString(value:String) : void
      {
         var condition:CSSCondition = null;
         if(value.charAt(0) == ".")
         {
            condition = new CSSCondition(CSSConditionKind.CLASS,value.substr(1));
            this._selector = new CSSSelector("",[condition]);
         }
         else
         {
            this._selector = new CSSSelector(value);
         }
         this._selectorString = value;
      }
      
      public function get specificity() : int
      {
         return !!this._selector ? int(this._selector.specificity) : 0;
      }
      
      public function get subject() : String
      {
         if(this._selector != null)
         {
            if(this._selector.subject == "" && this._selector.conditions)
            {
               return "*";
            }
            return this._selector.subject;
         }
         return null;
      }
      
      mx_internal function getPseudoCondition() : String
      {
         return this.selector != null ? this.selector.getPseudoCondition() : null;
      }
      
      mx_internal function isAdvanced() : Boolean
      {
         var condition:CSSCondition = null;
         if(this.selector != null)
         {
            if(this.selector.ancestor)
            {
               return true;
            }
            if(this.selector.conditions)
            {
               if(this.subject != "*" && this.subject != "global")
               {
                  return true;
               }
               for each(condition in this.selector.conditions)
               {
                  if(condition.kind != CSSConditionKind.CLASS)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function matchesStyleClient(object:IAdvancedStyleClient) : Boolean
      {
         return this.selector != null ? Boolean(this.selector.matchesStyleClient(object)) : false;
      }
      
      mx_internal function equals(styleDeclaration:CSSStyleDeclaration) : Boolean
      {
         var obj:Object = null;
         if(styleDeclaration == null)
         {
            return false;
         }
         if(ObjectUtil.compare(this.overrides,styleDeclaration.overrides) != 0)
         {
            return false;
         }
         if(this.factory == null && styleDeclaration.factory != null || this.factory != null && styleDeclaration.factory == null)
         {
            return false;
         }
         if(this.factory != null)
         {
            if(ObjectUtil.compare(new this.factory(),new styleDeclaration.factory()) != 0)
            {
               return false;
            }
         }
         if(this.defaultFactory == null && styleDeclaration.defaultFactory != null || this.defaultFactory != null && styleDeclaration.defaultFactory == null)
         {
            return false;
         }
         if(this.defaultFactory != null)
         {
            if(ObjectUtil.compare(new this.defaultFactory(),new styleDeclaration.defaultFactory()) != 0)
            {
               return false;
            }
         }
         if(ObjectUtil.compare(this.effects,styleDeclaration.effects))
         {
            return false;
         }
         return true;
      }
      
      public function getStyle(styleProp:String) : *
      {
         var o:* = undefined;
         var v:* = undefined;
         if(this.overrides)
         {
            if(styleProp in this.overrides && this.overrides[styleProp] === undefined)
            {
               return undefined;
            }
            v = this.overrides[styleProp];
            if(v !== undefined)
            {
               return v;
            }
         }
         if(this.factory != null)
         {
            this.factory.prototype = {};
            o = new this.factory();
            v = o[styleProp];
            if(v !== undefined)
            {
               return v;
            }
         }
         if(this.defaultFactory != null)
         {
            this.defaultFactory.prototype = {};
            o = new this.defaultFactory();
            v = o[styleProp];
            if(v !== undefined)
            {
               return v;
            }
         }
         return undefined;
      }
      
      public function setStyle(styleProp:String, newValue:*) : void
      {
         var i:int = 0;
         var sm:ISystemManager = null;
         var cm:Object = null;
         var oldValue:Object = this.getStyle(styleProp);
         var regenerate:Boolean = false;
         if(this.selectorRefCount > 0 && this.factory == null && this.defaultFactory == null && !this.overrides && oldValue !== newValue)
         {
            regenerate = true;
         }
         if(newValue !== undefined)
         {
            this.setLocalStyle(styleProp,newValue);
         }
         else
         {
            if(newValue == oldValue)
            {
               return;
            }
            this.setLocalStyle(styleProp,newValue);
         }
         var sms:Array = SystemManagerGlobals.topLevelSystemManagers;
         var n:int = sms.length;
         if(regenerate)
         {
            for(i = 0; i < n; i++)
            {
               sm = sms[i];
               cm = sm.getImplementation("mx.managers::ISystemManagerChildManager");
               cm.regenerateStyleCache(true);
            }
         }
         for(i = 0; i < n; i++)
         {
            sm = sms[i];
            cm = sm.getImplementation("mx.managers::ISystemManagerChildManager");
            cm.notifyStyleChangeInChildren(styleProp,true);
         }
      }
      
      mx_internal function setLocalStyle(styleProp:String, value:*) : void
      {
         var o:Object = null;
         var colorNumber:Number = NaN;
         var oldValue:Object = this.getStyle(styleProp);
         if(value === undefined)
         {
            this.clearStyleAttr(styleProp);
            return;
         }
         if(value is String)
         {
            if(!this.styleManager)
            {
               this.styleManager = Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2;
            }
            colorNumber = this.styleManager.getColorName(value);
            if(colorNumber != NOT_A_COLOR)
            {
               value = colorNumber;
            }
         }
         if(this.defaultFactory != null)
         {
            o = new this.defaultFactory();
            if(o[styleProp] !== value)
            {
               if(!this.overrides)
               {
                  this.overrides = {};
               }
               this.overrides[styleProp] = value;
            }
            else if(this.overrides)
            {
               delete this.overrides[styleProp];
            }
         }
         if(this.factory != null)
         {
            o = new this.factory();
            if(o[styleProp] !== value)
            {
               if(!this.overrides)
               {
                  this.overrides = {};
               }
               this.overrides[styleProp] = value;
            }
            else if(this.overrides)
            {
               delete this.overrides[styleProp];
            }
         }
         if(this.defaultFactory == null && this.factory == null)
         {
            if(!this.overrides)
            {
               this.overrides = {};
            }
            this.overrides[styleProp] = value;
         }
         this.updateClones(styleProp,value);
      }
      
      public function clearStyle(styleProp:String) : void
      {
         this.setStyle(styleProp,undefined);
      }
      
      mx_internal function createProtoChainRoot() : Object
      {
         var root:Object = {};
         if(this.defaultFactory != null)
         {
            this.defaultFactory.prototype = root;
            root = new this.defaultFactory();
         }
         if(this.factory != null)
         {
            this.factory.prototype = root;
            root = new this.factory();
         }
         this.clones[root] = 1;
         return root;
      }
      
      mx_internal function addStyleToProtoChain(chain:Object, target:DisplayObject, filterMap:Object = null) : Object
      {
         var style:CSSStyleDeclaration = null;
         var inChain:Object = null;
         var parentStyle:CSSStyleDeclaration = null;
         var nodeAddedToChain:Boolean = false;
         var originalChain:Object = chain;
         var parentStyleDeclarations:Vector.<CSSStyleDeclaration> = new Vector.<CSSStyleDeclaration>();
         var styleParent:IStyleManager2 = this.styleManager.parent;
         while(styleParent)
         {
            parentStyle = styleParent.getStyleDeclaration(this.selectorString);
            if(parentStyle)
            {
               parentStyleDeclarations.unshift(parentStyle);
            }
            styleParent = styleParent.parent;
         }
         for each(style in parentStyleDeclarations)
         {
            if(style.defaultFactory != null)
            {
               chain = style.addDefaultStyleToProtoChain(chain,target,filterMap);
            }
         }
         if(this.defaultFactory != null)
         {
            chain = this.addDefaultStyleToProtoChain(chain,target,filterMap);
         }
         var addedParentStyleToProtoChain:Boolean = false;
         for each(style in parentStyleDeclarations)
         {
            if(style.factory != null || style.overrides != null)
            {
               chain = style.addFactoryAndOverrideStylesToProtoChain(chain,target,filterMap);
               addedParentStyleToProtoChain = true;
            }
         }
         inChain = chain;
         if(this.factory != null || this.overrides != null)
         {
            chain = this.addFactoryAndOverrideStylesToProtoChain(chain,target,filterMap);
            if(inChain != chain)
            {
               nodeAddedToChain = true;
            }
         }
         if(this.defaultFactory != null && !nodeAddedToChain)
         {
            if(addedParentStyleToProtoChain)
            {
               emptyObjectFactory.prototype = chain;
               chain = new emptyObjectFactory();
               emptyObjectFactory.prototype = null;
            }
            nodeAddedToChain = true;
         }
         if(nodeAddedToChain)
         {
            this.clones[chain] = 1;
         }
         return chain;
      }
      
      mx_internal function addDefaultStyleToProtoChain(chain:Object, target:DisplayObject, filterMap:Object = null) : Object
      {
         var originalChain:Object = null;
         if(this.defaultFactory != null)
         {
            originalChain = chain;
            if(filterMap)
            {
               chain = {};
            }
            this.defaultFactory.prototype = chain;
            chain = new this.defaultFactory();
            this.defaultFactory.prototype = null;
            if(filterMap)
            {
               chain = this.applyFilter(originalChain,chain,filterMap);
            }
         }
         return chain;
      }
      
      mx_internal function addFactoryAndOverrideStylesToProtoChain(chain:Object, target:DisplayObject, filterMap:Object = null) : Object
      {
         var p:* = null;
         var originalChain:Object = chain;
         if(filterMap)
         {
            chain = {};
         }
         if(this.factory != null)
         {
            this.factory.prototype = chain;
            chain = new this.factory();
            this.factory.prototype = null;
         }
         if(this.overrides)
         {
            if(this.factory == null)
            {
               emptyObjectFactory.prototype = chain;
               chain = new emptyObjectFactory();
               emptyObjectFactory.prototype = null;
            }
            for(p in this.overrides)
            {
               if(this.overrides[p] === undefined)
               {
                  delete chain[p];
               }
               else
               {
                  chain[p] = this.overrides[p];
               }
            }
         }
         if(filterMap)
         {
            if(this.factory != null || this.overrides)
            {
               chain = this.applyFilter(originalChain,chain,filterMap);
            }
            else
            {
               chain = originalChain;
            }
         }
         if(this.factory != null || this.overrides)
         {
            this.clones[chain] = 1;
         }
         return chain;
      }
      
      mx_internal function applyFilter(originalChain:Object, chain:Object, filterMap:Object) : Object
      {
         var i:* = null;
         var filteredChain:Object = {};
         emptyObjectFactory.prototype = originalChain;
         filteredChain = new emptyObjectFactory();
         emptyObjectFactory.prototype = null;
         for(i in chain)
         {
            if(filterMap[i] != null)
            {
               filteredChain[filterMap[i]] = chain[i];
            }
         }
         chain = filteredChain;
         chain[FILTERMAP_PROP] = filterMap;
         return chain;
      }
      
      mx_internal function clearOverride(styleProp:String) : void
      {
         if(this.overrides && this.overrides[styleProp] !== undefined)
         {
            delete this.overrides[styleProp];
         }
      }
      
      private function clearStyleAttr(styleProp:String) : void
      {
         var clone:* = undefined;
         if(!this.overrides)
         {
            this.overrides = {};
         }
         this.overrides[styleProp] = undefined;
         for(clone in this.clones)
         {
            delete clone[styleProp];
         }
      }
      
      mx_internal function updateClones(styleProp:String, value:*) : void
      {
         var clone:* = undefined;
         var cloneFilter:Object = null;
         for(clone in this.clones)
         {
            cloneFilter = clone[FILTERMAP_PROP];
            if(cloneFilter)
            {
               if(cloneFilter[styleProp] != null)
               {
                  clone[cloneFilter[styleProp]] = value;
               }
            }
            else
            {
               clone[styleProp] = value;
            }
         }
      }
   }
}
