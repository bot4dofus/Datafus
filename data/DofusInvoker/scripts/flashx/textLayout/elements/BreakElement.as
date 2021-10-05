package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   public final class BreakElement extends SpecialCharacterElement
   {
       
      
      public function BreakElement()
      {
         super();
         this.text = " ";
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "br";
      }
   }
}
