package mx.utils
{
   import mx.messaging.config.LoaderConfig;
   
   public class URLUtil
   {
      
      private static const SQUARE_BRACKET_LEFT:String = "]";
      
      private static const SQUARE_BRACKET_RIGHT:String = "[";
      
      private static const SQUARE_BRACKET_LEFT_ENCODED:String = encodeURIComponent(SQUARE_BRACKET_LEFT);
      
      private static const SQUARE_BRACKET_RIGHT_ENCODED:String = encodeURIComponent(SQUARE_BRACKET_RIGHT);
      
      public static const SERVER_NAME_TOKEN:String = "{server.name}";
      
      public static const SERVER_PORT_TOKEN:String = "{server.port}";
      
      private static const SERVER_NAME_REGEX:RegExp = /\{server.name\}/g;
      
      private static const SERVER_PORT_REGEX:RegExp = /\{server.port\}/g;
       
      
      public function URLUtil()
      {
         super();
      }
      
      public static function getServerNameWithPort(url:String) : String
      {
         var start:int = url.indexOf("/") + 2;
         var length:int = url.indexOf("/",start);
         return length == -1 ? url.substring(start) : url.substring(start,length);
      }
      
      public static function getServerName(url:String) : String
      {
         var sp:String = getServerNameWithPort(url);
         var delim:int = URLUtil.indexOfLeftSquareBracket(sp);
         delim = delim > -1 ? int(sp.indexOf(":",delim)) : int(sp.indexOf(":"));
         if(delim > 0)
         {
            sp = sp.substring(0,delim);
         }
         return sp;
      }
      
      public static function getPort(url:String) : uint
      {
         var p:Number = NaN;
         var sp:String = getServerNameWithPort(url);
         var delim:int = URLUtil.indexOfLeftSquareBracket(sp);
         delim = delim > -1 ? int(sp.indexOf(":",delim)) : int(sp.indexOf(":"));
         var port:uint = 0;
         if(delim > 0)
         {
            p = Number(sp.substring(delim + 1));
            if(!isNaN(p))
            {
               port = int(p);
            }
         }
         return port;
      }
      
      public static function getFullURL(rootURL:String, url:String) : String
      {
         var slashPos:Number = NaN;
         if(url != null && !URLUtil.isHttpURL(url))
         {
            if(url.indexOf("./") == 0)
            {
               url = url.substring(2);
            }
            if(URLUtil.isHttpURL(rootURL))
            {
               if(url.charAt(0) == "/")
               {
                  slashPos = rootURL.indexOf("/",8);
                  if(slashPos == -1)
                  {
                     slashPos = rootURL.length;
                  }
               }
               else
               {
                  slashPos = rootURL.lastIndexOf("/") + 1;
                  if(slashPos <= 8)
                  {
                     rootURL += "/";
                     slashPos = rootURL.length;
                  }
               }
               if(slashPos > 0)
               {
                  url = rootURL.substring(0,slashPos) + url;
               }
            }
         }
         return url;
      }
      
      public static function isHttpURL(url:String) : Boolean
      {
         return url != null && (url.indexOf("http://") == 0 || url.indexOf("https://") == 0);
      }
      
      public static function isHttpsURL(url:String) : Boolean
      {
         return url != null && url.indexOf("https://") == 0;
      }
      
      public static function getProtocol(url:String) : String
      {
         var slash:int = url.indexOf("/");
         var indx:int = url.indexOf(":/");
         if(indx > -1 && indx < slash)
         {
            return url.substring(0,indx);
         }
         indx = url.indexOf("::");
         if(indx > -1 && indx < slash)
         {
            return url.substring(0,indx);
         }
         return "";
      }
      
      public static function replaceProtocol(uri:String, newProtocol:String) : String
      {
         return uri.replace(getProtocol(uri),newProtocol);
      }
      
      public static function replacePort(uri:String, newPort:uint) : String
      {
         var portEnd:int = 0;
         var result:String = "";
         var indx:int = uri.indexOf("]");
         if(indx == -1)
         {
            indx = uri.indexOf(":");
         }
         var portStart:int = uri.indexOf(":",indx + 1);
         if(portStart > -1)
         {
            portStart++;
            portEnd = uri.indexOf("/",portStart);
            result = uri.substring(0,portStart) + newPort.toString() + uri.substring(portEnd,uri.length);
         }
         else
         {
            portEnd = uri.indexOf("/",indx);
            if(portEnd > -1)
            {
               if(uri.charAt(portEnd + 1) == "/")
               {
                  portEnd = uri.indexOf("/",portEnd + 2);
               }
               if(portEnd > 0)
               {
                  result = uri.substring(0,portEnd) + ":" + newPort.toString() + uri.substring(portEnd,uri.length);
               }
               else
               {
                  result = uri + ":" + newPort.toString();
               }
            }
            else
            {
               result = uri + ":" + newPort.toString();
            }
         }
         return result;
      }
      
      public static function replaceTokens(url:String) : String
      {
         var loaderProtocol:String = null;
         var loaderServerName:String = null;
         var loaderPort:uint = 0;
         var loaderURL:String = LoaderConfig.url == null ? "" : LoaderConfig.url;
         if(url.indexOf(SERVER_NAME_TOKEN) > 0)
         {
            loaderURL = URLUtil.replaceEncodedSquareBrackets(loaderURL);
            loaderProtocol = URLUtil.getProtocol(loaderURL);
            loaderServerName = "localhost";
            if(loaderProtocol.toLowerCase() != "file")
            {
               loaderServerName = URLUtil.getServerName(loaderURL);
            }
            url = url.replace(SERVER_NAME_REGEX,loaderServerName);
         }
         var portToken:int = url.indexOf(SERVER_PORT_TOKEN);
         if(portToken > 0)
         {
            loaderPort = URLUtil.getPort(loaderURL);
            if(loaderPort > 0)
            {
               url = url.replace(SERVER_PORT_REGEX,loaderPort);
            }
            else
            {
               if(url.charAt(portToken - 1) == ":")
               {
                  url = url.substring(0,portToken - 1) + url.substring(portToken);
               }
               url = url.replace(SERVER_PORT_REGEX,"");
            }
         }
         return url;
      }
      
      public static function urisEqual(uri1:String, uri2:String) : Boolean
      {
         if(uri1 != null && uri2 != null)
         {
            uri1 = StringUtil.trim(uri1).toLowerCase();
            uri2 = StringUtil.trim(uri2).toLowerCase();
            if(uri1.charAt(uri1.length - 1) != "/")
            {
               uri1 += "/";
            }
            if(uri2.charAt(uri2.length - 1) != "/")
            {
               uri2 += "/";
            }
         }
         return uri1 == uri2;
      }
      
      public static function hasTokens(url:String) : Boolean
      {
         if(url == null || url == "")
         {
            return false;
         }
         if(url.indexOf(SERVER_NAME_TOKEN) > 0)
         {
            return true;
         }
         if(url.indexOf(SERVER_PORT_TOKEN) > 0)
         {
            return true;
         }
         return false;
      }
      
      public static function hasUnresolvableTokens() : Boolean
      {
         return LoaderConfig.url != null;
      }
      
      public static function objectToString(object:Object, separator:String = ";", encodeURL:Boolean = true) : String
      {
         return internalObjectToString(object,separator,null,encodeURL);
      }
      
      private static function indexOfLeftSquareBracket(value:String) : int
      {
         var delim:int = value.indexOf(SQUARE_BRACKET_LEFT);
         if(delim == -1)
         {
            delim = value.indexOf(SQUARE_BRACKET_LEFT_ENCODED);
         }
         return delim;
      }
      
      private static function internalObjectToString(object:Object, separator:String, prefix:String, encodeURL:Boolean) : String
      {
         var p:* = null;
         var value:Object = null;
         var name:String = null;
         var s:String = "";
         var first:Boolean = true;
         for(p in object)
         {
            if(first)
            {
               first = false;
            }
            else
            {
               s += separator;
            }
            value = object[p];
            name = !!prefix ? prefix + "." + p : p;
            if(encodeURL)
            {
               name = encodeURIComponent(name);
            }
            if(value is String)
            {
               s += name + "=" + (!!encodeURL ? encodeURIComponent(value as String) : value);
            }
            else if(value is Number)
            {
               value = value.toString();
               if(encodeURL)
               {
                  value = encodeURIComponent(value as String);
               }
               s += name + "=" + value;
            }
            else if(value is Boolean)
            {
               s += name + "=" + (!!value ? "true" : "false");
            }
            else if(value is Array)
            {
               s += internalArrayToString(value as Array,separator,name,encodeURL);
            }
            else
            {
               s += internalObjectToString(value,separator,name,encodeURL);
            }
         }
         return s;
      }
      
      private static function replaceEncodedSquareBrackets(value:String) : String
      {
         var leftIndex:int = 0;
         var rightIndex:int = value.indexOf(SQUARE_BRACKET_RIGHT_ENCODED);
         if(rightIndex > -1)
         {
            value = value.replace(SQUARE_BRACKET_RIGHT_ENCODED,SQUARE_BRACKET_RIGHT);
            leftIndex = value.indexOf(SQUARE_BRACKET_LEFT_ENCODED);
            if(leftIndex > -1)
            {
               value = value.replace(SQUARE_BRACKET_LEFT_ENCODED,SQUARE_BRACKET_LEFT);
            }
         }
         return value;
      }
      
      private static function internalArrayToString(array:Array, separator:String, prefix:String, encodeURL:Boolean) : String
      {
         var value:Object = null;
         var name:String = null;
         var s:String = "";
         var first:Boolean = true;
         var n:int = array.length;
         for(var i:int = 0; i < n; i++)
         {
            if(first)
            {
               first = false;
            }
            else
            {
               s += separator;
            }
            value = array[i];
            name = prefix + "." + i;
            if(encodeURL)
            {
               name = encodeURIComponent(name);
            }
            if(value is String)
            {
               s += name + "=" + (!!encodeURL ? encodeURIComponent(value as String) : value);
            }
            else if(value is Number)
            {
               value = value.toString();
               if(encodeURL)
               {
                  value = encodeURIComponent(value as String);
               }
               s += name + "=" + value;
            }
            else if(value is Boolean)
            {
               s += name + "=" + (!!value ? "true" : "false");
            }
            else if(value is Array)
            {
               s += internalArrayToString(value as Array,separator,name,encodeURL);
            }
            else
            {
               s += internalObjectToString(value,separator,name,encodeURL);
            }
         }
         return s;
      }
      
      public static function stringToObject(string:String, separator:String = ";", decodeURL:Boolean = true) : Object
      {
         var pieces:Array = null;
         var name:String = null;
         var value:Object = null;
         var obj:Object = null;
         var m:int = 0;
         var j:int = 0;
         var temp:Object = null;
         var prop:String = null;
         var subProp:String = null;
         var idx:Object = null;
         var o:Object = {};
         var arr:Array = string.split(separator);
         var n:int = arr.length;
         for(var i:int = 0; i < n; i++)
         {
            pieces = arr[i].split("=");
            name = pieces[0];
            if(decodeURL)
            {
               name = decodeURIComponent(name);
            }
            value = pieces[1];
            if(decodeURL)
            {
               value = decodeURIComponent(value as String);
            }
            if(value == "true")
            {
               value = true;
            }
            else if(value == "false")
            {
               value = false;
            }
            else
            {
               temp = int(value);
               if(temp.toString() == value)
               {
                  value = temp;
               }
               else
               {
                  temp = Number(value);
                  if(temp.toString() == value)
                  {
                     value = temp;
                  }
               }
            }
            obj = o;
            pieces = name.split(".");
            m = pieces.length;
            for(j = 0; j < m - 1; j++)
            {
               prop = pieces[j];
               if(obj[prop] == null && j < m - 1)
               {
                  subProp = pieces[j + 1];
                  idx = int(subProp);
                  if(idx.toString() == subProp)
                  {
                     obj[prop] = [];
                  }
                  else
                  {
                     obj[prop] = {};
                  }
               }
               obj = obj[prop];
            }
            obj[pieces[j]] = value;
         }
         return o;
      }
   }
}
