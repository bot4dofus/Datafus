package flashx.textLayout.formats
{
   public interface IListMarkerFormat extends ITextLayoutFormat
   {
       
      
      function get counterReset() : *;
      
      function get counterIncrement() : *;
      
      function get beforeContent() : *;
      
      function get content() : *;
      
      function get afterContent() : *;
      
      function get suffix() : *;
   }
}
