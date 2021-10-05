package flashx.textLayout.conversion
{
   import flash.system.System;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.TextLayoutVersion;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.ContainerFormattedElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ParagraphFormattedElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class BaseTextLayoutExporter extends ConverterBase implements ITextExporter
   {
      
      private static const brRegEx:RegExp = / /;
       
      
      private var _rootTag:XML;
      
      private var _ns:Namespace;
      
      public function BaseTextLayoutExporter(ns:Namespace, rootTag:XML, configuration:ImportExportConfiguration)
      {
         super();
         config = configuration;
         this._ns = ns;
         this._rootTag = rootTag;
      }
      
      tlf_internal static function convertXMLToString(xml:XML) : String
      {
         var result:String = null;
         var originalSettings:Object = null;
         originalSettings = XML.settings();
         try
         {
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            XML.prettyPrinting = false;
            result = xml.toXMLString();
            if(Configuration.playerEnablesArgoFeatures)
            {
               System["disposeXML"](xml);
            }
            XML.setSettings(originalSettings);
         }
         catch(e:Error)
         {
            XML.setSettings(originalSettings);
            throw e;
         }
         return result;
      }
      
      public static function exportFlowElement(exporter:BaseTextLayoutExporter, flowElement:FlowElement) : XMLList
      {
         return exporter.exportFlowElement(flowElement);
      }
      
      public static function exportSpanText(destination:XML, span:SpanElement, replacementRegex:RegExp, replacementXMLCallback:Function) : void
      {
         var dummy:XML = null;
         var ix:int = 0;
         var tempStr:String = null;
         var replacementXML:XML = null;
         var spanText:String = span.text;
         var matchLocation:Array = spanText.match(replacementRegex);
         if(matchLocation)
         {
            while(matchLocation != null)
            {
               ix = matchLocation.index;
               tempStr = spanText.substr(0,ix);
               if(tempStr.length > 0)
               {
                  dummy = <dummy/>;
                  dummy.appendChild(tempStr);
                  destination.appendChild(dummy.text()[0]);
               }
               replacementXML = replacementXMLCallback(spanText.charAt(ix));
               destination.appendChild(replacementXML);
               spanText = spanText.slice(ix + 1,spanText.length);
               matchLocation = spanText.match(replacementRegex);
               if(!matchLocation && spanText.length > 0)
               {
                  dummy = <dummy/>;
                  dummy.appendChild(spanText);
                  destination.appendChild(dummy.text()[0]);
               }
            }
         }
         else
         {
            destination.appendChild(spanText);
         }
      }
      
      public static function exportSpan(exporter:BaseTextLayoutExporter, span:SpanElement) : XMLList
      {
         var output:XMLList = exportFlowElement(exporter,span);
         exportSpanText(output[0],span,exporter.spanTextReplacementRegex,exporter.getSpanTextReplacementXML);
         return output;
      }
      
      public static function exportFlowGroupElement(exporter:BaseTextLayoutExporter, flowBlockElement:FlowGroupElement) : XMLList
      {
         var index:int = 0;
         var flowChild:FlowElement = null;
         var childXML:XMLList = null;
         var output:XMLList = exportFlowElement(exporter,flowBlockElement);
         for(var count:int = flowBlockElement.numChildren; index < count; )
         {
            flowChild = flowBlockElement.getChildAt(index);
            childXML = exporter.exportChild(flowChild);
            if(childXML)
            {
               output.appendChild(childXML);
            }
            index++;
         }
         return output;
      }
      
      public static function exportParagraphFormattedElement(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement) : XMLList
      {
         return exporter.exportParagraphFormattedElement(flowParagraph);
      }
      
      public static function exportList(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement) : XMLList
      {
         return exporter.exportList(flowParagraph);
      }
      
      public static function exportListItem(exporter:BaseTextLayoutExporter, flowParagraph:ParagraphFormattedElement) : XMLList
      {
         return exporter.exportListItem(flowParagraph);
      }
      
      public static function exportContainerFormattedElement(exporter:BaseTextLayoutExporter, container:ContainerFormattedElement) : XMLList
      {
         return exporter.exportContainerFormattedElement(container);
      }
      
      public static function exportTableElement(exporter:BaseTextLayoutExporter, table:TableElement) : XMLList
      {
         return exporter.exportTableElement(table);
      }
      
      public static function exportTableRowElement(exporter:BaseTextLayoutExporter, tableRow:TableRowElement) : XMLList
      {
         return exporter.exportTableRowElement(tableRow);
      }
      
      public static function exportTableCellElement(exporter:BaseTextLayoutExporter, tableCell:TableCellElement) : XMLList
      {
         return exporter.exportTableCellElement(tableCell);
      }
      
      public static function exportTextFlow(exporter:BaseTextLayoutExporter, textFlow:TextFlow) : XMLList
      {
         var output:XMLList = exportContainerFormattedElement(exporter,textFlow);
         if(exporter.config.whiteSpaceCollapse)
         {
            output[TextLayoutFormat.whiteSpaceCollapseProperty.name] = exporter.config.whiteSpaceCollapse;
         }
         output["version"] = TextLayoutVersion.getVersionString(TextLayoutVersion.CURRENT_VERSION);
         return output;
      }
      
      public function export(source:TextFlow, conversionType:String) : Object
      {
         clear();
         var result:XML = this.exportToXML(source);
         return conversionType == ConversionType.STRING_TYPE ? convertXMLToString(result) : result;
      }
      
      protected function exportToXML(textFlow:TextFlow) : XML
      {
         var result:XML = null;
         if(this._rootTag)
         {
            result = new XML(this._rootTag);
            result.addNamespace(this._ns);
            result.appendChild(this.exportChild(textFlow));
         }
         else
         {
            result = XML(exportTextFlow(this,textFlow));
            result.addNamespace(this._ns);
         }
         return result;
      }
      
      protected function exportFlowElement(flowElement:FlowElement) : XMLList
      {
         var className:String = getQualifiedClassName(flowElement);
         var elementName:String = config.lookupName(className);
         var output:XML = new XML("<" + elementName + "/>");
         output.setNamespace(this._ns);
         return XMLList(output);
      }
      
      protected function get spanTextReplacementRegex() : RegExp
      {
         return brRegEx;
      }
      
      protected function getSpanTextReplacementXML(ch:String) : XML
      {
         var breakXML:XML = <br/>;
         breakXML.setNamespace(this.flowNS);
         return breakXML;
      }
      
      protected function exportList(flowElement:FlowElement) : XMLList
      {
         var index:int = 0;
         var flowChild:FlowElement = null;
         var result:XMLList = this.exportFlowElement(flowElement);
         for(var count:int = FlowGroupElement(flowElement).numChildren; index < count; )
         {
            flowChild = FlowGroupElement(flowElement).getChildAt(index);
            result.appendChild(this.exportChild(flowChild));
            index++;
         }
         return result;
      }
      
      protected function exportListItem(flowElement:FlowElement) : XMLList
      {
         var index:int = 0;
         var flowChild:FlowElement = null;
         var result:XMLList = this.exportFlowElement(flowElement);
         for(var count:int = FlowGroupElement(flowElement).numChildren; index < count; )
         {
            flowChild = FlowGroupElement(flowElement).getChildAt(index);
            result.appendChild(this.exportChild(flowChild));
            index++;
         }
         return result;
      }
      
      protected function exportContainerFormattedElement(flowElement:FlowElement) : XMLList
      {
         return this.exportParagraphFormattedElement(flowElement);
      }
      
      protected function exportTableElement(tableElement:TableElement) : XMLList
      {
         var flowChild:FlowElement = null;
         var result:XMLList = this.exportFlowElement(tableElement);
         var count:int = tableElement.numRows;
         for(var index:int = 0; index < count; index++)
         {
            flowChild = tableElement.getRowAt(index);
            result.appendChild(this.exportChild(flowChild));
         }
         return result;
      }
      
      protected function exportTableRowElement(tableRowElement:TableRowElement) : XMLList
      {
         var index:int = 0;
         var flowChild:FlowElement = null;
         var result:XMLList = this.exportFlowElement(tableRowElement);
         for(var count:int = tableRowElement.numCells; index < count; )
         {
            flowChild = tableRowElement.getCellAt(index);
            result.appendChild(this.exportChild(flowChild));
            index++;
         }
         return result;
      }
      
      protected function exportTableCellElement(tableCellElement:TableCellElement) : XMLList
      {
         return this.exportFlowElement(tableCellElement);
      }
      
      protected function exportParagraphFormattedElement(flowElement:FlowElement) : XMLList
      {
         var index:int = 0;
         var flowChild:FlowElement = null;
         var result:XMLList = this.exportFlowElement(flowElement);
         for(var count:int = ParagraphFormattedElement(flowElement).numChildren; index < count; )
         {
            flowChild = ParagraphFormattedElement(flowElement).getChildAt(index);
            result.appendChild(this.exportChild(flowChild));
            index++;
         }
         return result;
      }
      
      public function exportChild(flowElement:FlowElement) : XMLList
      {
         var className:String = getQualifiedClassName(flowElement);
         var info:FlowElementInfo = config.lookupByClass(className);
         if(info != null)
         {
            return info.exporter(this,flowElement);
         }
         return null;
      }
      
      protected function exportStyles(xml:XMLList, sortableStyles:Array) : void
      {
         var exportInfo:Object = null;
         var xmlVal:Object = null;
         sortableStyles.sortOn("xmlName");
         for each(exportInfo in sortableStyles)
         {
            xmlVal = exportInfo.xmlVal;
            if(!(!useClipboardAnnotations && exportInfo.xmlName == ConverterBase.MERGE_TO_NEXT_ON_PASTE))
            {
               if(xmlVal is String)
               {
                  xml[exportInfo.xmlName] = xmlVal;
               }
               else if(xmlVal is XMLList)
               {
                  xml.appendChild(xmlVal);
               }
            }
         }
      }
      
      function get flowNS() : Namespace
      {
         return this._ns;
      }
      
      protected function get formatDescription() : Object
      {
         return null;
      }
   }
}
