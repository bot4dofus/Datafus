package flashx.textLayout.edit
{
   import flashx.textLayout.elements.CellCoordinates;
   import flashx.textLayout.elements.CellRange;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.TextLayoutFormat;
   
   public interface ISelectionManager extends IInteractionEventHandler
   {
       
      
      function get textFlow() : TextFlow;
      
      function set textFlow(param1:TextFlow) : void;
      
      function get currentTable() : TableElement;
      
      function set currentTable(param1:TableElement) : void;
      
      function hasCellRangeSelection() : Boolean;
      
      function selectCellRange(param1:CellCoordinates, param2:CellCoordinates) : void;
      
      function getCellRange() : CellRange;
      
      function setCellRange(param1:CellRange) : void;
      
      function get anchorCellPosition() : CellCoordinates;
      
      function set anchorCellPosition(param1:CellCoordinates) : void;
      
      function get activeCellPosition() : CellCoordinates;
      
      function set activeCellPosition(param1:CellCoordinates) : void;
      
      function get absoluteStart() : int;
      
      function get absoluteEnd() : int;
      
      function selectRange(param1:int, param2:int) : void;
      
      function selectAll() : void;
      
      function selectLastPosition() : void;
      
      function selectFirstPosition() : void;
      
      function deselect() : void;
      
      function get anchorPosition() : int;
      
      function get activePosition() : int;
      
      function hasSelection() : Boolean;
      
      function hasAnySelection() : Boolean;
      
      function get selectionType() : String;
      
      function isRangeSelection() : Boolean;
      
      function getSelectionState() : SelectionState;
      
      function setSelectionState(param1:SelectionState) : void;
      
      function refreshSelection() : void;
      
      function clearSelection() : void;
      
      function setFocus() : void;
      
      function get focused() : Boolean;
      
      function get windowActive() : Boolean;
      
      function get currentSelectionFormat() : SelectionFormat;
      
      function get currentCellSelectionFormat() : SelectionFormat;
      
      function getCommonCharacterFormat(param1:TextRange = null) : TextLayoutFormat;
      
      function getCommonParagraphFormat(param1:TextRange = null) : TextLayoutFormat;
      
      function getCommonContainerFormat(param1:TextRange = null) : TextLayoutFormat;
      
      function get editingMode() : String;
      
      function get focusedSelectionFormat() : SelectionFormat;
      
      function set focusedSelectionFormat(param1:SelectionFormat) : void;
      
      function get unfocusedSelectionFormat() : SelectionFormat;
      
      function set unfocusedSelectionFormat(param1:SelectionFormat) : void;
      
      function get inactiveSelectionFormat() : SelectionFormat;
      
      function set inactiveSelectionFormat(param1:SelectionFormat) : void;
      
      function get focusedCellSelectionFormat() : SelectionFormat;
      
      function set focusedCellSelectionFormat(param1:SelectionFormat) : void;
      
      function get unfocusedCellSelectionFormat() : SelectionFormat;
      
      function set unfocusedCellSelectionFormat(param1:SelectionFormat) : void;
      
      function get inactiveCellSelectionFormat() : SelectionFormat;
      
      function set inactiveCellSelectionFormat(param1:SelectionFormat) : void;
      
      function flushPendingOperations() : void;
      
      function notifyInsertOrDelete(param1:int, param2:int) : void;
      
      function get subManager() : ISelectionManager;
      
      function set subManager(param1:ISelectionManager) : void;
      
      function get superManager() : ISelectionManager;
      
      function set superManager(param1:ISelectionManager) : void;
   }
}
