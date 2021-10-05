package mx.styles
{
   import flash.display.DisplayObject;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class CSSMergedStyleDeclaration extends CSSStyleDeclaration
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var style:CSSStyleDeclaration;
      
      private var parentStyle:CSSStyleDeclaration;
      
      private var updateOverrides:Boolean;
      
      private var _defaultFactory:Function;
      
      private var _factory:Function;
      
      public function CSSMergedStyleDeclaration(style:CSSStyleDeclaration, parentStyle:CSSStyleDeclaration, selector:Object = null, styleManager:IStyleManager2 = null, setSelector:Boolean = false)
      {
         var i:uint = 0;
         var n:uint = 0;
         var effectsArray:Array = null;
         super(selector,styleManager,setSelector);
         this.style = style;
         this.parentStyle = parentStyle;
         if(style && style.effects)
         {
            effects = [];
            effectsArray = style.effects;
            n = effectsArray.length;
            for(i = 0; i < n; i++)
            {
               mx_internal::effects[i] = effectsArray[i];
            }
         }
         if(parentStyle && parentStyle.effects)
         {
            if(!mx_internal::effects)
            {
               effects = [];
            }
            effectsArray = parentStyle.effects;
            n = effectsArray.length;
            for(i = 0; i < n; i++)
            {
               mx_internal::effects[i] = effectsArray[i];
               if(mx_internal::effects.indexOf(effectsArray[i]) == -1)
               {
                  mx_internal::effects[i] = effectsArray[i];
               }
            }
         }
         this.updateOverrides = true;
      }
      
      [Inspectable(environment="none")]
      override public function get defaultFactory() : Function
      {
         if(this._defaultFactory != null)
         {
            return this._defaultFactory;
         }
         if(this.style != null && this.style.defaultFactory != null || this.parentStyle != null && this.parentStyle.defaultFactory != null)
         {
            this._defaultFactory = function():void
            {
               if(parentStyle && parentStyle.defaultFactory != null)
               {
                  parentStyle.defaultFactory.apply(this);
               }
               if(style && style.defaultFactory != null)
               {
                  style.defaultFactory.apply(this);
               }
            };
         }
         return this._defaultFactory;
      }
      
      override public function set defaultFactory(f:Function) : void
      {
      }
      
      [Inspectable(environment="none")]
      override public function get factory() : Function
      {
         if(this._factory != null)
         {
            return this._factory;
         }
         if(this.style != null && this.style.factory != null || this.parentStyle != null && this.parentStyle.factory != null)
         {
            this._factory = function():void
            {
               if(parentStyle && parentStyle.factory != null)
               {
                  parentStyle.factory.apply(this);
               }
               if(style && style.factory != null)
               {
                  style.factory.apply(this);
               }
            };
         }
         return this._factory;
      }
      
      override public function set factory(f:Function) : void
      {
      }
      
      override public function get overrides() : Object
      {
         var obj:* = null;
         var childOverrides:Object = null;
         var parentOverrides:Object = null;
         if(!this.updateOverrides)
         {
            return super.overrides;
         }
         var mergedOverrides:Object = null;
         if(this.style && this.style.overrides)
         {
            mergedOverrides = [];
            childOverrides = this.style.overrides;
            for(obj in childOverrides)
            {
               mergedOverrides[obj] = childOverrides[obj];
            }
         }
         if(this.parentStyle && this.parentStyle.overrides)
         {
            if(!mergedOverrides)
            {
               mergedOverrides = [];
            }
            parentOverrides = this.parentStyle.overrides;
            for(obj in parentOverrides)
            {
               if(mergedOverrides[obj] === undefined)
               {
                  mergedOverrides[obj] = parentOverrides[obj];
               }
            }
         }
         super.overrides = mergedOverrides;
         this.updateOverrides = false;
         return mergedOverrides;
      }
      
      override public function set overrides(o:Object) : void
      {
      }
      
      override public function setStyle(styleProp:String, newValue:*) : void
      {
      }
      
      override mx_internal function addStyleToProtoChain(chain:Object, target:DisplayObject, filterMap:Object = null) : Object
      {
         if(this.style)
         {
            return this.style.addStyleToProtoChain(chain,target,filterMap);
         }
         if(this.parentStyle)
         {
            return this.parentStyle.addStyleToProtoChain(chain,target,filterMap);
         }
         return chain;
      }
   }
}
