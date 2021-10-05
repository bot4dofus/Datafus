package flashx.textLayout.elements
{
   public class ParagraphFormattedElement extends FlowGroupElement
   {
       
      
      public function ParagraphFormattedElement()
      {
         super();
      }
      
      override public function shallowCopy(startPos:int = 0, endPos:int = -1) : FlowElement
      {
         return super.shallowCopy(startPos,endPos) as ParagraphFormattedElement;
      }
   }
}
