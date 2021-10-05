package flashx.textLayout.compose
{
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.utils.Dictionary;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextLineRecycler
   {
      
      private static const _textLineRecyclerCanBeEnabled:Boolean = new TextBlock().hasOwnProperty("recreateTextLine");
      
      private static var _textLineRecyclerEnabled:Boolean = _textLineRecyclerCanBeEnabled;
      
      private static var reusableLineCache:Dictionary = new Dictionary(true);
       
      
      public function TextLineRecycler()
      {
         super();
      }
      
      public static function get textLineRecyclerEnabled() : Boolean
      {
         return _textLineRecyclerEnabled;
      }
      
      public static function set textLineRecyclerEnabled(value:Boolean) : void
      {
         _textLineRecyclerEnabled = !!value ? Boolean(_textLineRecyclerCanBeEnabled) : false;
      }
      
      public static function addLineForReuse(textLine:TextLine) : void
      {
         if(_textLineRecyclerEnabled)
         {
            reusableLineCache[textLine] = null;
         }
      }
      
      public static function getLineForReuse() : TextLine
      {
         var obj:* = null;
         if(_textLineRecyclerEnabled)
         {
            var _loc2_:int = 0;
            var _loc3_:* = reusableLineCache;
            for(obj in _loc3_)
            {
               delete reusableLineCache[obj];
               return obj as TextLine;
            }
         }
         return null;
      }
      
      tlf_internal static function emptyReusableLineCache() : void
      {
         reusableLineCache = new Dictionary(true);
      }
   }
}
