package mx.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ISystemManager;
   import mx.managers.SystemManagerGlobals;
   import mx.styles.CSSDimension;
   import mx.styles.CSSOSVersion;
   import mx.styles.IStyleManager2;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class MediaQueryParser extends EventDispatcher
   {
      
      public static var platformMap:Object = {
         "AND":"android",
         "IOS":"ios",
         "MAC":"macintosh",
         "WIN":"windows",
         "LNX":"linux",
         "QNX":"qnx"
      };
      
      private static var _instance:MediaQueryParser;
       
      
      mx_internal var goodQueries:Object;
      
      mx_internal var badQueries:Object;
      
      private var sm:ISystemManager;
      
      private var usesDeviceWidth:Boolean = false;
      
      private var usesDeviceHeight:Boolean = false;
      
      private var usesDeviceDiagonal:Boolean = false;
      
      private var deviceDPI:Number;
      
      public var type:String = "screen";
      
      public var applicationDpi:Number;
      
      public var osPlatform:String;
      
      public var osVersion:CSSOSVersion;
      
      private var _1550605040deviceWidth:CSSDimension;
      
      private var _1257110755deviceHeight:CSSDimension;
      
      public var flexDeviceDiagonal:CSSDimension;
      
      public function MediaQueryParser(moduleFactory:IFlexModuleFactory = null)
      {
         this.goodQueries = {};
         this.badQueries = {};
         super();
         this.applicationDpi = DensityUtil.getRuntimeDPI();
         if(moduleFactory)
         {
            if(moduleFactory.info()["applicationDPI"] != null)
            {
               this.applicationDpi = moduleFactory.info()["applicationDPI"];
            }
            if(moduleFactory is ISystemManager)
            {
               this.sm = ISystemManager(moduleFactory);
               if(this.sm.stage)
               {
                  this.sm.stage.addEventListener(Event.RESIZE,this.stage_resizeHandler,false);
               }
            }
         }
         this.osPlatform = this.getPlatform();
         this.osVersion = this.getOSVersion();
         this.deviceDPI = Capabilities.screenDPI;
         this.computeDeviceDimensions();
      }
      
      public static function get instance() : MediaQueryParser
      {
         return _instance;
      }
      
      public static function set instance(value:MediaQueryParser) : void
      {
         if(!_instance)
         {
            _instance = value;
         }
      }
      
      public function parse(expression:String) : Boolean
      {
         var result:Boolean = false;
         var mediaQuery:String = null;
         var notFlag:Boolean = false;
         var expressions:Array = null;
         var numExpressions:int = 0;
         expression = StringUtil.trim(expression);
         if(expression == "")
         {
            return true;
         }
         if(this.goodQueries[expression])
         {
            return true;
         }
         if(this.badQueries[expression])
         {
            return false;
         }
         var originalExpression:String = expression;
         expression = expression.toLowerCase();
         if(expression == "all")
         {
            return true;
         }
         var mediaQueries:Array = expression.split(", ");
         var n:int = mediaQueries.length;
         for(var i:int = 0; i < n; i++)
         {
            mediaQuery = mediaQueries[i];
            notFlag = false;
            if(mediaQuery.indexOf("only ") == 0)
            {
               mediaQuery = mediaQuery.substr(5);
            }
            if(mediaQuery.indexOf("not ") == 0)
            {
               notFlag = true;
               mediaQuery = mediaQuery.substr(4);
            }
            expressions = this.tokenizeMediaQuery(mediaQuery);
            numExpressions = expressions.length;
            if(expressions[0] == "all" || expressions[0] == this.type)
            {
               if(numExpressions == 1 && !notFlag)
               {
                  this.goodQueries[originalExpression] = true;
                  return true;
               }
               if(numExpressions == 2)
               {
                  return false;
               }
               expressions.shift();
               expressions.shift();
               result = this.evalExpressions(expressions);
               if(result && !notFlag || !result && notFlag)
               {
                  this.goodQueries[originalExpression] = true;
                  return true;
               }
            }
            else if(notFlag)
            {
               this.goodQueries[originalExpression] = true;
               return true;
            }
         }
         this.badQueries[originalExpression] = true;
         return false;
      }
      
      private function tokenizeMediaQuery(mediaQuery:String) : Array
      {
         var c:String = null;
         var tokens:Array = [];
         var pos:int = mediaQuery.indexOf("(");
         if(pos == 0)
         {
            tokens.push("all");
            tokens.push("and");
         }
         else if(pos == -1)
         {
            return [mediaQuery];
         }
         var parenLevel:int = 0;
         var inComment:Boolean = false;
         var n:int = mediaQuery.length;
         var expression:Array = [];
         for(var i:int = 0; i < n; i++)
         {
            c = mediaQuery.charAt(i);
            if(!(StringUtil.isWhitespace(c) && expression.length == 0))
            {
               if(c == "/" && i < n - 1 && mediaQuery.charAt(i + 1) == "*")
               {
                  inComment = true;
                  i++;
               }
               else if(inComment)
               {
                  if(c == "*" && i < n - 1 && mediaQuery.charAt(i + 1) == "/")
                  {
                     inComment = false;
                     i++;
                  }
               }
               else
               {
                  if(c == "(")
                  {
                     parenLevel++;
                  }
                  else if(c == ")")
                  {
                     parenLevel--;
                  }
                  else
                  {
                     expression.push(c);
                  }
                  if(parenLevel == 0 && (StringUtil.isWhitespace(c) || c == ")"))
                  {
                     if(c != ")")
                     {
                        --expression.length;
                     }
                     tokens.push(expression.join(""));
                     expression.length = 0;
                  }
               }
            }
         }
         return tokens;
      }
      
      private function evalExpressions(expressions:Array) : Boolean
      {
         var expr:String = null;
         var parts:Array = null;
         var key:String = null;
         var min:Boolean = false;
         var max:Boolean = false;
         var flex:Boolean = false;
         var value:Object = null;
         var cmp:int = 0;
         var n:int = expressions.length;
         for(var i:int = 0; i < n; i++)
         {
            expr = expressions[i];
            if(expr != "and")
            {
               parts = expr.split(":");
               key = parts[0];
               min = false;
               max = false;
               flex = false;
               if(key.indexOf("-flex-") == 0)
               {
                  flex = true;
                  key = key.substr(6);
               }
               if(key.indexOf("min-") == 0)
               {
                  min = true;
                  key = key.substr(4);
               }
               else if(key.indexOf("max-") == 0)
               {
                  max = true;
                  key = key.substr(4);
               }
               if(key.indexOf("-") > 0)
               {
                  key = this.deHyphenate(key,flex);
               }
               if(key == "deviceWidth")
               {
                  this.usesDeviceWidth = true;
               }
               else if(key == "deviceHeight")
               {
                  this.usesDeviceHeight = true;
               }
               else if(key == "flexDeviceDiagonal")
               {
                  this.usesDeviceDiagonal = true;
               }
               if(parts.length == 1)
               {
                  if(!(key in this))
                  {
                     return false;
                  }
               }
               if(parts.length == 2)
               {
                  if(!(key in this))
                  {
                     return false;
                  }
                  value = this.normalize(parts[1],this[key]);
                  cmp = this.compareValues(this[key],value);
                  if(min)
                  {
                     if(cmp < 0)
                     {
                        return false;
                     }
                  }
                  else if(max)
                  {
                     if(cmp > 0)
                     {
                        return false;
                     }
                  }
                  else if(cmp != 0)
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      private function normalize(s:String, currentValue:Object) : Object
      {
         var index:int = 0;
         var matches:Array = null;
         var unit:String = null;
         var refDPI:Number = NaN;
         if(s.charAt(0) == " ")
         {
            s = s.substr(1);
         }
         if(currentValue is Number)
         {
            index = s.indexOf("dpi");
            if(index != -1)
            {
               s = s.substr(0,index);
            }
            return Number(s);
         }
         if(currentValue is int)
         {
            return int(s);
         }
         if(s.indexOf("\"") == 0)
         {
            if(s.lastIndexOf("\"") == s.length - 1)
            {
               s = s.substr(1,s.length - 2);
            }
            else
            {
               s = s.substr(1);
            }
         }
         if(currentValue is String)
         {
            return s;
         }
         if(currentValue is CSSOSVersion)
         {
            return new CSSOSVersion(s);
         }
         if(currentValue is CSSDimension)
         {
            matches = s.match(/([\d\.]+)(in|cm|dp|pt|px|)$/);
            if(matches != null && matches.length == 3)
            {
               unit = matches[2];
               refDPI = unit == CSSDimension.UNIT_DP ? Number(this.applicationDpi) : Number(this.deviceDPI);
               return new CSSDimension(Number(matches[1]),refDPI,unit);
            }
            throw new Error("Unknown unit in css media query:" + s);
         }
         return s;
      }
      
      private function compareValues(currentValue:Object, testValue:Object) : int
      {
         if(currentValue is CSSOSVersion)
         {
            return CSSOSVersion(currentValue).compareTo(CSSOSVersion(testValue));
         }
         if(currentValue is CSSDimension)
         {
            return CSSDimension(currentValue).compareTo(CSSDimension(testValue));
         }
         if(currentValue == testValue)
         {
            return 0;
         }
         if(currentValue < testValue)
         {
            return -1;
         }
         return 1;
      }
      
      private function deHyphenate(s:String, flex:Boolean) : String
      {
         var part:String = null;
         var c:String = null;
         var i:int = s.indexOf("-");
         while(i > 0)
         {
            part = s.substr(i + 1);
            s = s.substr(0,i);
            c = part.charAt(0).toUpperCase();
            s += c + part.substr(1);
            i = s.indexOf("-");
         }
         if(flex)
         {
            c = s.charAt(0).toUpperCase();
            s = "flex" + c + s.substr(1);
         }
         return s;
      }
      
      private function getPlatform() : String
      {
         var s:String = Capabilities.version.substr(0,3);
         if(platformMap.hasOwnProperty(s))
         {
            return platformMap[s] as String;
         }
         return s.toLowerCase();
      }
      
      private function getOSVersion() : CSSOSVersion
      {
         return new CSSOSVersion(Platform.osVersion);
      }
      
      private function computeDeviceDimensions() : Boolean
      {
         var w:Number = NaN;
         var h:Number = NaN;
         var diag:Number = NaN;
         var needToUpdateStyles:Boolean = false;
         if(this.sm)
         {
            w = this.sm.stage.stageWidth;
            h = this.sm.stage.stageHeight;
            diag = Math.sqrt(w * w + h * h);
            needToUpdateStyles = this.usesDeviceWidth && w != this.deviceWidth.pixelValue || this.usesDeviceHeight && h != this.deviceHeight.pixelValue;
            this.deviceWidth = new CSSDimension(w,this.deviceDPI);
            this.deviceHeight = new CSSDimension(h,this.deviceDPI);
            this.flexDeviceDiagonal = new CSSDimension(diag,this.deviceDPI);
            return needToUpdateStyles;
         }
         return false;
      }
      
      private function stage_resizeHandler(event:Event) : void
      {
         if(this.computeDeviceDimensions())
         {
            this.goodQueries = {};
            this.badQueries = {};
            this.reinitApplicationStyles();
         }
      }
      
      private function reinitApplicationStyles() : void
      {
         var i:int = 0;
         var sm:ISystemManager = null;
         var cm:Object = null;
         var styleManager:IStyleManager2 = StyleManager.getStyleManager(this.sm);
         styleManager.stylesRoot = null;
         styleManager.initProtoChainRoots();
         var sms:Array = SystemManagerGlobals.topLevelSystemManagers;
         var n:int = sms.length;
         for(i = 0; i < n; i++)
         {
            sm = sms[i];
            cm = sm.getImplementation("mx.managers::ISystemManagerChildManager");
            cm.regenerateStyleCache(true);
         }
         for(i = 0; i < n; i++)
         {
            sm = sms[i];
            cm = sm.getImplementation("mx.managers::ISystemManagerChildManager");
            cm.notifyStyleChangeInChildren(null,true);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get deviceWidth() : CSSDimension
      {
         return this._1550605040deviceWidth;
      }
      
      public function set deviceWidth(param1:CSSDimension) : void
      {
         var _loc2_:Object = this._1550605040deviceWidth;
         if(_loc2_ !== param1)
         {
            this._1550605040deviceWidth = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"deviceWidth",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get deviceHeight() : CSSDimension
      {
         return this._1257110755deviceHeight;
      }
      
      public function set deviceHeight(param1:CSSDimension) : void
      {
         var _loc2_:Object = this._1257110755deviceHeight;
         if(_loc2_ !== param1)
         {
            this._1257110755deviceHeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"deviceHeight",_loc2_,param1));
            }
         }
      }
   }
}
