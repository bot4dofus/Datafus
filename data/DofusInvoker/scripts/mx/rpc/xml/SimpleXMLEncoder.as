package mx.rpc.xml
{
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import mx.utils.ObjectUtil;
   
   public class SimpleXMLEncoder
   {
      
      private static const NUMBER_TYPE:uint = 0;
      
      private static const STRING_TYPE:uint = 1;
      
      private static const OBJECT_TYPE:uint = 2;
      
      private static const DATE_TYPE:uint = 3;
      
      private static const BOOLEAN_TYPE:uint = 4;
      
      private static const XML_TYPE:uint = 5;
      
      private static const ARRAY_TYPE:uint = 6;
      
      private static const MAP_TYPE:uint = 7;
      
      private static const ANY_TYPE:uint = 8;
      
      private static const ROWSET_TYPE:uint = 11;
      
      private static const QBEAN_TYPE:uint = 12;
      
      private static const DOC_TYPE:uint = 13;
      
      private static const SCHEMA_TYPE:uint = 14;
      
      private static const FUNCTION_TYPE:uint = 15;
      
      private static const ELEMENT_TYPE:uint = 16;
      
      private static const BASE64_BINARY_TYPE:uint = 17;
      
      private static const HEX_BINARY_TYPE:uint = 18;
      
      private static const CLASS_INFO_OPTIONS:Object = {
         "includeReadOnly":false,
         "includeTransient":false
      };
       
      
      private var myXMLDoc:XMLDocument;
      
      public function SimpleXMLEncoder(myXML:XMLDocument)
      {
         super();
         this.myXMLDoc = !!myXML ? myXML : new XMLDocument();
      }
      
      static function encodeDate(rawDate:Date, dateType:String) : String
      {
         var n:Number = NaN;
         var s:String = new String();
         if(dateType == "dateTime" || dateType == "date")
         {
            s = s.concat(rawDate.getUTCFullYear(),"-");
            n = rawDate.getUTCMonth() + 1;
            if(n < 10)
            {
               s = s.concat("0");
            }
            s = s.concat(n,"-");
            n = rawDate.getUTCDate();
            if(n < 10)
            {
               s = s.concat("0");
            }
            s = s.concat(n);
         }
         if(dateType == "dateTime")
         {
            s = s.concat("T");
         }
         if(dateType == "dateTime" || dateType == "time")
         {
            n = rawDate.getUTCHours();
            if(n < 10)
            {
               s = s.concat("0");
            }
            s = s.concat(n,":");
            n = rawDate.getUTCMinutes();
            if(n < 10)
            {
               s = s.concat("0");
            }
            s = s.concat(n,":");
            n = rawDate.getUTCSeconds();
            if(n < 10)
            {
               s = s.concat("0");
            }
            s = s.concat(n,".");
            n = rawDate.getUTCMilliseconds();
            if(n < 10)
            {
               s = s.concat("00");
            }
            else if(n < 100)
            {
               s = s.concat("0");
            }
            s = s.concat(n);
         }
         return s.concat("Z");
      }
      
      public function encodeValue(obj:Object, qname:QName, parentNode:XMLNode) : XMLNode
      {
         var myElement:XMLNode = null;
         var classInfo:Object = null;
         var properties:Array = null;
         var pCount:uint = 0;
         var p:uint = 0;
         var fieldName:String = null;
         var propQName:QName = null;
         var numMembers:uint = 0;
         var itemQName:QName = null;
         var i:uint = 0;
         var valueString:String = null;
         var valueNode:XMLNode = null;
         var rep:String = null;
         var start:String = null;
         if(obj == null)
         {
            return null;
         }
         var typeType:uint = this.getDataTypeFromObject(obj);
         if(typeType == SimpleXMLEncoder.FUNCTION_TYPE)
         {
            return null;
         }
         if(typeType == SimpleXMLEncoder.XML_TYPE)
         {
            myElement = obj.cloneNode(true);
            parentNode.appendChild(myElement);
            return myElement;
         }
         myElement = this.myXMLDoc.createElement("foo");
         myElement.nodeName = qname.localName;
         parentNode.appendChild(myElement);
         if(typeType == SimpleXMLEncoder.OBJECT_TYPE)
         {
            classInfo = ObjectUtil.getClassInfo(obj,null,CLASS_INFO_OPTIONS);
            properties = classInfo.properties;
            pCount = properties.length;
            for(p = 0; p < pCount; p++)
            {
               fieldName = properties[p];
               propQName = new QName("",fieldName);
               this.encodeValue(obj[fieldName],propQName,myElement);
            }
         }
         else if(typeType == SimpleXMLEncoder.ARRAY_TYPE)
         {
            numMembers = obj.length;
            itemQName = new QName("","item");
            for(i = 0; i < numMembers; i++)
            {
               this.encodeValue(obj[i],itemQName,myElement);
            }
         }
         else
         {
            if(typeType == SimpleXMLEncoder.DATE_TYPE)
            {
               valueString = encodeDate(obj as Date,"dateTime");
            }
            else if(typeType == SimpleXMLEncoder.NUMBER_TYPE)
            {
               if(obj == Number.POSITIVE_INFINITY)
               {
                  valueString = "INF";
               }
               else if(obj == Number.NEGATIVE_INFINITY)
               {
                  valueString = "-INF";
               }
               else
               {
                  rep = obj.toString();
                  start = rep.substr(0,2);
                  if(start == "0X" || start == "0x")
                  {
                     valueString = parseInt(rep).toString();
                  }
                  else
                  {
                     valueString = rep;
                  }
               }
            }
            else
            {
               valueString = obj.toString();
            }
            valueNode = this.myXMLDoc.createTextNode(valueString);
            myElement.appendChild(valueNode);
         }
         return myElement;
      }
      
      private function getDataTypeFromObject(obj:Object) : uint
      {
         if(obj is Number)
         {
            return SimpleXMLEncoder.NUMBER_TYPE;
         }
         if(obj is Boolean)
         {
            return SimpleXMLEncoder.BOOLEAN_TYPE;
         }
         if(obj is String)
         {
            return SimpleXMLEncoder.STRING_TYPE;
         }
         if(obj is XMLDocument)
         {
            return SimpleXMLEncoder.XML_TYPE;
         }
         if(obj is Date)
         {
            return SimpleXMLEncoder.DATE_TYPE;
         }
         if(obj is Array)
         {
            return SimpleXMLEncoder.ARRAY_TYPE;
         }
         if(obj is Function)
         {
            return SimpleXMLEncoder.FUNCTION_TYPE;
         }
         if(obj is Object)
         {
            return SimpleXMLEncoder.OBJECT_TYPE;
         }
         return SimpleXMLEncoder.STRING_TYPE;
      }
   }
}
