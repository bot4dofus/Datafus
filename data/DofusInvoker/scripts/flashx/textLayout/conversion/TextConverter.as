package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.IConfiguration;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextConverter
   {
      
      public static const TEXT_FIELD_HTML_FORMAT:String = "textFieldHTMLFormat";
      
      public static const PLAIN_TEXT_FORMAT:String = "plainTextFormat";
      
      public static const TEXT_LAYOUT_FORMAT:String = "textLayoutFormat";
      
      tlf_internal static var _descriptors:Array = [];
      
      {
         setFormatsToDefault();
      }
      
      public function TextConverter()
      {
         super();
      }
      
      tlf_internal static function setFormatsToDefault() : void
      {
         _descriptors = [];
         addFormat(TEXT_LAYOUT_FORMAT,TextLayoutImporter,TextLayoutExporter,TEXT_LAYOUT_FORMAT);
         addFormat(TEXT_FIELD_HTML_FORMAT,TextFieldHtmlImporter,TextFieldHtmlExporter,null);
         addFormat(PLAIN_TEXT_FORMAT,PlainTextImporter,PlainTextExporter,"air:text");
      }
      
      public static function importToFlow(source:Object, format:String, config:IConfiguration = null) : TextFlow
      {
         var parser:ITextImporter = getImporter(format,config);
         if(!parser)
         {
            return null;
         }
         parser.throwOnError = false;
         return parser.importToFlow(source);
      }
      
      public static function export(source:TextFlow, format:String, conversionType:String) : Object
      {
         var exporter:ITextExporter = getExporter(format);
         if(!exporter)
         {
            return null;
         }
         exporter.throwOnError = false;
         return exporter.export(source,conversionType);
      }
      
      public static function getImporter(format:String, config:IConfiguration = null) : ITextImporter
      {
         var descriptor:FormatDescriptor = null;
         var importer:ITextImporter = null;
         var i:int = findFormatIndex(format);
         if(i >= 0)
         {
            descriptor = tlf_internal::_descriptors[i];
            if(descriptor && descriptor.importerClass)
            {
               importer = new descriptor.importerClass();
               importer.configuration = config;
            }
         }
         return importer;
      }
      
      public static function getExporter(format:String) : ITextExporter
      {
         var descriptor:FormatDescriptor = null;
         var exporter:ITextExporter = null;
         var i:int = findFormatIndex(format);
         if(i >= 0)
         {
            descriptor = tlf_internal::_descriptors[i];
            if(descriptor && descriptor.exporterClass)
            {
               exporter = new descriptor.exporterClass();
            }
         }
         return exporter;
      }
      
      public static function addFormatAt(index:int, format:String, importerClass:Class, exporterClass:Class = null, clipboardFormat:String = null) : void
      {
         var descriptor:FormatDescriptor = new FormatDescriptor(format,importerClass,exporterClass,clipboardFormat);
         tlf_internal::_descriptors.splice(index,0,descriptor);
      }
      
      public static function addFormat(format:String, importerClass:Class, exporterClass:Class, clipboardFormat:String) : void
      {
         addFormatAt(tlf_internal::_descriptors.length,format,importerClass,exporterClass,clipboardFormat);
      }
      
      public static function removeFormatAt(index:int) : void
      {
         if(index >= 0 && index < tlf_internal::_descriptors.length)
         {
            tlf_internal::_descriptors.splice(index,1);
         }
      }
      
      private static function findFormatIndex(format:String) : int
      {
         for(var i:int = 0; i < numFormats; i++)
         {
            if(tlf_internal::_descriptors[i].format == format)
            {
               return i;
            }
         }
         return -1;
      }
      
      public static function removeFormat(format:String) : void
      {
         removeFormatAt(findFormatIndex(format));
      }
      
      public static function getFormatAt(index:int) : String
      {
         return tlf_internal::_descriptors[index].format;
      }
      
      public static function getFormatDescriptorAt(index:int) : FormatDescriptor
      {
         return tlf_internal::_descriptors[index];
      }
      
      public static function get numFormats() : int
      {
         return tlf_internal::_descriptors.length;
      }
   }
}
