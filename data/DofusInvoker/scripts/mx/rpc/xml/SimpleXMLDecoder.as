package mx.rpc.xml
{
   import flash.xml.XMLNode;
   import flash.xml.XMLNodeType;
   import mx.collections.ArrayCollection;
   import mx.utils.ObjectProxy;
   
   public class SimpleXMLDecoder
   {
       
      
      private var makeObjectsBindable:Boolean;
      
      public function SimpleXMLDecoder(makeObjectsBindable:Boolean = false)
      {
         super();
         this.makeObjectsBindable = makeObjectsBindable;
      }
      
      public static function simpleType(val:Object) : Object
      {
         var valStr:String = null;
         var valStrLC:String = null;
         var result:Object = val;
         if(val != null)
         {
            if(val is String && String(val) == "")
            {
               result = val.toString();
            }
            else if(isNaN(Number(val)) || val.charAt(0) == "0" || val.charAt(0) == "-" && val.charAt(1) == "0" || val.charAt(val.length - 1) == "E")
            {
               valStr = val.toString();
               valStrLC = valStr.toLowerCase();
               if(valStrLC == "true")
               {
                  result = true;
               }
               else if(valStrLC == "false")
               {
                  result = false;
               }
               else
               {
                  result = valStr;
               }
            }
            else
            {
               result = Number(val);
            }
         }
         return result;
      }
      
      public static function getLocalName(xmlNode:XMLNode) : String
      {
         var name:String = xmlNode.nodeName;
         var myPrefixIndex:int = name.indexOf(":");
         if(myPrefixIndex != -1)
         {
            name = name.substring(myPrefixIndex + 1);
         }
         return name;
      }
      
      public function decodeXML(dataNode:XMLNode) : Object
      {
         var result:Object = null;
         var attribute:* = null;
         var i:uint = 0;
         var partNode:XMLNode = null;
         var partName:String = null;
         var partObj:Object = null;
         var existing:Object = null;
         var isSimpleType:Boolean = false;
         if(dataNode == null)
         {
            return null;
         }
         var children:Array = dataNode.childNodes;
         if(children.length == 1 && children[0].nodeType == XMLNodeType.TEXT_NODE)
         {
            isSimpleType = true;
            result = SimpleXMLDecoder.simpleType(children[0].nodeValue);
         }
         else if(children.length > 0)
         {
            result = {};
            if(this.makeObjectsBindable)
            {
               result = new ObjectProxy(result);
            }
            for(i = 0; i < children.length; i++)
            {
               partNode = children[i];
               if(partNode.nodeType == XMLNodeType.ELEMENT_NODE)
               {
                  partName = getLocalName(partNode);
                  partObj = this.decodeXML(partNode);
                  existing = result[partName];
                  if(existing != null)
                  {
                     if(existing is Array)
                     {
                        existing.push(partObj);
                     }
                     else if(existing is ArrayCollection)
                     {
                        existing.source.push(partObj);
                     }
                     else
                     {
                        existing = [existing];
                        existing.push(partObj);
                        if(this.makeObjectsBindable)
                        {
                           existing = new ArrayCollection(existing as Array);
                        }
                        result[partName] = existing;
                     }
                  }
                  else
                  {
                     result[partName] = partObj;
                  }
               }
            }
         }
         var attributes:Object = dataNode.attributes;
         for(attribute in attributes)
         {
            if(!(attribute == "xmlns" || attribute.indexOf("xmlns:") != -1))
            {
               if(result == null)
               {
                  result = {};
                  if(this.makeObjectsBindable)
                  {
                     result = new ObjectProxy(result);
                  }
               }
               if(isSimpleType && !(result is ComplexString))
               {
                  result = new ComplexString(result.toString());
                  isSimpleType = false;
               }
               result[attribute] = SimpleXMLDecoder.simpleType(attributes[attribute]);
            }
         }
         return result;
      }
   }
}
