package flashx.textLayout.elements
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   
   public interface IExplicitFormatResolver extends IFormatResolver
   {
       
      
      function resolveExplicitFormat(param1:Object) : ITextLayoutFormat;
   }
}
