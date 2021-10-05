package flashx.textLayout.formats
{
   import flash.text.engine.TabAlignment;
   import flashx.textLayout.property.*;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TabStopFormat implements ITabStopFormat
   {
      
      public static const positionProperty:Property = Property.NewNumberProperty("position",0,false,Vector.<String>([Category.TABSTOP]),0,10000);
      
      public static const alignmentProperty:Property = Property.NewEnumStringProperty("alignment",TabAlignment.START,false,Vector.<String>([Category.TABSTOP]),TabAlignment.START,TabAlignment.CENTER,TabAlignment.END,TabAlignment.DECIMAL);
      
      public static const decimalAlignmentTokenProperty:Property = Property.NewStringProperty("decimalAlignmentToken",null,false,Vector.<String>([Category.TABSTOP]));
      
      private static var _description:Object = {
         "position":positionProperty,
         "alignment":alignmentProperty,
         "decimalAlignmentToken":decimalAlignmentTokenProperty
      };
      
      private static var _emptyTabStopFormat:ITabStopFormat;
      
      private static var _defaults:TabStopFormat;
       
      
      private var _position;
      
      private var _alignment;
      
      private var _decimalAlignmentToken;
      
      public function TabStopFormat(initialValues:ITabStopFormat = null)
      {
         super();
         if(initialValues)
         {
            this.apply(initialValues);
         }
      }
      
      tlf_internal static function get description() : Object
      {
         return _description;
      }
      
      tlf_internal static function get emptyTabStopFormat() : ITabStopFormat
      {
         if(_emptyTabStopFormat == null)
         {
            _emptyTabStopFormat = new TabStopFormat();
         }
         return _emptyTabStopFormat;
      }
      
      public static function isEqual(p1:ITabStopFormat, p2:ITabStopFormat) : Boolean
      {
         if(p1 == null)
         {
            p1 = tlf_internal::emptyTabStopFormat;
         }
         if(p2 == null)
         {
            p2 = tlf_internal::emptyTabStopFormat;
         }
         if(p1 == p2)
         {
            return true;
         }
         if(!positionProperty.equalHelper(p1.position,p2.position))
         {
            return false;
         }
         if(!alignmentProperty.equalHelper(p1.alignment,p2.alignment))
         {
            return false;
         }
         if(!decimalAlignmentTokenProperty.equalHelper(p1.decimalAlignmentToken,p2.decimalAlignmentToken))
         {
            return false;
         }
         return true;
      }
      
      public static function get defaultFormat() : ITabStopFormat
      {
         if(_defaults == null)
         {
            _defaults = new TabStopFormat();
            Property.defaultsAllHelper(_description,_defaults);
         }
         return _defaults;
      }
      
      public function getStyle(styleName:String) : *
      {
         return this[styleName];
      }
      
      public function setStyle(styleName:String, value:*) : void
      {
         this[styleName] = value;
      }
      
      public function get position() : *
      {
         return this._position;
      }
      
      public function set position(newValue:*) : void
      {
         this._position = positionProperty.setHelper(this._position,newValue);
      }
      
      [Inspectable(enumeration="start,center,end,decimal,inherit")]
      public function get alignment() : *
      {
         return this._alignment;
      }
      
      public function set alignment(newValue:*) : void
      {
         this._alignment = alignmentProperty.setHelper(this._alignment,newValue);
      }
      
      public function get decimalAlignmentToken() : *
      {
         return this._decimalAlignmentToken;
      }
      
      public function set decimalAlignmentToken(newValue:*) : void
      {
         this._decimalAlignmentToken = decimalAlignmentTokenProperty.setHelper(this._decimalAlignmentToken,newValue);
      }
      
      public function copy(values:ITabStopFormat) : void
      {
         if(values == null)
         {
            values = tlf_internal::emptyTabStopFormat;
         }
         this.position = values.position;
         this.alignment = values.alignment;
         this.decimalAlignmentToken = values.decimalAlignmentToken;
      }
      
      public function concat(incoming:ITabStopFormat) : void
      {
         this.position = positionProperty.concatHelper(this.position,incoming.position);
         this.alignment = alignmentProperty.concatHelper(this.alignment,incoming.alignment);
         this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatHelper(this.decimalAlignmentToken,incoming.decimalAlignmentToken);
      }
      
      public function concatInheritOnly(incoming:ITabStopFormat) : void
      {
         this.position = positionProperty.concatInheritOnlyHelper(this.position,incoming.position);
         this.alignment = alignmentProperty.concatInheritOnlyHelper(this.alignment,incoming.alignment);
         this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatInheritOnlyHelper(this.decimalAlignmentToken,incoming.decimalAlignmentToken);
      }
      
      public function apply(incoming:ITabStopFormat) : void
      {
         var val:* = undefined;
         if((val = incoming.position) !== undefined)
         {
            this.position = val;
         }
         if((val = incoming.alignment) !== undefined)
         {
            this.alignment = val;
         }
         if((val = incoming.decimalAlignmentToken) !== undefined)
         {
            this.decimalAlignmentToken = val;
         }
      }
      
      public function removeMatching(incoming:ITabStopFormat) : void
      {
         if(incoming == null)
         {
            return;
         }
         if(positionProperty.equalHelper(this.position,incoming.position))
         {
            this.position = undefined;
         }
         if(alignmentProperty.equalHelper(this.alignment,incoming.alignment))
         {
            this.alignment = undefined;
         }
         if(decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken,incoming.decimalAlignmentToken))
         {
            this.decimalAlignmentToken = undefined;
         }
      }
      
      public function removeClashing(incoming:ITabStopFormat) : void
      {
         if(incoming == null)
         {
            return;
         }
         if(!positionProperty.equalHelper(this.position,incoming.position))
         {
            this.position = undefined;
         }
         if(!alignmentProperty.equalHelper(this.alignment,incoming.alignment))
         {
            this.alignment = undefined;
         }
         if(!decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken,incoming.decimalAlignmentToken))
         {
            this.decimalAlignmentToken = undefined;
         }
      }
   }
}
