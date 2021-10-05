package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ListMarkerFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   class TextLayoutExporter extends BaseTextLayoutExporter
   {
      
      private static var _formatDescription:Object = TextLayoutFormat.description;
      
      private static const brTabRegEx:RegExp = new RegExp("[" + " " + "\t" + "]");
       
      
      function TextLayoutExporter()
      {
         super(new Namespace("http://ns.adobe.com/textLayout/2008"),null,TextLayoutImporter.defaultConfiguration);
      }
      
      public static function exportImage(exporter:BaseTextLayoutExporter, image:InlineGraphicElement) : XMLList
      {
         var output:XMLList = exportFlowElement(exporter,image);
         if(image.height !== undefined)
         {
            output.@height = image.height;
         }
         if(image.width !== undefined)
         {
            output.@width = image.width;
         }
         if(image.source != null)
         {
            output.@source = image.source;
         }
         if(image.float != undefined)
         {
            output.@float = image.float;
         }
         return output;
      }
      
      public static function exportLink(exporter:BaseTextLayoutExporter, link:LinkElement) : XMLList
      {
         var output:XMLList = exportFlowGroupElement(exporter,link);
         if(link.href)
         {
            output.@href = link.href;
         }
         if(link.target)
         {
            output.@target = link.target;
         }
         return output;
      }
      
      public static function exportDiv(exporter:BaseTextLayoutExporter, div:DivElement) : XMLList
      {
         return exportContainerFormattedElement(exporter,div);
      }
      
      public static function exportSPGE(exporter:BaseTextLayoutExporter, elem:SubParagraphGroupElement) : XMLList
      {
         return exportFlowGroupElement(exporter,elem);
      }
      
      public static function exportTCY(exporter:BaseTextLayoutExporter, tcy:TCYElement) : XMLList
      {
         return exportFlowGroupElement(exporter,tcy);
      }
      
      public static function exportTable(exporter:BaseTextLayoutExporter, table:TableElement) : XMLList
      {
         return exportTableElement(exporter,table);
      }
      
      public static function exportTableRow(exporter:BaseTextLayoutExporter, tableRow:TableRowElement) : XMLList
      {
         return exportTableRowElement(exporter,tableRow);
      }
      
      public static function exportTableCell(exporter:BaseTextLayoutExporter, tableCell:TableCellElement) : XMLList
      {
         return exportTableCellElement(exporter,tableCell);
      }
      
      override protected function get spanTextReplacementRegex() : RegExp
      {
         return brTabRegEx;
      }
      
      override protected function getSpanTextReplacementXML(ch:String) : XML
      {
         var replacementXML:XML = null;
         if(ch == " ")
         {
            replacementXML = <br/>;
         }
         else
         {
            if(ch != "\t")
            {
               return null;
            }
            replacementXML = <tab/>;
         }
         replacementXML.setNamespace(flowNS);
         return replacementXML;
      }
      
      tlf_internal function createStylesFromDescription(styles:Object, description:Object, includeUserStyles:Boolean, exclusions:Array) : Array
      {
         var key:* = null;
         var val:Object = null;
         var prop:Property = null;
         var customDictProp:XMLList = null;
         var sortableStyles:Array = [];
         for(key in styles)
         {
            val = styles[key];
            if(!(exclusions && exclusions.indexOf(val) != -1))
            {
               prop = description[key];
               if(!prop)
               {
                  if(includeUserStyles)
                  {
                     if(val is String || val.hasOwnProperty("toString"))
                     {
                        sortableStyles.push({
                           "xmlName":key,
                           "xmlVal":val
                        });
                     }
                  }
               }
               else if(val is TextLayoutFormat)
               {
                  customDictProp = this.exportObjectAsTextLayoutFormat(key,(val as TextLayoutFormat).getStyles());
                  if(customDictProp)
                  {
                     sortableStyles.push({
                        "xmlName":key,
                        "xmlVal":customDictProp
                     });
                  }
               }
               else
               {
                  sortableStyles.push({
                     "xmlName":key,
                     "xmlVal":prop.toXMLString(val)
                  });
               }
            }
         }
         return sortableStyles;
      }
      
      tlf_internal function exportObjectAsTextLayoutFormat(key:String, styleDict:Object) : XMLList
      {
         var elementName:String = null;
         var description:Object = null;
         if(key == LinkElement.LINK_NORMAL_FORMAT_NAME || key == LinkElement.LINK_ACTIVE_FORMAT_NAME || key == LinkElement.LINK_HOVER_FORMAT_NAME)
         {
            elementName = "TextLayoutFormat";
            description = TextLayoutFormat.description;
         }
         else if(key == ListElement.LIST_MARKER_FORMAT_NAME)
         {
            elementName = "ListMarkerFormat";
            description = ListMarkerFormat.description;
         }
         if(elementName == null)
         {
            return null;
         }
         var formatXML:XML = new XML("<" + elementName + "/>");
         formatXML.setNamespace(flowNS);
         var sortableStyles:Array = this.createStylesFromDescription(styleDict,description,true,null);
         exportStyles(XMLList(formatXML),sortableStyles);
         var propertyXML:XMLList = XMLList(new XML("<" + key + "/>"));
         propertyXML.appendChild(formatXML);
         return propertyXML;
      }
      
      override protected function exportFlowElement(flowElement:FlowElement) : XMLList
      {
         var sortableStyles:Array = null;
         var rslt:XMLList = super.exportFlowElement(flowElement);
         var allStyles:Object = flowElement.styles;
         if(allStyles)
         {
            delete allStyles[TextLayoutFormat.whiteSpaceCollapseProperty.name];
            sortableStyles = this.createStylesFromDescription(allStyles,this.formatDescription,true,!!flowElement.parent ? null : [FormatValue.INHERIT]);
            exportStyles(rslt,sortableStyles);
         }
         if(flowElement.id != null)
         {
            rslt["id"] = flowElement.id;
         }
         if(flowElement.typeName != flowElement.defaultTypeName)
         {
            rslt["typeName"] = flowElement.typeName;
         }
         return rslt;
      }
      
      override protected function get formatDescription() : Object
      {
         return _formatDescription;
      }
   }
}
