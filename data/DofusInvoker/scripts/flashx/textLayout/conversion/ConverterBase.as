package flashx.textLayout.conversion
{
   import flashx.textLayout.tlf_internal;
   
   public class ConverterBase
   {
      
      public static const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";
       
      
      private var _errors:Vector.<String> = null;
      
      private var _throwOnError:Boolean = false;
      
      private var _useClipboardAnnotations:Boolean = false;
      
      private var _config:ImportExportConfiguration;
      
      public function ConverterBase()
      {
         super();
      }
      
      public function get errors() : Vector.<String>
      {
         return this._errors;
      }
      
      public function get throwOnError() : Boolean
      {
         return this._throwOnError;
      }
      
      public function set throwOnError(value:Boolean) : void
      {
         this._throwOnError = value;
      }
      
      tlf_internal function clear() : void
      {
         this._errors = null;
      }
      
      tlf_internal function reportError(error:String) : void
      {
         if(this._throwOnError)
         {
            throw new Error(error);
         }
         if(!this._errors)
         {
            this._errors = new Vector.<String>();
         }
         this._errors.push(error);
      }
      
      public function get useClipboardAnnotations() : Boolean
      {
         return this._useClipboardAnnotations;
      }
      
      public function set useClipboardAnnotations(value:Boolean) : void
      {
         this._useClipboardAnnotations = value;
      }
      
      public function get config() : ImportExportConfiguration
      {
         return this._config;
      }
      
      public function set config(value:ImportExportConfiguration) : void
      {
         this._config = value;
      }
   }
}
