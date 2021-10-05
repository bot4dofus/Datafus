package flashx.textLayout.edit
{
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.operations.FlowOperation;
   import flashx.undo.IOperation;
   import flashx.undo.IUndoManager;
   
   [Exclude(kind="property",name="delayedOperations")]
   public interface IEditManager extends ISelectionManager
   {
       
      
      function get undoManager() : IUndoManager;
      
      function applyFormat(param1:ITextLayoutFormat, param2:ITextLayoutFormat, param3:ITextLayoutFormat, param4:SelectionState = null) : void;
      
      function clearFormat(param1:ITextLayoutFormat, param2:ITextLayoutFormat, param3:ITextLayoutFormat, param4:SelectionState = null) : void;
      
      function applyLeafFormat(param1:ITextLayoutFormat, param2:SelectionState = null) : void;
      
      function applyTCY(param1:Boolean, param2:SelectionState = null) : TCYElement;
      
      function applyLink(param1:String, param2:String = null, param3:Boolean = false, param4:SelectionState = null) : LinkElement;
      
      function changeElementID(param1:String, param2:FlowElement, param3:int = 0, param4:int = -1, param5:SelectionState = null) : void;
      
      function changeStyleName(param1:String, param2:FlowElement, param3:int = 0, param4:int = -1, param5:SelectionState = null) : void;
      
      function changeTypeName(param1:String, param2:FlowElement, param3:int = 0, param4:int = -1, param5:SelectionState = null) : void;
      
      function deleteNextCharacter(param1:SelectionState = null) : void;
      
      function deletePreviousCharacter(param1:SelectionState = null) : void;
      
      function deleteNextWord(param1:SelectionState = null) : void;
      
      function deletePreviousWord(param1:SelectionState = null) : void;
      
      function deleteText(param1:SelectionState = null) : void;
      
      function insertInlineGraphic(param1:Object, param2:Object, param3:Object, param4:Object = null, param5:SelectionState = null) : InlineGraphicElement;
      
      function insertTableElement(param1:TableElement, param2:SelectionState = null) : void;
      
      function modifyInlineGraphic(param1:Object, param2:Object, param3:Object, param4:Object = null, param5:SelectionState = null) : void;
      
      function insertText(param1:String, param2:SelectionState = null) : void;
      
      function overwriteText(param1:String, param2:SelectionState = null) : void;
      
      function applyParagraphFormat(param1:ITextLayoutFormat, param2:SelectionState = null) : void;
      
      function applyContainerFormat(param1:ITextLayoutFormat, param2:SelectionState = null) : void;
      
      function applyFormatToElement(param1:FlowElement, param2:ITextLayoutFormat, param3:int = 0, param4:int = -1, param5:SelectionState = null) : void;
      
      function clearFormatOnElement(param1:FlowElement, param2:ITextLayoutFormat, param3:SelectionState = null) : void;
      
      function splitParagraph(param1:SelectionState = null) : ParagraphElement;
      
      function splitElement(param1:FlowGroupElement, param2:SelectionState = null) : FlowGroupElement;
      
      function createDiv(param1:FlowGroupElement = null, param2:ITextLayoutFormat = null, param3:SelectionState = null) : DivElement;
      
      function createList(param1:FlowGroupElement = null, param2:ITextLayoutFormat = null, param3:SelectionState = null) : ListElement;
      
      function moveChildren(param1:FlowGroupElement, param2:int, param3:int, param4:FlowGroupElement, param5:int, param6:SelectionState = null) : void;
      
      function createSubParagraphGroup(param1:FlowGroupElement = null, param2:ITextLayoutFormat = null, param3:SelectionState = null) : SubParagraphGroupElement;
      
      function cutTextScrap(param1:SelectionState = null) : TextScrap;
      
      function pasteTextScrap(param1:TextScrap, param2:SelectionState = null) : void;
      
      function beginCompositeOperation() : void;
      
      function endCompositeOperation() : void;
      
      function doOperation(param1:FlowOperation) : void;
      
      function undo() : void;
      
      function redo() : void;
      
      function performUndo(param1:IOperation) : void;
      
      function performRedo(param1:IOperation) : void;
      
      function get delayUpdates() : Boolean;
      
      function set delayUpdates(param1:Boolean) : void;
      
      function get allowDelayedOperations() : Boolean;
      
      function set allowDelayedOperations(param1:Boolean) : void;
      
      function updateAllControllers() : void;
   }
}
