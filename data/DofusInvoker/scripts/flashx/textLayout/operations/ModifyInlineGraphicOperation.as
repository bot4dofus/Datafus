package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ModifyInlineGraphicOperation extends FlowTextOperation
   {
       
      
      private var _source:Object;
      
      private var imageWidth:Object;
      
      private var imageHeight:Object;
      
      private var _options:Object;
      
      private var oldImage:FlowElement;
      
      private var selPos:int = 0;
      
      public function ModifyInlineGraphicOperation(operationState:SelectionState, source:Object, width:Object, height:Object, options:Object = null)
      {
         super(operationState);
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
      
      override public function doOperation() : Boolean
      {
         this.selPos = absoluteStart;
         var img:InlineGraphicElement = textFlow.findLeaf(this.selPos) as InlineGraphicElement;
         if(img)
         {
            this.oldImage = img.shallowCopy(0,1);
            if(img.width != this.imageWidth)
            {
               img.width = this.imageWidth;
            }
            if(img.height != this.imageHeight)
            {
               img.height = this.imageHeight;
            }
            if(img.source != this._source)
            {
               img.source = this._source;
            }
            if(this.options && img.float != this.options.toString())
            {
               img.float = this.options.toString();
            }
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         var leafNode:FlowElement = textFlow.findLeaf(this.selPos);
         var leafNodeParent:FlowGroupElement = leafNode.parent;
         var elementIdx:int = leafNode.parent.getChildIndex(leafNode);
         leafNodeParent.replaceChildren(elementIdx,elementIdx + 1,this.oldImage);
         return originalSelectionState;
      }
   }
}
