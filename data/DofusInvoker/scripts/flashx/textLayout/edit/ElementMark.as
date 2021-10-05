package flashx.textLayout.edit
{
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class ElementMark
   {
       
      
      tlf_internal var _elemStart:int;
      
      tlf_internal var _indexChain:Array;
      
      public function ElementMark(elem:FlowElement, relativeStartPosition:int)
      {
         super();
         this._elemStart = relativeStartPosition;
         this._indexChain = [];
         var p:FlowGroupElement = elem.parent;
         while(p != null)
         {
            this._indexChain.splice(0,0,p.getChildIndex(elem));
            elem = p;
            p = p.parent;
         }
      }
      
      public function get elemStart() : int
      {
         return this._elemStart;
      }
      
      public function findElement(textFlow:TextFlow) : FlowElement
      {
         var idx:int = 0;
         var element:FlowElement = textFlow;
         for each(idx in this._indexChain)
         {
            element = (element as FlowGroupElement).getChildAt(idx);
         }
         return element;
      }
   }
}
