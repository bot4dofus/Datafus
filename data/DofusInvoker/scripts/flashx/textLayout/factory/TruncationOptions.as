package flashx.textLayout.factory
{
   import flashx.textLayout.formats.ITextLayoutFormat;
   
   public final class TruncationOptions
   {
      
      public static const NO_LINE_COUNT_LIMIT:int = -1;
      
      public static const HORIZONTAL_ELLIPSIS:String = "…";
       
      
      private var _truncationIndicator:String;
      
      private var _truncationIndicatorFormat:ITextLayoutFormat;
      
      private var _lineCountLimit:int;
      
      public function TruncationOptions(truncationIndicator:String = "…", lineCountLimit:int = -1, truncationIndicatorFormat:ITextLayoutFormat = null)
      {
         super();
         this.truncationIndicator = truncationIndicator;
         this.truncationIndicatorFormat = truncationIndicatorFormat;
         this.lineCountLimit = lineCountLimit;
      }
      
      public function get truncationIndicator() : String
      {
         return !!this._truncationIndicator ? this._truncationIndicator : HORIZONTAL_ELLIPSIS;
      }
      
      public function set truncationIndicator(val:String) : void
      {
         this._truncationIndicator = val;
      }
      
      public function get truncationIndicatorFormat() : ITextLayoutFormat
      {
         return this._truncationIndicatorFormat;
      }
      
      public function set truncationIndicatorFormat(val:ITextLayoutFormat) : void
      {
         this._truncationIndicatorFormat = val;
      }
      
      public function get lineCountLimit() : int
      {
         return this._lineCountLimit < NO_LINE_COUNT_LIMIT ? 0 : int(this._lineCountLimit);
      }
      
      public function set lineCountLimit(val:int) : void
      {
         this._lineCountLimit = val;
      }
   }
}
