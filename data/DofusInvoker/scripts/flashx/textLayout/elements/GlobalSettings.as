package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class GlobalSettings
   {
      
      private static var _fontMapperFunction:Function;
      
      private static var _enableSearch:Boolean = true;
      
      private static var _resolveFontLookupFunction:Function;
      
      private static const resourceDict:Object = {
         "missingStringResource":"No string for resource {0}",
         "invalidFlowElementConstruct":"Attempted construct of invalid FlowElement subclass",
         "invalidSplitAtPosition":"Invalid parameter to splitAtPosition",
         "badMXMLChildrenArgument":"Bad element of type {0} passed to mxmlChildren",
         "badReplaceChildrenIndex":"Out of range index to FlowGroupElement.replaceChildren",
         "invalidChildType":"NewElement not of a type that this can be parent of",
         "badRemoveChild":"Child to remove not found",
         "invalidSplitAtIndex":"Invalid parameter to splitAtIndex",
         "badShallowCopyRange":"Bad range in shallowCopy",
         "badSurrogatePairCopy":"Copying only half of a surrogate pair in SpanElement.shallowCopy",
         "invalidReplaceTextPositions":"Invalid positions passed to SpanElement.replaceText",
         "invalidSurrogatePairSplit":"Invalid splitting of a surrogate pair",
         "badPropertyValue":"Property {0} value {1} is out of range",
         "illegalOperation":"Illegal attempt to execute {0} operation",
         "unexpectedXMLElementInSpan":"Unexpected element {0} within a span",
         "unexpectedNamespace":"Unexpected namespace {0}",
         "unknownElement":"Unknown element {0}",
         "unknownAttribute":"Attribute {0} not permitted in element {1}",
         "malformedTag":"Malformed tag {0}",
         "malformedMarkup":"Malformed markup {0}",
         "missingTextFlow":"No TextFlow to parse",
         "expectedExactlyOneTextLayoutFormat":"Expected one and only one TextLayoutFormat in {0}",
         "expectedExactlyOneListMarkerFormat":"Expected one and only one ListMarkerFormat in {0}",
         "unsupportedVersion":"Version {0} is unsupported",
         "unsupportedProperty":"Property {0} is unsupported"
      };
      
      private static var _resourceStringFunction:Function = tlf_internal::defaultResourceStringFunction;
      
      private static var _enableDefaultTabStops:Boolean = false;
      
      private static var _alwaysCalculateWhitespaceBounds:Boolean = false;
       
      
      public function GlobalSettings()
      {
         super();
      }
      
      public static function get fontMapperFunction() : Function
      {
         return _fontMapperFunction;
      }
      
      public static function set fontMapperFunction(val:Function) : void
      {
         _fontMapperFunction = val;
      }
      
      public static function get enableSearch() : Boolean
      {
         return _enableSearch;
      }
      
      public static function set enableSearch(value:Boolean) : void
      {
         _enableSearch = value;
      }
      
      public static function get resolveFontLookupFunction() : Function
      {
         return _resolveFontLookupFunction;
      }
      
      public static function set resolveFontLookupFunction(val:Function) : void
      {
         _resolveFontLookupFunction = val;
      }
      
      public static function get resourceStringFunction() : Function
      {
         return _resourceStringFunction;
      }
      
      public static function set resourceStringFunction(val:Function) : void
      {
         _resourceStringFunction = val;
      }
      
      tlf_internal static function defaultResourceStringFunction(resourceName:String, parameters:Array = null) : String
      {
         var value:String = String(resourceDict[resourceName]);
         if(value == null)
         {
            value = String(resourceDict["missingStringResource"]);
            parameters = [resourceName];
         }
         if(parameters)
         {
            value = substitute(value,parameters);
         }
         return value;
      }
      
      tlf_internal static function substitute(str:String, ... rest) : String
      {
         var args:Array = null;
         if(str == null)
         {
            return "";
         }
         var len:uint = rest.length;
         if(len == 1 && rest[0] is Array)
         {
            args = rest[0] as Array;
            len = args.length;
         }
         else
         {
            args = rest;
         }
         for(var i:int = 0; i < len; i++)
         {
            str = str.replace(new RegExp("\\{" + i + "\\}","g"),args[i]);
         }
         return str;
      }
      
      tlf_internal static function get enableDefaultTabStops() : Boolean
      {
         return _enableDefaultTabStops;
      }
      
      tlf_internal static function set enableDefaultTabStops(val:Boolean) : void
      {
         _enableDefaultTabStops = val;
      }
      
      tlf_internal static function get alwaysCalculateWhitespaceBounds() : Boolean
      {
         return _alwaysCalculateWhitespaceBounds;
      }
      
      tlf_internal static function set alwaysCalculateWhitespaceBounds(val:Boolean) : void
      {
         _alwaysCalculateWhitespaceBounds = val;
      }
   }
}
