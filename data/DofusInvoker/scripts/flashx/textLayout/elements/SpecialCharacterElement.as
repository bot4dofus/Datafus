package flashx.textLayout.elements
{
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.formats.WhiteSpaceCollapse;
   import flashx.textLayout.tlf_internal;
   
   public class SpecialCharacterElement extends SpanElement
   {
       
      
      public function SpecialCharacterElement()
      {
         super();
         whiteSpaceCollapse = WhiteSpaceCollapse.PRESERVE;
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean
      {
         var myidx:int = 0;
         var newSib:SpanElement = null;
         var sib:SpanElement = null;
         var siblingInsertPosition:int = 0;
         if(parent)
         {
            myidx = parent.getChildIndex(this);
            if(myidx != 0)
            {
               sib = parent.getChildAt(myidx - 1) as SpanElement;
               if(sib != null && sib is SpanElement && TextLayoutFormat.isEqual(sib.format,format))
               {
                  siblingInsertPosition = sib.textLength;
                  sib.replaceText(siblingInsertPosition,siblingInsertPosition,this.text);
                  parent.replaceChildren(myidx,myidx + 1);
                  return true;
               }
            }
            newSib = new SpanElement();
            newSib.text = this.text;
            newSib.format = format;
            parent.replaceChildren(myidx,myidx + 1,newSib);
            newSib.normalizeRange(0,newSib.textLength);
            return false;
         }
         return false;
      }
   }
}
