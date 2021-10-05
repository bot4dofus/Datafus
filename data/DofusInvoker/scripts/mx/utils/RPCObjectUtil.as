package mx.utils
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLNode;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class RPCObjectUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var defaultToStringExcludes:Array = ["password","credentials"];
      
      private static var _externalToString:Function = null;
      
      private static var refCount:int = 0;
      
      private static var CLASS_INFO_CACHE:Object = {};
       
      
      public function RPCObjectUtil()
      {
         super();
      }
      
      public static function setToStringExcludes(excludes:Array) : void
      {
         defaultToStringExcludes = excludes;
      }
      
      public static function externalToString(value:Function) : void
      {
         _externalToString = value;
      }
      
      public static function toString(value:Object, namespaceURIs:Array = null, exclude:Array = null) : String
      {
         if(exclude == null)
         {
            exclude = defaultToStringExcludes;
         }
         refCount = 0;
         if(_externalToString != null)
         {
            return _externalToString(value,namespaceURIs,exclude);
         }
         return internalToString(value,0,null,namespaceURIs,exclude);
      }
      
      private static function internalToString(value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String
      {
         var str:String = null;
         var classInfo:Object = null;
         var properties:Array = null;
         var id:Object = null;
         var isArray:Boolean = false;
         var prop:* = undefined;
         var length:int = 0;
         var j:int = 0;
         var type:String = value == null ? "null" : typeof value;
         switch(type)
         {
            case "boolean":
            case "number":
               return value.toString();
            case "string":
               return "\"" + value.toString() + "\"";
            case "object":
               if(value is Date)
               {
                  return value.toString();
               }
               if(value is XMLNode)
               {
                  return value.toString();
               }
               if(value is Class)
               {
                  return "(" + getQualifiedClassName(value) + ")";
               }
               classInfo = getClassInfo(value,exclude,{
                  "includeReadOnly":true,
                  "uris":namespaceURIs,
                  "includeTransient":false
               });
               properties = classInfo.properties;
               str = "(" + classInfo.name + ")";
               if(refs == null)
               {
                  var refs:Dictionary = new Dictionary(true);
               }
               id = refs[value];
               if(id != null)
               {
                  str += "#" + int(id);
                  return str;
               }
               if(value != null)
               {
                  str += "#" + refCount.toString();
                  refs[value] = refCount;
                  ++refCount;
               }
               isArray = value is Array;
               var indent:int = indent + 2;
               length = properties.length;
               for(j = 0; j < length; j++)
               {
                  str = newline(str,indent);
                  prop = properties[j];
                  if(isArray)
                  {
                     str += "[";
                  }
                  str += prop.toString();
                  if(isArray)
                  {
                     str += "] ";
                  }
                  else
                  {
                     str += " = ";
                  }
                  try
                  {
                     str += internalToString(value[prop],indent,refs,namespaceURIs,exclude);
                  }
                  catch(e:Error)
                  {
                     str += "?";
                  }
               }
               indent -= 2;
               return str;
               break;
            case "xml":
               return value.toString();
            default:
               return "(" + type + ")";
         }
      }
      
      private static function newline(str:String, length:int = 0) : String
      {
         var result:* = str + "\n";
         for(var i:int = 0; i < length; i++)
         {
            result += " ";
         }
         return result;
      }
      
      public static function getClassInfo(obj:Object, excludes:Array = null, options:Object = null) : Object
      {
         var length:int = 0;
         var i:int = 0;
         var result:Object = null;
         var cacheKey:String = null;
         var className:String = null;
         var classAlias:String = null;
         var properties:XMLList = null;
         var prop:XML = null;
         var metadataInfo:Object = null;
         var classInfo:XML = null;
         var numericIndex:Boolean = false;
         var p:String = null;
         var pi:Number = NaN;
         var uris:Array = null;
         var uri:String = null;
         var qName:QName = null;
         var includeTransients:Boolean = false;
         var j:int = 0;
         if(options == null)
         {
            var options:Object = {
               "includeReadOnly":true,
               "uris":null,
               "includeTransient":true
            };
         }
         var propertyNames:Array = [];
         var dynamic:Boolean = false;
         if(typeof obj == "xml")
         {
            className = "XML";
            properties = obj.text();
            if(properties.length())
            {
               propertyNames.push("*");
            }
            properties = obj.attributes();
         }
         else
         {
            classInfo = describeType(obj);
            className = classInfo.@name.toString();
            classAlias = classInfo.@alias.toString();
            dynamic = classInfo.@isDynamic.toString() == "true";
            if(options.includeReadOnly)
            {
               properties = classInfo..accessor.(@access != "writeonly") + classInfo..variable;
            }
            else
            {
               properties = classInfo..accessor.(@access == "readwrite") + classInfo..variable;
            }
            numericIndex = false;
         }
         if(!dynamic)
         {
            cacheKey = getCacheKey(obj,excludes,options);
            result = CLASS_INFO_CACHE[cacheKey];
            if(result != null)
            {
               return result;
            }
         }
         result = {};
         result["name"] = className;
         result["alias"] = classAlias;
         result["properties"] = propertyNames;
         result["dynamic"] = dynamic;
         result["metadata"] = metadataInfo = recordMetadata(properties);
         var excludeObject:Object = {};
         if(excludes)
         {
            length = excludes.length;
            for(i = 0; i < length; i++)
            {
               excludeObject[excludes[i]] = 1;
            }
         }
         var isArray:Boolean = className == "Array";
         if(dynamic)
         {
            for(p in obj)
            {
               if(excludeObject[p] != 1)
               {
                  if(isArray)
                  {
                     pi = parseInt(p);
                     if(isNaN(pi))
                     {
                        propertyNames.push(new QName("",p));
                     }
                     else
                     {
                        propertyNames.push(pi);
                     }
                  }
                  else
                  {
                     propertyNames.push(new QName("",p));
                  }
               }
            }
            numericIndex = isArray && !isNaN(Number(p));
         }
         if(!(className == "Object" || isArray))
         {
            if(className == "XML")
            {
               length = properties.length();
               for(i = 0; i < length; i++)
               {
                  p = properties[i].name();
                  if(excludeObject[p] != 1)
                  {
                     propertyNames.push(new QName("","@" + p));
                  }
               }
            }
            else
            {
               length = properties.length();
               uris = options.uris;
               includeTransients = options.hasOwnProperty("includeTransient") && options.includeTransient;
               for(i = 0; i < length; i++)
               {
                  prop = properties[i];
                  p = prop.@name.toString();
                  uri = prop.@uri.toString();
                  if(excludeObject[p] != 1)
                  {
                     if(!(!includeTransients && internalHasMetadata(metadataInfo,p,"Transient")))
                     {
                        if(uris != null)
                        {
                           if(uris.length == 1 && uris[0] == "*")
                           {
                              qName = new QName(uri,p);
                              try
                              {
                                 obj[qName];
                                 propertyNames.push();
                              }
                              catch(e:Error)
                              {
                              }
                           }
                           else
                           {
                              for(j = 0; j < uris.length; j++)
                              {
                                 uri = uris[j];
                                 if(prop.@uri.toString() == uri)
                                 {
                                    qName = new QName(uri,p);
                                    try
                                    {
                                       obj[qName];
                                       propertyNames.push(qName);
                                    }
                                    catch(e:Error)
                                    {
                                    }
                                 }
                              }
                           }
                        }
                        else if(uri.length == 0)
                        {
                           qName = new QName(uri,p);
                           try
                           {
                              obj[qName];
                              propertyNames.push(qName);
                           }
                           catch(e:Error)
                           {
                           }
                        }
                     }
                  }
               }
            }
         }
         propertyNames.sort(Array.CASEINSENSITIVE | (!!numericIndex ? Array.NUMERIC : 0));
         length = propertyNames.length;
         for(i = 0; i < length - 1; i++)
         {
            if(propertyNames[i].toString() == propertyNames[i + 1].toString())
            {
               propertyNames.splice(i,1);
               i--;
            }
         }
         if(!dynamic)
         {
            cacheKey = getCacheKey(obj,excludes,options);
            CLASS_INFO_CACHE[cacheKey] = result;
         }
         return result;
      }
      
      private static function internalHasMetadata(metadataInfo:Object, propName:String, metadataName:String) : Boolean
      {
         var metadata:Object = null;
         if(metadataInfo != null)
         {
            metadata = metadataInfo[propName];
            if(metadata != null)
            {
               if(metadata[metadataName] != null)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private static function recordMetadata(properties:XMLList) : Object
      {
         var prop:XML = null;
         var propName:String = null;
         var metadataList:XMLList = null;
         var metadata:Object = null;
         var md:XML = null;
         var mdName:String = null;
         var argsList:XMLList = null;
         var value:Object = null;
         var arg:XML = null;
         var existing:Object = null;
         var argKey:String = null;
         var argValue:String = null;
         var existingArray:Array = null;
         var result:Object = null;
         try
         {
            for each(prop in properties)
            {
               propName = prop.attribute("name").toString();
               metadataList = prop.metadata;
               if(metadataList.length() > 0)
               {
                  if(result == null)
                  {
                     result = {};
                  }
                  metadata = {};
                  result[propName] = metadata;
                  for each(md in metadataList)
                  {
                     mdName = md.attribute("name").toString();
                     argsList = md.arg;
                     value = {};
                     for each(arg in argsList)
                     {
                        argKey = arg.attribute("key").toString();
                        if(argKey != null)
                        {
                           argValue = arg.attribute("value").toString();
                           value[argKey] = argValue;
                        }
                     }
                     existing = metadata[mdName];
                     if(existing != null)
                     {
                        if(existing is Array)
                        {
                           existingArray = existing as Array;
                        }
                        else
                        {
                           existingArray = [];
                        }
                        existingArray.push(value);
                        existing = existingArray;
                     }
                     else
                     {
                        existing = value;
                     }
                     metadata[mdName] = existing;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
         return result;
      }
      
      private static function getCacheKey(o:Object, excludes:Array = null, options:Object = null) : String
      {
         var length:int = 0;
         var i:uint = 0;
         var excl:String = null;
         var flag:* = null;
         var value:String = null;
         var key:String = getQualifiedClassName(o);
         if(excludes != null)
         {
            length = excludes.length;
            for(i = 0; i < length; i++)
            {
               excl = excludes[i] as String;
               if(excl != null)
               {
                  key += excl;
               }
            }
         }
         if(options != null)
         {
            for(flag in options)
            {
               key += flag;
               value = options[flag];
               if(value != null)
               {
                  key += value.toString();
               }
            }
         }
         return key;
      }
   }
}
