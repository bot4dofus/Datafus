package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.types.event.CssEvent;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.FontManager;
   import flash.text.AntiAliasType;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   import flash.text.engine.CFFHinting;
   import flash.text.engine.FontLookup;
   import flash.text.engine.RenderingMode;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.formats.TextLayoutFormat;
   
   public class ExtendedStyleSheet extends StyleSheet
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExtendedStyleSheet));
      
      private static const CSS_INHERITANCE_KEYWORD:String = "extends";
      
      private static const CSS_FILES_KEYWORD:String = "files";
       
      
      private var _inherit:Array;
      
      private var _inherited:uint;
      
      private var _url:String;
      
      private var _content:String;
      
      private var _fontStyle:String;
      
      public function ExtendedStyleSheet(url:String)
      {
         this._inherit = new Array();
         this._inherited = 0;
         this._url = url;
         super();
      }
      
      public function get inherit() : Array
      {
         return this._inherit;
      }
      
      public function get ready() : Boolean
      {
         return this._inherited == this._inherit.length;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      override public function parseCSS(content:String) : void
      {
         this._fontStyle = FontManager.getInstance().activeType.toLowerCase();
         this._content = content;
         super.parseCSS(content);
         this.update();
      }
      
      override public function transform(formatObject:Object) : TextFormat
      {
         if(this._fontStyle != FontManager.getInstance().activeType.toLowerCase())
         {
            this.parseCSS(this._content);
         }
         return super.transform(formatObject);
      }
      
      public function merge(stylesheet:ExtendedStyleSheet, replace:Boolean = false) : void
      {
         var localDef:Object = null;
         var newDef:Object = null;
         var property:* = null;
         for(var i:uint = 0; i < stylesheet.styleNames.length; i++)
         {
            if(stylesheet.styleNames[i] != CSS_INHERITANCE_KEYWORD)
            {
               localDef = getStyle(stylesheet.styleNames[i]);
               newDef = stylesheet.getStyle(stylesheet.styleNames[i]);
               if(localDef)
               {
                  for(property in newDef)
                  {
                     if(localDef[property] == null || replace)
                     {
                        localDef[property] = newDef[property];
                     }
                  }
                  newDef = localDef;
               }
               setStyle(stylesheet.styleNames[i],newDef);
            }
         }
      }
      
      override public function toString() : String
      {
         var localDef:Object = null;
         var property:* = null;
         var result:String = "";
         result += "File " + this.url + " :\n";
         for(var i:uint = 0; i < styleNames.length; i++)
         {
            localDef = getStyle(styleNames[i]);
            result += " [" + styleNames[i] + "]\n";
            for(property in localDef)
            {
               result += "  " + property + " : " + localDef[property] + "\n";
            }
         }
         return result;
      }
      
      public function TLFTransform(formatObject:Object) : TextLayoutFormat
      {
         var cssFont:String = null;
         var format:TextLayoutFormat = new TextLayoutFormat();
         if(formatObject["fontFamily"])
         {
            cssFont = formatObject["fontFamily"];
            if(FontManager.getInstance().getFontInfo(cssFont).antialiasingType == AntiAliasType.ADVANCED)
            {
               format.renderingMode = RenderingMode.CFF;
               format.fontLookup = FontLookup.EMBEDDED_CFF;
               format.cffHinting = CFFHinting.HORIZONTAL_STEM;
            }
            format.fontFamily = cssFont;
         }
         if(formatObject["color"])
         {
            format.color = formatObject["color"];
         }
         if(formatObject["fontSize"])
         {
            format.fontSize = formatObject["fontSize"];
         }
         if(formatObject["paddingLeft"])
         {
            format.paddingLeft = formatObject["paddingLeft"];
         }
         if(formatObject["paddingRight"])
         {
            format.paddingRight = formatObject["paddingRight"];
         }
         if(formatObject["paddingBottom"])
         {
            format.paddingBottom = formatObject["paddingBottom"];
         }
         if(formatObject["paddingTop"])
         {
            format.paddingTop = formatObject["paddingTop"];
         }
         if(formatObject["textIndent"])
         {
            format.textIndent = formatObject["textIndent"];
         }
         return format;
      }
      
      private function update() : void
      {
         var finalName:String = null;
         var name:* = null;
         var names:Array = null;
         var fontTypeOverried:* = false;
         var computedStyle:Object = null;
         var done:Boolean = false;
         var subStyleName:String = null;
         var subStyle:Object = null;
         var propertyName:* = null;
         var proceedStyle:Dictionary = new Dictionary();
         var blocked:Boolean = false;
         var oneMoreTime:Boolean = true;
         while(!blocked && oneMoreTime)
         {
            blocked = true;
            oneMoreTime = false;
            for each(name in styleNames)
            {
               names = name.split("_");
               finalName = names[0];
               if(!proceedStyle[finalName])
               {
                  fontTypeOverried = getStyle(finalName + "-" + this._fontStyle) == null;
                  if(names.length > 1 || fontTypeOverried)
                  {
                     names.shift();
                     names.reverse();
                     names.push(name);
                     if(fontTypeOverried)
                     {
                        names.push(finalName + "-" + this._fontStyle);
                     }
                     computedStyle = {};
                     done = true;
                     for each(subStyleName in names)
                     {
                        if(subStyleName != name && proceedStyle[subStyleName] == null)
                        {
                           done = false;
                           break;
                        }
                        subStyle = !!proceedStyle[subStyleName] ? proceedStyle[subStyleName] : getStyle(subStyleName);
                        if(subStyle != null)
                        {
                           for(propertyName in subStyle)
                           {
                              if(subStyle[propertyName] != null)
                              {
                                 computedStyle[propertyName] = subStyle[propertyName];
                              }
                           }
                        }
                     }
                     if(done)
                     {
                        proceedStyle[finalName] = computedStyle;
                        blocked = false;
                     }
                     else
                     {
                        oneMoreTime = true;
                     }
                  }
                  else
                  {
                     blocked = false;
                     proceedStyle[finalName] = getStyle(finalName);
                  }
               }
            }
         }
         clear();
         for(name in proceedStyle)
         {
            setStyle(name,proceedStyle[name]);
         }
         dispatchEvent(new CssEvent(CssEvent.CSS_PARSED,false,false,this));
      }
   }
}
