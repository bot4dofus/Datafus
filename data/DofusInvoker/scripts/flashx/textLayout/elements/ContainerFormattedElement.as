package flashx.textLayout.elements
{
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.tlf_internal;
   
   public class ContainerFormattedElement extends ParagraphFormattedElement
   {
       
      
      public function ContainerFormattedElement()
      {
         super();
      }
      
      public function get flowComposer() : IFlowComposer
      {
         return null;
      }
      
      override tlf_internal function formatChanged(notifyModelChanged:Boolean = true) : void
      {
         var idx:int = 0;
         super.formatChanged(notifyModelChanged);
         if(this.flowComposer)
         {
            for(idx = 0; idx < this.flowComposer.numControllers; idx++)
            {
               this.flowComposer.getControllerAt(idx).formatChanged();
            }
         }
      }
      
      tlf_internal function preCompose() : void
      {
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
         var p:ParagraphElement = null;
         super.normalizeRange(normalizeStart,normalizeEnd);
         if(this.numChildren == 0)
         {
            p = new ParagraphElement();
            if(this.canOwnFlowElement(p))
            {
               p.replaceChildren(0,0,new SpanElement());
               replaceChildren(0,0,p);
               p.normalizeRange(0,p.textLength);
            }
         }
      }
   }
}
