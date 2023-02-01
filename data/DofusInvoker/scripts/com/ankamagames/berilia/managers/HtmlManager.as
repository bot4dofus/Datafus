package com.ankamagames.berilia.managers
{
   import com.adobe.utils.StringUtil;
   import flashx.textLayout.elements.SpanElement;
   
   public class HtmlManager
   {
      
      public static const LINK:String = "a";
      
      public static const SPAN:String = "span";
      
      public static const COLOR:String = "color";
      
      public static const UNDERLINE:String = "underline";
      
      public static const ITALIC:String = "italic";
      
      public static const BOLD:String = "bold";
      
      private static var htmlVersion:String;
      
      public static const OLD_FASHION:String = "old";
      
      public static const INLINE_CSS_VERSION:String = "inline";
       
      
      public function HtmlManager()
      {
         super();
      }
      
      public static function changeCssHandler(val:String) : void
      {
         switch(val)
         {
            case OLD_FASHION:
            case INLINE_CSS_VERSION:
               htmlVersion = val;
               break;
            default:
               htmlVersion = OLD_FASHION;
         }
      }
      
      public static function addTag(pText:String, pBalise:String, pStyle:Object = null) : String
      {
         if(htmlVersion == INLINE_CSS_VERSION)
         {
            if(isTagValide(pBalise))
            {
               return "<" + pBalise + " " + formateStyleWithInlineCss(pStyle) + ">" + pText + "</" + pBalise + ">";
            }
            return pText;
         }
         if(pStyle == null)
         {
            pStyle = new Object();
         }
         if(pBalise == BOLD)
         {
            pStyle[BOLD] = true;
         }
         if(pBalise == ITALIC)
         {
            pStyle[ITALIC] = true;
         }
         if(pBalise == UNDERLINE)
         {
            pStyle["text-decoration"] = UNDERLINE;
         }
         return formateStyleWithTags(pText,pStyle);
      }
      
      private static function formateStyleWithInlineCss(pStyle:Object = null) : String
      {
         var htmlText:* = "";
         if(pStyle != null)
         {
            htmlText += " style=\"";
            if(pStyle[COLOR])
            {
               htmlText += "color:" + getHexaColor(pStyle[COLOR]) + ";";
            }
            if(pStyle[ITALIC])
            {
               htmlText += "font-style:" + pStyle[ITALIC] + ";";
            }
            if(pStyle[BOLD])
            {
               htmlText += "font-weight: bold;";
            }
            htmlText += "\"";
         }
         return htmlText;
      }
      
      private static function formateStyleWithTags(pText:String, pStyle:Object = null) : String
      {
         var htmlText:* = "";
         if(pStyle != null)
         {
            if(pStyle[COLOR])
            {
               htmlText += "<font color=\"" + getHexaColor(pStyle[COLOR]) + "\">";
            }
            if(pStyle[ITALIC])
            {
               htmlText += "<i>";
            }
            if(pStyle[BOLD])
            {
               htmlText += "<b>";
            }
            if(pStyle["text-decoration"] == UNDERLINE || pStyle["textDecoration"] == UNDERLINE)
            {
               htmlText += "<u>";
            }
            htmlText += pText;
            if(pStyle["text-decoration"] == UNDERLINE || pStyle["textDecoration"] == UNDERLINE)
            {
               htmlText += "</u>";
            }
            if(pStyle[BOLD])
            {
               htmlText += "</b>";
            }
            if(pStyle[ITALIC])
            {
               htmlText += "</i>";
            }
            if(pStyle[COLOR])
            {
               htmlText += "</font>";
            }
         }
         else
         {
            htmlText = pText;
         }
         return htmlText;
      }
      
      private static function getHexaColor(pColor:*) : String
      {
         var hexaColor:String = "";
         switch(true)
         {
            case pColor is int:
            case pColor is uint:
               hexaColor = "#" + pColor.toString(16);
               break;
            case pColor is String:
               if(pColor.indexOf("#") == 0)
               {
                  hexaColor = String(pColor);
               }
               else
               {
                  hexaColor = pColor.replace("0x","#");
               }
               break;
            default:
               hexaColor = "#FF0000";
         }
         return hexaColor;
      }
      
      public static function addLink(pText:String, pHref:String = "", pStyle:Object = null, pForceInlineCss:Boolean = false) : String
      {
         if(htmlVersion == INLINE_CSS_VERSION || pForceInlineCss)
         {
            if(pStyle != null)
            {
               return "<" + LINK + " href=\"" + pHref + "\"" + formateStyleWithInlineCss(pStyle) + ">" + pText + "</" + LINK + ">";
            }
            return "<" + LINK + " href=\"" + pHref + "\">" + pText + "</" + LINK + ">";
         }
         return "<" + LINK + " href=\"" + pHref + "\"><b>" + pText + "</b></" + LINK + ">";
      }
      
      public static function removeStyle(pText:String, pBalise:String, pAllOccurrences:Boolean = false) : String
      {
         return pText;
      }
      
      public static function addStyleToWords(pParagraphe:String, pText:String, pBalise:String) : String
      {
         return pParagraphe;
      }
      
      private static function isTagValide(pTag:String) : Boolean
      {
         switch(pTag)
         {
            case SPAN:
               return true;
            default:
               return false;
         }
      }
      
      public static function parseStyle(val:String) : Array
      {
         var val1:String = null;
         var tab2:Array = null;
         var style:Array = new Array();
         var tab1:Array = val.split(";");
         for each(val1 in tab1)
         {
            tab2 = val1.split(":");
            if(tab2[0] != "")
            {
               style[tab2[0]] = StringUtil.trim(tab2[1]);
            }
         }
         return style;
      }
      
      public static function formateSpan(span:SpanElement, pStyle:String) : SpanElement
      {
         var style:Array = parseStyle(pStyle);
         if(style["font-weight"])
         {
            span.fontWeight = style["font-weight"];
         }
         if(style["color"])
         {
            span.color = style["color"];
         }
         if(style["background-color"])
         {
            span.backgroundColor = style["background-color"];
         }
         if(style["text-decoration"])
         {
            span.textDecoration = style["text-decoration"];
         }
         if(style["font-style"])
         {
            span.fontStyle = style["font-style"];
         }
         return span;
      }
      
      public static function addValueToInlineStyle(inlineStyle:String, data:String, value:String) : String
      {
         if(inlineStyle.length > 0)
         {
            if(inlineStyle.charAt(inlineStyle.length - 1) != ";")
            {
               inlineStyle += ";";
            }
            inlineStyle += data + ":" + value + ";";
         }
         else
         {
            inlineStyle = data + ":" + value + ";";
         }
         return inlineStyle;
      }
   }
}
