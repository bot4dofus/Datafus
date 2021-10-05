package flashx.textLayout.conversion
{
   public interface IPlainTextExporter extends ITextExporter
   {
       
      
      function get paragraphSeparator() : String;
      
      function set paragraphSeparator(param1:String) : void;
      
      function get stripDiscretionaryHyphens() : Boolean;
      
      function set stripDiscretionaryHyphens(param1:Boolean) : void;
   }
}
