package flashx.textLayout.property
{
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class Property
   {
      
      public static var errorHandler:Function = defaultErrorHandler;
      
      tlf_internal static const sharedStringHandler:StringPropertyHandler = new StringPropertyHandler();
      
      tlf_internal static const sharedInheritEnumHandler:EnumPropertyHandler = new EnumPropertyHandler([FormatValue.INHERIT]);
      
      tlf_internal static const sharedUndefinedHandler:UndefinedPropertyHandler = new UndefinedPropertyHandler();
      
      tlf_internal static const sharedUintHandler:UintPropertyHandler = new UintPropertyHandler();
      
      tlf_internal static const sharedBooleanHandler:BooleanPropertyHandler = new BooleanPropertyHandler();
      
      tlf_internal static const sharedTextLayoutFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
      
      tlf_internal static const sharedListMarkerFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
      
      private static const undefinedValue = undefined;
      
      public static const NO_LIMITS:String = "noLimits";
      
      public static const LOWER_LIMIT:String = "lowerLimit";
      
      public static const UPPER_LIMIT:String = "upperLimit";
      
      public static const ALL_LIMITS:String = "allLimits";
      
      tlf_internal static const nullStyleObject:Object = new Object();
      
      private static function prototypeFactory():void
      {
      } 
      
      private var _name:String;
      
      private var _default;
      
      private var _inherited:Boolean;
      
      private var _categories:Vector.<String>;
      
      private var _hasCustomExporterHandler:Boolean;
      
      private var _numberPropertyHandler:NumberPropertyHandler;
      
      protected var _handlers:Vector.<PropertyHandler>;
      
      public function Property(nameValue:String, defaultValue:*, inherited:Boolean, categories:Vector.<String>)
      {
         super();
         this._name = nameValue;
         this._default = defaultValue;
         this._inherited = inherited;
         this._categories = categories;
         this._hasCustomExporterHandler = false;
      }
      
      public static function defaultErrorHandler(p:Property, value:Object) : void
      {
         throw new RangeError(createErrorString(p,value));
      }
      
      public static function createErrorString(p:Property, value:Object) : String
      {
         return GlobalSettings.resourceStringFunction("badPropertyValue",[p.name,value.toString()]);
      }
      
      public static function NewBooleanProperty(nameValue:String, defaultValue:Boolean, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,tlf_internal::sharedBooleanHandler,tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewStringProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,tlf_internal::sharedStringHandler);
         return rslt;
      }
      
      public static function NewUintProperty(nameValue:String, defaultValue:uint, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,tlf_internal::sharedUintHandler,tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewEnumStringProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>, ... rest) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new EnumPropertyHandler(rest),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewIntOrEnumProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, minValue:int, maxValue:int, ... rest) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new EnumPropertyHandler(rest),new IntPropertyHandler(minValue,maxValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewUintOrEnumProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, ... rest) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new EnumPropertyHandler(rest),tlf_internal::sharedUintHandler,tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewNumberProperty(nameValue:String, defaultValue:Number, inherited:Boolean, categories:Vector.<String>, minValue:Number, maxValue:Number) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new NumberPropertyHandler(minValue,maxValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewNumberOrPercentOrEnumProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, minValue:Number, maxValue:Number, minPercentValue:String, maxPercentValue:String, ... rest) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new EnumPropertyHandler(rest),new PercentPropertyHandler(minPercentValue,maxPercentValue),new NumberPropertyHandler(minValue,maxValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewNumberOrPercentProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, minValue:Number, maxValue:Number, minPercentValue:String, maxPercentValue:String) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new PercentPropertyHandler(minPercentValue,maxPercentValue),new NumberPropertyHandler(minValue,maxValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewNumberOrEnumProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, minValue:Number, maxValue:Number, ... rest) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new EnumPropertyHandler(rest),new NumberPropertyHandler(minValue,maxValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewTabStopsProperty(nameValue:String, defaultValue:Array, inherited:Boolean, categories:Vector.<String>) : Property
      {
         return new TabStopsProperty(nameValue,defaultValue,inherited,categories);
      }
      
      public static function NewSpacingLimitProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>, minPercentValue:String, maxPercentValue:String) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,new SpacingLimitPropertyHandler(minPercentValue,maxPercentValue),tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewTextLayoutFormatProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,undefinedValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,tlf_internal::sharedTextLayoutFormatHandler,tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function NewListMarkerFormatProperty(nameValue:String, defaultValue:Object, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,undefinedValue,inherited,categories);
         rslt.addHandlers(tlf_internal::sharedUndefinedHandler,tlf_internal::sharedListMarkerFormatHandler,tlf_internal::sharedInheritEnumHandler);
         return rslt;
      }
      
      public static function defaultConcatHelper(currVal:*, concatVal:*) : *
      {
         return currVal === undefined || currVal == FormatValue.INHERIT ? concatVal : currVal;
      }
      
      public static function defaultsAllHelper(description:Object, current:Object) : void
      {
         var prop:Property = null;
         for each(prop in description)
         {
            current[prop.name] = prop.defaultValue;
         }
      }
      
      public static function equalAllHelper(description:Object, p1:Object, p2:Object) : Boolean
      {
         var prop:Property = null;
         var name:String = null;
         if(p1 == p2)
         {
            return true;
         }
         if(p1 == null || p2 == null)
         {
            return false;
         }
         for each(prop in description)
         {
            name = prop.name;
            if(!prop.equalHelper(p1[name],p2[name]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function extractInCategory(formatClass:Class, description:Object, props:Object, category:String, legacy:Boolean = true) : Object
      {
         var prop:Property = null;
         var rslt:Object = null;
         for each(prop in description)
         {
            if(props[prop.name] != null)
            {
               if(legacy)
               {
                  if(prop.category != category)
                  {
                     continue;
                  }
               }
               else if(prop.categories.indexOf(category) == -1)
               {
                  continue;
               }
               if(rslt == null)
               {
                  rslt = new formatClass();
               }
               rslt[prop.name] = props[prop.name];
            }
         }
         return rslt;
      }
      
      public static function shallowCopy(src:Object) : Object
      {
         var val:* = null;
         var rslt:Object = new Object();
         for(val in src)
         {
            rslt[val] = src[val];
         }
         return rslt;
      }
      
      public static function shallowCopyInFilter(src:Object, filter:Object) : Object
      {
         var val:* = null;
         var rslt:Object = new Object();
         for(val in src)
         {
            if(filter.hasOwnProperty(val))
            {
               rslt[val] = src[val];
            }
         }
         return rslt;
      }
      
      public static function shallowCopyNotInFilter(src:Object, filter:Object) : Object
      {
         var val:* = null;
         var rslt:Object = new Object();
         for(val in src)
         {
            if(!filter.hasOwnProperty(val))
            {
               rslt[val] = src[val];
            }
         }
         return rslt;
      }
      
      private static function compareStylesLoop(o1:Object, o2:Object, description:Object) : Boolean
      {
         var val:* = null;
         var o1val:Object = null;
         var o2val:Object = null;
         var prop:ArrayProperty = null;
         for(val in o1)
         {
            o1val = o1[val];
            o2val = o2[val];
            if(o1val != o2val)
            {
               if(!(o1val is Array) || !(o2val is Array) || o1val.length != o2val.length || !description)
               {
                  return false;
               }
               prop = description[val];
               if(!prop || !equalAllHelper(prop.memberType.description,o1val,o2val))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function equalStyles(o1:Object, o2:Object, description:Object) : Boolean
      {
         if(o1 == null)
         {
            o1 = tlf_internal::nullStyleObject;
         }
         if(o2 == null)
         {
            o2 = tlf_internal::nullStyleObject;
         }
         return compareStylesLoop(o1,o2,description) && compareStylesLoop(o2,o1,description);
      }
      
      public static function toNumberIfPercent(o:Object) : Number
      {
         if(!(o is String))
         {
            return NaN;
         }
         var s:String = String(o);
         var len:int = s.length;
         return len != 0 && s.charAt(len - 1) == "%" ? Number(parseFloat(s)) : Number(NaN);
      }
      
      public static function createObjectWithPrototype(parent:Object) : Object
      {
         prototypeFactory.prototype = parent;
         return new prototypeFactory();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get defaultValue() : *
      {
         return this._default;
      }
      
      public function get inherited() : Object
      {
         return this._inherited;
      }
      
      public function get category() : String
      {
         return this._categories[0];
      }
      
      public function get categories() : Vector.<String>
      {
         return this._categories;
      }
      
      public function addHandlers(... rest) : void
      {
         var handler:PropertyHandler = null;
         this._handlers = new Vector.<PropertyHandler>(rest.length,true);
         for(var idx:int = 0; idx < rest.length; idx++)
         {
            handler = rest[idx];
            this._handlers[idx] = handler;
            if(handler.customXMLStringHandler)
            {
               this._hasCustomExporterHandler = true;
            }
            if(handler is NumberPropertyHandler)
            {
               this._numberPropertyHandler = handler as NumberPropertyHandler;
            }
         }
      }
      
      public function findHandler(handlerClass:Class) : PropertyHandler
      {
         var prop:PropertyHandler = null;
         for each(prop in this._handlers)
         {
            if(prop is handlerClass)
            {
               return prop;
            }
         }
         return null;
      }
      
      public function setHelper(currVal:*, newVal:*) : *
      {
         var handler:PropertyHandler = null;
         var checkRslt:* = undefined;
         for each(handler in this._handlers)
         {
            checkRslt = handler.owningHandlerCheck(newVal);
            if(checkRslt !== undefined)
            {
               return handler.setHelper(checkRslt);
            }
         }
         Property.errorHandler(this,newVal);
         return currVal;
      }
      
      public function concatInheritOnlyHelper(currVal:*, concatVal:*) : *
      {
         return this._inherited && currVal === undefined || currVal == FormatValue.INHERIT ? concatVal : currVal;
      }
      
      public function concatHelper(currVal:*, concatVal:*) : *
      {
         if(this._inherited)
         {
            return currVal === undefined || currVal == FormatValue.INHERIT ? concatVal : currVal;
         }
         if(currVal === undefined)
         {
            return this.defaultValue;
         }
         return currVal == FormatValue.INHERIT ? concatVal : currVal;
      }
      
      public function equalHelper(v1:*, v2:*) : Boolean
      {
         return v1 == v2;
      }
      
      public function toXMLString(val:Object) : String
      {
         var prop:PropertyHandler = null;
         if(this._hasCustomExporterHandler)
         {
            for each(prop in this._handlers)
            {
               if(prop.customXMLStringHandler && prop.owningHandlerCheck(val) !== undefined)
               {
                  return prop.toXMLString(val);
               }
            }
         }
         return val.toString();
      }
      
      public function get maxPercentValue() : Number
      {
         var handler:PercentPropertyHandler = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
         return !!handler ? Number(handler.maxValue) : Number(NaN);
      }
      
      public function get minPercentValue() : Number
      {
         var handler:PercentPropertyHandler = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
         return !!handler ? Number(handler.minValue) : Number(NaN);
      }
      
      public function get minValue() : Number
      {
         var numberHandler:NumberPropertyHandler = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
         if(numberHandler)
         {
            return numberHandler.minValue;
         }
         var intHandler:IntPropertyHandler = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
         return !!intHandler ? Number(intHandler.minValue) : Number(NaN);
      }
      
      public function get maxValue() : Number
      {
         var numberHandler:NumberPropertyHandler = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
         if(numberHandler)
         {
            return numberHandler.maxValue;
         }
         var intHandler:IntPropertyHandler = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
         return !!intHandler ? Number(intHandler.maxValue) : Number(NaN);
      }
      
      public function computeActualPropertyValue(propertyValue:Object, percentInput:Number) : Number
      {
         var percent:Number = toNumberIfPercent(propertyValue);
         if(isNaN(percent))
         {
            return Number(propertyValue);
         }
         var rslt:Number = percentInput * (percent / 100);
         return !!this._numberPropertyHandler ? Number(this._numberPropertyHandler.clampToRange(rslt)) : Number(rslt);
      }
   }
}
