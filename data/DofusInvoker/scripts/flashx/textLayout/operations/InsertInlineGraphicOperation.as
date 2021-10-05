package flashx.textLayout.operations
{
   import flashx.textLayout.edit.ElementRange;
   import flashx.textLayout.edit.ParaEdit;
   import flashx.textLayout.edit.PointFormat;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class InsertInlineGraphicOperation extends FlowTextOperation
   {
       
      
      private var delSelOp:DeleteTextOperation;
      
      private var _source:Object;
      
      private var imageWidth:Object;
      
      private var imageHeight:Object;
      
      private var _options:Object;
      
      private var selPos:int = 0;
      
      private var _inlineGraphicElement:InlineGraphicElement;
      
      public function InsertInlineGraphicOperation(operationState:SelectionState, source:Object, width:Object, height:Object, options:Object = null)
      {
         super(operationState);
         if(absoluteStart != absoluteEnd)
         {
            this.delSelOp = new DeleteTextOperation(operationState);
         }
         this._source = source;
         this._options = options;
         this.imageWidth = width;
         this.imageHeight = height;
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(value:Object) : void
      {
         this._source = value;
      }
      
      public function get width() : Object
      {
         return this.imageWidth;
      }
      
      public function set width(value:Object) : void
      {
         this.imageWidth = value;
      }
      
      public function get height() : Object
      {
         return this.imageHeight;
      }
      
      public function set height(value:Object) : void
      {
         this.imageHeight = value;
      }
      
      public function get options() : Object
      {
         return this._options;
      }
      
      public function set options(value:Object) : void
      {
         this._options = value;
      }
      
      public function get newInlineGraphicElement() : InlineGraphicElement
      {
         return this._inlineGraphicElement;
      }
      
      override public function doOperation() : Boolean
      {
         var pointFormat:ITextLayoutFormat = null;
         var leafEl:FlowLeafElement = null;
         var deleteFormat:PointFormat = null;
         var subParInsertionPoint:int = 0;
         this.selPos = absoluteStart;
         if(this.delSelOp)
         {
            leafEl = textFlow.findLeaf(absoluteStart);
            deleteFormat = new PointFormat(textFlow.findLeaf(absoluteStart).format);
            if(this.delSelOp.doOperation())
            {
               pointFormat = deleteFormat;
            }
         }
         else
         {
            pointFormat = originalSelectionState.pointFormat;
         }
         var range:ElementRange = ElementRange.createElementRange(textFlow,this.selPos,this.selPos);
         var leafNode:FlowElement = range.firstLeaf;
         var leafNodeParent:FlowGroupElement = leafNode.parent;
         while(leafNodeParent is SubParagraphGroupElementBase)
         {
            subParInsertionPoint = this.selPos - leafNodeParent.getAbsoluteStart();
            if(!(subParInsertionPoint == 0 && !(leafNodeParent as SubParagraphGroupElementBase).acceptTextBefore() || subParInsertionPoint == leafNodeParent.textLength && !(leafNodeParent as SubParagraphGroupElementBase).acceptTextAfter()))
            {
               break;
            }
            leafNodeParent = leafNodeParent.parent;
         }
         this._inlineGraphicElement = ParaEdit.createImage(leafNodeParent,this.selPos - leafNodeParent.getAbsoluteStart(),this._source,this.imageWidth,this.imageHeight,this.options,pointFormat);
         if(textFlow.interactionManager)
         {
            textFlow.interactionManager.notifyInsertOrDelete(absoluteStart,1);
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         var leafNode:FlowElement = textFlow.findLeaf(this.selPos);
         var leafNodeParent:FlowGroupElement = leafNode.parent;
         var elementIdx:int = leafNode.parent.getChildIndex(leafNode);
         leafNodeParent.replaceChildren(elementIdx,elementIdx + 1,null);
         if(textFlow.interactionManager)
         {
            textFlow.interactionManager.notifyInsertOrDelete(absoluteStart,-1);
         }
         return !!this.delSelOp ? this.delSelOp.undo() : originalSelectionState;
      }
      
      override public function redo() : SelectionState
      {
         this.doOperation();
         return new SelectionState(textFlow,this.selPos + 1,this.selPos + 1,null);
      }
   }
}
