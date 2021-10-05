package flashx.textLayout.formats
{
   import flashx.textLayout.property.CounterContentHandler;
   import flashx.textLayout.property.CounterPropHandler;
   import flashx.textLayout.property.EnumPropertyHandler;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ListMarkerFormat extends TextLayoutFormat implements IListMarkerFormat
   {
      
      tlf_internal static const counterResetProperty:Property = createCounterResetProperty("counterReset",FormatValue.NONE,false,Vector.<String>([Category.LIST]));
      
      tlf_internal static const counterIncrementProperty:Property = createCounterResetProperty("counterIncrement","ordered 1",false,Vector.<String>([Category.LIST]));
      
      tlf_internal static const beforeContentProperty:Property = Property.NewStringProperty("beforeContent",null,false,Vector.<String>([Category.LIST]));
      
      tlf_internal static const contentProperty:Property = createCounterContentProperty("content","counter(ordered)",false,Vector.<String>([Category.LIST]));
      
      tlf_internal static const afterContentProperty:Property = Property.NewStringProperty("afterContent",null,false,Vector.<String>([Category.LIST]));
      
      tlf_internal static const suffixProperty:Property = Property.NewEnumStringProperty("suffix",Suffix.AUTO,false,Vector.<String>([Category.LIST]),Suffix.AUTO,Suffix.NONE);
      
      private static var _lmfDescription:Object = {
         "counterReset":tlf_internal::counterResetProperty,
         "counterIncrement":tlf_internal::counterIncrementProperty,
         "beforeContent":tlf_internal::beforeContentProperty,
         "content":tlf_internal::contentProperty,
         "afterContent":tlf_internal::afterContentProperty,
         "suffix":tlf_internal::suffixProperty
      };
      
      private static var _description:Object;
      
      {
         Property.sharedTextLayoutFormatHandler.converter = TextLayoutFormat.createTextLayoutFormat;
         Property.sharedListMarkerFormatHandler.converter = ListMarkerFormat.createListMarkerFormat;
      }
      
      public function ListMarkerFormat(initialValues:IListMarkerFormat = null)
      {
         super(initialValues);
      }
      
      tlf_internal static function createCounterResetProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterPropHandler(0));
         return rslt;
      }
      
      tlf_internal static function createCounterIncrementProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterPropHandler(1));
         return rslt;
      }
      
      tlf_internal static function createCounterContentProperty(nameValue:String, defaultValue:String, inherited:Boolean, categories:Vector.<String>) : Property
      {
         var rslt:Property = new Property(nameValue,defaultValue,inherited,categories);
         rslt.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterContentHandler());
         return rslt;
      }
      
      tlf_internal static function get description() : Object
      {
         var key:* = null;
         if(!_description)
         {
            _description = Property.createObjectWithPrototype(TextLayoutFormat.description);
            for(key in _lmfDescription)
            {
               _description[key] = _lmfDescription[key];
            }
         }
         return _description;
      }
      
      public static function createListMarkerFormat(initialValues:Object) : ListMarkerFormat
      {
         var key:* = null;
         var lmf:IListMarkerFormat = initialValues as IListMarkerFormat;
         var rslt:ListMarkerFormat = new ListMarkerFormat(lmf);
         if(lmf == null && initialValues)
         {
            for(key in initialValues)
            {
               rslt.setStyle(key,initialValues[key]);
            }
         }
         return rslt;
      }
      
      private function setLMFStyle(styleProp:Property, newValue:*) : void
      {
         var name:String = styleProp.name;
         newValue = styleProp.setHelper(getStyle(name),newValue);
         super.setStyleByName(name,newValue);
      }
      
      override public function setStyle(styleProp:String, newValue:*) : void
      {
         var lmfStyle:Property = _lmfDescription[styleProp];
         if(lmfStyle)
         {
            this.setLMFStyle(lmfStyle,newValue);
         }
         else
         {
            super.setStyle(styleProp,newValue);
         }
      }
      
      public function get counterReset() : *
      {
         return getStyle(tlf_internal::counterResetProperty.name);
      }
      
      public function set counterReset(value:*) : *
      {
         this.setLMFStyle(tlf_internal::counterResetProperty,value);
      }
      
      public function get counterIncrement() : *
      {
         return getStyle(tlf_internal::counterIncrementProperty.name);
      }
      
      public function set counterIncrement(value:*) : *
      {
         this.setLMFStyle(tlf_internal::counterIncrementProperty,value);
      }
      
      public function get content() : *
      {
         return getStyle(tlf_internal::contentProperty.name);
      }
      
      public function set content(value:*) : *
      {
         this.setLMFStyle(tlf_internal::contentProperty,value);
      }
      
      public function get beforeContent() : *
      {
         return getStyle(tlf_internal::beforeContentProperty.name);
      }
      
      public function set beforeContent(value:*) : void
      {
         this.setLMFStyle(tlf_internal::beforeContentProperty,value);
      }
      
      public function get afterContent() : *
      {
         return getStyle(tlf_internal::afterContentProperty.name);
      }
      
      public function set afterContent(value:*) : void
      {
         this.setLMFStyle(tlf_internal::afterContentProperty,value);
      }
      
      public function get suffix() : *
      {
         return getStyle(tlf_internal::suffixProperty.name);
      }
      
      public function set suffix(value:*) : void
      {
         this.setLMFStyle(tlf_internal::suffixProperty,value);
      }
      
      override public function copy(incoming:ITextLayoutFormat) : void
      {
         var key:* = null;
         super.copy(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for(key in _lmfDescription)
            {
               this[key] = lmf[key];
            }
         }
      }
      
      override public function concat(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var name:String = null;
         super.concat(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for each(prop in _lmfDescription)
            {
               name = prop.name;
               this.setLMFStyle(prop,prop.concatHelper(this[name],lmf[name]));
            }
         }
      }
      
      override public function concatInheritOnly(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var name:String = null;
         super.concatInheritOnly(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for each(prop in _lmfDescription)
            {
               name = prop.name;
               this.setLMFStyle(prop,prop.concatInheritOnlyHelper(this[name],lmf[name]));
            }
         }
      }
      
      override public function apply(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var name:String = null;
         var val:* = undefined;
         super.apply(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for each(prop in _lmfDescription)
            {
               name = prop.name;
               val = lmf[name];
               if(val !== undefined)
               {
                  this[name] = val;
               }
            }
         }
      }
      
      override public function removeMatching(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var name:String = null;
         super.removeMatching(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for each(prop in _lmfDescription)
            {
               name = prop.name;
               if(prop.equalHelper(this[name],lmf[name]))
               {
                  this[name] = undefined;
               }
            }
         }
      }
      
      override public function removeClashing(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var name:String = null;
         super.removeClashing(incoming);
         var lmf:IListMarkerFormat = incoming as IListMarkerFormat;
         if(lmf)
         {
            for each(prop in _lmfDescription)
            {
               name = prop.name;
               if(!prop.equalHelper(this[name],lmf[name]))
               {
                  this[name] = undefined;
               }
            }
         }
      }
   }
}
