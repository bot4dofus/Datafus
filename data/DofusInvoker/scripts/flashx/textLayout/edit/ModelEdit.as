package flashx.textLayout.edit
{
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class ModelEdit
   {
       
      
      public function ModelEdit()
      {
         super();
      }
      
      public static function splitElement(textFlow:TextFlow, elemToSplit:FlowGroupElement, relativePosition:int) : IMemento
      {
         return SplitMemento.perform(textFlow,elemToSplit,relativePosition,true);
      }
      
      public static function joinElement(textFlow:TextFlow, element1:FlowGroupElement, element2:FlowGroupElement) : IMemento
      {
         return JoinMemento.perform(textFlow,element1,element2,true);
      }
      
      public static function addElement(textFlow:TextFlow, elemToAdd:FlowElement, parent:FlowGroupElement, index:int) : IMemento
      {
         return AddElementMemento.perform(textFlow,elemToAdd,parent,index,true);
      }
      
      public static function moveElement(textFlow:TextFlow, elemToMove:FlowElement, parent:FlowGroupElement, index:int) : IMemento
      {
         return MoveElementMemento.perform(textFlow,elemToMove,parent,index,true);
      }
      
      public static function removeElements(textFlow:TextFlow, elemtToRemoveParent:FlowGroupElement, startIndex:int, numElements:int) : IMemento
      {
         return RemoveElementsMemento.perform(textFlow,elemtToRemoveParent,startIndex,numElements,true);
      }
      
      public static function deleteText(textFlow:TextFlow, absoluteStart:int, absoluteEnd:int, createMemento:Boolean) : IMemento
      {
         var memento:MementoList = null;
         var mergePara:ParagraphElement = null;
         var newLastParagraph:ParagraphElement = null;
         var lastElement:FlowElement = null;
         var lastSpan:FlowLeafElement = null;
         var lastParagraph:ParagraphElement = null;
         var newLastSpan:SpanElement = null;
         var deleteTextMemento:DeleteTextMemento = null;
         if(absoluteEnd == textFlow.textLength - 1)
         {
            lastElement = textFlow.getChildAt(textFlow.numChildren - 1);
            if(absoluteStart <= lastElement.getAbsoluteStart())
            {
               absoluteEnd = textFlow.textLength;
            }
         }
         if(absoluteEnd >= textFlow.textLength)
         {
            lastSpan = textFlow.getLastLeaf();
            lastParagraph = lastSpan.getParagraph();
            newLastParagraph = new ParagraphElement();
            newLastSpan = new SpanElement();
            newLastParagraph.replaceChildren(0,0,newLastSpan);
            newLastParagraph.format = lastParagraph.format;
            newLastSpan.format = lastSpan.format;
            absoluteEnd = textFlow.textLength;
         }
         if(createMemento)
         {
            memento = new MementoList(textFlow);
            if(newLastParagraph)
            {
               memento.push(addElement(textFlow,newLastParagraph,textFlow,textFlow.numChildren));
            }
            deleteTextMemento = new DeleteTextMemento(textFlow,absoluteStart,absoluteEnd);
            memento.push(deleteTextMemento);
            mergePara = TextFlowEdit.deleteRange(textFlow,absoluteStart,absoluteEnd);
            memento.push(TextFlowEdit.joinNextParagraph(mergePara,false));
            checkNormalize(textFlow,deleteTextMemento.commonRoot,memento);
         }
         else
         {
            if(newLastParagraph)
            {
               textFlow.replaceChildren(textFlow.numChildren,textFlow.numChildren,newLastParagraph);
            }
            mergePara = TextFlowEdit.deleteRange(textFlow,absoluteStart,absoluteEnd);
            TextFlowEdit.joinNextParagraph(mergePara,false);
         }
         if(textFlow.interactionManager)
         {
            textFlow.interactionManager.notifyInsertOrDelete(absoluteStart,-(absoluteEnd - absoluteStart));
         }
         return memento;
      }
      
      private static function checkNormalize(textFlow:TextFlow, commonRoot:FlowGroupElement, mementoList:MementoList) : void
      {
         var paragraph:ParagraphElement = null;
         var child:FlowGroupElement = null;
         if(commonRoot is ListItemElement && (commonRoot as ListItemElement).normalizeNeedsInitialParagraph())
         {
            paragraph = new ParagraphElement();
            paragraph.replaceChildren(0,0,new SpanElement());
            mementoList.push(ModelEdit.addElement(textFlow,paragraph,commonRoot,0));
         }
         for(var index:int = 0; index < commonRoot.numChildren; index++)
         {
            child = commonRoot.getChildAt(index) as FlowGroupElement;
            if(child)
            {
               checkNormalize(textFlow,child,mementoList);
            }
         }
      }
      
      public static function saveCurrentState(textFlow:TextFlow, absoluteStart:int, absoluteEnd:int) : IMemento
      {
         return new TextRangeMemento(textFlow,absoluteStart,absoluteEnd);
      }
   }
}

