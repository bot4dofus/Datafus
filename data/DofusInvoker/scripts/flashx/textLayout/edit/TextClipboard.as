package flashx.textLayout.edit
{
   import flash.desktop.Clipboard;
   import flash.system.System;
   import flashx.textLayout.conversion.ConversionType;
   import flashx.textLayout.conversion.ConverterBase;
   import flashx.textLayout.conversion.FormatDescriptor;
   import flashx.textLayout.conversion.ITextExporter;
   import flashx.textLayout.conversion.ITextImporter;
   import flashx.textLayout.conversion.TextConverter;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextClipboard
   {
      
      tlf_internal static const TEXT_LAYOUT_MARKUP:String = "TEXT_LAYOUT_MARKUP";
       
      
      public function TextClipboard()
      {
         super();
      }
      
      public static function getContents() : TextScrap
      {
         var systemClipboard:Clipboard = null;
         var getFromClipboard:Function = null;
         getFromClipboard = function(clipboardFormat:String):String
         {
            return !!systemClipboard.hasFormat(clipboardFormat) ? String(systemClipboard.getData(clipboardFormat)) : null;
         };
         systemClipboard = Clipboard.generalClipboard;
         return importScrap(getFromClipboard);
      }
      
      tlf_internal static function importScrap(importFunctor:Function) : TextScrap
      {
         var textScrap:TextScrap = null;
         var textOnClipboard:String = null;
         var descriptor:FormatDescriptor = null;
         var numFormats:int = TextConverter.numFormats;
         var i:int = 0;
         while(i < numFormats && !textScrap)
         {
            descriptor = TextConverter.getFormatDescriptorAt(i);
            textOnClipboard = importFunctor(descriptor.clipboardFormat);
            if(textOnClipboard && textOnClipboard != "")
            {
               textOnClipboard = textOnClipboard.replace(/\x0b/g," ");
               textScrap = importToScrap(textOnClipboard,descriptor.format);
            }
            i++;
         }
         return textScrap;
      }
      
      public static function setContents(textScrap:TextScrap) : void
      {
         var systemClipboard:Clipboard = null;
         var addToClipboard:Function = null;
         addToClipboard = function(clipboardFormat:String, clipboardData:String):void
         {
            systemClipboard.setData(clipboardFormat,clipboardData);
         };
         if(!textScrap)
         {
            return;
         }
         systemClipboard = Clipboard.generalClipboard;
         systemClipboard.clear();
         exportScrap(textScrap,addToClipboard);
      }
      
      tlf_internal static function exportScrap(scrap:TextScrap, exportFunctor:Function) : void
      {
         var descriptor:FormatDescriptor = null;
         var exportString:String = null;
         var formatsPosted:Array = [];
         var numFormats:int = TextConverter.numFormats;
         for(var i:int = 0; i < numFormats; i++)
         {
            descriptor = TextConverter.getFormatDescriptorAt(i);
            if(descriptor.clipboardFormat && formatsPosted.indexOf(descriptor.clipboardFormat) < 0)
            {
               exportString = exportForClipboard(scrap,descriptor.format);
               if(exportString)
               {
                  exportFunctor(descriptor.clipboardFormat,exportString);
                  formatsPosted.push(descriptor.clipboardFormat);
               }
            }
         }
      }
      
      tlf_internal static function importToScrap(textOnClipboard:String, format:String) : TextScrap
      {
         var textScrap:TextScrap = null;
         var textFlow:TextFlow = null;
         var importer:ITextImporter = TextConverter.getImporter(format);
         if(importer)
         {
            importer.useClipboardAnnotations = true;
            textFlow = importer.importToFlow(textOnClipboard);
            if(textFlow)
            {
               textScrap = new TextScrap(textFlow);
               if(format == TextConverter.PLAIN_TEXT_FORMAT)
               {
                  textScrap.setPlainText(true);
               }
               else if(format == TextConverter.TEXT_LAYOUT_FORMAT)
               {
                  textScrap.setPlainText(false);
               }
            }
            if(!textScrap && format == TextConverter.TEXT_LAYOUT_FORMAT)
            {
               textScrap = importOldTextLayoutFormatToScrap(textOnClipboard);
            }
         }
         return textScrap;
      }
      
      tlf_internal static function importOldTextLayoutFormatToScrap(textOnClipboard:String) : TextScrap
      {
         var textScrap:TextScrap = null;
         var xmlTree:XML = null;
         var beginArrayChild:XML = null;
         var endArrayChild:XML = null;
         var textLayoutMarkup:XML = null;
         var textFlow:TextFlow = null;
         var element:FlowElement = null;
         var endMissingArray:Array = null;
         var originalSettings:Object = XML.settings();
         try
         {
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            xmlTree = new XML(textOnClipboard);
            if(xmlTree.localName() == "TextScrap")
            {
               beginArrayChild = xmlTree..BeginMissingElements[0];
               endArrayChild = xmlTree..EndMissingElements[0];
               textLayoutMarkup = xmlTree..TextFlow[0];
               textFlow = TextConverter.importToFlow(textLayoutMarkup,TextConverter.TEXT_LAYOUT_FORMAT);
               if(textFlow)
               {
                  textScrap = new TextScrap(textFlow);
                  endMissingArray = getEndArray(endArrayChild,textFlow);
                  for each(element in endMissingArray)
                  {
                     element.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
                  }
               }
            }
            if(Configuration.playerEnablesArgoFeatures)
            {
               System["disposeXML"](xmlTree);
            }
         }
         finally
         {
            XML.setSettings(originalSettings);
         }
         return textScrap;
      }
      
      tlf_internal static function exportForClipboard(scrap:TextScrap, format:String) : String
      {
         var exporter:ITextExporter = TextConverter.getExporter(format);
         if(exporter)
         {
            exporter.useClipboardAnnotations = true;
            return exporter.export(scrap.textFlow,ConversionType.STRING_TYPE) as String;
         }
         return null;
      }
      
      private static function getBeginArray(beginArrayChild:XML, textFlow:TextFlow) : Array
      {
         var value:String = null;
         var posOfComma:int = 0;
         var startPos:int = 0;
         var endPos:int = 0;
         var curStr:String = null;
         var indexIntoFlowElement:int = 0;
         var beginArray:Array = new Array();
         var curFlElement:FlowElement = textFlow;
         if(beginArrayChild != null)
         {
            value = beginArrayChild.@value != undefined ? String(beginArrayChild.@value) : "";
            beginArray.push(textFlow);
            posOfComma = value.indexOf(",");
            while(posOfComma >= 0)
            {
               startPos = posOfComma + 1;
               posOfComma = value.indexOf(",",startPos);
               if(posOfComma >= 0)
               {
                  endPos = posOfComma;
               }
               else
               {
                  endPos = value.length;
               }
               curStr = value.substring(startPos,endPos);
               if(curStr.length > 0)
               {
                  indexIntoFlowElement = parseInt(curStr);
                  if(curFlElement is FlowGroupElement)
                  {
                     curFlElement = (curFlElement as FlowGroupElement).getChildAt(indexIntoFlowElement);
                     beginArray.push(curFlElement);
                  }
               }
            }
         }
         return beginArray.reverse();
      }
      
      private static function getEndArray(endArrayChild:XML, textFlow:TextFlow) : Array
      {
         var value:String = null;
         var posOfComma:int = 0;
         var startPos:int = 0;
         var endPos:int = 0;
         var curStr:String = null;
         var indexIntoFlowElement:int = 0;
         var endArray:Array = new Array();
         var curFlElement:FlowElement = textFlow;
         if(endArrayChild != null)
         {
            value = endArrayChild.@value != undefined ? String(endArrayChild.@value) : "";
            endArray.push(textFlow);
            posOfComma = value.indexOf(",");
            while(posOfComma >= 0)
            {
               startPos = posOfComma + 1;
               posOfComma = value.indexOf(",",startPos);
               if(posOfComma >= 0)
               {
                  endPos = posOfComma;
               }
               else
               {
                  endPos = value.length;
               }
               curStr = value.substring(startPos,endPos);
               if(curStr.length > 0)
               {
                  indexIntoFlowElement = parseInt(curStr);
                  if(curFlElement is FlowGroupElement)
                  {
                     curFlElement = (curFlElement as FlowGroupElement).getChildAt(indexIntoFlowElement);
                     endArray.push(curFlElement);
                  }
               }
            }
         }
         return endArray.reverse();
      }
   }
}

class TextClipboardSingletonEnforcer
{
    
   
   function TextClipboardSingletonEnforcer()
   {
      super();
   }
}
