package flashx.textLayout.edit
{
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.Category;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ElementRange
   {
       
      
      private var _absoluteStart:int;
      
      private var _absoluteEnd:int;
      
      private var _firstLeaf:FlowLeafElement;
      
      private var _lastLeaf:FlowLeafElement;
      
      private var _firstParagraph:ParagraphElement;
      
      private var _lastParagraph:ParagraphElement;
      
      private var _textFlow:TextFlow;
      
      public function ElementRange()
      {
         super();
      }
      
      public static function createElementRange(textFlow:TextFlow, absoluteStart:int, absoluteEnd:int) : ElementRange
      {
         var rslt:ElementRange = new ElementRange();
         if(absoluteStart == absoluteEnd)
         {
            rslt.absoluteStart = rslt.absoluteEnd = absoluteStart;
            rslt.firstLeaf = textFlow.findLeaf(rslt.absoluteStart);
            rslt.firstParagraph = rslt.firstLeaf.getParagraph();
            adjustForLeanLeft(rslt);
            rslt.lastLeaf = rslt.firstLeaf;
            rslt.lastParagraph = rslt.firstParagraph;
         }
         else
         {
            if(absoluteStart < absoluteEnd)
            {
               rslt.absoluteStart = absoluteStart;
               rslt.absoluteEnd = absoluteEnd;
            }
            else
            {
               rslt.absoluteStart = absoluteEnd;
               rslt.absoluteEnd = absoluteStart;
            }
            rslt.firstLeaf = textFlow.findLeaf(rslt.absoluteStart);
            rslt.lastLeaf = textFlow.findLeaf(rslt.absoluteEnd);
            if(rslt.lastLeaf == null && rslt.absoluteEnd == textFlow.textLength || rslt.absoluteEnd == rslt.lastLeaf.getAbsoluteStart())
            {
               rslt.lastLeaf = textFlow.findLeaf(rslt.absoluteEnd - 1);
            }
            rslt.firstParagraph = rslt.firstLeaf.getParagraph();
            rslt.lastParagraph = rslt.lastLeaf.getParagraph();
            if(rslt.absoluteEnd == rslt.lastParagraph.getAbsoluteStart() + rslt.lastParagraph.textLength - 1)
            {
               ++rslt.absoluteEnd;
               rslt.lastLeaf = rslt.lastParagraph.getLastLeaf();
            }
         }
         rslt.textFlow = textFlow;
         return rslt;
      }
      
      private static function adjustForLeanLeft(rslt:ElementRange) : void
      {
         var previousNode:FlowLeafElement = null;
         if(rslt.firstLeaf.getAbsoluteStart() == rslt.absoluteStart)
         {
            previousNode = rslt.firstLeaf.getPreviousLeaf(rslt.firstParagraph);
            if(previousNode && previousNode.getParagraph() == rslt.firstLeaf.getParagraph())
            {
               if((!(previousNode.parent is SubParagraphGroupElementBase) || (previousNode.parent as SubParagraphGroupElementBase).acceptTextAfter()) && (!(rslt.firstLeaf.parent is SubParagraphGroupElementBase) || previousNode.parent === rslt.firstLeaf.parent))
               {
                  rslt.firstLeaf = previousNode;
               }
            }
         }
      }
      
      public function get absoluteStart() : int
      {
         return this._absoluteStart;
      }
      
      public function set absoluteStart(value:int) : void
      {
         this._absoluteStart = value;
      }
      
      public function get absoluteEnd() : int
      {
         return this._absoluteEnd;
      }
      
      public function set absoluteEnd(value:int) : void
      {
         this._absoluteEnd = value;
      }
      
      public function get firstLeaf() : FlowLeafElement
      {
         return this._firstLeaf;
      }
      
      public function set firstLeaf(value:FlowLeafElement) : void
      {
         this._firstLeaf = value;
      }
      
      public function get lastLeaf() : FlowLeafElement
      {
         return this._lastLeaf;
      }
      
      public function set lastLeaf(value:FlowLeafElement) : void
      {
         this._lastLeaf = value;
      }
      
      public function get firstParagraph() : ParagraphElement
      {
         return this._firstParagraph;
      }
      
      public function set firstParagraph(value:ParagraphElement) : void
      {
         this._firstParagraph = value;
      }
      
      public function get lastParagraph() : ParagraphElement
      {
         return this._lastParagraph;
      }
      
      public function set lastParagraph(value:ParagraphElement) : void
      {
         this._lastParagraph = value;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         this._textFlow = value;
      }
      
      public function get containerFormat() : ITextLayoutFormat
      {
         var container:ContainerController = null;
         var idx:int = 0;
         var flowComposer:IFlowComposer = this._textFlow.flowComposer;
         if(flowComposer)
         {
            idx = flowComposer.findControllerIndexAtPosition(this.absoluteStart);
            if(idx != -1)
            {
               container = flowComposer.getControllerAt(idx);
            }
         }
         return !!container ? container.computedFormat : this._textFlow.computedFormat;
      }
      
      public function get paragraphFormat() : ITextLayoutFormat
      {
         return this.firstParagraph.computedFormat;
      }
      
      public function get characterFormat() : ITextLayoutFormat
      {
         return this.firstLeaf.computedFormat;
      }
      
      public function getCommonCharacterFormat() : TextLayoutFormat
      {
         var leaf:FlowLeafElement = this.firstLeaf;
         var attr:TextLayoutFormat = new TextLayoutFormat(leaf.computedFormat);
         while(leaf != this.lastLeaf)
         {
            leaf = leaf.getNextLeaf();
            attr.removeClashing(leaf.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,attr,Category.CHARACTER,false) as TextLayoutFormat;
      }
      
      public function getCommonParagraphFormat() : TextLayoutFormat
      {
         var para:ParagraphElement = this.firstParagraph;
         var attr:TextLayoutFormat = new TextLayoutFormat(para.computedFormat);
         while(para != this.lastParagraph)
         {
            para = this._textFlow.findAbsoluteParagraph(para.getAbsoluteStart() + para.textLength);
            attr.removeClashing(para.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,attr,Category.PARAGRAPH,false) as TextLayoutFormat;
      }
      
      public function getCommonContainerFormat() : TextLayoutFormat
      {
         var flowComposer:IFlowComposer = this._textFlow.flowComposer;
         if(!flowComposer)
         {
            return null;
         }
         var index:int = flowComposer.findControllerIndexAtPosition(this.absoluteStart);
         if(index == -1)
         {
            return null;
         }
         var controller:ContainerController = flowComposer.getControllerAt(index);
         var attr:TextLayoutFormat = new TextLayoutFormat(controller.computedFormat);
         while(controller.absoluteStart + controller.textLength < this.absoluteEnd)
         {
            index++;
            if(index == flowComposer.numControllers)
            {
               break;
            }
            controller = flowComposer.getControllerAt(index);
            attr.removeClashing(controller.computedFormat);
         }
         return Property.extractInCategory(TextLayoutFormat,TextLayoutFormat.description,attr,Category.CONTAINER,false) as TextLayoutFormat;
      }
   }
}
