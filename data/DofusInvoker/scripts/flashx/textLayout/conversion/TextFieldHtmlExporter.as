package flashx.textLayout.conversion
{
   import flash.text.engine.FontPosture;
   import flash.text.engine.FontWeight;
   import flash.text.engine.Kerning;
   import flash.text.engine.TabAlignment;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TabElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.formats.TabStopFormat;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.TextDecoration;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class TextFieldHtmlExporter extends ConverterBase implements ITextExporter
   {
      
      tlf_internal static var _config:ImportExportConfiguration;
      
      tlf_internal static const brRegEx:RegExp = / /;
       
      
      public function TextFieldHtmlExporter()
      {
         super();
         if(!tlf_internal::_config)
         {
            _config = new ImportExportConfiguration();
            tlf_internal::_config.addIEInfo(null,DivElement,null,this.exportDiv);
            tlf_internal::_config.addIEInfo(null,ParagraphElement,null,this.exportParagraph);
            tlf_internal::_config.addIEInfo(null,LinkElement,null,this.exportLink);
            tlf_internal::_config.addIEInfo(null,TCYElement,null,this.exportTCY);
            tlf_internal::_config.addIEInfo(null,SubParagraphGroupElement,null,this.exportSPGE);
            tlf_internal::_config.addIEInfo(null,SpanElement,null,this.exportSpan);
            tlf_internal::_config.addIEInfo(null,InlineGraphicElement,null,this.exportImage);
            tlf_internal::_config.addIEInfo(null,TabElement,null,this.exportTab);
            tlf_internal::_config.addIEInfo(null,BreakElement,null,this.exportBreak);
            tlf_internal::_config.addIEInfo(null,ListElement,null,this.exportList);
            tlf_internal::_config.addIEInfo(null,ListItemElement,null,this.exportListItem);
         }
      }
      
      tlf_internal static function makeTaggedTypeName(elem:FlowElement, defaultTag:String) : XML
      {
         if(elem.typeName == elem.defaultTypeName)
         {
            return new XML("<" + defaultTag + "/>");
         }
         return new XML("<" + elem.typeName.toUpperCase() + "/>");
      }
      
      tlf_internal static function exportStyling(elem:FlowElement, xml:XML) : void
      {
         if(elem.id != null)
         {
            xml["id"] = elem.id;
         }
         if(elem.styleName != null)
         {
            xml["class"] = elem.styleName;
         }
      }
      
      tlf_internal static function getSpanTextReplacementXML(ch:String) : XML
      {
         return <BR/>;
      }
      
      tlf_internal static function nest(parent:XML, children:Object) : XML
      {
         parent.setChildren(children);
         return parent;
      }
      
      public function export(source:TextFlow, conversionType:String) : Object
      {
         var result:XML = this.exportToXML(source);
         return conversionType == ConversionType.STRING_TYPE ? BaseTextLayoutExporter.convertXMLToString(result) : result;
      }
      
      tlf_internal function exportToXML(textFlow:TextFlow) : XML
      {
         var body:XML = null;
         var html:XML = <HTML/>;
         if(textFlow.numChildren != 0)
         {
            if(textFlow.getChildAt(0).typeName != "BODY")
            {
               body = <BODY/>;
               html.appendChild(body);
               this.exportChildren(textFlow,body);
            }
            else
            {
               this.exportChildren(textFlow,html);
            }
         }
         return html;
      }
      
      tlf_internal function exportChildren(elem:FlowGroupElement, parentXML:XML) : void
      {
         var child:FlowElement = null;
         for(var idx:int = 0; idx < elem.numChildren; idx++)
         {
            child = elem.getChildAt(idx);
            this.exportElement(child,parentXML);
         }
      }
      
      tlf_internal function exportList(list:ListElement, parentXML:XML) : void
      {
         var xml:XML = null;
         var typeNameXML:XML = null;
         if(list.isNumberedList())
         {
            xml = <OL/>;
         }
         else
         {
            xml = <UL/>;
         }
         exportStyling(list,xml);
         this.exportChildren(list,xml);
         if(list.typeName != list.defaultTypeName)
         {
            typeNameXML = new XML("<" + list.typeName + "/>");
            typeNameXML.appendChild(xml);
            parentXML.appendChild(typeNameXML);
         }
         else
         {
            parentXML.appendChild(xml);
         }
      }
      
      tlf_internal function exportListItem(li:ListItemElement, parentXML:XML) : void
      {
         var child:XML = null;
         var paraChildren:XMLList = null;
         var xml:XML = <LI/>;
         exportStyling(li,xml);
         this.exportChildren(li,xml);
         var children:XMLList = xml.children();
         if(children.length() == 1)
         {
            child = children[0];
            if(child.name().localName == "P")
            {
               paraChildren = child.children();
               if(paraChildren.length() == 1)
               {
                  xml = <LI/>;
                  xml.appendChild(paraChildren[0]);
               }
            }
         }
         parentXML.appendChild(xml);
      }
      
      tlf_internal function exportDiv(div:DivElement, parentXML:XML) : void
      {
         var xml:XML = makeTaggedTypeName(div,"DIV");
         exportStyling(div,xml);
         this.exportChildren(div,xml);
         parentXML.appendChild(xml);
      }
      
      tlf_internal function exportParagraph(para:ParagraphElement, parentXML:XML) : void
      {
         var xml:XML = makeTaggedTypeName(para,"P");
         exportStyling(para,xml);
         var fontXML:XML = this.exportFont(para.computedFormat);
         this.exportSubParagraphChildren(para,fontXML);
         nest(xml,fontXML);
         parentXML.appendChild(this.exportParagraphFormat(xml,para));
      }
      
      tlf_internal function exportLink(link:LinkElement, parentXML:XML) : void
      {
         var xml:XML = <A/>;
         if(link.href)
         {
            xml.@HREF = link.href;
         }
         if(link.target)
         {
            xml.@TARGET = link.target;
         }
         else
         {
            xml.@TARGET = "_blank";
         }
         this.exportSubParagraphElement(link,xml,parentXML);
      }
      
      tlf_internal function exportTCY(tcy:TCYElement, parentXML:XML) : void
      {
         var xml:XML = <TCY/>;
         this.exportSubParagraphElement(tcy,xml,parentXML);
      }
      
      tlf_internal function exportSPGE(spge:SubParagraphGroupElement, parentXML:XML) : void
      {
         var xml:XML = spge.typeName != spge.defaultTypeName ? new XML("<" + spge.typeName + "/>") : <SPAN/>;
         this.exportSubParagraphElement(spge,xml,parentXML,false);
      }
      
      tlf_internal function exportSubParagraphElement(elem:SubParagraphGroupElementBase, xml:XML, parentXML:XML, checkTypeName:Boolean = true) : void
      {
         var typeNameXML:XML = null;
         exportStyling(elem,xml);
         this.exportSubParagraphChildren(elem,xml);
         var format:ITextLayoutFormat = elem.computedFormat;
         var ifDifferentFromFormat:ITextLayoutFormat = elem.parent.computedFormat;
         var font:XML = this.exportFont(format,ifDifferentFromFormat);
         var childXML:XML = !!font ? nest(font,xml) : xml;
         if(checkTypeName && elem.typeName != elem.defaultTypeName)
         {
            typeNameXML = new XML("<" + elem.typeName + "/>");
            typeNameXML.appendChild(childXML);
            parentXML.appendChild(typeNameXML);
         }
         else
         {
            parentXML.appendChild(childXML);
         }
      }
      
      tlf_internal function exportSpan(span:SpanElement, parentXML:XML) : void
      {
         var children:Object = null;
         var xml:XML = makeTaggedTypeName(span,"SPAN");
         exportStyling(span,xml);
         BaseTextLayoutExporter.exportSpanText(xml,span,tlf_internal::brRegEx,tlf_internal::getSpanTextReplacementXML);
         if(span.id == null && span.styleName == null && span.typeName == span.defaultTypeName)
         {
            children = xml.children();
            if(children.length() == 1 && children[0].nodeKind() == "text")
            {
               children = xml.text()[0];
            }
            parentXML.appendChild(this.exportSpanFormat(children,span));
         }
         else
         {
            parentXML.appendChild(this.exportSpanFormat(xml,span));
         }
      }
      
      tlf_internal function exportImage(image:InlineGraphicElement, parentXML:XML) : void
      {
         var typeNameXML:XML = null;
         var xml:XML = <IMG/>;
         exportStyling(image,xml);
         if(image.source)
         {
            xml.@SRC = image.source;
         }
         if(image.width !== undefined && image.width != FormatValue.AUTO)
         {
            xml.@WIDTH = image.width;
         }
         if(image.height !== undefined && image.height != FormatValue.AUTO)
         {
            xml.@HEIGHT = image.height;
         }
         if(image.computedFloat != Float.NONE)
         {
            xml.@ALIGN = image.float;
         }
         if(image.typeName != image.defaultTypeName)
         {
            typeNameXML = new XML("<" + image.typeName + "/>");
            typeNameXML.appendChild(xml);
            parentXML.appendChild(typeNameXML);
         }
         else
         {
            parentXML.appendChild(xml);
         }
      }
      
      tlf_internal function exportBreak(breakElement:BreakElement, parentXML:XML) : void
      {
         parentXML.appendChild(<BR/>);
      }
      
      tlf_internal function exportTab(tabElement:TabElement, parentXML:XML) : void
      {
         this.exportSpan(tabElement,parentXML);
      }
      
      tlf_internal function exportTextFormatAttribute(textFormatXML:XML, attrName:String, attrVal:*) : XML
      {
         if(!textFormatXML)
         {
            textFormatXML = <TEXTFORMAT/>;
         }
         textFormatXML[attrName] = attrVal;
         return textFormatXML;
      }
      
      tlf_internal function exportParagraphFormat(xml:XML, para:ParagraphElement) : XML
      {
         var textAlignment:String = null;
         var textFormat:XML = null;
         var firstLeaf:FlowLeafElement = null;
         var lineHeight:Number = NaN;
         var tabStopsString:* = null;
         var tabStop:TabStopFormat = null;
         var paraFormat:ITextLayoutFormat = para.computedFormat;
         switch(paraFormat.textAlign)
         {
            case TextAlign.START:
               textAlignment = paraFormat.direction == Direction.LTR ? TextAlign.LEFT : TextAlign.RIGHT;
               break;
            case TextAlign.END:
               textAlignment = paraFormat.direction == Direction.LTR ? TextAlign.RIGHT : TextAlign.LEFT;
               break;
            default:
               textAlignment = paraFormat.textAlign;
         }
         xml.@ALIGN = textAlignment;
         if(paraFormat.paragraphStartIndent != 0)
         {
            textFormat = this.exportTextFormatAttribute(textFormat,paraFormat.direction == Direction.LTR ? "LEFTMARGIN" : "RIGHTMARGIN",paraFormat.paragraphStartIndent);
         }
         if(paraFormat.paragraphEndIndent != 0)
         {
            textFormat = this.exportTextFormatAttribute(textFormat,paraFormat.direction == Direction.LTR ? "RIGHTMARGIN" : "LEFTMARGIN",paraFormat.paragraphEndIndent);
         }
         if(paraFormat.textIndent != 0)
         {
            textFormat = this.exportTextFormatAttribute(textFormat,"INDENT",paraFormat.textIndent);
         }
         if(paraFormat.leadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
         {
            firstLeaf = para.getFirstLeaf();
            if(firstLeaf)
            {
               lineHeight = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(firstLeaf.computedFormat.lineHeight,firstLeaf.getEffectiveFontSize());
               if(lineHeight != 0)
               {
                  textFormat = this.exportTextFormatAttribute(textFormat,"LEADING",lineHeight);
               }
            }
         }
         var tabStops:Array = paraFormat.tabStops;
         if(tabStops)
         {
            tabStopsString = "";
            for each(tabStop in tabStops)
            {
               if(tabStop.alignment != TabAlignment.START)
               {
                  break;
               }
               if(tabStopsString.length)
               {
                  tabStopsString += ", ";
               }
               tabStopsString += tabStop.position;
            }
            if(tabStopsString.length)
            {
               textFormat = this.exportTextFormatAttribute(textFormat,"TABSTOPS",tabStopsString);
            }
         }
         return !!textFormat ? nest(textFormat,xml) : xml;
      }
      
      tlf_internal function exportSpanFormat(xml:Object, span:SpanElement) : Object
      {
         var format:ITextLayoutFormat = span.computedFormat;
         var outerElement:Object = xml;
         if(format.textDecoration.toString() == TextDecoration.UNDERLINE)
         {
            outerElement = nest(<U/>,outerElement);
         }
         if(format.fontStyle.toString() == FontPosture.ITALIC)
         {
            outerElement = nest(<I/>,outerElement);
         }
         if(format.fontWeight.toString() == FontWeight.BOLD)
         {
            outerElement = nest(<B/>,outerElement);
         }
         var exportedParent:FlowElement = span.getParentByType(LinkElement);
         if(!exportedParent)
         {
            exportedParent = span.getParagraph();
         }
         var font:XML = this.exportFont(format,exportedParent.computedFormat);
         if(font)
         {
            outerElement = nest(font,outerElement);
         }
         return outerElement;
      }
      
      tlf_internal function exportFontAttribute(fontXML:XML, attrName:String, attrVal:*) : XML
      {
         if(!fontXML)
         {
            fontXML = <FONT/>;
         }
         fontXML[attrName] = attrVal;
         return fontXML;
      }
      
      tlf_internal function exportFont(format:ITextLayoutFormat, ifDifferentFromFormat:ITextLayoutFormat = null) : XML
      {
         var font:XML = null;
         var rgb:String = null;
         if(!ifDifferentFromFormat || ifDifferentFromFormat.fontFamily != format.fontFamily)
         {
            font = this.exportFontAttribute(font,"FACE",format.fontFamily);
         }
         if(!ifDifferentFromFormat || ifDifferentFromFormat.fontSize != format.fontSize)
         {
            font = this.exportFontAttribute(font,"SIZE",format.fontSize);
         }
         if(!ifDifferentFromFormat || ifDifferentFromFormat.color != format.color)
         {
            rgb = format.color.toString(16);
            while(rgb.length < 6)
            {
               rgb = "0" + rgb;
            }
            rgb = "#" + rgb;
            font = this.exportFontAttribute(font,"COLOR",rgb);
         }
         if(!ifDifferentFromFormat || ifDifferentFromFormat.trackingRight != format.trackingRight)
         {
            font = this.exportFontAttribute(font,"LETTERSPACING",format.trackingRight);
         }
         if(!ifDifferentFromFormat || ifDifferentFromFormat.kerning != format.kerning)
         {
            font = this.exportFontAttribute(font,"KERNING",format.kerning == Kerning.OFF ? "0" : "1");
         }
         return font;
      }
      
      tlf_internal function exportElement(flowElement:FlowElement, parentXML:XML) : void
      {
         var xml:XML = null;
         var className:String = getQualifiedClassName(flowElement);
         var info:FlowElementInfo = tlf_internal::_config.lookupByClass(className);
         if(info)
         {
            info.exporter(flowElement,parentXML);
         }
         else
         {
            xml = new XML("<" + flowElement.typeName.toUpperCase() + "/>");
            this.exportChildren(flowElement as FlowGroupElement,xml);
            parentXML.appendChild(xml);
         }
      }
      
      tlf_internal function exportSubParagraphChildren(flowGroupElement:FlowGroupElement, parentXML:XML) : void
      {
         for(var i:int = 0; i < flowGroupElement.numChildren; i++)
         {
            this.exportElement(flowGroupElement.getChildAt(i),parentXML);
         }
      }
   }
}
