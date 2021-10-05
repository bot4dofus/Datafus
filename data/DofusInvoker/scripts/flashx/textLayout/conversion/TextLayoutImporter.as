package flashx.textLayout.conversion
{
   import flash.utils.Dictionary;
   import flashx.textLayout.TextLayoutVersion;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TabElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextLayoutImporter extends BaseTextLayoutImporter implements ITextLayoutImporter
   {
      
      private static var _defaultConfiguration:ImportExportConfiguration;
      
      private static const _formatImporter:TLFormatImporter = new TLFormatImporter(TextLayoutFormat,TextLayoutFormat.description);
      
      private static const _idImporter:SingletonAttributeImporter = new SingletonAttributeImporter("id");
      
      private static const _typeNameImporter:SingletonAttributeImporter = new SingletonAttributeImporter("typeName");
      
      private static const _customFormatImporter:CustomFormatImporter = new CustomFormatImporter();
      
      private static const _flowElementFormatImporters:Array = [_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
      
      static const _linkDescription:Object = {
         "href":Property.NewStringProperty("href",null,false,null),
         "target":Property.NewStringProperty("target",null,false,null)
      };
      
      private static const _linkFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary,_linkDescription);
      
      private static const _linkElementFormatImporters:Array = [_linkFormatImporter,_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
      
      private static const _imageDescription:Object = {
         "height":InlineGraphicElement.heightPropertyDefinition,
         "width":InlineGraphicElement.widthPropertyDefinition,
         "source":Property.NewStringProperty("source",null,false,null),
         "float":Property.NewStringProperty("float",null,false,null),
         "rotation":InlineGraphicElement.rotationPropertyDefinition
      };
      
      private static const _ilgFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary,_imageDescription);
      
      private static const _ilgElementFormatImporters:Array = [_ilgFormatImporter,_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
       
      
      private var _imageSourceResolveFunction:Function;
      
      public function TextLayoutImporter()
      {
         super(new Namespace("flow","http://ns.adobe.com/textLayout/2008"),defaultConfiguration);
      }
      
      public static function get defaultConfiguration() : ImportExportConfiguration
      {
         if(!_defaultConfiguration)
         {
            _defaultConfiguration = new ImportExportConfiguration();
            _defaultConfiguration.addIEInfo("TextFlow",TextFlow,BaseTextLayoutImporter.parseTextFlow,BaseTextLayoutExporter.exportTextFlow);
            _defaultConfiguration.addIEInfo("br",BreakElement,BaseTextLayoutImporter.parseBreak,BaseTextLayoutExporter.exportFlowElement);
            _defaultConfiguration.addIEInfo("p",ParagraphElement,BaseTextLayoutImporter.parsePara,BaseTextLayoutExporter.exportParagraphFormattedElement);
            _defaultConfiguration.addIEInfo("span",SpanElement,BaseTextLayoutImporter.parseSpan,BaseTextLayoutExporter.exportSpan);
            _defaultConfiguration.addIEInfo("tab",TabElement,BaseTextLayoutImporter.parseTab,BaseTextLayoutExporter.exportFlowElement);
            _defaultConfiguration.addIEInfo("list",ListElement,BaseTextLayoutImporter.parseList,BaseTextLayoutExporter.exportList);
            _defaultConfiguration.addIEInfo("li",ListItemElement,BaseTextLayoutImporter.parseListItem,BaseTextLayoutExporter.exportListItem);
            _defaultConfiguration.addIEInfo("g",SubParagraphGroupElement,TextLayoutImporter.parseSPGE,TextLayoutExporter.exportSPGE);
            _defaultConfiguration.addIEInfo("tcy",TCYElement,TextLayoutImporter.parseTCY,TextLayoutExporter.exportTCY);
            _defaultConfiguration.addIEInfo("a",LinkElement,TextLayoutImporter.parseLink,TextLayoutExporter.exportLink);
            _defaultConfiguration.addIEInfo("div",DivElement,TextLayoutImporter.parseDivElement,TextLayoutExporter.exportDiv);
            _defaultConfiguration.addIEInfo("img",InlineGraphicElement,TextLayoutImporter.parseInlineGraphic,TextLayoutExporter.exportImage);
            _defaultConfiguration.addIEInfo("table",TableElement,TextLayoutImporter.parseTable,TextLayoutExporter.exportTable);
            _defaultConfiguration.addIEInfo("tr",TableRowElement,TextLayoutImporter.parseTableRow,TextLayoutExporter.exportTableRow);
            _defaultConfiguration.addIEInfo("th",TableCellElement,TextLayoutImporter.parseTableCell,TextLayoutExporter.exportTableCell);
            _defaultConfiguration.addIEInfo("td",TableCellElement,TextLayoutImporter.parseTableCell,TextLayoutExporter.exportTableCell);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_NORMAL_FORMAT_NAME,null,TextLayoutImporter.parseLinkNormalFormat,null);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_ACTIVE_FORMAT_NAME,null,TextLayoutImporter.parseLinkActiveFormat,null);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_HOVER_FORMAT_NAME,null,TextLayoutImporter.parseLinkHoverFormat,null);
            _defaultConfiguration.addIEInfo(ListElement.LIST_MARKER_FORMAT_NAME,null,TextLayoutImporter.parseListMarkerFormat,null);
         }
         return _defaultConfiguration;
      }
      
      public static function restoreDefaults() : void
      {
         _defaultConfiguration = null;
      }
      
      public static function parseSPGE(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var elem:SubParagraphGroupElement = TextLayoutImporter(importFilter).createSubParagraphGroupFromXML(xmlToParse);
         if(importFilter.addChild(parent,elem))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,elem);
            if(elem.numChildren == 0)
            {
               elem.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseTCY(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var tcyElem:TCYElement = TextLayoutImporter(importFilter).createTCYFromXML(xmlToParse);
         if(importFilter.addChild(parent,tcyElem))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,tcyElem);
            if(tcyElem.numChildren == 0)
            {
               tcyElem.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseLink(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var linkElem:LinkElement = TextLayoutImporter(importFilter).createLinkFromXML(xmlToParse);
         if(importFilter.addChild(parent,linkElem))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,linkElem);
            if(linkElem.numChildren == 0)
            {
               linkElem.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseLinkNormalFormat(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         parent.linkNormalFormat = TextLayoutImporter(importFilter).createDictionaryFromXML(xmlToParse);
      }
      
      public static function parseLinkActiveFormat(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         parent.linkActiveFormat = TextLayoutImporter(importFilter).createDictionaryFromXML(xmlToParse);
      }
      
      public static function parseLinkHoverFormat(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         parent.linkHoverFormat = TextLayoutImporter(importFilter).createDictionaryFromXML(xmlToParse);
      }
      
      public static function parseListMarkerFormat(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         parent.listMarkerFormat = TextLayoutImporter(importFilter).createListMarkerFormatDictionaryFromXML(xmlToParse);
      }
      
      public static function parseDivElement(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var divElem:DivElement = TextLayoutImporter(importFilter).createDivFromXML(xmlToParse);
         if(importFilter.addChild(parent,divElem))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,divElem);
            if(divElem.numChildren == 0)
            {
               divElem.addChild(new ParagraphElement());
            }
         }
      }
      
      public static function parseInlineGraphic(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var ilg:InlineGraphicElement = TextLayoutImporter(importFilter).createInlineGraphicFromXML(xmlToParse);
         importFilter.addChild(parent,ilg);
      }
      
      public static function parseTable(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var tableElement:TableElement = TextLayoutImporter(importFilter).createTableFromXML(xmlToParse);
         if(importFilter.addChild(parent,tableElement))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,tableElement);
         }
      }
      
      public static function parseTableRow(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var table:TableElement = null;
         var columnCount:int = 0;
         var tableRowElement:TableRowElement = TextLayoutImporter(importFilter).createTableRowFromXML(xmlToParse);
         if(importFilter.addChild(parent,tableRowElement))
         {
            importFilter.parseFlowGroupElementChildren(xmlToParse,tableRowElement);
            table = tableRowElement.getTable();
            columnCount = tableRowElement.getColumnCount();
            if(table.numColumns < columnCount)
            {
               table.numColumns = columnCount;
            }
            table.insertRow(tableRowElement,tableRowElement.mxmlChildren);
         }
      }
      
      public static function parseTableCell(importFilter:BaseTextLayoutImporter, xmlToParse:XML, parent:FlowGroupElement) : void
      {
         var tableCellElement:TableCellElement = TextLayoutImporter(importFilter).createTableCellFromXML(xmlToParse);
         if(importFilter.addChild(parent,tableCellElement))
         {
            importFilter.parseTableCellElementChildren(xmlToParse,tableCellElement);
         }
         TableRowElement(parent).addCell(tableCellElement);
      }
      
      public static function getTextFlowContent(text:String = null, selectable:Boolean = false, editable:Boolean = false) : TextFlow
      {
         var textFlowContent:TextFlow = new TextFlow();
         var paragraph:ParagraphElement = new ParagraphElement();
         var span:SpanElement = new SpanElement();
         if(text)
         {
            span.text = text;
         }
         else
         {
            span.text = "";
         }
         paragraph.backgroundAlpha = 0.2;
         paragraph.backgroundColor = 16711680;
         paragraph.addChild(span);
         if(!editable)
         {
            if(!selectable)
            {
            }
         }
         textFlowContent.addChild(paragraph);
         return textFlowContent;
      }
      
      public function get imageSourceResolveFunction() : Function
      {
         return this._imageSourceResolveFunction;
      }
      
      public function set imageSourceResolveFunction(resolver:Function) : void
      {
         this._imageSourceResolveFunction = resolver;
      }
      
      override protected function parseContent(rootStory:XML) : TextFlow
      {
         var rootName:String = rootStory.name().localName;
         var textFlowElement:XML = rootName == "TextFlow" ? rootStory : rootStory..TextFlow[0];
         if(!textFlowElement)
         {
            reportError(GlobalSettings.resourceStringFunction("missingTextFlow"));
            return null;
         }
         if(!checkNamespace(textFlowElement))
         {
            return null;
         }
         return parseTextFlow(this,textFlowElement);
      }
      
      private function parseStandardFlowElementAttributes(flowElem:FlowElement, xmlToParse:XML, importers:Array = null) : void
      {
         var styleName:* = null;
         if(importers == null)
         {
            importers = _flowElementFormatImporters;
         }
         parseAttributes(xmlToParse,importers);
         var textFormat:TextLayoutFormat = this.extractTextFormatAttributesHelper(flowElem.format,_formatImporter) as TextLayoutFormat;
         if(textFormat)
         {
            flowElem.format = textFormat;
         }
         if(_idImporter.result)
         {
            flowElem.id = _idImporter.result as String;
         }
         if(_typeNameImporter.result)
         {
            flowElem.typeName = _typeNameImporter.result as String;
         }
         if(_customFormatImporter.result)
         {
            for(styleName in _customFormatImporter.result)
            {
               flowElem.setStyle(styleName,_customFormatImporter.result[styleName]);
            }
         }
      }
      
      override public function createTextFlowFromXML(xmlToParse:XML, textFlow:TextFlow = null) : TextFlow
      {
         var version:String = null;
         var newFlow:TextFlow = null;
         if(!checkNamespace(xmlToParse))
         {
            return newFlow;
         }
         if(xmlToParse.hasOwnProperty("@version"))
         {
            version = xmlToParse["version"];
            if(version == "3.0.0")
            {
               _importVersion = TextLayoutVersion.VERSION_3_0;
            }
            else if(version == "2.0.0")
            {
               _importVersion = TextLayoutVersion.VERSION_2_0;
            }
            else if(version == "1.1.0" || version == "1.0.0")
            {
               _importVersion = TextLayoutVersion.VERSION_1_0;
            }
            else
            {
               reportError(GlobalSettings.resourceStringFunction("unsupportedVersion",[xmlToParse["version"]]));
               _importVersion = TextLayoutVersion.CURRENT_VERSION;
            }
         }
         else
         {
            _importVersion = TextLayoutVersion.VERSION_1_0;
         }
         if(!newFlow)
         {
            newFlow = new TextFlow(_textFlowConfiguration);
         }
         this.parseStandardFlowElementAttributes(newFlow,xmlToParse);
         parseFlowGroupElementChildren(xmlToParse,newFlow);
         newFlow.normalize();
         newFlow.applyWhiteSpaceCollapse(null);
         return newFlow;
      }
      
      public function createDivFromXML(xmlToParse:XML) : DivElement
      {
         var divElem:DivElement = new DivElement();
         this.parseStandardFlowElementAttributes(divElem,xmlToParse);
         return divElem;
      }
      
      public function createTableFromXML(xmlToParse:XML) : TableElement
      {
         var tableElement:TableElement = new TableElement();
         this.parseStandardFlowElementAttributes(tableElement,xmlToParse);
         return tableElement;
      }
      
      public function createTableRowFromXML(xmlToParse:XML) : TableRowElement
      {
         var tableRowElement:TableRowElement = new TableRowElement();
         this.parseStandardFlowElementAttributes(tableRowElement,xmlToParse);
         return tableRowElement;
      }
      
      public function createTableCellFromXML(xmlToParse:XML) : TableCellElement
      {
         var tableCellElement:TableCellElement = new TableCellElement();
         this.parseStandardFlowElementAttributes(tableCellElement,xmlToParse);
         return tableCellElement;
      }
      
      override public function createParagraphFromXML(xmlToParse:XML) : ParagraphElement
      {
         var paraElem:ParagraphElement = new ParagraphElement();
         this.parseStandardFlowElementAttributes(paraElem,xmlToParse);
         return paraElem;
      }
      
      public function createSubParagraphGroupFromXML(xmlToParse:XML) : SubParagraphGroupElement
      {
         var elem:SubParagraphGroupElement = new SubParagraphGroupElement();
         this.parseStandardFlowElementAttributes(elem,xmlToParse);
         return elem;
      }
      
      public function createTCYFromXML(xmlToParse:XML) : TCYElement
      {
         var tcyElem:TCYElement = new TCYElement();
         this.parseStandardFlowElementAttributes(tcyElem,xmlToParse);
         return tcyElem;
      }
      
      public function createLinkFromXML(xmlToParse:XML) : LinkElement
      {
         var linkElem:LinkElement = new LinkElement();
         this.parseStandardFlowElementAttributes(linkElem,xmlToParse,_linkElementFormatImporters);
         if(_linkFormatImporter.result)
         {
            linkElem.href = _linkFormatImporter.result["href"] as String;
            linkElem.target = _linkFormatImporter.result["target"] as String;
         }
         return linkElem;
      }
      
      override public function createSpanFromXML(xmlToParse:XML) : SpanElement
      {
         var spanElem:SpanElement = new SpanElement();
         this.parseStandardFlowElementAttributes(spanElem,xmlToParse);
         return spanElem;
      }
      
      public function createInlineGraphicFromXML(xmlToParse:XML) : InlineGraphicElement
      {
         var source:String = null;
         var imgElem:InlineGraphicElement = new InlineGraphicElement();
         this.parseStandardFlowElementAttributes(imgElem,xmlToParse,_ilgElementFormatImporters);
         if(_ilgFormatImporter.result)
         {
            source = _ilgFormatImporter.result["source"];
            imgElem.source = this._imageSourceResolveFunction != null ? this._imageSourceResolveFunction(source) : source;
            imgElem.height = _ilgFormatImporter.result["height"];
            imgElem.width = _ilgFormatImporter.result["width"];
            imgElem.float = _ilgFormatImporter.result["float"];
         }
         return imgElem;
      }
      
      override public function createListFromXML(xmlToParse:XML) : ListElement
      {
         var rslt:ListElement = new ListElement();
         this.parseStandardFlowElementAttributes(rslt,xmlToParse);
         return rslt;
      }
      
      override public function createListItemFromXML(xmlToParse:XML) : ListItemElement
      {
         var rslt:ListItemElement = new ListItemElement();
         this.parseStandardFlowElementAttributes(rslt,xmlToParse);
         return rslt;
      }
      
      public function extractTextFormatAttributesHelper(curAttrs:Object, importer:TLFormatImporter) : Object
      {
         return extractAttributesHelper(curAttrs,importer);
      }
      
      public function createDictionaryFromXML(xmlToParse:XML) : Dictionary
      {
         var formatImporters:Array = [_customFormatImporter];
         var formatList:XMLList = xmlToParse..TextLayoutFormat;
         if(formatList.length() != 1)
         {
            reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneTextLayoutFormat",[xmlToParse.name()]));
         }
         var parseThis:XML = formatList.length() > 0 ? formatList[0] : xmlToParse;
         parseAttributes(parseThis,formatImporters);
         return _customFormatImporter.result as Dictionary;
      }
      
      public function createListMarkerFormatDictionaryFromXML(xmlToParse:XML) : Dictionary
      {
         var formatImporters:Array = [_customFormatImporter];
         var formatList:XMLList = xmlToParse..ListMarkerFormat;
         if(formatList.length() != 1)
         {
            reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneListMarkerFormat",[xmlToParse.name()]));
         }
         var parseThis:XML = formatList.length() > 0 ? formatList[0] : xmlToParse;
         parseAttributes(parseThis,formatImporters);
         return _customFormatImporter.result as Dictionary;
      }
   }
}
