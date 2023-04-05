package com.ankamagames.berilia.types.template
{
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.jerakine.eval.Evaluator;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import flash.xml.XMLNodeType;
   
   public class XmlTemplate
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlTemplate));
      
      private static var _instanceIdInc:int = 0;
      
      private static var _utilDoc:XMLDocument = new XMLDocument();
       
      
      private var _sXml:String;
      
      private var _xDoc:XMLDocument;
      
      private var _filename:String;
      
      private var _templateParams:Array;
      
      private var _templateVars:Array;
      
      private var _utilsVar:Array;
      
      private var _instanceId:int;
      
      private var _uniqueIdInc:int = 0;
      
      public function XmlTemplate(sXml:String = null, sFilename:String = null)
      {
         this._templateParams = [];
         this._templateVars = [];
         super();
         this._filename = sFilename;
         if(sXml != null)
         {
            this.xml = sXml;
         }
      }
      
      public function get xml() : String
      {
         return this._sXml;
      }
      
      public function set xml(sXml:String) : void
      {
         this._sXml = sXml;
         this.parseTemplate();
      }
      
      public function get filename() : String
      {
         return this._filename;
      }
      
      public function set filename(s:String) : void
      {
         this._filename = s;
      }
      
      public function get templateParams() : Array
      {
         return this._templateParams;
      }
      
      public function get templateVars() : Array
      {
         return this._templateVars;
      }
      
      public function makeTemplate(aVar:Array) : XMLNode
      {
         this.initializeIds();
         return this.initTemplateWithParam(aVar,this.initFinalVar(aVar),this._xDoc);
      }
      
      private function initializeIds() : void
      {
         this._instanceId = _instanceIdInc++;
         this._utilsVar = [new TemplateVar("TEMPLATE_INSTANCE_ID",this._filename.replace(".xml","") + "" + this._instanceId),new TemplateVar("UNIQUE_ID",this.getUniqueId)];
      }
      
      private function parseTemplate() : void
      {
         this._xDoc = new XMLDocument();
         this._xDoc.ignoreWhite = true;
         this._xDoc.parseXML(this._sXml);
         if(this._xDoc.firstChild.nodeName + ".xml" != this._filename)
         {
            _log.error("Wrong root node name in " + this._filename + ", found " + this._xDoc.firstChild.nodeName + ", waiting for " + this._filename.replace(".xml",""));
            return;
         }
         this.storeVarAndParam(this._xDoc.firstChild);
      }
      
      private function storeVarAndParam(node:XMLNode) : void
      {
         var currNode:XMLNode = null;
         for(var i:uint = 0; i < node.childNodes.length; i++)
         {
            currNode = node.childNodes[i];
            if(currNode.nodeName == XmlTagsEnum.TAG_VAR)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  this._templateVars[currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]] = currNode.childNodes;
                  currNode.removeNode();
                  i--;
               }
               else
               {
                  _log.warn("Template " + this._filename + ", " + currNode.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
               }
            }
            else if(currNode.nodeName == XmlTagsEnum.TAG_PARAM)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  this._templateParams[currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]] = currNode.childNodes;
                  currNode.removeNode();
                  i--;
               }
               else
               {
                  _log.warn("Template " + this._filename + ", " + currNode.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
               }
            }
         }
      }
      
      private function initTemplateWithParam(specifiedParam:Array, finalVar:Array, xmlNode:XMLNode) : XMLNode
      {
         var node:XMLNode = null;
         var nodeValue:String = null;
         var paramNode:XMLNode = null;
         var finalNode:XMLNode = xmlNode.cloneNode(false);
         this.initAttributes(specifiedParam,finalVar,finalNode);
         for each(node in xmlNode.childNodes)
         {
            if(node.nodeType == XMLNodeType.ELEMENT_NODE)
            {
               finalNode.appendChild(this.initTemplateWithParam(specifiedParam,finalVar,node));
            }
            else if(node.nodeType == XMLNodeType.TEXT_NODE)
            {
               nodeValue = node.nodeValue;
               if(nodeValue.charAt(0) == "#")
               {
                  if(nodeValue.indexOf("\n") != -1)
                  {
                     nodeValue = nodeValue.substring(1,nodeValue.indexOf("\n"));
                  }
                  else
                  {
                     nodeValue = nodeValue.substring(1);
                  }
                  if(specifiedParam && specifiedParam[nodeValue])
                  {
                     _utilDoc.parseXML(specifiedParam[nodeValue].value);
                     for each(paramNode in _utilDoc.childNodes)
                     {
                        finalNode.appendChild(paramNode.cloneNode(true));
                     }
                  }
                  else if(this._templateParams[nodeValue] && this._templateParams[nodeValue][0])
                  {
                     for each(paramNode in this._templateParams[nodeValue])
                     {
                        finalNode.appendChild(paramNode.cloneNode(true));
                     }
                  }
               }
               else if(nodeValue.charAt(0) == "$")
               {
                  if(nodeValue.indexOf("\n") != -1)
                  {
                     nodeValue = nodeValue.substring(1,nodeValue.indexOf("\n"));
                  }
                  else
                  {
                     nodeValue = nodeValue.substring(1);
                  }
                  if(finalVar[nodeValue])
                  {
                     _utilDoc.parseXML(finalVar[nodeValue]);
                     finalNode.appendChild(_utilDoc.firstChild);
                  }
                  else
                  {
                     _log.warn("Template " + this._filename + ", var " + nodeValue + " is not defined");
                  }
               }
               else
               {
                  finalNode.appendChild(node.cloneNode(false));
               }
            }
         }
         return finalNode;
      }
      
      private function initAttributes(specifiedParam:Array, finalVar:Array, finalNode:XMLNode) : void
      {
         var attribute:* = null;
         var value:String = null;
         var paramName:String = null;
         var indexKey:uint = 0;
         var reverse:Boolean = false;
         var sign:String = null;
         for(attribute in finalNode.attributes)
         {
            value = finalNode.attributes[attribute];
            paramName = null;
            indexKey = 0;
            reverse = false;
            sign = "";
            if(value.charAt(1) == "!")
            {
               paramName = value.substring(2);
               reverse = true;
            }
            else if(value.charAt(0) == "-")
            {
               indexKey = 1;
               sign = "-";
            }
            if(value.charAt(indexKey) == "#")
            {
               if(!paramName)
               {
                  paramName = value.substring(indexKey + 1);
               }
               value = sign + this.getParamString(specifiedParam,paramName);
            }
            else if(value.charAt(indexKey) == "$")
            {
               if(!paramName)
               {
                  paramName = value.substring(indexKey + 1);
               }
               if(finalVar[paramName] != null)
               {
                  value = sign + finalVar[paramName];
               }
               else
               {
                  _log.warn("Template " + this._filename + ", node " + finalNode.nodeName + " contains var attribute " + paramName + " but it don\'t exist !");
               }
            }
            if(reverse)
            {
               if(value == "true")
               {
                  value = "false";
               }
               else if(value == "false")
               {
                  value = "true";
               }
               else
               {
                  _log.warn("Template " + this._filename + ", can\'t reverse " + value + ", it\'s not a boolean !");
               }
            }
            finalNode.attributes[attribute] = value;
         }
      }
      
      private function initFinalVar(specifiedParam:Array = null) : Array
      {
         var varName:* = null;
         var paramNode:XMLNode = null;
         var nodeValue:String = null;
         var index:int = 0;
         var paramName:String = null;
         var finalVar:Array = [];
         for(varName in this._templateVars)
         {
            paramNode = this._templateVars[varName][0];
            nodeValue = paramNode.nodeValue;
            index = nodeValue.indexOf("#");
            while(index != -1)
            {
               paramName = nodeValue.substring(index + 1);
               if(paramName.indexOf("\'") != -1)
               {
                  paramName = paramName.substring(0,paramName.indexOf("\'"));
               }
               else if(paramName.indexOf(" ") != -1)
               {
                  paramName = paramName.substring(0,paramName.indexOf(" "));
               }
               nodeValue = nodeValue.replace("#" + paramName,this.getParamString(specifiedParam,paramName));
               index = nodeValue.indexOf("#",index + 1);
            }
            finalVar[varName] = Evaluator.eval(nodeValue);
         }
         return finalVar;
      }
      
      private function getParamString(specifiedParam:Array, paramName:String) : String
      {
         var paramString:String = null;
         if(specifiedParam && specifiedParam[paramName])
         {
            paramString = this.getRealValue(specifiedParam[paramName].value);
         }
         else if(this._templateParams[paramName])
         {
            if(this._templateParams[paramName][0])
            {
               paramString = this.getRealValue(this._templateParams[paramName][0].nodeValue);
            }
            else
            {
               paramString = "";
            }
         }
         else
         {
            _log.warn("Template " + this._filename + " contains param " + paramName + " but it don\'t exist !");
         }
         return paramString;
      }
      
      private function getRealValue(value:String) : String
      {
         var utilsVar:String = null;
         var tmpVar:TemplateVar = null;
         if(value == null)
         {
            return value;
         }
         var index:int = value.indexOf("$");
         if(index != -1)
         {
            utilsVar = value.substring(index + 1);
            for each(tmpVar in this._utilsVar)
            {
               if(tmpVar.name == utilsVar)
               {
                  return tmpVar.value;
               }
            }
         }
         return value;
      }
      
      private function getUniqueId() : String
      {
         return this._filename + "_" + this._instanceId + "_" + this._uniqueIdInc++;
      }
   }
}