import flashx.textLayout.elements.TextFlow;

class BaseMemento
{
    
   
   protected var _textFlow:TextFlow;
   
   function BaseMemento(textFlow:TextFlow)
   {
      super();
      this._textFlow = textFlow;
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.FlowLeafElement;
import flashx.textLayout.elements.TextFlow;

class DeleteTextMemento extends BaseMemento implements IMemento
{
    
   
   private var _commonRootMark:ElementMark;
   
   private var _startChildIndex:int;
   
   private var _endChildIndex:int;
   
   private var _originalChildren:Array;
   
   private var _absoluteStart:int;
   
   protected var scrapChildren:Array;
   
   protected var replaceCount:int;
   
   function DeleteTextMemento(textFlow:TextFlow, absoluteStart:int, absoluteEnd:int)
   {
      var rootStart:int = 0;
      var startChild:FlowElement = null;
      var absoluteStartAdjusted:int = 0;
      var endChild:FlowElement = null;
      var absoluteEndAdjusted:int = 0;
      var scrapRoot:FlowGroupElement = null;
      super(textFlow);
      var startLeaf:FlowLeafElement = textFlow.findLeaf(absoluteStart);
      var commonRoot:FlowGroupElement = startLeaf.getParagraph().parent;
      while(commonRoot && commonRoot.parent && (commonRoot.getAbsoluteStart() + commonRoot.textLength < absoluteEnd || commonRoot.getAbsoluteStart() == absoluteStart && commonRoot.getAbsoluteStart() + commonRoot.textLength == absoluteEnd))
      {
         commonRoot = commonRoot.parent;
      }
      if(commonRoot)
      {
         rootStart = commonRoot.getAbsoluteStart();
         this._startChildIndex = commonRoot.findChildIndexAtPosition(absoluteStart - rootStart);
         this._endChildIndex = commonRoot.findChildIndexAtPosition(absoluteEnd - rootStart - 1);
         if(this._endChildIndex < 0)
         {
            this._endChildIndex = commonRoot.numChildren - 1;
         }
         startChild = commonRoot.getChildAt(this._startChildIndex);
         absoluteStartAdjusted = startChild.getAbsoluteStart();
         endChild = commonRoot.getChildAt(this._endChildIndex);
         absoluteEndAdjusted = endChild.getAbsoluteStart() + endChild.textLength;
         this.replaceCount = 0;
         if(this._startChildIndex == this._endChildIndex)
         {
            if(absoluteStartAdjusted < absoluteStart || absoluteEndAdjusted > absoluteEnd)
            {
               this.replaceCount = 1;
            }
         }
         else
         {
            if(absoluteStartAdjusted < absoluteStart)
            {
               ++this.replaceCount;
            }
            if(absoluteEndAdjusted > absoluteEnd)
            {
               ++this.replaceCount;
            }
         }
         scrapRoot = commonRoot.deepCopy(absoluteStartAdjusted - rootStart,absoluteEndAdjusted - rootStart) as FlowGroupElement;
         this.scrapChildren = scrapRoot.mxmlChildren;
      }
      this._commonRootMark = new ElementMark(commonRoot,0);
      this._absoluteStart = absoluteStart;
   }
   
   public function undo() : *
   {
      var element:FlowElement = null;
      var root:FlowGroupElement = this.commonRoot;
      this._originalChildren = [];
      for(var childIndex:int = this._startChildIndex; childIndex < this._startChildIndex + this.replaceCount; childIndex++)
      {
         this._originalChildren.push(root.getChildAt(childIndex));
      }
      var addToFlow:Array = [];
      for each(element in this.scrapChildren)
      {
         addToFlow.push(element.deepCopy());
      }
      root.replaceChildren(this._startChildIndex,this._startChildIndex + this.replaceCount,addToFlow);
   }
   
   public function redo() : *
   {
      this.commonRoot.replaceChildren(this._startChildIndex,this._startChildIndex + this.scrapChildren.length,this._originalChildren);
   }
   
   public function get commonRoot() : FlowGroupElement
   {
      return this._commonRootMark.findElement(_textFlow) as FlowGroupElement;
   }
}

import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.TextFlow;

class TextRangeMemento extends DeleteTextMemento implements IMemento
{
    
   
   function TextRangeMemento(textFlow:TextFlow, absoluteStart:int, absoluteEnd:int)
   {
      super(textFlow,absoluteStart,absoluteEnd);
      replaceCount = scrapChildren.length;
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.FlowLeafElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SubParagraphGroupElementBase;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class InternalSplitFGEMemento extends BaseMemento implements IMemento
{
    
   
   private var _target:ElementMark;
   
   private var _undoTarget:ElementMark;
   
   private var _newSibling:FlowGroupElement;
   
   private var _skipUndo:Boolean;
   
   function InternalSplitFGEMemento(textFlow:TextFlow, target:ElementMark, undoTarget:ElementMark, newSibling:FlowGroupElement)
   {
      super(textFlow);
      this._target = target;
      this._undoTarget = undoTarget;
      this._newSibling = newSibling;
      this._skipUndo = newSibling is SubParagraphGroupElementBase;
   }
   
   public static function perform(textFlow:TextFlow, elemToSplit:FlowElement, relativePosition:int, createMemento:Boolean) : *
   {
      var undoTarget:ElementMark = null;
      var target:ElementMark = new ElementMark(elemToSplit,relativePosition);
      var newSibling:FlowGroupElement = performInternal(textFlow,target);
      if(createMemento)
      {
         undoTarget = new ElementMark(newSibling,0);
         return new InternalSplitFGEMemento(textFlow,target,undoTarget,newSibling);
      }
      return newSibling;
   }
   
   public static function performInternal(textFlow:TextFlow, target:ElementMark) : *
   {
      var newSibling:FlowGroupElement = null;
      var targetElement:FlowGroupElement = target.findElement(textFlow) as FlowGroupElement;
      var childIdx:int = target.elemStart == targetElement.textLength ? int(targetElement.numChildren - 1) : int(targetElement.findChildIndexAtPosition(target.elemStart));
      var child:FlowElement = targetElement.getChildAt(childIdx);
      if(child.parentRelativeStart == target.elemStart)
      {
         newSibling = targetElement.splitAtIndex(childIdx);
      }
      else
      {
         newSibling = targetElement.splitAtPosition(target.elemStart) as FlowGroupElement;
      }
      if(targetElement is ParagraphElement)
      {
         if(targetElement.textLength <= 1)
         {
            targetElement.normalizeRange(0,targetElement.textLength);
            targetElement.getLastLeaf().quickCloneTextLayoutFormat(newSibling.getFirstLeaf());
         }
         else if(newSibling.textLength <= 1)
         {
            newSibling.normalizeRange(0,newSibling.textLength);
            newSibling.getFirstLeaf().quickCloneTextLayoutFormat(targetElement.getLastLeaf());
         }
      }
      return newSibling;
   }
   
   public function get newSibling() : FlowGroupElement
   {
      return this._newSibling;
   }
   
   public function undo() : *
   {
      if(this._skipUndo)
      {
         return;
      }
      var target:FlowGroupElement = this._undoTarget.findElement(_textFlow) as FlowGroupElement;
      var prevSibling:FlowGroupElement = target.getPreviousSibling() as FlowGroupElement;
      target.parent.removeChild(target);
      var lastLeaf:FlowLeafElement = prevSibling.getLastLeaf();
      prevSibling.replaceChildren(prevSibling.numChildren,prevSibling.numChildren,target.mxmlChildren);
      if(prevSibling is ParagraphElement && lastLeaf.parent && lastLeaf.textLength == 0)
      {
         prevSibling.removeChild(lastLeaf);
      }
   }
   
   public function redo() : *
   {
      return performInternal(_textFlow,this._target);
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.edit.ModelEdit;
import flashx.textLayout.elements.ContainerFormattedElement;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.ListItemElement;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class SplitMemento extends BaseMemento implements IMemento
{
    
   
   private var _mementoList:Array;
   
   private var _target:ElementMark;
   
   function SplitMemento(textFlow:TextFlow, target:ElementMark, mementoList:Array)
   {
      super(textFlow);
      this._target = target;
      this._mementoList = mementoList;
   }
   
   public static function perform(textFlow:TextFlow, elemToSplit:FlowGroupElement, relativePosition:int, createMemento:Boolean) : *
   {
      var target:ElementMark = new ElementMark(elemToSplit,relativePosition);
      var mementoList:Array = [];
      var newChild:FlowGroupElement = performInternal(textFlow,target,!!createMemento ? mementoList : null);
      if(createMemento)
      {
         return new SplitMemento(textFlow,target,mementoList);
      }
      return newChild;
   }
   
   private static function testValidLeadingParagraph(elem:FlowGroupElement) : Boolean
   {
      if(elem is ListItemElement)
      {
         return !(elem as ListItemElement).normalizeNeedsInitialParagraph();
      }
      while(elem && !(elem is ParagraphElement))
      {
         elem = elem.getChildAt(0) as FlowGroupElement;
      }
      return elem is ParagraphElement;
   }
   
   public static function performInternal(textFlow:TextFlow, target:ElementMark, mementoList:Array) : FlowGroupElement
   {
      var newChild:FlowGroupElement = null;
      var memento:IMemento = null;
      var splitPos:int = 0;
      var splitMemento:InternalSplitFGEMemento = null;
      var targetElement:FlowGroupElement = target.findElement(textFlow) as FlowGroupElement;
      var child:FlowGroupElement = (target.elemStart == targetElement.textLength ? targetElement.getLastLeaf() : targetElement.findLeaf(target.elemStart)).parent;
      var splitStart:int = target.elemStart;
      while(true)
      {
         splitPos = splitStart - (child.getAbsoluteStart() - targetElement.getAbsoluteStart());
         splitMemento = InternalSplitFGEMemento.perform(textFlow,child,splitPos,true);
         if(mementoList)
         {
            mementoList.push(splitMemento);
         }
         newChild = splitMemento.newSibling;
         if(child is ParagraphElement && target.elemStart != targetElement.textLength)
         {
            splitStart++;
         }
         else if(child is ContainerFormattedElement)
         {
            if(!testValidLeadingParagraph(child))
            {
               memento = ModelEdit.addElement(textFlow,new ParagraphElement(),child,0);
               if(mementoList)
               {
                  mementoList.push(memento);
               }
               splitStart++;
            }
            if(!testValidLeadingParagraph(newChild))
            {
               memento = ModelEdit.addElement(textFlow,new ParagraphElement(),newChild,0);
               if(mementoList)
               {
                  mementoList.push(memento);
               }
            }
         }
         if(child == targetElement)
         {
            break;
         }
         child = child.parent;
      }
      return newChild;
   }
   
   public function undo() : *
   {
      var memento:IMemento = null;
      this._mementoList.reverse();
      for each(memento in this._mementoList)
      {
         memento.undo();
      }
      this._mementoList.reverse();
   }
   
   public function redo() : *
   {
      return performInternal(_textFlow,this._target,null);
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.edit.TextFlowEdit;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class JoinMemento extends BaseMemento implements IMemento
{
    
   
   private var _element1:ElementMark;
   
   private var _element2:ElementMark;
   
   private var _joinPosition:int;
   
   private var _removeParentChain:IMemento;
   
   function JoinMemento(textFlow:TextFlow, element1:ElementMark, element2:ElementMark, joinPosition:int, removeParentChain:IMemento)
   {
      super(textFlow);
      this._element1 = element1;
      this._element2 = element2;
      this._joinPosition = joinPosition;
      this._removeParentChain = removeParentChain;
   }
   
   public static function perform(textFlow:TextFlow, element1:FlowGroupElement, element2:FlowGroupElement, createMemento:Boolean) : *
   {
      var joinPosition:int = element1.textLength - 1;
      var element1Mark:ElementMark = new ElementMark(element1,0);
      var element2Mark:ElementMark = new ElementMark(element2,0);
      performInternal(textFlow,element1Mark,element2Mark);
      var removeParentChain:IMemento = TextFlowEdit.removeEmptyParentChain(element2);
      if(createMemento)
      {
         return new JoinMemento(textFlow,element1Mark,element2Mark,joinPosition,removeParentChain);
      }
      return null;
   }
   
   public static function performInternal(textFlow:TextFlow, element1Mark:ElementMark, element2Mark:ElementMark) : void
   {
      var element1:FlowGroupElement = element1Mark.findElement(textFlow) as FlowGroupElement;
      var element2:FlowGroupElement = element2Mark.findElement(textFlow) as FlowGroupElement;
      moveChildren(element2,element1);
   }
   
   private static function moveChildren(elementSource:FlowGroupElement, elementDestination:FlowGroupElement) : void
   {
      var childrenToMove:Array = elementSource.mxmlChildren;
      elementSource.replaceChildren(0,elementSource.numChildren);
      elementDestination.replaceChildren(elementDestination.numChildren,elementDestination.numChildren,childrenToMove);
   }
   
   public function undo() : *
   {
      this._removeParentChain.undo();
      var element1:FlowGroupElement = this._element1.findElement(_textFlow) as FlowGroupElement;
      var element2:FlowGroupElement = this._element2.findElement(_textFlow) as FlowGroupElement;
      var tmpElement:FlowGroupElement = element1.splitAtPosition(this._joinPosition) as FlowGroupElement;
      moveChildren(tmpElement,element2);
      tmpElement.parent.removeChild(tmpElement);
   }
   
   public function redo() : *
   {
      performInternal(_textFlow,this._element1,this._element2);
      this._removeParentChain.redo();
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.TextFlow;

class AddElementMemento extends BaseMemento implements IMemento
{
    
   
   private var _target:ElementMark;
   
   private var _targetIndex:int;
   
   private var _elemToAdd:FlowElement;
   
   function AddElementMemento(textFlow:TextFlow, elemToAdd:FlowElement, target:ElementMark, index:int)
   {
      super(textFlow);
      this._target = target;
      this._targetIndex = index;
      this._elemToAdd = elemToAdd;
   }
   
   public static function perform(textFlow:TextFlow, elemToAdd:FlowElement, parent:FlowGroupElement, index:int, createMemento:Boolean) : *
   {
      var elem:FlowElement = elemToAdd;
      if(createMemento)
      {
         elemToAdd = elem.deepCopy();
      }
      var target:ElementMark = new ElementMark(parent,0);
      var targetElement:FlowGroupElement = target.findElement(textFlow) as FlowGroupElement;
      targetElement.addChildAt(index,elem);
      if(createMemento)
      {
         return new AddElementMemento(textFlow,elemToAdd,target,index);
      }
      return null;
   }
   
   public function undo() : *
   {
      var target:FlowGroupElement = this._target.findElement(_textFlow) as FlowGroupElement;
      target.removeChildAt(this._targetIndex);
   }
   
   public function redo() : *
   {
      var parent:FlowGroupElement = this._target.findElement(_textFlow) as FlowGroupElement;
      return perform(_textFlow,this._elemToAdd,parent,this._targetIndex,false);
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.FlowElement;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.TextFlow;

class MoveElementMemento extends BaseMemento implements IMemento
{
    
   
   private var _target:ElementMark;
   
   private var _targetIndex:int;
   
   private var _elemBeforeMove:ElementMark;
   
   private var _elemAfterMove:ElementMark;
   
   private var _source:ElementMark;
   
   private var _sourceIndex:int;
   
   function MoveElementMemento(textFlow:TextFlow, elemBeforeMove:ElementMark, elemAfterMove:ElementMark, target:ElementMark, targetIndex:int, source:ElementMark, sourceIndex:int)
   {
      super(textFlow);
      this._elemBeforeMove = elemBeforeMove;
      this._elemAfterMove = elemAfterMove;
      this._target = target;
      this._targetIndex = targetIndex;
      this._source = source;
      this._sourceIndex = sourceIndex;
   }
   
   public static function perform(textFlow:TextFlow, elem:FlowElement, newParent:FlowGroupElement, newIndex:int, createMemento:Boolean) : *
   {
      var target:ElementMark = new ElementMark(newParent,0);
      var elemBeforeMove:ElementMark = new ElementMark(elem,0);
      var source:FlowGroupElement = elem.parent;
      var sourceIndex:int = source.getChildIndex(elem);
      var sourceMark:ElementMark = new ElementMark(source,0);
      newParent.addChildAt(newIndex,elem);
      if(createMemento)
      {
         return new MoveElementMemento(textFlow,elemBeforeMove,new ElementMark(elem,0),target,newIndex,sourceMark,sourceIndex);
      }
      return elem;
   }
   
   public function undo() : *
   {
      var elem:FlowElement = this._elemAfterMove.findElement(_textFlow);
      elem.parent.removeChildAt(elem.parent.getChildIndex(elem));
      var source:FlowGroupElement = this._source.findElement(_textFlow) as FlowGroupElement;
      source.addChildAt(this._sourceIndex,elem);
   }
   
   public function redo() : *
   {
      var target:FlowGroupElement = this._target.findElement(_textFlow) as FlowGroupElement;
      var elem:FlowElement = this._elemBeforeMove.findElement(_textFlow) as FlowElement;
      return perform(_textFlow,elem,target,this._targetIndex,false);
   }
}

import flashx.textLayout.edit.ElementMark;
import flashx.textLayout.edit.IMemento;
import flashx.textLayout.elements.FlowGroupElement;
import flashx.textLayout.elements.TextFlow;

class RemoveElementsMemento extends BaseMemento implements IMemento
{
    
   
   private var _elements:Array;
   
   private var _elemParent:ElementMark;
   
   private var _startIndex:int;
   
   private var _numElements:int;
   
   function RemoveElementsMemento(textFlow:TextFlow, elementParent:ElementMark, startIndex:int, numElements:int, elements:Array)
   {
      super(textFlow);
      this._elemParent = elementParent;
      this._startIndex = startIndex;
      this._numElements = numElements;
      this._elements = elements;
   }
   
   public static function perform(textFlow:TextFlow, parent:FlowGroupElement, startIndex:int, numElements:int, createMemento:Boolean) : *
   {
      var elemParent:ElementMark = new ElementMark(parent,0);
      var elements:Array = parent.mxmlChildren.slice(startIndex,startIndex + numElements);
      parent.replaceChildren(startIndex,startIndex + numElements);
      if(createMemento)
      {
         return new RemoveElementsMemento(textFlow,elemParent,startIndex,numElements,elements);
      }
      return elements;
   }
   
   public function undo() : *
   {
      var parent:FlowGroupElement = this._elemParent.findElement(_textFlow) as FlowGroupElement;
      parent.replaceChildren(this._startIndex,this._startIndex,this._elements);
      this._elements = null;
      return parent.mxmlChildren.slice(this._startIndex,this._startIndex + this._numElements);
   }
   
   public function redo() : *
   {
      var parent:FlowGroupElement = this._elemParent.findElement(_textFlow) as FlowGroupElement;
      this._elements = perform(_textFlow,parent,this._startIndex,this._numElements,false);
   }
}
