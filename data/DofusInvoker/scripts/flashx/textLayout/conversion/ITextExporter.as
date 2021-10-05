package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.TextFlow;
   
   public interface ITextExporter
   {
       
      
      function export(param1:TextFlow, param2:String) : Object;
      
      function get errors() : Vector.<String>;
      
      function get throwOnError() : Boolean;
      
      function set throwOnError(param1:Boolean) : void;
      
      function get useClipboardAnnotations() : Boolean;
      
      function set useClipboardAnnotations(param1:Boolean) : void;
      
      function get config() : ImportExportConfiguration;
      
      function set config(param1:ImportExportConfiguration) : void;
   }
}
