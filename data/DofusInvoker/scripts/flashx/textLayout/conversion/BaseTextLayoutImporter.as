package flashx.textLayout.conversion
{
   import flash.system.System;
   import flashx.textLayout.TextLayoutVersion;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.elements.IConfiguration;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.ParagraphFormattedElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TabElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   class BaseTextLayoutImporter extends ConverterBase implements ITextImporter
   {
      
      private static const anyPrintChar:RegExp = /[^\t\n\r ]/g;
      
      private static const dblSpacePattern:RegExp = /[ ]{2,}/g;
      
      private static const tabNewLinePattern:RegExp = /[\t\n\r]/g;
       
      
      private var _ns:Namespace;
      
      private var _textFlowNamespace:Namespace;
      
      protected var _config:ImportExportConfiguration;
      
      protected var _textFlowConfiguration:IConfiguration = null;
      
      protected var _importVersion:uint;
      
      private var _impliedPara:ParagraphElement = null;
      
      function BaseTextLayoutImporter(nsValue:Namespace, config:ImportExportConfiguration)
      {
         super();
         this._ns = nsValue;
         this._config = config;
      }
      
      protected static function stripWhitespace(insertString:String) : String
      {
         return insertString.replace(tabNewLinePattern," ");
      }
      
      public static function parseTextFlow(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:Object = null) : TextFlow
      {
         return importer.createTextFlowFromXML(xmlToParse,null);
      }
      
      public static function parsePara(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var paraElem:ParagraphElement = importer.createParagraphFromXML(xmlToParse);
         if(importer.addChild(parent,paraElem))
         {
            importer.parseFlowGroupElementChildren(xmlToParse,paraElem);
            if(paraElem.numChildren == 0)
            {
               paraElem.addChild(new SpanElement());
            }
         }
      }
      
      protected static function copyAllStyleProps(dst:FlowLeafElement, src:FlowLeafElement) : void
      {
         dst.format = src.format;
         dst.typeName = src.typeName;
         dst.id = src.id;
      }
      
      public static function parseSpan(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var child:XML = null;
         var elemName:String = null;
         var s:SpanElement = null;
         var brElem:BreakElement = null;
         var tabElem:TabElement = null;
         var firstSpan:SpanElement = importer.createSpanFromXML(xmlToParse);
         var elemList:XMLList = xmlToParse[0].children();
         if(elemList.length() == 0)
         {
            importer.addChild(parent,firstSpan);
            return;
         }
         for each(child in elemList)
         {
            elemName = !!child.name() ? child.name().localName : null;
            if(elemName == null)
            {
               if(firstSpan.parent == null)
               {
                  firstSpan.text = child.toString();
                  importer.addChild(parent,firstSpan);
               }
               else
               {
                  s = new SpanElement();
                  copyAllStyleProps(s,firstSpan);
                  s.text = child.toString();
                  importer.addChild(parent,s);
               }
            }
            else if(elemName == "br")
            {
               brElem = importer.createBreakFromXML(child);
               if(brElem)
               {
                  copyAllStyleProps(brElem,firstSpan);
                  importer.addChild(parent,brElem);
               }
               else
               {
                  importer.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan",[elemName]));
               }
            }
            else if(elemName == "tab")
            {
               tabElem = importer.createTabFromXML(child);
               if(tabElem)
               {
                  copyAllStyleProps(tabElem,firstSpan);
                  importer.addChild(parent,tabElem);
               }
               else
               {
                  importer.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan",[elemName]));
               }
            }
            else
            {
               importer.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan",[elemName]));
            }
         }
      }
      
      public static function parseBreak(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var breakElem:BreakElement = importer.createBreakFromXML(xmlToParse);
         importer.addChild(parent,breakElem);
      }
      
      public static function parseTab(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var tabElem:TabElement = importer.createTabFromXML(xmlToParse);
         if(tabElem)
         {
            importer.addChild(parent,tabElem);
         }
      }
      
      public static function parseList(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var listElem:ListElement = importer.createListFromXML(xmlToParse);
         if(importer.addChild(parent,listElem))
         {
            importer.parseFlowGroupElementChildren(xmlToParse,listElem);
         }
      }
      
      public static function parseListItem(importer:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var listItem:ListItemElement = importer.createListItemFromXML(xmlToParse);
         if(importer.addChild(parent,listItem))
         {
            importer.parseFlowGroupElementChildren(xmlToParse,listItem);
            if(listItem.numChildren == 0)
            {
               listItem.addChild(new ParagraphElement());
            }
         }
      }
      
      protected static function extractAttributesHelper(curAttrs:Object, importer:TLFormatImporter) : Object
      {
         if(curAttrs == null)
         {
            return importer.result;
         }
         if(importer.result == null)
         {
            return curAttrs;
         }
         var workAttrs:Object = new importer.classType(curAttrs);
         workAttrs.apply(importer.result);
         return workAttrs;
      }
      
      override tlf_internal function clear() : void
      {
         super.clear();
         this._textFlowNamespace = null;
         this._impliedPara = null;
      }
      
      public function importToFlow(source:Object) : TextFlow
      {
         this.clear();
         if(throwOnError)
         {
            return this.importToFlowCanThrow(source);
         }
         var rslt:TextFlow = null;
         var savedErrorHandler:Function = Property.errorHandler;
         try
         {
            Property.errorHandler = this.importPropertyErrorHandler;
            rslt = this.importToFlowCanThrow(source);
         }
         catch(e:Error)
         {
            reportError(e.toString());
         }
         Property.errorHandler = savedErrorHandler;
         return rslt;
      }
      
      public function get configuration() : IConfiguration
      {
         return this._textFlowConfiguration;
      }
      
      public function set configuration(value:IConfiguration) : void
      {
         this._textFlowConfiguration = value;
      }
      
      protected function importPropertyErrorHandler(p:Property, value:Object) : void
      {
         reportError(Property.createErrorString(p,value));
      }
      
      private function importToFlowCanThrow(source:Object) : TextFlow
      {
         if(source is String)
         {
            return this.importFromString(String(source));
         }
         if(source is XML)
         {
            return this.importFromXML(XML(source));
         }
         return null;
      }
      
      protected function importFromString(source:String) : TextFlow
      {
         var xmlTree:XML = null;
         var originalSettings:Object = XML.settings();
         try
         {
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            xmlTree = new XML(source);
         }
         finally
         {
            XML.setSettings(originalSettings);
         }
         var textFlow:TextFlow = this.importFromXML(xmlTree);
         if(Configuration.playerEnablesArgoFeatures)
         {
            System["disposeXML"](xmlTree);
         }
         return textFlow;
      }
      
      protected function importFromXML(xmlSource:XML) : TextFlow
      {
         return this.parseContent(xmlSource[0]);
      }
      
      protected function parseContent(rootStory:XML) : TextFlow
      {
         var child:XML = rootStory..TextFlow[0];
         if(child)
         {
            return parseTextFlow(this,rootStory);
         }
         return null;
      }
      
      public function get ns() : Namespace
      {
         return this._ns;
      }
      
      protected function checkNamespace(xmlToParse:XML) : Boolean
      {
         var elementNS:Namespace = xmlToParse.namespace();
         if(!this._textFlowNamespace)
         {
            if(elementNS != this.ns)
            {
               reportError(GlobalSettings.resourceStringFunction("unexpectedNamespace",[elementNS.toString()]));
               return false;
            }
            this._textFlowNamespace = elementNS;
         }
         else if(elementNS != this._textFlowNamespace)
         {
            reportError(GlobalSettings.resourceStringFunction("unexpectedNamespace",[elementNS.toString()]));
            return false;
         }
         return true;
      }
      
      public function parseAttributes(xmlToParse:XML, formatImporters:Array) : void
      {
         var importer:IFormatImporter = null;
         var item:XML = null;
         var propertyName:String = null;
         var propertyValue:String = null;
         var imported:Boolean = false;
         for each(importer in formatImporters)
         {
            importer.reset();
         }
         if(!xmlToParse)
         {
            return;
         }
         for each(item in xmlToParse.attributes())
         {
            propertyName = item.name().localName;
            propertyValue = item.toString();
            imported = false;
            if(xmlToParse.localName() == "TextFlow")
            {
               if(propertyName == "version")
               {
                  continue;
               }
            }
            else if(this._importVersion < TextLayoutVersion.VERSION_2_0 && (propertyName == "paddingLeft" || propertyName == "paddingTop" || propertyName == "paddingRight" || propertyName == "paddingBottom"))
            {
               continue;
            }
            for each(importer in formatImporters)
            {
               if(importer.importOneFormat(propertyName,propertyValue))
               {
                  imported = true;
                  break;
               }
            }
            if(!imported)
            {
               this.handleUnknownAttribute(xmlToParse.name().localName,propertyName);
            }
         }
      }
      
      public function createTextFlowFromXML(xmlToParse:XML, newFlow:TextFlow = null) : TextFlow
      {
         return null;
      }
      
      public function createParagraphFromXML(xmlToParse:XML) : ParagraphElement
      {
         return null;
      }
      
      public function createSpanFromXML(xmlToParse:XML) : SpanElement
      {
         return null;
      }
      
      public function createBreakFromXML(xmlToParse:XML) : BreakElement
      {
         this.parseAttributes(xmlToParse,null);
         return new BreakElement();
      }
      
      public function createListFromXML(xmlToParse:XML) : ListElement
      {
         return null;
      }
      
      public function createListItemFromXML(xmlToParse:XML) : ListItemElement
      {
         return null;
      }
      
      public function createTabFromXML(xmlToParse:XML) : TabElement
      {
         this.parseAttributes(xmlToParse,null);
         return new TabElement();
      }
      
      public function parseFlowChildren(xmlToParse:XML, parent:FlowGroupElement) : void
      {
         this.parseFlowGroupElementChildren(xmlToParse,parent);
      }
      
      public function parseFlowGroupElementChildren(xmlToParse:XML, parent:FlowGroupElement, exceptionElements:Object = null, chainedParent:Boolean = false) : void
      {
         var child:XML = null;
         var txt:String = null;
         var strip:* = false;
         for each(child in xmlToParse.children())
         {
            if(child.nodeKind() == "element")
            {
               this.parseObject(child.name().localName,child,parent,exceptionElements);
            }
            else if(child.nodeKind() == "text")
            {
               txt = child.toString();
               strip = false;
               if(parent is ContainerFormattedElement)
               {
                  strip = txt.search(anyPrintChar) == -1;
               }
               if(!strip)
               {
                  this.addChild(parent,this.createImpliedSpan(txt));
               }
            }
         }
         if(!chainedParent && parent is ContainerFormattedElement)
         {
            this.resetImpliedPara();
         }
      }
      
      public function parseTableCellElementChildren(xmlToParse:XML, parent:FlowGroupElement, exceptionElements:Object = null, chainedParent:Boolean = false) : void
      {
         var textFlow:TextFlow = null;
         var child:XML = null;
         var txt:String = null;
         var strip:* = false;
         for each(child in xmlToParse.children())
         {
            if(child.nodeKind() == "element")
            {
               if(child.name().localName == "p")
               {
                  textFlow = new TextFlow();
                  this.parseObject(child.name().localName,child,textFlow,exceptionElements);
               }
               else if(child.name().localName == "TextFlow")
               {
                  TableCellElement(parent).textFlow = this.createTextFlowFromXML(child);
               }
            }
            else if(child.nodeKind() == "text")
            {
               txt = child.toString();
               strip = false;
               if(parent is ContainerFormattedElement)
               {
                  strip = txt.search(anyPrintChar) == -1;
               }
               if(!strip)
               {
                  textFlow = new TextFlow();
                  this.parseObject(child.name().localName,child,textFlow,exceptionElements);
               }
            }
            if(textFlow)
            {
               TableCellElement(parent).textFlow = textFlow;
               textFlow = null;
            }
         }
      }
      
      public function createImpliedSpan(text:String) : SpanElement
      {
         var span:SpanElement = new SpanElement();
         span.text = text;
         return span;
      }
      
      public function createParagraphFlowFromXML(xmlToParse:XML, newFlow:TextFlow = null) : TextFlow
      {
         return null;
      }
      
      tlf_internal function parseObject(name:String, xmlToParse:XML, parent:FlowGroupElement, exceptionElements:Object = null) : void
      {
         if(!this.checkNamespace(xmlToParse))
         {
            return;
         }
         var info:FlowElementInfo = this._config.lookup(name);
         if(!info)
         {
            if(exceptionElements == null || exceptionElements[name] === undefined)
            {
               this.handleUnknownElement(name,xmlToParse,parent);
            }
         }
         else
         {
            info.parser(this,xmlToParse,parent);
         }
      }
      
      protected function handleUnknownElement(name:String, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         reportError(GlobalSettings.resourceStringFunction("unknownElement",[name]));
      }
      
      protected function handleUnknownAttribute(elementName:String, propertyName:String) : void
      {
         reportError(GlobalSettings.resourceStringFunction("unknownAttribute",[propertyName,elementName]));
      }
      
      protected function getElementInfo(xmlToParse:XML) : FlowElementInfo
      {
         return this._config.lookup(xmlToParse.name().localName);
      }
      
      protected function GetClass(xmlToParse:XML) : Class
      {
         var info:FlowElementInfo = this._config.lookup(xmlToParse.name().localName);
         return !!info ? info.flowClass : null;
      }
      
      tlf_internal function createImpliedParagraph() : ParagraphElement
      {
         return this.createParagraphFromXML(<p/>);
      }
      
      tlf_internal function addChild(parent:FlowGroupElement, child:FlowElement) : Boolean
      {
         if(child is ParagraphFormattedElement)
         {
            this.resetImpliedPara();
         }
         else if(parent is ContainerFormattedElement)
         {
            if(!this._impliedPara)
            {
               this._impliedPara = this.createImpliedParagraph();
               parent.addChild(this._impliedPara);
            }
            var parent:FlowGroupElement = this._impliedPara;
         }
         if(throwOnError)
         {
            parent.addChild(child);
         }
         else
         {
            try
            {
               parent.addChild(child);
            }
            catch(e:*)
            {
               reportError(e);
               return false;
            }
         }
         return true;
      }
      
      tlf_internal function resetImpliedPara() : void
      {
         if(this._impliedPara)
         {
            this.onResetImpliedPara(this._impliedPara);
            this._impliedPara = null;
         }
      }
      
      protected function onResetImpliedPara(para:ParagraphElement) : void
      {
      }
   }
}
