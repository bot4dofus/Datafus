package flashx.textLayout.conversion
{
   public class FormatDescriptor
   {
       
      
      private var _format:String;
      
      private var _clipboardFormat:String;
      
      private var _importerClass:Class;
      
      private var _exporterClass:Class;
      
      public function FormatDescriptor(format:String, importerClass:Class, exporterClass:Class, clipboardFormat:String)
      {
         super();
         this._format = format;
         this._clipboardFormat = clipboardFormat;
         this._importerClass = importerClass;
         this._exporterClass = exporterClass;
      }
      
      public function get format() : String
      {
         return this._format;
      }
      
      public function get clipboardFormat() : String
      {
         return this._clipboardFormat;
      }
      
      public function get importerClass() : Class
      {
         return this._importerClass;
      }
      
      public function get exporterClass() : Class
      {
         return this._exporterClass;
      }
   }
}
