package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   public final class SubParagraphGroupElement extends SubParagraphGroupElementBase
   {
       
      
      public function SubParagraphGroupElement()
      {
         super();
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "g";
      }
      
      override tlf_internal function get precedence() : uint
      {
         return tlf_internal::kMinSPGEPrecedence;
      }
      
      override tlf_internal function get allowNesting() : Boolean
      {
         return true;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean
      {
         var myidx:int = 0;
         var sib:SubParagraphGroupElement = null;
         if(parent && !tlf_internal::bindableElement && !hasActiveEventMirror())
         {
            myidx = parent.getChildIndex(this);
            if(myidx != 0)
            {
               sib = parent.getChildAt(myidx - 1) as SubParagraphGroupElement;
               if(sib == null || sib.hasActiveEventMirror())
               {
                  return false;
               }
               if(equalStylesForMerge(sib))
               {
                  parent.removeChildAt(myidx);
                  if(numChildren > 0)
                  {
                     sib.replaceChildren(sib.numChildren,sib.numChildren,this.mxmlChildren);
                  }
                  return true;
               }
            }
         }
         return false;
      }
   }
}
