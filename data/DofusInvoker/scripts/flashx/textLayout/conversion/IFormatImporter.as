package flashx.textLayout.conversion
{
   [ExcludeClass]
   public interface IFormatImporter
   {
       
      
      function reset() : void;
      
      function get result() : Object;
      
      function importOneFormat(param1:String, param2:String) : Boolean;
   }
}
