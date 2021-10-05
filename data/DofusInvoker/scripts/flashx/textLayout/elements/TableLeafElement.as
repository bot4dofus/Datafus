package flashx.textLayout.elements
{
   import flash.text.engine.ElementFormat;
   import flash.text.engine.TextElement;
   import flash.text.engine.TextLine;
   import flashx.textLayout.compose.BaseCompose;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.ISWFContext;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TableLeafElement extends FlowLeafElement
   {
       
      
      private var _table:TableElement;
      
      public function TableLeafElement(table:TableElement)
      {
         super();
         this._table = table;
      }
      
      override tlf_internal function createContentElement() : void
      {
         if(_blockElement)
         {
            return;
         }
         this.computedFormat;
         var flowComposer:IFlowComposer = this.getTextFlow().flowComposer;
         var swfContext:ISWFContext = flowComposer && flowComposer.swfContext ? flowComposer.swfContext : BaseCompose.globalSWFContext;
         var format:ElementFormat = FlowLeafElement.computeElementFormatHelper(this._table.computedFormat,this._table.getParagraph(),swfContext);
         _blockElement = new TextElement(_text,format);
         super.createContentElement();
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "table";
      }
      
      override public function get text() : String
      {
         return String.fromCharCode(22);
      }
      
      override public function getText(relativeStart:int = 0, relativeEnd:int = -1, paragraphSeparator:String = "\n") : String
      {
         return this._table.getText(relativeStart,relativeEnd,paragraphSeparator);
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
         super.normalizeRange(normalizeStart,normalizeEnd);
      }
      
      override tlf_internal function mergeToPreviousIfPossible() : Boolean
      {
         return false;
      }
      
      override public function getNextLeaf(limitElement:FlowGroupElement = null) : FlowLeafElement
      {
         return this._table.getNextLeafHelper(limitElement,this);
      }
      
      override public function getPreviousLeaf(limitElement:FlowGroupElement = null) : FlowLeafElement
      {
         return this._table.getPreviousLeafHelper(limitElement,this);
      }
      
      override public function getCharAtPosition(relativePosition:int) : String
      {
         return this.getText(relativePosition,relativePosition);
      }
      
      override public function get computedFormat() : ITextLayoutFormat
      {
         return this._table.computedFormat;
      }
      
      override public function get textLength() : int
      {
         return this._table.textLength;
      }
      
      override tlf_internal function updateAdornments(tLine:TextLine, blockProgression:String) : int
      {
         return 0;
      }
      
      override public function get parent() : FlowGroupElement
      {
         return this._table;
      }
      
      override public function getTextFlow() : TextFlow
      {
         return this._table.getTextFlow();
      }
      
      override public function getParagraph() : ParagraphElement
      {
         return this._table.getParagraph();
      }
      
      override public function getElementRelativeStart(ancestorElement:FlowElement) : int
      {
         return this._table.getElementRelativeStart(ancestorElement);
      }
   }
}
