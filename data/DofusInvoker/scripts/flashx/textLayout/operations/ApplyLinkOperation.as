package flashx.textLayout.operations
{
   import flashx.textLayout.edit.IMemento;
   import flashx.textLayout.edit.ModelEdit;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.edit.TextFlowEdit;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.LinkElement;
   
   public class ApplyLinkOperation extends FlowTextOperation
   {
       
      
      private var _hrefString:String;
      
      private var _target:String;
      
      private var _extendToLinkBoundary:Boolean;
      
      private var _memento:IMemento;
      
      private var _linkElement:LinkElement;
      
      public function ApplyLinkOperation(operationState:SelectionState, href:String, target:String, extendToLinkBoundary:Boolean)
      {
         super(operationState);
         this._hrefString = href;
         this._target = target;
         this._extendToLinkBoundary = extendToLinkBoundary;
      }
      
      public function get href() : String
      {
         return this._hrefString;
      }
      
      public function set href(value:String) : void
      {
         this._hrefString = value;
      }
      
      public function get target() : String
      {
         return this._target;
      }
      
      public function set target(value:String) : void
      {
         this._target = value;
      }
      
      public function get extendToLinkBoundary() : Boolean
      {
         return this._extendToLinkBoundary;
      }
      
      public function set extendToLinkBoundary(value:Boolean) : void
      {
         this._extendToLinkBoundary = value;
      }
      
      public function get newLinkElement() : LinkElement
      {
         return this._linkElement;
      }
      
      override public function doOperation() : Boolean
      {
         var leaf:FlowLeafElement = null;
         var link:LinkElement = null;
         var madeLink:Boolean = false;
         if(absoluteStart == absoluteEnd)
         {
            return false;
         }
         if(this._extendToLinkBoundary)
         {
            leaf = textFlow.findLeaf(absoluteStart);
            link = leaf.getParentByType(LinkElement) as LinkElement;
            if(link)
            {
               absoluteStart = link.getAbsoluteStart();
            }
            leaf = textFlow.findLeaf(absoluteEnd - 1);
            link = leaf.getParentByType(LinkElement) as LinkElement;
            if(link)
            {
               absoluteEnd = link.getAbsoluteStart() + link.textLength;
            }
         }
         this._memento = ModelEdit.saveCurrentState(textFlow,absoluteStart,absoluteEnd);
         if(this._hrefString && this._hrefString != "")
         {
            madeLink = TextFlowEdit.makeLink(textFlow,absoluteStart,absoluteEnd,this._hrefString,this._target);
            if(!madeLink)
            {
               this._memento = null;
               return false;
            }
            leaf = textFlow.findLeaf(absoluteStart);
            this._linkElement = leaf.getParentByType(LinkElement) as LinkElement;
         }
         else
         {
            TextFlowEdit.removeLink(textFlow,absoluteStart,absoluteEnd);
         }
         return true;
      }
      
      override public function undo() : SelectionState
      {
         if(this._memento)
         {
            this._memento.undo();
         }
         return originalSelectionState;
      }
      
      override public function redo() : SelectionState
      {
         if(absoluteStart != absoluteEnd && this._memento)
         {
            if(this._hrefString != "")
            {
               TextFlowEdit.makeLink(textFlow,absoluteStart,absoluteEnd,this._hrefString,this._target);
            }
            else
            {
               TextFlowEdit.removeLink(textFlow,absoluteStart,absoluteEnd);
            }
         }
         return originalSelectionState;
      }
   }
}
