package mx.utils
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLNode;
   import mx.collections.IList;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ObjectUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var defaultToStringExcludes:Array = ["password","credentials"];
      
      private static var refCount:int = 0;
      
      private static var CLASS_INFO_CACHE:Object = {};
       
      
      public function ObjectUtil()
      {
         super();
      }
      
      public static function compare(a:Object, b:Object, depth:int = -1) : int
      {
         return internalCompare(a,b,0,depth,new Dictionary(true));
      }
      
      public static function copy(value:Object) : Object
      {
         var buffer:ByteArray = new ByteArray();
         buffer.writeObject(value);
         buffer.position = 0;
         return buffer.readObject();
      }
      
      public static function clone(value:Object) : Object
      {
         var result:Object = copy(value);
         cloneInternal(result,value);
         return result;
      }
      
      private static function cloneInternal(result:Object, value:Object) : void
      {
         var v:Object = null;
         var p:* = undefined;
         if(value && value.hasOwnProperty("uid"))
         {
            result.uid = value.uid;
         }
         var classInfo:Object = getClassInfo(value);
         for each(p in classInfo.properties)
         {
            v = value[p];
            if(v && v.hasOwnProperty("uid"))
            {
               cloneInternal(result[p],v);
            }
         }
      }
      
      public static function isSimple(value:Object) : Boolean
      {
         var objectType:* = typeof value;
         switch(objectType)
         {
            case "number":
            case "string":
            case "boolean":
               return true;
            case "object":
               return value is Date || value is Array;
            default:
               return false;
         }
      }
      
      public static function numericCompare(a:Number, b:Number) : int
      {
         if(isNaN(a) && isNaN(b))
         {
            return 0;
         }
         if(isNaN(a))
         {
            return 1;
         }
         if(isNaN(b))
         {
            return -1;
         }
         if(a < b)
         {
            return -1;
         }
         if(a > b)
         {
            return 1;
         }
         return 0;
      }
      
      public static function stringCompare(a:String, b:String, caseInsensitive:Boolean = false) : int
      {
         if(a == null && b == null)
         {
            return 0;
         }
         if(a == null)
         {
            return 1;
         }
         if(b == null)
         {
            return -1;
         }
         if(caseInsensitive)
         {
            a = a.toLocaleLowerCase();
            b = b.toLocaleLowerCase();
         }
         var result:int = a.localeCompare(b);
         if(result < -1)
         {
            result = -1;
         }
         else if(result > 1)
         {
            result = 1;
         }
         return result;
      }
      
      public static function dateCompare(a:Date, b:Date) : int
      {
         if(a == null && b == null)
         {
            return 0;
         }
         if(a == null)
         {
            return 1;
         }
         if(b == null)
         {
            return -1;
         }
         var na:Number = a.getTime();
         var nb:Number = b.getTime();
         if(na < nb)
         {
            return -1;
         }
         if(na > nb)
         {
            return 1;
         }
         if(isNaN(na) && isNaN(nb))
         {
            return 0;
         }
         if(isNaN(na))
         {
            return 1;
         }
         if(isNaN(nb))
         {
            return -1;
         }
         return 0;
      }
      
      public static function toString(value:Object, namespaceURIs:Array = null, exclude:Array = null) : String
      {
         if(exclude == null)
         {
            exclude = defaultToStringExcludes;
         }
         refCount = 0;
         return internalToString(value,0,null,namespaceURIs,exclude);
      }
      
      private static function internalToString(value:Object, indent:int = 0, refs:Dictionary = null, namespaceURIs:Array = null, exclude:Array = null) : String
      {
         var str:String = null;
         var classInfo:Object = null;
         var properties:Array = null;
         var isArray:Boolean = false;
         var isDict:Boolean = false;
         var prop:* = undefined;
         var j:int = 0;
         var id:Object = null;
         var objectType:String = value == null ? "null" : typeof value;
         switch(objectType)
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
                  "uris":namespaceURIs
               });
               properties = classInfo.properties;
               str = "(" + classInfo.name + ")";
               if(refs == null)
               {
                  var refs:Dictionary = new Dictionary(true);
               }
               try
               {
                  id = refs[value];
                  if(id != null)
                  {
                     str += "#" + int(id);
                     return str;
                  }
               }
               catch(e:Error)
               {
                  return String(value);
               }
               if(value != null)
               {
                  str += "#" + refCount.toString();
                  refs[value] = refCount;
                  ++refCount;
               }
               isArray = value is Array;
               isDict = value is Dictionary;
               var indent:int = indent + 2;
               for(j = 0; j < properties.length; j++)
               {
                  str = newline(str,indent);
                  prop = properties[j];
                  if(isArray)
                  {
                     str += "[";
                  }
                  else if(isDict)
                  {
                     str += "{";
                  }
                  if(isDict)
                  {
                     str += internalToString(prop,indent,refs,namespaceURIs,exclude);
                  }
                  else
                  {
                     str += prop.toString();
                  }
                  if(isArray)
                  {
                     str += "] ";
                  }
                  else if(isDict)
                  {
                     str += "} = ";
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
               return value.toXMLString();
            default:
               return "(" + objectType + ")";
         }
      }
      
      private static function newline(str:String, n:int = 0) : String
      {
         var result:* = str;
         result += "\n";
         for(var i:int = 0; i < n; i++)
         {
            result += " ";
         }
         return result;
      }
      
      private static function internalCompare(a:Object, b:Object, currentDepth:int, desiredDepth:int, refs:Dictionary) : int
      {
         var newDepth:int = 0;
         var aRef:Object = null;
         var bRef:Object = null;
         var aProps:Array = null;
         var bProps:Array = null;
         var isObjectDynamic:Boolean = false;
         var propName:QName = null;
         var aProp:Object = null;
         var bProp:Object = null;
         var i:int = 0;
         if(a == null && b == null)
         {
            return 0;
         }
         if(a == null)
         {
            return 1;
         }
         if(b == null)
         {
            return -1;
         }
         if(a is ObjectProxy)
         {
            a = ObjectProxy(a).object_proxy::object;
         }
         if(b is ObjectProxy)
         {
            b = ObjectProxy(b).object_proxy::object;
         }
         var typeOfA:* = typeof a;
         var typeOfB:* = typeof b;
         var result:int = 0;
         if(typeOfA == typeOfB)
         {
            switch(typeOfA)
            {
               case "boolean":
                  result = numericCompare(Number(a),Number(b));
                  break;
               case "number":
                  result = numericCompare(a as Number,b as Number);
                  break;
               case "string":
                  result = stringCompare(a as String,b as String);
                  break;
               case "object":
                  newDepth = desiredDepth > 0 ? int(desiredDepth - 1) : int(desiredDepth);
                  aRef = getRef(a,refs);
                  bRef = getRef(b,refs);
                  if(aRef == bRef)
                  {
                     return 0;
                  }
                  refs[bRef] = aRef;
                  if(desiredDepth != -1 && currentDepth > desiredDepth)
                  {
                     result = stringCompare(a.toString(),b.toString());
                  }
                  else if(a is Array && b is Array)
                  {
                     result = arrayCompare(a as Array,b as Array,currentDepth,desiredDepth,refs);
                  }
                  else if(a is Date && b is Date)
                  {
                     result = dateCompare(a as Date,b as Date);
                  }
                  else if(a is IList && b is IList)
                  {
                     result = listCompare(a as IList,b as IList,currentDepth,desiredDepth,refs);
                  }
                  else if(a is ByteArray && b is ByteArray)
                  {
                     result = byteArrayCompare(a as ByteArray,b as ByteArray);
                  }
                  else
                  {
                     if(getQualifiedClassName(a) != getQualifiedClassName(b))
                     {
                        return 1;
                     }
                     aProps = getClassInfo(a).properties;
                     isObjectDynamic = isDynamicObject(a);
                     if(isObjectDynamic)
                     {
                        bProps = getClassInfo(b).properties;
                        result = arrayCompare(aProps,bProps,currentDepth,newDepth,refs);
                        if(result != 0)
                        {
                           return result;
                        }
                     }
                     for(i = 0; i < aProps.length; i++)
                     {
                        propName = aProps[i];
                        aProp = a[propName];
                        bProp = b[propName];
                        result = internalCompare(aProp,bProp,currentDepth + 1,newDepth,refs);
                        if(result != 0)
                        {
                           return result;
                        }
                     }
                  }
                  break;
            }
            return result;
         }
         return stringCompare(typeOfA,typeOfB);
      }
      
      public static function getClassInfo(obj:Object, excludes:Array = null, options:Object = null) : Object
      {
         var n:int = 0;
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
         var key:* = undefined;
         var p:String = null;
         var pi:Number = NaN;
         var uris:Array = null;
         var uri:String = null;
         var qName:QName = null;
         var j:int = 0;
         if(obj is ObjectProxy)
         {
            var obj:Object = ObjectProxy(obj).object_proxy::object;
         }
         if(options == null)
         {
            var options:Object = {
               "includeReadOnly":true,
               "uris":null,
               "includeTransient":true
            };
         }
         var propertyNames:Array = [];
         var isDynamic:Boolean = false;
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
            classInfo = DescribeTypeCache.describeType(obj).typeDescription;
            className = classInfo.@name.toString();
            classAlias = classInfo.@alias.toString();
            isDynamic = classInfo.@isDynamic.toString() == "true";
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
         if(!isDynamic)
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
         result["dynamic"] = isDynamic;
         result["metadata"] = metadataInfo = recordMetadata(properties);
         var excludeObject:Object = {};
         if(excludes)
         {
            n = excludes.length;
            for(i = 0; i < n; i++)
            {
               excludeObject[excludes[i]] = 1;
            }
         }
         var isArray:Boolean = obj is Array;
         var isDict:Boolean = obj is Dictionary;
         if(isDict)
         {
            for(key in obj)
            {
               propertyNames.push(key);
            }
         }
         else if(isDynamic)
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
         if(!(isArray || isDict || className == "Object"))
         {
            if(className == "XML")
            {
               n = properties.length();
               for(i = 0; i < n; i++)
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
               n = properties.length();
               uris = options.uris;
               for(i = 0; i < n; i++)
               {
                  prop = properties[i];
                  p = prop.@name.toString();
                  uri = prop.@uri.toString();
                  if(excludeObject[p] != 1)
                  {
                     if(!(!options.includeTransient && internalHasMetadata(metadataInfo,p,"Transient")))
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
         if(!isDict)
         {
            for(i = 0; i < propertyNames.length - 1; i++)
            {
               if(propertyNames[i].toString() == propertyNames[i + 1].toString())
               {
                  propertyNames.splice(i,1);
                  i--;
               }
            }
         }
         if(!isDynamic && className != "XML")
         {
            cacheKey = getCacheKey(obj,excludes,options);
            CLASS_INFO_CACHE[cacheKey] = result;
         }
         return result;
      }
      
      public static function hasMetadata(obj:Object, propName:String, metadataName:String, excludes:Array = null, options:Object = null) : Boolean
      {
         var classInfo:Object = getClassInfo(obj,excludes,options);
         var metadataInfo:Object = classInfo["metadata"];
         return internalHasMetadata(metadataInfo,propName,metadataName);
      }
      
      public static function isDynamicObject(object:Object) : Boolean
      {
         try
         {
            object["wootHackwoot"];
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public static function getEnumerableProperties(object:Object) : Array
      {
         var property:* = null;
         var result:Array = [];
         if(!isDynamicObject(object))
         {
            return result;
         }
         for(property in object)
         {
            result.push(property);
         }
         return result;
      }
      
      public static function valuesAreSubsetOfObject(values:Object, object:Object) : Boolean
      {
         var property:String = null;
         if(!object && !values)
         {
            return true;
         }
         if(!object || !values)
         {
            return false;
         }
         if(object === values)
         {
            return true;
         }
         var enumerableProperties:Array = ObjectUtil.getEnumerableProperties(values);
         var matches:Boolean = enumerableProperties.length > 0 || ObjectUtil.isDynamicObject(values);
         for each(property in enumerableProperties)
         {
            if(!object.hasOwnProperty(property) || object[property] != values[property])
            {
               matches = false;
               break;
            }
         }
         return matches;
      }
      
      public static function getValue(obj:Object, path:Array) : *
      {
         if(!obj)
         {
            return undefined;
         }
         if(!path || !path.length)
         {
            return obj;
         }
         var result:* = obj;
         var i:int = -1;
         while(++i < path.length && result)
         {
            result = !!result.hasOwnProperty(path[i]) ? result[path[i]] : undefined;
         }
         return result;
      }
      
      public static function setValue(obj:Object, path:Array, newValue:*) : Boolean
      {
         if(!obj || !path || !path.length)
         {
            return false;
         }
         var secondToLastLink:* = getValue(obj,path.slice(0,-1));
         if(secondToLastLink && secondToLastLink.hasOwnProperty(path[path.length - 1]))
         {
            secondToLastLink[path[path.length - 1]] = newValue;
            return true;
         }
         return false;
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
                           existingArray = [existing];
                           delete metadata[mdName];
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
      
      private static function arrayCompare(a:Array, b:Array, currentDepth:int, desiredDepth:int, refs:Dictionary) : int
      {
         var key:* = null;
         var result:int = 0;
         if(a.length != b.length)
         {
            if(a.length < b.length)
            {
               result = -1;
            }
            else
            {
               result = 1;
            }
         }
         else
         {
            for(key in a)
            {
               if(!b.hasOwnProperty(key))
               {
                  return -1;
               }
               result = internalCompare(a[key],b[key],currentDepth,desiredDepth,refs);
               if(result != 0)
               {
                  return result;
               }
            }
            for(key in b)
            {
               if(!a.hasOwnProperty(key))
               {
                  return 1;
               }
            }
         }
         return result;
      }
      
      private static function byteArrayCompare(a:ByteArray, b:ByteArray) : int
      {
         var i:int = 0;
         var result:int = 0;
         if(a == b)
         {
            return result;
         }
         if(a.length != b.length)
         {
            if(a.length < b.length)
            {
               result = -1;
            }
            else
            {
               result = 1;
            }
         }
         else
         {
            for(i = 0; i < a.length; i++)
            {
               result = numericCompare(a[i],b[i]);
               if(result != 0)
               {
                  i = a.length;
               }
            }
         }
         return result;
      }
      
      private static function listCompare(a:IList, b:IList, currentDepth:int, desiredDepth:int, refs:Dictionary) : int
      {
         var i:int = 0;
         var result:int = 0;
         if(a.length != b.length)
         {
            if(a.length < b.length)
            {
               result = -1;
            }
            else
            {
               result = 1;
            }
         }
         else
         {
            for(i = 0; i < a.length; i++)
            {
               result = internalCompare(a.getItemAt(i),b.getItemAt(i),currentDepth + 1,desiredDepth,refs);
               if(result != 0)
               {
                  i = a.length;
               }
            }
         }
         return result;
      }
      
      private static function getRef(o:Object, refs:Dictionary) : Object
      {
         var oRef:Object = refs[o];
         while(oRef && oRef != refs[oRef])
         {
            oRef = refs[oRef];
         }
         if(!oRef)
         {
            oRef = o;
         }
         if(oRef != refs[o])
         {
            refs[o] = oRef;
         }
         return oRef;
      }
   }
}
