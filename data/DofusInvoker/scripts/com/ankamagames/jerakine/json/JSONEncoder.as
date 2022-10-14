package com.ankamagames.jerakine.json
{
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.classInfo.MetadataInfo;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class JSONEncoder
   {
       
      
      protected var _depthLimit:uint = 0;
      
      protected var _showObjectType:Boolean = false;
      
      protected var _processDictionaryKeys:Boolean = false;
      
      protected var jsonString:String;
      
      public function JSONEncoder(value:*, pMaxDepth:uint = 0, pShowObjectType:Boolean = false, processDictionaryKeys:Boolean = false)
      {
         super();
         this.init(value,pMaxDepth,pShowObjectType,processDictionaryKeys);
      }
      
      private static function escapeString(str:String) : String
      {
         var ch:String = null;
         var hexCode:String = null;
         var zeroPad:String = null;
         var s:* = "";
         var len:Number = str.length;
         for(var i:int = 0; i < len; i++)
         {
            ch = str.charAt(i);
            switch(ch)
            {
               case "\"":
                  s += "\\\"";
                  break;
               case "\\":
                  s += "\\\\";
                  break;
               case "\b":
                  s += "\\b";
                  break;
               case "\f":
                  s += "\\f";
                  break;
               case "\n":
                  s += "\\n";
                  break;
               case "\r":
                  s += "\\r";
                  break;
               case "\t":
                  s += "\\t";
                  break;
               default:
                  if(ch < " ")
                  {
                     hexCode = ch.charCodeAt(0).toString(16);
                     zeroPad = hexCode.length == 2 ? "00" : "000";
                     s += "\\u" + zeroPad + hexCode;
                  }
                  else
                  {
                     s += ch;
                  }
                  break;
            }
         }
         return "\"" + s + "\"";
      }
      
      protected function init(value:*, pMaxDepth:uint = 0, pShowObjectType:Boolean = false, processDictionaryKeys:Boolean = false) : void
      {
         this._depthLimit = pMaxDepth;
         this._showObjectType = pShowObjectType;
         this._processDictionaryKeys = processDictionaryKeys;
         this.jsonString = this.convertToString(value,0);
      }
      
      public function getString() : String
      {
         return this.jsonString;
      }
      
      private function convertToString(value:*, depth:int = 0) : String
      {
         if(this._depthLimit != 0 && depth > this._depthLimit)
         {
            return "";
         }
         if(value is String)
         {
            return escapeString(value as String);
         }
         if(value is Number)
         {
            return !!isFinite(value as Number) ? value.toString() : "null";
         }
         if(value is Boolean)
         {
            return !!value ? "true" : "false";
         }
         if(value is Array || value is Vector.<int> || value is Vector.<uint> || value is Vector.<String> || value is Vector.<Boolean> || value is Vector.<*> || value is Dictionary && !this._processDictionaryKeys)
         {
            return this.arrayToString(value,depth + 1);
         }
         if(value is Dictionary && this._processDictionaryKeys)
         {
            return this.dictionaryToString(value,depth + 1);
         }
         if(value is Object && value != null)
         {
            return this.objectToString(value,depth + 1);
         }
         return "null";
      }
      
      private function arrayToString(a:*, depth:int) : String
      {
         var value:* = undefined;
         if(this._depthLimit != 0 && depth > this._depthLimit)
         {
            return "";
         }
         var s:* = "";
         for each(value in a)
         {
            if(s.length > 0)
            {
               s += ",";
            }
            s += this.convertToString(value);
         }
         return "[" + s + "]";
      }
      
      private function dictionaryToString(a:*, depth:int) : String
      {
         var key:* = undefined;
         if(this._depthLimit != 0 && depth > this._depthLimit)
         {
            return "";
         }
         var s:* = "";
         for(key in a)
         {
            if(s.length > 0)
            {
               s += ",";
            }
            s += escapeString(key) + ":" + this.convertToString(a[key]);
         }
         return "{" + s + "}";
      }
      
      private function objectToString(o:Object, depth:int) : String
      {
         var className:Array = null;
         var value:Object = null;
         var key:* = null;
         var classInfo:Vector.<String> = null;
         var v:String = null;
         var metadatas:Vector.<MetadataInfo> = null;
         if(this._depthLimit != 0 && depth > this._depthLimit)
         {
            return "";
         }
         var s:* = "";
         if(getQualifiedClassName(o) == "Object")
         {
            for(key in o)
            {
               value = o[key];
               if(!(value is Function))
               {
                  if(s.length > 0)
                  {
                     s += ",";
                  }
                  s += escapeString(key) + ":" + this.convertToString(value);
               }
            }
         }
         else
         {
            classInfo = DescribeTypeCache.getVariables(o,false,true,false,true);
            for each(v in classInfo)
            {
               metadatas = DescribeTypeCache.getVariableMetadata(o,v);
               if(!(metadatas && metadatas.length > 0 && metadatas[0].name == "Transient"))
               {
                  if(s.length > 0)
                  {
                     s += ",";
                  }
                  try
                  {
                     s += escapeString(v) + ":" + this.convertToString(o[v]);
                  }
                  catch(e:Error)
                  {
                  }
               }
            }
         }
         if(this._showObjectType)
         {
            className = getQualifiedClassName(o).split("::");
         }
         if(className != null)
         {
            return "{" + escapeString("type") + ":" + escapeString(className.pop()) + ", " + escapeString("value") + ":{" + s + "}}";
         }
         return "{" + s + "}";
      }
   }
}
