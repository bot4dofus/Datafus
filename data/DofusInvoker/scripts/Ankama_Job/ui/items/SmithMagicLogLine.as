package Ankama_Job.ui.items
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   
   public class SmithMagicLogLine
   {
       
      
      private var _text:String;
      
      private var _rune:ItemWrapper;
      
      private var _cssClass:String;
      
      public function SmithMagicLogLine(text:String, rune:ItemWrapper, cssClass:String)
      {
         super();
         this._text = text;
         this._rune = rune;
         this._cssClass = cssClass;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get rune() : ItemWrapper
      {
         return this._rune;
      }
      
      public function get cssClass() : String
      {
         return this._cssClass;
      }
   }
}
