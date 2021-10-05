package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class FlowElementOperation extends FlowTextOperation
   {
       
      
      private var nestLevel:int;
      
      private var absStart:int;
      
      private var absEnd:int;
      
      private var origAbsStart:int;
      
      private var origAbsEnd:int;
      
      private var firstTime:Boolean = true;
      
      private var splitAtStart:Boolean = false;
      
      private var splitAtEnd:Boolean = false;
      
      private var _relStart:int = 0;
      
      private var _relEnd:int = -1;
      
      public function FlowElementOperation(operationState:SelectionState, targetElement:FlowElement, relativeStart:int = 0, relativeEnd:int = -1)
      {
         super(operationState);
         this.initialize(targetElement,relativeStart,relativeEnd);
      }
      
      private function initialize(targetElement:FlowElement, relativeStart:int, relativeEnd:int) : void
      {
         this.targetElement = targetElement;
         this.relativeEnd = relativeEnd;
         this.relativeStart = relativeStart;
         if(relativeEnd == -1)
         {
            relativeEnd = targetElement.textLength;
         }
         if(targetElement is SpanElement && SpanElement(targetElement).hasParagraphTerminator && relativeEnd == targetElement.textLength - 1)
         {
            relativeEnd += 1;
         }
         this.origAbsStart = this.absStart = targetElement.getAbsoluteStart() + relativeStart;
         this.origAbsEnd = this.absEnd = this.absStart - relativeStart + relativeEnd;
      }
      
      public function get targetElement() : FlowElement
      {
         var groupElement:FlowGroupElement = null;
         var element:FlowElement = originalSelectionState.textFlow;
         for(var i:int = this.nestLevel; i > 0; i--)
         {
            groupElement = element as FlowGroupElement;
            element = groupElement.getChildAt(groupElement.findChildIndexAtPosition(this.absStart - element.getAbsoluteStart()));
         }
         return element;
      }
      
      public function set targetElement(value:FlowElement) : void
      {
         this.nestLevel = 0;
         for(var element:FlowElement = value; element.parent != null; element = element.parent)
         {
            ++this.nestLevel;
         }
      }
      
      public function get relativeStart() : int
      {
         return this._relStart;
      }
      
      public function set relativeStart(value:int) : void
      {
         this._relStart = value;
      }
      
      public function get relativeEnd() : int
      {
         return this._relEnd;
      }
      
      public function set relativeEnd(value:int) : void
      {
         this._relEnd = value;
      }
      
      protected function getTargetElement() : FlowElement
      {
         var splitElement:FlowElement = null;
         var element:FlowElement = this.targetElement;
         var elemStart:int = element.getAbsoluteStart();
         if(this.absEnd != elemStart + element.textLength)
         {
            splitElement = element.splitAtPosition(this.absEnd - elemStart);
            if(this.firstTime && splitElement != element)
            {
               this.splitAtEnd = true;
            }
         }
         if(this.absStart != elemStart)
         {
            splitElement = element.splitAtPosition(this.absStart - elemStart);
            if(splitElement != element)
            {
               if(this.firstTime)
               {
                  this.splitAtStart = true;
               }
               element = splitElement;
            }
         }
         this.firstTime = false;
         return element;
      }
      
      protected function adjustForDoOperation(targetElement:FlowElement) : void
      {
         this.absStart = targetElement.getAbsoluteStart();
         this.absEnd = this.absStart + targetElement.textLength;
      }
      
      protected function adjustForUndoOperation(targetElement:FlowElement) : void
      {
         var targetIdx:int = 0;
         var workElem:FlowGroupElement = null;
         var child:FlowElement = null;
         if((this.splitAtEnd || this.splitAtStart) && targetElement is FlowGroupElement)
         {
            targetIdx = targetElement.parent.getChildIndex(targetElement);
            if(this.splitAtEnd)
            {
               workElem = targetElement.parent.getChildAt(targetIdx + 1) as FlowGroupElement;
               while(workElem.numChildren)
               {
                  child = workElem.getChildAt(0);
                  workElem.removeChildAt(0);
                  FlowGroupElement(targetElement).addChild(child);
               }
               targetElement.parent.removeChildAt(targetIdx + 1);
            }
            if(this.splitAtStart)
            {
               workElem = targetElement.parent.getChildAt(targetIdx - 1) as FlowGroupElement;
               while(FlowGroupElement(targetElement).numChildren)
               {
                  child = FlowGroupElement(targetElement).getChildAt(0);
                  FlowGroupElement(targetElement).removeChildAt(0);
                  workElem.addChild(child);
               }
               targetElement.parent.removeChildAt(targetIdx);
            }
         }
         this.absStart = this.origAbsStart;
         this.absEnd = this.origAbsEnd;
      }
   }
}
