package flashx.textLayout.edit
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.errors.IllegalOperationError;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IMEEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flash.text.engine.TextRotation;
   import flash.ui.ContextMenu;
   import flash.ui.Keyboard;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.ui.MouseCursorData;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.compose.TextFlowTableBlock;
   import flashx.textLayout.container.ColumnState;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.CellContainer;
   import flashx.textLayout.elements.CellCoordinates;
   import flashx.textLayout.elements.CellRange;
   import flashx.textLayout.elements.Configuration;
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.elements.TableColElement;
   import flashx.textLayout.elements.TableElement;
   import flashx.textLayout.elements.TableRowElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.events.FlowOperationEvent;
   import flashx.textLayout.events.SelectionEvent;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.operations.CopyOperation;
   import flashx.textLayout.operations.FlowOperation;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.NavigationUtil;
   
   use namespace tlf_internal;
   
   public class SelectionManager implements ISelectionManager
   {
      
      tlf_internal static var useTableSelectionCursors:Boolean = false;
      
      public static var SelectTable:String = "selectTable";
      
      public static var SelectTableRow:String = "selectTableRow";
      
      public static var SelectTableColumn:String = "selectTableColumn";
       
      
      private var _focusedSelectionFormat:SelectionFormat;
      
      private var _unfocusedSelectionFormat:SelectionFormat;
      
      private var _inactiveSelectionFormat:SelectionFormat;
      
      private var _focusedCellSelectionFormat:SelectionFormat;
      
      private var _unfocusedCellSelectionFormat:SelectionFormat;
      
      private var _inactiveCellSelectionFormat:SelectionFormat;
      
      private var _selFormatState:String = "unfocused";
      
      private var _isActive:Boolean;
      
      private var _textFlow:TextFlow;
      
      protected var _subManager:ISelectionManager;
      
      protected var _superManager:ISelectionManager;
      
      private var _currentTable:TableElement;
      
      private var _cellRange:CellRange;
      
      private var anchorMark:Mark;
      
      private var activeMark:Mark;
      
      private var _anchorCellPosition:CellCoordinates;
      
      private var _activeCellPosition:CellCoordinates;
      
      private var _pointFormat:ITextLayoutFormat;
      
      protected var ignoreNextTextEvent:Boolean = false;
      
      protected var allowOperationMerge:Boolean = false;
      
      private var _mouseOverSelectionArea:Boolean = false;
      
      private var marks:Array;
      
      private var cellMarks:Array;
      
      public var selectTableCursorPoints:Vector.<Number>;
      
      public var selectTableCursorDrawCommands:Vector.<int>;
      
      public function SelectionManager()
      {
         this.marks = [];
         this.cellMarks = [];
         this.selectTableCursorPoints = new <Number>[1,3,11,3,11,0,12,0,16,4,12,8,11,8,11,5,1,5,1,3];
         this.selectTableCursorDrawCommands = new <int>[1,2,2,2,2,2,2,2,2,2];
         super();
         this._textFlow = null;
         this.anchorMark = this.createMark();
         this.activeMark = this.createMark();
         this.anchorCellPosition = this.createCellMark();
         this.activeCellPosition = this.createCellMark();
         this._pointFormat = null;
         this._isActive = false;
         Mouse.registerCursor(SelectTable,this.createSelectTableCursor());
         Mouse.registerCursor(SelectTableRow,this.createSelectTableRowCursor());
         Mouse.registerCursor(SelectTableColumn,this.createSelectTableColumnCursor());
      }
      
      private static function computeSelectionIndexInContainer(textFlow:TextFlow, controller:ContainerController, localX:Number, localY:Number) : int
      {
         var result:int = 0;
         var rtline:TextFlowLine = null;
         var rtTextLine:TextLine = null;
         var bounds:Rectangle = null;
         var linePerpCoor:Number = NaN;
         var midPerpCoor:Number = NaN;
         var isLineBelow:Boolean = false;
         var prevPerpCoor:Number = NaN;
         var inPrevLine:Boolean = false;
         var textLine:TextLine = null;
         var startOnNextLineIfNecessary:Boolean = false;
         var lastAtom:int = 0;
         var lastAtomRect:Rectangle = null;
         var lastLinePosInPar:int = 0;
         var lastChar:String = null;
         var lineIndex:int = -1;
         var firstCharVisible:int = controller.absoluteStart;
         var length:int = controller.textLength;
         var bp:String = textFlow.computedFormat.blockProgression;
         var isTTB:* = bp == BlockProgression.RL;
         var isDirectionRTL:* = textFlow.computedFormat.direction == Direction.RTL;
         var perpCoor:Number = !!isTTB ? Number(localX) : Number(localY);
         var nearestColIdx:int = locateNearestColumn(controller,localX,localY,textFlow.computedFormat.blockProgression,textFlow.computedFormat.direction);
         var prevLineBounds:Rectangle = null;
         var previousLineIndex:int = -1;
         var lastLineIndexInColumn:int = -1;
         for(var testIndex:int = textFlow.flowComposer.numLines - 1; testIndex >= 0; testIndex--)
         {
            rtline = textFlow.flowComposer.getLineAt(testIndex);
            if(rtline.controller != controller || rtline.columnIndex != nearestColIdx)
            {
               if(lastLineIndexInColumn != -1)
               {
                  lineIndex = testIndex + 1;
                  break;
               }
            }
            else if(!(rtline.absoluteStart < firstCharVisible || rtline.absoluteStart >= firstCharVisible + length))
            {
               rtTextLine = rtline.getTextLine();
               if(!(rtTextLine == null || rtTextLine.parent == null))
               {
                  if(lastLineIndexInColumn == -1)
                  {
                     lastLineIndexInColumn = testIndex;
                  }
                  bounds = rtTextLine.getBounds(DisplayObject(controller.container));
                  linePerpCoor = !!isTTB ? Number(bounds.left) : Number(bounds.bottom);
                  midPerpCoor = -1;
                  if(prevLineBounds)
                  {
                     prevPerpCoor = !!isTTB ? Number(prevLineBounds.right) : Number(prevLineBounds.top);
                     midPerpCoor = (linePerpCoor + prevPerpCoor) / 2;
                  }
                  isLineBelow = !!isTTB ? linePerpCoor > perpCoor : linePerpCoor < perpCoor;
                  if(isLineBelow || testIndex == 0)
                  {
                     inPrevLine = midPerpCoor != -1 && (!!isTTB ? perpCoor < midPerpCoor : perpCoor > midPerpCoor);
                     lineIndex = inPrevLine && testIndex != lastLineIndexInColumn ? int(testIndex + 1) : int(testIndex);
                     break;
                  }
                  prevLineBounds = bounds;
                  previousLineIndex = testIndex;
               }
            }
         }
         if(lineIndex == -1)
         {
            lineIndex = previousLineIndex;
            if(lineIndex == -1)
            {
               return -1;
            }
         }
         var textFlowLine:TextFlowLine = textFlow.flowComposer.getLineAt(lineIndex);
         if(textFlowLine is TextFlowTableBlock)
         {
            result = TextFlowTableBlock(textFlowLine).absoluteStart;
         }
         else
         {
            textLine = textFlowLine.getTextLine(true);
            localX -= textLine.x;
            localY -= textLine.y;
            startOnNextLineIfNecessary = false;
            lastAtom = -1;
            if(isDirectionRTL)
            {
               lastAtom = textLine.atomCount - 1;
            }
            else if(textFlowLine.absoluteStart + textFlowLine.textLength >= textFlowLine.paragraph.getAbsoluteStart() + textFlowLine.paragraph.textLength)
            {
               if(textLine.atomCount > 1)
               {
                  lastAtom = textLine.atomCount - 2;
               }
            }
            else
            {
               lastLinePosInPar = textFlowLine.absoluteStart + textFlowLine.textLength - 1;
               lastChar = textLine.textBlock.content.rawText.charAt(lastLinePosInPar);
               if(lastChar == " ")
               {
                  if(textLine.atomCount > 1)
                  {
                     lastAtom = textLine.atomCount - 2;
                  }
               }
               else
               {
                  startOnNextLineIfNecessary = true;
                  if(textLine.atomCount > 0)
                  {
                     lastAtom = textLine.atomCount - 1;
                  }
               }
            }
            lastAtomRect = lastAtom > 0 ? textLine.getAtomBounds(lastAtom) : new Rectangle(0,0,0,0);
            if(!isTTB)
            {
               if(localX < 0)
               {
                  localX = 0;
               }
               else if(localX > lastAtomRect.x + lastAtomRect.width)
               {
                  if(startOnNextLineIfNecessary)
                  {
                     return textFlowLine.absoluteStart + textFlowLine.textLength - 1;
                  }
                  if(lastAtomRect.x + lastAtomRect.width > 0)
                  {
                     localX = lastAtomRect.x + lastAtomRect.width;
                  }
               }
            }
            else if(localY < 0)
            {
               localY = 0;
            }
            else if(localY > lastAtomRect.y + lastAtomRect.height)
            {
               if(startOnNextLineIfNecessary)
               {
                  return textFlowLine.absoluteStart + textFlowLine.textLength - 1;
               }
               if(lastAtomRect.y + lastAtomRect.height > 0)
               {
                  localY = lastAtomRect.y + lastAtomRect.height;
               }
            }
            result = computeSelectionIndexInLine(textFlow,textLine,localX,localY);
         }
         return result != -1 ? int(result) : int(firstCharVisible + length);
      }
      
      private static function locateNearestColumn(container:ContainerController, localX:Number, localY:Number, wm:String, direction:String) : int
      {
         var curCol:Rectangle = null;
         var nextCol:Rectangle = null;
         var colIdx:int = 0;
         var columnState:ColumnState = container.columnState;
         while(colIdx < columnState.columnCount - 1)
         {
            curCol = columnState.getColumnAt(colIdx);
            nextCol = columnState.getColumnAt(colIdx + 1);
            if(curCol.contains(localX,localY))
            {
               break;
            }
            if(nextCol.contains(localX,localY))
            {
               colIdx++;
               break;
            }
            if(wm == BlockProgression.RL)
            {
               if(localY < curCol.top || localY < nextCol.top && Math.abs(curCol.bottom - localY) <= Math.abs(nextCol.top - localY))
               {
                  break;
               }
               if(localY > nextCol.top)
               {
                  colIdx++;
                  break;
               }
            }
            else if(direction == Direction.LTR)
            {
               if(localX < curCol.left || localX < nextCol.left && Math.abs(curCol.right - localX) <= Math.abs(nextCol.left - localX))
               {
                  break;
               }
               if(localX < nextCol.left)
               {
                  colIdx++;
                  break;
               }
            }
            else
            {
               if(localX > curCol.right || localX > nextCol.right && Math.abs(curCol.left - localX) <= Math.abs(nextCol.right - localX))
               {
                  break;
               }
               if(localX > nextCol.right)
               {
                  colIdx++;
                  break;
               }
            }
            colIdx++;
         }
         return colIdx;
      }
      
      private static function computeSelectionIndexInLine(textFlow:TextFlow, textLine:TextLine, localX:Number, localY:Number) : int
      {
         var paraSelectionIdx:int = 0;
         if(!(textLine.userData is TextFlowLine))
         {
            return -1;
         }
         var rtline:TextFlowLine = TextFlowLine(textLine.userData);
         if(rtline.validity == TextLineValidity.INVALID)
         {
            return -1;
         }
         textLine = rtline.getTextLine(true);
         var isTTB:* = textFlow.computedFormat.blockProgression == BlockProgression.RL;
         var perpCoor:Number = !!isTTB ? Number(localX) : Number(localY);
         var pt:Point = new Point();
         pt.x = localX;
         pt.y = localY;
         pt = textLine.localToGlobal(pt);
         var elemIdx:int = textLine.getAtomIndexAtPoint(pt.x,pt.y);
         if(elemIdx == -1)
         {
            pt.x = localX;
            pt.y = localY;
            if(pt.x < 0 || isTTB && perpCoor > textLine.ascent)
            {
               pt.x = 0;
            }
            if(pt.y < 0 || !isTTB && perpCoor > textLine.descent)
            {
               pt.y = 0;
            }
            pt = textLine.localToGlobal(pt);
            elemIdx = textLine.getAtomIndexAtPoint(pt.x,pt.y);
         }
         if(elemIdx == -1)
         {
            pt.x = localX;
            pt.y = localY;
            pt = textLine.localToGlobal(pt);
            if(textLine.parent)
            {
               pt = textLine.parent.globalToLocal(pt);
            }
            if(!isTTB)
            {
               return pt.x <= textLine.x ? int(rtline.absoluteStart) : int(rtline.absoluteStart + rtline.textLength - 1);
            }
            return pt.y <= textLine.y ? int(rtline.absoluteStart) : int(rtline.absoluteStart + rtline.textLength - 1);
         }
         var glyphRect:Rectangle = textLine.getAtomBounds(elemIdx);
         var leanRight:* = false;
         if(glyphRect)
         {
            if(isTTB && textLine.getAtomTextRotation(elemIdx) != TextRotation.ROTATE_0)
            {
               leanRight = localY > glyphRect.y + glyphRect.height / 2;
            }
            else
            {
               leanRight = localX > glyphRect.x + glyphRect.width / 2;
            }
         }
         if(textLine.getAtomBidiLevel(elemIdx) % 2 != 0)
         {
            paraSelectionIdx = !!leanRight ? int(textLine.getAtomTextBlockBeginIndex(elemIdx)) : int(textLine.getAtomTextBlockEndIndex(elemIdx));
         }
         else
         {
            paraSelectionIdx = !!leanRight ? int(textLine.getAtomTextBlockEndIndex(elemIdx)) : int(textLine.getAtomTextBlockBeginIndex(elemIdx));
         }
         return rtline.paragraph.getTextBlockAbsoluteStart(textLine.textBlock) + paraSelectionIdx;
      }
      
      private static function checkForDisplayed(container:DisplayObject) : Boolean
      {
         try
         {
            while(container)
            {
               if(!container.visible)
               {
                  return false;
               }
               var container:DisplayObject = container.parent;
               if(container is Stage)
               {
                  return true;
               }
            }
         }
         catch(e:Error)
         {
            return true;
         }
         return false;
      }
      
      private static function findController(textFlow:TextFlow, target:Object, currentTarget:Object, localPoint:Point) : ContainerController
      {
         var controller:ContainerController = null;
         var containerPoint:Point = null;
         var candidateLocalX:Number = NaN;
         var candidateLocalY:Number = NaN;
         var testController:ContainerController = null;
         var curContainerController:ContainerController = null;
         var bounds:Rectangle = null;
         var containerWidth:Number = NaN;
         var containerHeight:Number = NaN;
         var adjustX:Number = NaN;
         var adjustY:Number = NaN;
         var relDistanceX:Number = NaN;
         var relDistanceY:Number = NaN;
         var tempDist:Number = NaN;
         var localX:Number = localPoint.x;
         var localY:Number = localPoint.y;
         var globalPoint:Point = DisplayObject(target).localToGlobal(new Point(localX,localY));
         for(var idx:int = 0; idx < textFlow.flowComposer.numControllers; idx++)
         {
            testController = textFlow.flowComposer.getControllerAt(idx);
            if(testController.container == target || testController.container == currentTarget)
            {
               controller = testController;
               break;
            }
         }
         if(controller)
         {
            if(target != controller.container)
            {
               containerPoint = DisplayObject(controller.container).globalToLocal(globalPoint);
               localPoint.x = containerPoint.x;
               localPoint.y = containerPoint.y;
            }
            return controller;
         }
         var controllerCandidate:ContainerController = null;
         var relDistance:Number = Number.MAX_VALUE;
         for(var containerIndex:int = 0; containerIndex < textFlow.flowComposer.numControllers; containerIndex++)
         {
            curContainerController = textFlow.flowComposer.getControllerAt(containerIndex);
            if(checkForDisplayed(curContainerController.container as DisplayObject))
            {
               bounds = curContainerController.getContentBounds();
               containerWidth = !!isNaN(curContainerController.compositionWidth) ? Number(curContainerController.getTotalPaddingLeft() + bounds.width) : Number(curContainerController.compositionWidth);
               containerHeight = !!isNaN(curContainerController.compositionHeight) ? Number(curContainerController.getTotalPaddingTop() + bounds.height) : Number(curContainerController.compositionHeight);
               containerPoint = DisplayObject(curContainerController.container).globalToLocal(globalPoint);
               adjustX = 0;
               adjustY = 0;
               if(curContainerController.hasScrollRect)
               {
                  containerPoint.x -= adjustX = curContainerController.container.scrollRect.x;
                  containerPoint.y -= adjustY = curContainerController.container.scrollRect.y;
               }
               if(containerPoint.x >= 0 && containerPoint.x <= containerWidth && containerPoint.y >= 0 && containerPoint.y <= containerHeight)
               {
                  controllerCandidate = curContainerController;
                  candidateLocalX = containerPoint.x + adjustX;
                  candidateLocalY = containerPoint.y + adjustY;
                  break;
               }
               relDistanceX = 0;
               relDistanceY = 0;
               if(containerPoint.x < 0)
               {
                  relDistanceX = containerPoint.x;
                  if(containerPoint.y < 0)
                  {
                     relDistanceY = containerPoint.y;
                  }
                  else if(containerPoint.y > containerHeight)
                  {
                     relDistanceY = containerPoint.y - containerHeight;
                  }
               }
               else if(containerPoint.x > containerWidth)
               {
                  relDistanceX = containerPoint.x - containerWidth;
                  if(containerPoint.y < 0)
                  {
                     relDistanceY = containerPoint.y;
                  }
                  else if(containerPoint.y > containerHeight)
                  {
                     relDistanceY = containerPoint.y - containerHeight;
                  }
               }
               else if(containerPoint.y < 0)
               {
                  relDistanceY = -containerPoint.y;
               }
               else
               {
                  relDistanceY = containerPoint.y - containerHeight;
               }
               tempDist = relDistanceX * relDistanceX + relDistanceY * relDistanceY;
               if(tempDist <= relDistance)
               {
                  relDistance = tempDist;
                  controllerCandidate = curContainerController;
                  candidateLocalX = containerPoint.x + adjustX;
                  candidateLocalY = containerPoint.y + adjustY;
               }
            }
         }
         localPoint.x = candidateLocalX;
         localPoint.y = candidateLocalY;
         return controllerCandidate;
      }
      
      tlf_internal static function computeCellCoordinates(textFlow:TextFlow, target:Object, currentTarget:Object, localX:Number, localY:Number) : CellCoordinates
      {
         var rslt:CellCoordinates = null;
         var containerPoint:Point = null;
         var cell:TableCellElement = null;
         if(target is TextLine)
         {
            return null;
         }
         if(target is CellContainer)
         {
            cell = (target as CellContainer).element;
            return new CellCoordinates(cell.rowIndex,cell.colIndex,cell.getTable());
         }
         var localPoint:Point = new Point(localX,localY);
         var controller:ContainerController = findController(textFlow,target,currentTarget,localPoint);
         if(!controller)
         {
            return null;
         }
         return controller.findCellAtPosition(localPoint);
      }
      
      tlf_internal static function computeSelectionIndex(textFlow:TextFlow, target:Object, currentTarget:Object, localX:Number, localY:Number) : int
      {
         var containerPoint:Point = null;
         var tfl:TextFlowLine = null;
         var para:ParagraphElement = null;
         var localPoint:Point = null;
         var controller:ContainerController = null;
         var rslt:int = 0;
         var useTargetedTextLine:Boolean = false;
         if(target is TextLine)
         {
            tfl = TextLine(target).userData as TextFlowLine;
            if(tfl)
            {
               para = tfl.paragraph;
               if(para.getTextFlow() == textFlow)
               {
                  useTargetedTextLine = true;
               }
            }
         }
         if(useTargetedTextLine)
         {
            rslt = computeSelectionIndexInLine(textFlow,TextLine(target),localX,localY);
         }
         else
         {
            localPoint = new Point(localX,localY);
            controller = findController(textFlow,target,currentTarget,localPoint);
            rslt = !!controller ? int(computeSelectionIndexInContainer(textFlow,controller,localPoint.x,localPoint.y)) : -1;
         }
         if(rslt >= textFlow.textLength)
         {
            rslt = textFlow.textLength - 1;
         }
         return rslt;
      }
      
      public function get currentTable() : TableElement
      {
         return this._currentTable;
      }
      
      public function set currentTable(table:TableElement) : void
      {
         this._currentTable = table;
      }
      
      public function hasCellRangeSelection() : Boolean
      {
         if(!this._currentTable)
         {
            return false;
         }
         if(!this._cellRange)
         {
            return false;
         }
         return true;
      }
      
      public function selectCellTextFlow(cell:TableCellElement) : void
      {
         var selectionManager:SelectionManager = null;
         if(cell && cell.table)
         {
            selectionManager = cell.textFlow.interactionManager as SelectionManager;
            this.clear();
            if(selectionManager)
            {
               selectionManager.currentTable = cell.table;
               selectionManager.selectAll();
               selectionManager.setFocus();
            }
         }
      }
      
      public function selectCell(cell:TableCellElement) : void
      {
         var beginCoordinates:CellCoordinates = null;
         var endCoordinates:CellCoordinates = null;
         if(cell)
         {
            beginCoordinates = new CellCoordinates(cell.rowIndex,cell.colIndex);
            endCoordinates = new CellCoordinates(cell.rowIndex,cell.colIndex);
            if(beginCoordinates.isValid())
            {
               this.selectCellRange(beginCoordinates,endCoordinates);
            }
         }
      }
      
      public function selectCellAt(table:TableElement, rowIndex:int, colIndex:int) : void
      {
         var cell:TableCellElement = table.getCellAt(rowIndex,colIndex);
         if(cell)
         {
            this.selectCell(cell);
         }
      }
      
      public function selectCells(cells:Vector.<TableCellElement>) : void
      {
         var cell:TableCellElement = null;
         var table:TableElement = null;
         var col:int = 0;
         var row:int = 0;
         var startX:int = int.MAX_VALUE;
         var startY:int = int.MAX_VALUE;
         var endX:int = int.MIN_VALUE;
         var endY:int = int.MIN_VALUE;
         for each(cell in cells)
         {
            if(cell)
            {
               if(table == null)
               {
                  table = cell.getTable();
               }
               col = cell.colIndex;
               row = cell.rowIndex;
               if(col < startX)
               {
                  startX = col;
               }
               if(col > endX)
               {
                  endX = col;
               }
               if(row < startY)
               {
                  startY = row;
               }
               if(row > endY)
               {
                  endY = row;
               }
            }
         }
         if(startX <= endX && startY <= endY)
         {
            this.selectCellRange(new CellCoordinates(startY,startX,table),new CellCoordinates(endY,endX,table));
         }
      }
      
      public function selectRow(row:TableRowElement) : void
      {
         var beginCoordinates:CellCoordinates = null;
         var endCoordinates:CellCoordinates = null;
         if(row)
         {
            beginCoordinates = new CellCoordinates(row.rowIndex,0);
            endCoordinates = new CellCoordinates(row.rowIndex,row.numCells);
            if(beginCoordinates.isValid() && endCoordinates.isValid())
            {
               this.selectCellRange(beginCoordinates,endCoordinates);
            }
         }
      }
      
      public function selectRowAt(table:TableElement, index:int) : void
      {
         var row:TableRowElement = !!table ? table.getRowAt(index) : null;
         if(row)
         {
            this.selectRow(row);
         }
      }
      
      public function selectRows(rows:Array) : void
      {
         var table:TableElement = null;
         var cell:TableCellElement = null;
         var i:int = 0;
         var row:TableRowElement = null;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         if(rows && rows.length)
         {
            while(i < rows.length)
            {
               row = rows[i] as TableRowElement;
               if(row)
               {
                  for each(cell in row.cells)
                  {
                     cells.push(cell);
                  }
               }
               i++;
            }
            this.selectCells(cells);
         }
      }
      
      public function selectColumn(column:TableColElement) : void
      {
         var table:TableElement = column.table;
         if(column && table)
         {
            this.selectCells(table.getCellsForColumn(column));
         }
      }
      
      public function selectColumnAt(table:TableElement, index:int) : void
      {
         var column:TableColElement = table.getColumnAt(index);
         if(column && table)
         {
            return this.selectColumn(column);
         }
      }
      
      public function selectColumns(columns:Array) : void
      {
         var cell:TableCellElement = null;
         var i:int = 0;
         var column:TableColElement = null;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         if(columns && columns.length)
         {
            while(i < columns.length)
            {
               column = columns[i] as TableColElement;
               if(column)
               {
                  for each(cell in column.cells)
                  {
                     cells.push(cell);
                  }
               }
               i++;
            }
            this.selectCells(cells);
         }
      }
      
      public function selectTable(table:TableElement) : void
      {
         var startCoords:CellCoordinates = null;
         var endCoords:CellCoordinates = null;
         if(table)
         {
            startCoords = new CellCoordinates(0,0,table);
            endCoords = new CellCoordinates(table.numRows - 1,table.numColumns - 1,table);
            this.selectCellRange(startCoords,endCoords);
         }
      }
      
      public function selectCellRange(anchorCoords:CellCoordinates, activeCoords:CellCoordinates) : void
      {
         var blocks:Vector.<TextFlowTableBlock> = null;
         var block:TextFlowTableBlock = null;
         var controller:ContainerController = null;
         if(this.selectionType == SelectionType.TEXT)
         {
            this.clear();
         }
         this.clearCellSelections();
         if(anchorCoords && activeCoords)
         {
            this._cellRange = new CellRange(this._currentTable,anchorCoords,activeCoords);
            this.activeCellPosition = activeCoords;
            blocks = this._currentTable.getTableBlocksInRange(anchorCoords,activeCoords);
            for each(block in blocks)
            {
               block.controller.clearSelectionShapes();
               block.controller.addCellSelectionShapes(this.currentCellSelectionFormat.rangeColor,block,anchorCoords,activeCoords);
            }
            if(this.subManager)
            {
               this.subManager.selectRange(-1,-1);
               this.subManager = null;
            }
         }
         else
         {
            this._cellRange = null;
            this.activeCellPosition.column = -1;
            this.activeCellPosition.row = -1;
         }
         this.selectionChanged();
      }
      
      public function getCellRange() : CellRange
      {
         return this._cellRange;
      }
      
      public function setCellRange(range:CellRange) : void
      {
         this.selectCellRange(range.anchorCoordinates,range.activeCoordinates);
      }
      
      protected function get pointFormat() : ITextLayoutFormat
      {
         return this._pointFormat;
      }
      
      public function getSelectionState() : SelectionState
      {
         if(this.subManager)
         {
            return this.subManager.getSelectionState();
         }
         return new SelectionState(this._textFlow,this.anchorMark.position,this.activeMark.position,this.pointFormat,this._cellRange);
      }
      
      public function setSelectionState(sel:SelectionState) : void
      {
         this.internalSetSelection(sel.textFlow,sel.anchorPosition,sel.activePosition,sel.pointFormat);
      }
      
      public function hasSelection() : Boolean
      {
         return this.selectionType == SelectionType.TEXT;
      }
      
      public function hasAnySelection() : Boolean
      {
         return this.selectionType != SelectionType.NONE;
      }
      
      public function get selectionType() : String
      {
         if(this.anchorMark.position != -1)
         {
            return SelectionType.TEXT;
         }
         if(this.anchorCellPosition.isValid())
         {
            return SelectionType.CELLS;
         }
         return SelectionType.NONE;
      }
      
      public function isRangeSelection() : Boolean
      {
         return this.anchorMark.position != -1 && this.anchorMark.position != this.activeMark.position;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         if(this._textFlow != value)
         {
            if(this._textFlow)
            {
               this.flushPendingOperations();
            }
            this.clear();
            this.clearCellSelections();
            this._cellRange = null;
            if(!value)
            {
               this.setMouseCursor(MouseCursor.AUTO);
            }
            this._textFlow = value;
            if(this._textFlow && this._textFlow.interactionManager != this)
            {
               this._textFlow.interactionManager = this;
            }
         }
      }
      
      public function get editingMode() : String
      {
         return EditingMode.READ_SELECT;
      }
      
      public function get windowActive() : Boolean
      {
         return this._selFormatState != SelectionFormatState.INACTIVE;
      }
      
      public function get focused() : Boolean
      {
         return this._selFormatState == SelectionFormatState.FOCUSED;
      }
      
      public function get currentSelectionFormat() : SelectionFormat
      {
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            return this.unfocusedSelectionFormat;
         }
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            return this.inactiveSelectionFormat;
         }
         return this.focusedSelectionFormat;
      }
      
      public function get currentCellSelectionFormat() : SelectionFormat
      {
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            return this.unfocusedCellSelectionFormat;
         }
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            return this.inactiveCellSelectionFormat;
         }
         return this.focusedCellSelectionFormat;
      }
      
      public function set focusedSelectionFormat(val:SelectionFormat) : void
      {
         this._focusedSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.FOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get focusedSelectionFormat() : SelectionFormat
      {
         return !!this._focusedSelectionFormat ? this._focusedSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.focusedSelectionFormat : null);
      }
      
      public function set unfocusedSelectionFormat(val:SelectionFormat) : void
      {
         this._unfocusedSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get unfocusedSelectionFormat() : SelectionFormat
      {
         return !!this._unfocusedSelectionFormat ? this._unfocusedSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.unfocusedSelectionFormat : null);
      }
      
      public function set inactiveSelectionFormat(val:SelectionFormat) : void
      {
         this._inactiveSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            this.refreshSelection();
         }
      }
      
      public function get inactiveSelectionFormat() : SelectionFormat
      {
         return !!this._inactiveSelectionFormat ? this._inactiveSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.inactiveSelectionFormat : null);
      }
      
      public function set focusedCellSelectionFormat(val:SelectionFormat) : void
      {
         this._focusedCellSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.FOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get focusedCellSelectionFormat() : SelectionFormat
      {
         return !!this._focusedCellSelectionFormat ? this._focusedCellSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.focusedSelectionFormat : null);
      }
      
      public function set unfocusedCellSelectionFormat(val:SelectionFormat) : void
      {
         this._unfocusedCellSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get unfocusedCellSelectionFormat() : SelectionFormat
      {
         return !!this._unfocusedCellSelectionFormat ? this._unfocusedCellSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.unfocusedSelectionFormat : null);
      }
      
      public function set inactiveCellSelectionFormat(val:SelectionFormat) : void
      {
         this._inactiveCellSelectionFormat = val;
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            this.refreshSelection();
         }
      }
      
      public function get inactiveCellSelectionFormat() : SelectionFormat
      {
         return !!this._inactiveCellSelectionFormat ? this._inactiveCellSelectionFormat : (!!this._textFlow ? this._textFlow.configuration.inactiveSelectionFormat : null);
      }
      
      tlf_internal function get selectionFormatState() : String
      {
         return this._selFormatState;
      }
      
      tlf_internal function setSelectionFormatState(selFormatState:String) : void
      {
         var oldSelectionFormat:SelectionFormat = null;
         var newSelectionFormat:SelectionFormat = null;
         if(selFormatState != this._selFormatState)
         {
            oldSelectionFormat = this.currentSelectionFormat;
            this._selFormatState = selFormatState;
            newSelectionFormat = this.currentSelectionFormat;
            if(!newSelectionFormat.equals(oldSelectionFormat))
            {
               this.refreshSelection();
            }
         }
      }
      
      tlf_internal function cloneSelectionFormatState(oldISelectionManager:ISelectionManager) : void
      {
         var oldSelectionManager:SelectionManager = oldISelectionManager as SelectionManager;
         if(oldSelectionManager)
         {
            this._isActive = oldSelectionManager._isActive;
            this._mouseOverSelectionArea = oldSelectionManager._mouseOverSelectionArea;
            this.setSelectionFormatState(oldSelectionManager.selectionFormatState);
         }
      }
      
      private function selectionPoint(currentTarget:Object, target:InteractiveObject, localX:Number, localY:Number, extendSelection:Boolean = false) : SelectionState
      {
         if(!this._textFlow)
         {
            return null;
         }
         if(!this.hasSelection())
         {
            extendSelection = false;
         }
         var begIdx:int = this.anchorMark.position;
         var endIdx:int = this.activeMark.position;
         endIdx = computeSelectionIndex(this._textFlow,target,currentTarget,localX,localY);
         if(endIdx == -1)
         {
            return null;
         }
         endIdx = Math.min(endIdx,this._textFlow.textLength - 1);
         if(!extendSelection)
         {
            begIdx = endIdx;
         }
         if(begIdx == endIdx)
         {
            begIdx = NavigationUtil.updateStartIfInReadOnlyElement(this._textFlow,begIdx);
            endIdx = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow,endIdx);
         }
         else
         {
            endIdx = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow,endIdx);
         }
         return new SelectionState(this.textFlow,begIdx,endIdx);
      }
      
      public function setFocus() : void
      {
         if(!this._textFlow)
         {
            return;
         }
         if(this._textFlow.flowComposer)
         {
            this._textFlow.flowComposer.setFocus(this.activePosition,false);
         }
         this.setSelectionFormatState(SelectionFormatState.FOCUSED);
      }
      
      protected function setMouseCursor(cursor:String) : void
      {
         Mouse.cursor = Configuration.getCursorString(this.textFlow.configuration,cursor);
      }
      
      public function get anchorPosition() : int
      {
         return this.anchorMark.position;
      }
      
      public function get activePosition() : int
      {
         return this.activeMark.position;
      }
      
      public function get absoluteStart() : int
      {
         return this.anchorMark.position < this.activeMark.position ? int(this.anchorMark.position) : int(this.activeMark.position);
      }
      
      public function get absoluteEnd() : int
      {
         return this.anchorMark.position > this.activeMark.position ? int(this.anchorMark.position) : int(this.activeMark.position);
      }
      
      public function selectAll() : void
      {
         var lastSelectablePos:int = 0;
         if(this.subManager)
         {
            this.subManager.selectAll();
         }
         else
         {
            lastSelectablePos = this._textFlow.textLength > 0 ? int(this._textFlow.textLength - 1) : 0;
            this.selectRange(0,lastSelectablePos);
         }
      }
      
      public function selectRange(anchorPosition:int, activePosition:int) : void
      {
         var cell:TableCellElement = null;
         this.flushPendingOperations();
         if(this.subManager && (anchorPosition != -1 || activePosition != -1))
         {
            this.subManager.selectRange(-1,-1);
            this.subManager = null;
         }
         if(this.textFlow.nestedInTable())
         {
            cell = this.textFlow.parentElement as TableCellElement;
            this.superManager = cell.getTextFlow().interactionManager;
            this.superManager.currentTable = cell.getTable();
            this.superManager.deselect();
            this.superManager.anchorCellPosition.column = cell.colIndex;
            this.superManager.anchorCellPosition.row = cell.rowIndex;
            this.superManager.subManager = this;
         }
         if(anchorPosition != this.anchorMark.position || activePosition != this.activeMark.position)
         {
            this.clearSelectionShapes();
            this.clearCellSelections();
            this._cellRange = null;
            this.internalSetSelection(this._textFlow,anchorPosition,activePosition,this._pointFormat);
            this.selectionChanged();
            this.allowOperationMerge = false;
         }
      }
      
      public function selectFirstPosition() : void
      {
         this.selectRange(0,0);
      }
      
      public function selectLastPosition() : void
      {
         this.selectRange(int.MAX_VALUE,int.MAX_VALUE);
      }
      
      public function deselect() : void
      {
         if(this.hasAnySelection())
         {
            this.clearSelectionShapes();
            this.clearCellSelections();
            this.addSelectionShapes();
         }
         this.selectRange(-1,-1);
         this._cellRange = null;
      }
      
      private function internalSetSelection(root:TextFlow, anchorPosition:int, activePosition:int, format:ITextLayoutFormat = null) : void
      {
         this._textFlow = root;
         if(anchorPosition < 0 || activePosition < 0)
         {
            anchorPosition = -1;
            activePosition = -1;
         }
         else if(this.subManager)
         {
            this.subManager.flushPendingOperations();
            this.subManager = null;
         }
         var lastSelectablePos:int = this._textFlow.textLength > 0 ? int(this._textFlow.textLength - 1) : 0;
         if(anchorPosition != -1 && activePosition != -1)
         {
            if(anchorPosition > lastSelectablePos)
            {
               anchorPosition = lastSelectablePos;
            }
            if(activePosition > lastSelectablePos)
            {
               activePosition = lastSelectablePos;
            }
         }
         this._pointFormat = format;
         this.anchorMark.position = anchorPosition;
         this.activeMark.position = activePosition;
      }
      
      private function clear() : void
      {
         if(this.hasSelection())
         {
            this.flushPendingOperations();
            this.clearSelectionShapes();
            this.internalSetSelection(this._textFlow,-1,-1);
            this.selectionChanged();
            this.allowOperationMerge = false;
         }
      }
      
      private function clearCellSelections() : void
      {
         var blocks:Vector.<TextFlowTableBlock> = null;
         var block:TextFlowTableBlock = null;
         var controller:ContainerController = null;
         if(this._cellRange)
         {
            blocks = this._cellRange.table.getTableBlocksInRange(this._cellRange.anchorCoordinates,this._cellRange.activeCoordinates);
            for each(block in blocks)
            {
               if(controller != block.controller)
               {
                  block.controller.clearSelectionShapes();
               }
               controller = block.controller;
            }
         }
         if(block)
         {
            block.controller.clearSelectionShapes();
         }
      }
      
      private function addSelectionShapes() : void
      {
         var containerIter:int = 0;
         if(this._textFlow.flowComposer)
         {
            this.internalSetSelection(this._textFlow,this.anchorMark.position,this.activeMark.position,this._pointFormat);
            if(this.currentSelectionFormat && (this.absoluteStart == this.absoluteEnd && this.currentSelectionFormat.pointAlpha != 0 || this.absoluteStart != this.absoluteEnd && this.currentSelectionFormat.rangeAlpha != 0))
            {
               containerIter = 0;
               while(containerIter < this._textFlow.flowComposer.numControllers)
               {
                  this._textFlow.flowComposer.getControllerAt(containerIter++).addSelectionShapes(this.currentSelectionFormat,this.absoluteStart,this.absoluteEnd);
               }
            }
         }
      }
      
      private function clearSelectionShapes() : void
      {
         var containerIter:int = 0;
         var flowComposer:IFlowComposer = !!this._textFlow ? this._textFlow.flowComposer : null;
         if(flowComposer)
         {
            containerIter = 0;
            while(containerIter < flowComposer.numControllers)
            {
               flowComposer.getControllerAt(containerIter++).clearSelectionShapes();
            }
         }
      }
      
      public function refreshSelection() : void
      {
         if(this.hasAnySelection())
         {
            this.clearSelectionShapes();
            this.clearCellSelections();
            this.addSelectionShapes();
         }
      }
      
      public function clearSelection() : void
      {
         if(this.hasAnySelection())
         {
            this.clearSelectionShapes();
            this.clearCellSelections();
         }
      }
      
      tlf_internal function selectionChanged(doDispatchEvent:Boolean = true, resetPointFormat:Boolean = true) : void
      {
         if(resetPointFormat)
         {
            this._pointFormat = null;
         }
         if(doDispatchEvent && this._textFlow)
         {
            if(this.textFlow.parentElement && this.textFlow.parentElement.getTextFlow())
            {
               this.textFlow.parentElement.getTextFlow().dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE,false,false,!!this.hasSelection() ? this.getSelectionState() : null));
            }
            else
            {
               this.textFlow.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE,false,false,!!this.hasSelection() ? this.getSelectionState() : null));
            }
         }
      }
      
      tlf_internal function setNewSelectionPoint(currentTarget:Object, target:InteractiveObject, localX:Number, localY:Number, extendSelection:Boolean = false) : Boolean
      {
         var selState:SelectionState = this.selectionPoint(currentTarget,target,localX,localY,extendSelection);
         if(selState == null)
         {
            return false;
         }
         if(selState.anchorPosition != this.anchorMark.position || selState.activePosition != this.activeMark.position)
         {
            this.selectRange(selState.anchorPosition,selState.activePosition);
            return true;
         }
         return false;
      }
      
      public function mouseDownHandler(event:MouseEvent) : void
      {
         var coords:CellCoordinates = null;
         if(this.subManager)
         {
            this.subManager.selectRange(-1,-1);
         }
         var cell:TableCellElement = this._textFlow.parentElement as TableCellElement;
         if(!cell)
         {
            coords = computeCellCoordinates(this.textFlow,event.target,event.currentTarget,event.localX,event.localY);
         }
         if(cell || coords)
         {
            if(coords)
            {
               cell = coords.table.findCell(coords);
            }
            this.superManager = cell.getTextFlow().interactionManager;
            if(event.shiftKey && cell.getTable() == this.superManager.currentTable)
            {
               this.flushPendingOperations();
               coords = new CellCoordinates(cell.rowIndex,cell.colIndex);
               if(!CellCoordinates.areEqual(coords,this.superManager.anchorCellPosition) || this.superManager.activeCellPosition.isValid())
               {
                  this.superManager.selectCellRange(this.superManager.anchorCellPosition,coords);
                  this.superManager.subManager = null;
                  this.allowOperationMerge = false;
                  event.stopPropagation();
                  return;
               }
            }
            if(this.superManager == this)
            {
               if(cell.textFlow.interactionManager)
               {
                  cell.textFlow.interactionManager.mouseDownHandler(event);
               }
               return;
            }
            this.superManager.currentTable = cell.getTable();
            this.superManager.deselect();
            this.superManager.anchorCellPosition.column = cell.colIndex;
            this.superManager.anchorCellPosition.row = cell.rowIndex;
            this.superManager.subManager = this;
         }
         this.handleMouseEventForSelection(event,event.shiftKey,cell != null);
      }
      
      public function mouseMoveHandler(event:MouseEvent) : void
      {
         var cell:TableCellElement = null;
         var cellCoords:CellCoordinates = null;
         var coords:CellCoordinates = null;
         var wmode:String = this.textFlow.computedFormat.blockProgression;
         if(wmode != BlockProgression.RL)
         {
            this.setMouseCursor(MouseCursor.IBEAM);
         }
         if(event.buttonDown)
         {
            cell = this._textFlow.parentElement as TableCellElement;
            if(cell)
            {
               do
               {
                  cellCoords = new CellCoordinates(cell.rowIndex,cell.colIndex,cell.getTable());
                  coords = computeCellCoordinates(cell.getTextFlow(),event.target,event.currentTarget,event.localX,event.localY);
                  if(!coords)
                  {
                     break;
                  }
                  if(CellCoordinates.areEqual(cellCoords,coords) && (!this.superManager.activeCellPosition.isValid() || CellCoordinates.areEqual(coords,this.superManager.activeCellPosition)))
                  {
                     break;
                  }
                  if(coords.table != cellCoords.table)
                  {
                     break;
                  }
                  this.superManager = cell.getTextFlow().interactionManager;
                  if(!CellCoordinates.areEqual(coords,this.superManager.activeCellPosition))
                  {
                     this.allowOperationMerge = false;
                     this.superManager.selectCellRange(this.superManager.anchorCellPosition,coords);
                     event.stopPropagation();
                     return;
                  }
               }
               while(0);
               
            }
            if(this.superManager && this.superManager.getCellRange())
            {
               return;
            }
            this.handleMouseEventForSelection(event,true,this._textFlow.parentElement != null);
         }
      }
      
      tlf_internal function handleMouseEventForSelection(event:MouseEvent, allowExtend:Boolean, stopPropogate:Boolean = false) : void
      {
         var startSelectionActive:Boolean = this.hasSelection();
         if(this.setNewSelectionPoint(event.currentTarget,event.target as InteractiveObject,event.localX,event.localY,startSelectionActive && allowExtend))
         {
            if(startSelectionActive)
            {
               this.clearSelectionShapes();
            }
            if(this.hasSelection())
            {
               this.addSelectionShapes();
            }
         }
         this.allowOperationMerge = false;
         if(stopPropogate)
         {
            event.stopPropagation();
         }
      }
      
      public function mouseUpHandler(event:MouseEvent) : void
      {
         if(!this._mouseOverSelectionArea)
         {
            this.setMouseCursor(MouseCursor.AUTO);
         }
      }
      
      private function atBeginningWordPos(activePara:ParagraphElement, pos:int) : Boolean
      {
         if(pos == 0)
         {
            return true;
         }
         var paraEnd:Number = activePara.getAbsoluteStart() + activePara.textLength;
         activePara.getTextFlow().flowComposer.composeToPosition(paraEnd);
         var nextPos:int = activePara.findNextWordBoundary(pos);
         nextPos = activePara.findPreviousWordBoundary(nextPos);
         return pos == nextPos;
      }
      
      public function mouseDoubleClickHandler(event:MouseEvent) : void
      {
         var newActiveIndex:int = 0;
         var newAnchorIndex:int = 0;
         var anchorPara:ParagraphElement = null;
         var anchorParaStart:int = 0;
         if(!this.hasSelection())
         {
            return;
         }
         var activePara:ParagraphElement = this._textFlow.findAbsoluteParagraph(this.activeMark.position);
         var activeParaStart:int = activePara.getAbsoluteStart();
         if(this.anchorMark.position <= this.activeMark.position)
         {
            newActiveIndex = activePara.findNextWordBoundary(this.activeMark.position - activeParaStart) + activeParaStart;
         }
         else
         {
            newActiveIndex = activePara.findPreviousWordBoundary(this.activeMark.position - activeParaStart) + activeParaStart;
         }
         if(newActiveIndex == activeParaStart + activePara.textLength)
         {
            newActiveIndex--;
         }
         if(event.shiftKey)
         {
            newAnchorIndex = this.anchorMark.position;
         }
         else
         {
            anchorPara = this._textFlow.findAbsoluteParagraph(this.anchorMark.position);
            anchorParaStart = anchorPara.getAbsoluteStart();
            if(this.atBeginningWordPos(anchorPara,this.anchorMark.position - anchorParaStart))
            {
               newAnchorIndex = this.anchorMark.position;
            }
            else
            {
               if(this.anchorMark.position <= this.activeMark.position)
               {
                  newAnchorIndex = anchorPara.findPreviousWordBoundary(this.anchorMark.position - anchorParaStart) + anchorParaStart;
               }
               else
               {
                  newAnchorIndex = anchorPara.findNextWordBoundary(this.anchorMark.position - anchorParaStart) + anchorParaStart;
               }
               if(newAnchorIndex == anchorParaStart + anchorPara.textLength)
               {
                  newAnchorIndex--;
               }
            }
         }
         if(newAnchorIndex != this.anchorMark.position || newActiveIndex != this.activeMark.position)
         {
            this.internalSetSelection(this._textFlow,newAnchorIndex,newActiveIndex,null);
            this.selectionChanged();
            this.clearSelectionShapes();
            if(this.hasSelection())
            {
               this.addSelectionShapes();
            }
         }
         this.allowOperationMerge = false;
      }
      
      public function mouseOverHandler(event:MouseEvent) : void
      {
         var cell:TableCellElement = null;
         var leftEdge:int = 0;
         var topEdge:int = 0;
         var globalPoint:Point = null;
         var cellContainer:CellContainer = null;
         var point:Point = null;
         var cellContainerPoint:Point = null;
         this._mouseOverSelectionArea = true;
         var wmode:String = this.textFlow.computedFormat.blockProgression;
         if(wmode != BlockProgression.RL)
         {
            cell = this._textFlow.parentElement as TableCellElement;
            if(cell)
            {
               leftEdge = 5;
               topEdge = 5;
               globalPoint = new Point(event.stageX,event.stageY);
               cellContainer = event.currentTarget as CellContainer;
               if(cellContainer)
               {
                  cellContainerPoint = cellContainer.localToGlobal(new Point());
                  point = globalPoint.subtract(cellContainerPoint);
               }
               if(tlf_internal::useTableSelectionCursors)
               {
                  if(cell.colIndex == 0 && point.x < leftEdge && point.y > topEdge)
                  {
                     event.stopPropagation();
                     event.stopImmediatePropagation();
                     this.setMouseCursor(SelectTableRow);
                  }
                  else if(cell.rowIndex == 0 && cell.colIndex == 0 && point.x < leftEdge && point.y < topEdge)
                  {
                     event.stopPropagation();
                     event.stopImmediatePropagation();
                     this.setMouseCursor(SelectTable);
                  }
                  else if(cell.rowIndex == 0 && point.x > leftEdge && point.y < topEdge)
                  {
                     event.stopPropagation();
                     event.stopImmediatePropagation();
                     this.setMouseCursor(SelectTableColumn);
                  }
                  else
                  {
                     this.setMouseCursor(MouseCursor.IBEAM);
                  }
               }
               else
               {
                  this.setMouseCursor(MouseCursor.IBEAM);
               }
            }
            else
            {
               this.setMouseCursor(MouseCursor.IBEAM);
            }
         }
         else
         {
            this.setMouseCursor(MouseCursor.AUTO);
         }
      }
      
      public function mouseOutHandler(event:MouseEvent) : void
      {
         this._mouseOverSelectionArea = false;
         this.setMouseCursor(MouseCursor.AUTO);
      }
      
      public function focusInHandler(event:FocusEvent) : void
      {
         this._isActive = true;
         this.setSelectionFormatState(SelectionFormatState.FOCUSED);
      }
      
      public function focusOutHandler(event:FocusEvent) : void
      {
         if(this._isActive)
         {
            this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
         }
      }
      
      public function activateHandler(event:Event) : void
      {
         if(!this._isActive)
         {
            this._isActive = true;
            this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
         }
      }
      
      public function deactivateHandler(event:Event) : void
      {
         if(this._isActive)
         {
            this._isActive = false;
            this.setSelectionFormatState(SelectionFormatState.INACTIVE);
         }
      }
      
      public function doOperation(op:FlowOperation) : void
      {
         var opError:Error = null;
         var opEvent:FlowOperationEvent = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_BEGIN,false,true,op,0,null);
         this.textFlow.dispatchEvent(opEvent);
         if(!opEvent.isDefaultPrevented())
         {
            var op:FlowOperation = opEvent.operation;
            if(!(op is CopyOperation))
            {
               throw new IllegalOperationError(GlobalSettings.resourceStringFunction("illegalOperation",[getQualifiedClassName(op)]));
            }
            opError = null;
            try
            {
               op.doOperation();
            }
            catch(e:Error)
            {
               opError = e;
            }
            opEvent = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_END,false,true,op,0,opError);
            this.textFlow.dispatchEvent(opEvent);
            opError = !!opEvent.isDefaultPrevented() ? null : opEvent.error;
            if(opError)
            {
               throw opError;
            }
            this.textFlow.dispatchEvent(new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_COMPLETE,false,false,op,0,null));
         }
      }
      
      public function editHandler(event:Event) : void
      {
         switch(event.type)
         {
            case Event.COPY:
               this.flushPendingOperations();
               this.doOperation(new CopyOperation(this.getSelectionState()));
               break;
            case Event.SELECT_ALL:
               this.flushPendingOperations();
               this.selectAll();
               this.refreshSelection();
         }
      }
      
      private function handleLeftArrow(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if(event.ctrlKey || event.altKey)
               {
                  NavigationUtil.previousWord(selState,event.shiftKey);
               }
               else
               {
                  NavigationUtil.previousCharacter(selState,event.shiftKey);
               }
            }
            else if(event.ctrlKey || event.altKey)
            {
               NavigationUtil.nextWord(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.nextCharacter(selState,event.shiftKey);
            }
         }
         else if(event.altKey)
         {
            NavigationUtil.endOfParagraph(selState,event.shiftKey);
         }
         else if(event.ctrlKey)
         {
            NavigationUtil.endOfDocument(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.nextLine(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handleUpArrow(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(event.altKey)
            {
               NavigationUtil.startOfParagraph(selState,event.shiftKey);
            }
            else if(event.ctrlKey)
            {
               NavigationUtil.startOfDocument(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.previousLine(selState,event.shiftKey);
            }
         }
         else if(this._textFlow.computedFormat.direction == Direction.LTR)
         {
            if(event.ctrlKey || event.altKey)
            {
               NavigationUtil.previousWord(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.previousCharacter(selState,event.shiftKey);
            }
         }
         else if(event.ctrlKey || event.altKey)
         {
            NavigationUtil.nextWord(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.nextCharacter(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handleRightArrow(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if(event.ctrlKey || event.altKey)
               {
                  NavigationUtil.nextWord(selState,event.shiftKey);
               }
               else
               {
                  NavigationUtil.nextCharacter(selState,event.shiftKey);
               }
            }
            else if(event.ctrlKey || event.altKey)
            {
               NavigationUtil.previousWord(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.previousCharacter(selState,event.shiftKey);
            }
         }
         else if(event.altKey)
         {
            NavigationUtil.startOfParagraph(selState,event.shiftKey);
         }
         else if(event.ctrlKey)
         {
            NavigationUtil.startOfDocument(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.previousLine(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handleDownArrow(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(event.altKey)
            {
               NavigationUtil.endOfParagraph(selState,event.shiftKey);
            }
            else if(event.ctrlKey)
            {
               NavigationUtil.endOfDocument(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.nextLine(selState,event.shiftKey);
            }
         }
         else if(this._textFlow.computedFormat.direction == Direction.LTR)
         {
            if(event.ctrlKey || event.altKey)
            {
               NavigationUtil.nextWord(selState,event.shiftKey);
            }
            else
            {
               NavigationUtil.nextCharacter(selState,event.shiftKey);
            }
         }
         else if(event.ctrlKey || event.altKey)
         {
            NavigationUtil.previousWord(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.previousCharacter(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handleHomeKey(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(event.ctrlKey && !event.altKey)
         {
            NavigationUtil.startOfDocument(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.startOfLine(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handleEndKey(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         if(event.ctrlKey && !event.altKey)
         {
            NavigationUtil.endOfDocument(selState,event.shiftKey);
         }
         else
         {
            NavigationUtil.endOfLine(selState,event.shiftKey);
         }
         return selState;
      }
      
      private function handlePageUpKey(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         NavigationUtil.previousPage(selState,event.shiftKey);
         return selState;
      }
      
      private function handlePageDownKey(event:KeyboardEvent) : SelectionState
      {
         var selState:SelectionState = this.getSelectionState();
         NavigationUtil.nextPage(selState,event.shiftKey);
         return selState;
      }
      
      private function handleKeyEvent(event:KeyboardEvent) : void
      {
         var selState:SelectionState = null;
         this.flushPendingOperations();
         switch(event.keyCode)
         {
            case Keyboard.LEFT:
               selState = this.handleLeftArrow(event);
               break;
            case Keyboard.UP:
               selState = this.handleUpArrow(event);
               break;
            case Keyboard.RIGHT:
               selState = this.handleRightArrow(event);
               break;
            case Keyboard.DOWN:
               selState = this.handleDownArrow(event);
               break;
            case Keyboard.HOME:
               selState = this.handleHomeKey(event);
               break;
            case Keyboard.END:
               selState = this.handleEndKey(event);
               break;
            case Keyboard.PAGE_DOWN:
               selState = this.handlePageDownKey(event);
               break;
            case Keyboard.PAGE_UP:
               selState = this.handlePageUpKey(event);
         }
         if(selState != null)
         {
            event.preventDefault();
            this.updateSelectionAndShapes(this._textFlow,selState.anchorPosition,selState.activePosition);
            if(this._textFlow.flowComposer && this._textFlow.flowComposer.numControllers != 0)
            {
               this._textFlow.flowComposer.getControllerAt(this._textFlow.flowComposer.numControllers - 1).scrollToRange(selState.activePosition,selState.activePosition);
            }
         }
         this.allowOperationMerge = false;
      }
      
      public function keyDownHandler(event:KeyboardEvent) : void
      {
         if(!this.hasSelection() || event.isDefaultPrevented())
         {
            return;
         }
         if(event.charCode == 0)
         {
            switch(event.keyCode)
            {
               case Keyboard.LEFT:
               case Keyboard.UP:
               case Keyboard.RIGHT:
               case Keyboard.DOWN:
               case Keyboard.HOME:
               case Keyboard.END:
               case Keyboard.PAGE_DOWN:
               case Keyboard.PAGE_UP:
               case Keyboard.ESCAPE:
                  this.handleKeyEvent(event);
            }
         }
         else if(event.keyCode == Keyboard.ESCAPE)
         {
            this.handleKeyEvent(event);
         }
         if(this._textFlow.parentElement)
         {
            event.stopPropagation();
         }
      }
      
      public function keyUpHandler(event:KeyboardEvent) : void
      {
      }
      
      public function keyFocusChangeHandler(event:FocusEvent) : void
      {
      }
      
      public function textInputHandler(event:TextEvent) : void
      {
         this.ignoreNextTextEvent = false;
      }
      
      public function imeStartCompositionHandler(event:IMEEvent) : void
      {
      }
      
      public function softKeyboardActivatingHandler(event:Event) : void
      {
      }
      
      protected function enterFrameHandler(event:Event) : void
      {
         this.flushPendingOperations();
      }
      
      public function focusChangeHandler(event:FocusEvent) : void
      {
      }
      
      public function menuSelectHandler(event:ContextMenuEvent) : void
      {
         var menu:ContextMenu = event.target as ContextMenu;
         if(this.activePosition != this.anchorPosition)
         {
            menu.clipboardItems.copy = true;
            menu.clipboardItems.cut = this.editingMode == EditingMode.READ_WRITE;
            menu.clipboardItems.clear = this.editingMode == EditingMode.READ_WRITE;
         }
         else
         {
            menu.clipboardItems.copy = false;
            menu.clipboardItems.cut = false;
            menu.clipboardItems.clear = false;
         }
         var systemClipboard:Clipboard = Clipboard.generalClipboard;
         if(this.activePosition != -1 && this.editingMode == EditingMode.READ_WRITE && (systemClipboard.hasFormat(TextClipboard.TEXT_LAYOUT_MARKUP) || systemClipboard.hasFormat(ClipboardFormats.TEXT_FORMAT)))
         {
            menu.clipboardItems.paste = true;
         }
         else
         {
            menu.clipboardItems.paste = false;
         }
         menu.clipboardItems.selectAll = true;
      }
      
      public function mouseWheelHandler(event:MouseEvent) : void
      {
      }
      
      public function flushPendingOperations() : void
      {
      }
      
      public function getCommonCharacterFormat(range:TextRange = null) : TextLayoutFormat
      {
         if(!range && !this.hasSelection())
         {
            return null;
         }
         var selRange:ElementRange = ElementRange.createElementRange(this._textFlow,!!range ? int(range.absoluteStart) : int(this.absoluteStart),!!range ? int(range.absoluteEnd) : int(this.absoluteEnd));
         var rslt:TextLayoutFormat = selRange.getCommonCharacterFormat();
         if(selRange.absoluteEnd == selRange.absoluteStart && this.pointFormat)
         {
            rslt.apply(this.pointFormat);
         }
         return rslt;
      }
      
      public function getCommonParagraphFormat(range:TextRange = null) : TextLayoutFormat
      {
         if(!range && !this.hasSelection())
         {
            return null;
         }
         return ElementRange.createElementRange(this._textFlow,!!range ? int(range.absoluteStart) : int(this.absoluteStart),!!range ? int(range.absoluteEnd) : int(this.absoluteEnd)).getCommonParagraphFormat();
      }
      
      public function getCommonContainerFormat(range:TextRange = null) : TextLayoutFormat
      {
         if(!range && !this.hasSelection())
         {
            return null;
         }
         return ElementRange.createElementRange(this._textFlow,!!range ? int(range.absoluteStart) : int(this.absoluteStart),!!range ? int(range.absoluteEnd) : int(this.absoluteEnd)).getCommonContainerFormat();
      }
      
      private function updateSelectionAndShapes(tf:TextFlow, begIdx:int, endIdx:int) : void
      {
         this.internalSetSelection(tf,begIdx,endIdx);
         if(this._textFlow.flowComposer && this._textFlow.flowComposer.numControllers != 0)
         {
            this._textFlow.flowComposer.getControllerAt(this._textFlow.flowComposer.numControllers - 1).scrollToRange(this.activeMark.position,this.anchorMark.position);
         }
         this.selectionChanged();
         this.clearSelectionShapes();
         this.addSelectionShapes();
      }
      
      tlf_internal function createMark() : Mark
      {
         var mark:Mark = new Mark(-1);
         this.marks.push(mark);
         return mark;
      }
      
      tlf_internal function removeMark(mark:Mark) : void
      {
         var idx:int = this.marks.indexOf(mark);
         if(idx != -1)
         {
            this.marks.splice(idx,1);
         }
      }
      
      tlf_internal function createCellMark() : CellCoordinates
      {
         var mark:CellCoordinates = new CellCoordinates(-1,-1);
         this.cellMarks.push(mark);
         return mark;
      }
      
      tlf_internal function removeCellMark(mark:CellCoordinates) : void
      {
         var idx:int = this.cellMarks.indexOf(mark);
         if(idx != -1)
         {
            this.marks.splice(idx,1);
         }
      }
      
      public function notifyInsertOrDelete(absolutePosition:int, length:int) : void
      {
         var mark:Mark = null;
         if(length == 0)
         {
            return;
         }
         for(var i:int = 0; i < this.marks.length; i++)
         {
            mark = this.marks[i];
            if(mark.position >= absolutePosition)
            {
               if(length < 0)
               {
                  mark.position = mark.position + length < absolutePosition ? int(absolutePosition) : int(mark.position + length);
               }
               else
               {
                  mark.position += length;
               }
            }
         }
      }
      
      public function get subManager() : ISelectionManager
      {
         return this._subManager;
      }
      
      public function set subManager(value:ISelectionManager) : void
      {
         if(value == this._subManager)
         {
            return;
         }
         if(this._subManager)
         {
            this._subManager.selectRange(-1,-1);
         }
         this._subManager = value;
      }
      
      public function get superManager() : ISelectionManager
      {
         return this._superManager;
      }
      
      public function set superManager(value:ISelectionManager) : void
      {
         this._superManager = value;
      }
      
      public function get anchorCellPosition() : CellCoordinates
      {
         return this._anchorCellPosition;
      }
      
      public function set anchorCellPosition(value:CellCoordinates) : void
      {
         this._anchorCellPosition = value;
      }
      
      public function get activeCellPosition() : CellCoordinates
      {
         return this._activeCellPosition;
      }
      
      public function set activeCellPosition(value:CellCoordinates) : void
      {
         this._activeCellPosition = value;
      }
      
      public function createSelectTableCursor() : MouseCursorData
      {
         var cursorData:Vector.<BitmapData> = new Vector.<BitmapData>();
         var cursorShape:Shape = new Shape();
         cursorShape.graphics.beginFill(0,1);
         cursorShape.graphics.lineStyle(0,16777215,1,true);
         cursorShape.graphics.drawPath(this.selectTableCursorDrawCommands,this.selectTableCursorPoints);
         cursorShape.graphics.endFill();
         var transformer:Matrix = new Matrix();
         var cursorFrame:BitmapData = new BitmapData(32,32,true,0);
         var angle:int = 8;
         var rotation:Number = 0.785398163;
         transformer.translate(-angle,-angle);
         transformer.rotate(rotation);
         transformer.translate(angle,angle);
         cursorFrame.draw(cursorShape,transformer);
         cursorData.push(cursorFrame);
         var mouseCursorData:MouseCursorData = new MouseCursorData();
         mouseCursorData.data = cursorData;
         mouseCursorData.hotSpot = new Point(16,10);
         mouseCursorData.frameRate = 1;
         return mouseCursorData;
      }
      
      public function createSelectTableRowCursor() : MouseCursorData
      {
         var cursorData:Vector.<BitmapData> = new Vector.<BitmapData>();
         var cursorShape:Shape = new Shape();
         cursorShape.graphics.beginFill(0,1);
         cursorShape.graphics.lineStyle(0,16777215,1,true);
         cursorShape.graphics.drawPath(this.selectTableCursorDrawCommands,this.selectTableCursorPoints);
         cursorShape.graphics.endFill();
         var transformer:Matrix = new Matrix();
         var cursorFrame:BitmapData = new BitmapData(32,32,true,0);
         cursorFrame.draw(cursorShape,transformer);
         cursorData.push(cursorFrame);
         var mouseCursorData:MouseCursorData = new MouseCursorData();
         mouseCursorData.data = cursorData;
         mouseCursorData.hotSpot = new Point(16,4);
         mouseCursorData.frameRate = 1;
         return mouseCursorData;
      }
      
      public function createSelectTableColumnCursor() : MouseCursorData
      {
         var cursorData:Vector.<BitmapData> = new Vector.<BitmapData>();
         var cursorShape:Shape = new Shape();
         cursorShape.graphics.beginFill(0,1);
         cursorShape.graphics.lineStyle(0,16777215,1,true);
         cursorShape.graphics.drawPath(this.selectTableCursorDrawCommands,this.selectTableCursorPoints);
         cursorShape.graphics.endFill();
         var transformer:Matrix = new Matrix();
         var cursorFrame:BitmapData = new BitmapData(32,32,true,0);
         var angle:int = 16;
         var rotation:Number = 0.785398163;
         transformer.translate(-angle,-angle);
         transformer.rotate(rotation * 2);
         transformer.translate(angle,angle);
         cursorFrame.draw(cursorShape,transformer);
         cursorData.push(cursorFrame);
         var mouseCursorData:MouseCursorData = new MouseCursorData();
         mouseCursorData.data = cursorData;
         mouseCursorData.hotSpot = new Point(28,16);
         mouseCursorData.frameRate = 1;
         return mouseCursorData;
      }
   }
}
