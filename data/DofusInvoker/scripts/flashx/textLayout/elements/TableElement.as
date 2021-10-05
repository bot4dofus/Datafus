package flashx.textLayout.elements
{
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.TextFlowTableBlock;
   import flashx.textLayout.events.ModelChange;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TableElement extends TableFormattedElement
   {
       
      
      private var _computedWidth:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      private var columns:Vector.<TableColElement>;
      
      private var rows:Vector.<TableRowElement>;
      
      private var damagedColumns:Vector.<TableColElement>;
      
      private var damageRows:Vector.<TableRowElement>;
      
      private var _hasCellDamage:Boolean = true;
      
      private var _headerRowCount:uint = 0;
      
      private var _footerRowCount:uint = 0;
      
      private var _tableRowsComputed:Boolean;
      
      private var _headerRows:Vector.<Vector.<TableCellElement>>;
      
      private var _footerRows:Vector.<Vector.<TableCellElement>>;
      
      private var _bodyRows:Vector.<Vector.<TableCellElement>>;
      
      private var _composedRowIndex:uint = 0;
      
      private var _tableBlocks:Vector.<TextFlowTableBlock>;
      
      private var _tableBlockIndex:uint = 0;
      
      private var _tableBlockDict:Dictionary;
      
      private var _leaf:TableLeafElement;
      
      private var _defaultRowFormat:ITextLayoutFormat;
      
      private var _defaultColumnFormat:ITextLayoutFormat;
      
      public function TableElement()
      {
         this.columns = new Vector.<TableColElement>();
         this.rows = new Vector.<TableRowElement>();
         this.damagedColumns = new Vector.<TableColElement>();
         this.damageRows = new Vector.<TableRowElement>();
         super();
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "table";
      }
      
      override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
      {
         return elem is TableCellElement || elem is TableRowElement || elem is TableColElement;
      }
      
      override tlf_internal function modelChanged(changeType:String, elem:FlowElement, changeStart:int, changeLen:int, needNormalize:Boolean = true, bumpGeneration:Boolean = true) : void
      {
         if(changeType != ModelChange.ELEMENT_ADDED)
         {
            if(changeType == ModelChange.ELEMENT_REMOVAL)
            {
               if(this.headerRowCount > 0 || this.footerRowCount > 0)
               {
               }
            }
         }
         super.modelChanged(changeType,elem,changeStart,changeLen,needNormalize,bumpGeneration);
      }
      
      override public function set cellSpacing(cellSpacingValue:*) : void
      {
         this.markCellsDamaged();
         this.hasCellDamage = true;
         this.normalizeCells();
         super.cellSpacing = cellSpacingValue;
      }
      
      public function get numRows() : int
      {
         return this.rows.length;
      }
      
      public function get numColumns() : int
      {
         return this.columns.length;
      }
      
      public function get numCells() : int
      {
         return this.getCells().length;
      }
      
      public function set numRows(value:int) : void
      {
         var row:TableRowElement = null;
         while(value < this.numRows)
         {
            this.rows.pop();
         }
         var num:int = this.numRows;
         for(var i:int = num; i < value; i++)
         {
            row = this.createRowElement(i,this.defaultRowFormat);
            this.rows.push(row);
         }
      }
      
      public function set numColumns(value:int) : void
      {
         var column:TableColElement = null;
         while(value < this.numColumns)
         {
            this.columns.pop();
         }
         var num:int = this.numColumns;
         for(var i:int = num; i < value; i++)
         {
            column = this.createColumnElement(i,this.defaultColumnFormat);
            this.columns.push(column);
         }
      }
      
      public function get defaultRowFormat() : ITextLayoutFormat
      {
         if(!this._defaultRowFormat)
         {
            this._defaultRowFormat = new TextLayoutFormat(computedFormat);
         }
         return this._defaultRowFormat;
      }
      
      public function set defaultRowFormat(value:ITextLayoutFormat) : void
      {
         this._defaultRowFormat = value;
      }
      
      public function get defaultColumnFormat() : ITextLayoutFormat
      {
         if(!this._defaultColumnFormat)
         {
            this._defaultColumnFormat = new TextLayoutFormat(computedFormat);
         }
         return this._defaultColumnFormat;
      }
      
      public function set defaultColumnFormat(value:ITextLayoutFormat) : void
      {
         this._defaultColumnFormat = value;
      }
      
      override public function addChild(child:FlowElement) : FlowElement
      {
         if(child is TableFormattedElement)
         {
            TableFormattedElement(child).table = this;
         }
         super.addChild(child);
         return child;
      }
      
      override public function removeChild(child:FlowElement) : FlowElement
      {
         super.removeChild(child);
         if(child is TableFormattedElement)
         {
            TableFormattedElement(child).table = null;
         }
         return child;
      }
      
      public function addRow(format:ITextLayoutFormat = null) : void
      {
         this.addRowAt(this.rows.length,format);
      }
      
      public function addRowAt(idx:int, format:ITextLayoutFormat = null) : void
      {
         if(idx < 0 || idx > this.rows.length)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badPropertyValue"));
         }
         var row:TableRowElement = this.createRowElement(idx,format);
         this.rows.splice(idx,0,row);
         row.composedHeight = row.computedFormat.minCellHeight;
         row.isMaxHeight = row.computedFormat.minCellHeight == row.computedFormat.maxCellHeight;
         row.setParentAndRelativeStartOnly(this,1);
      }
      
      public function addColumn(format:ITextLayoutFormat = null) : void
      {
         this.addColumnAt(this.columns.length,format);
      }
      
      public function addColumnAt(idx:int, format:ITextLayoutFormat = null) : void
      {
         if(idx < 0 || idx > this.columns.length)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badPropertyValue"));
         }
         if(!format)
         {
            format = this.defaultColumnFormat;
         }
         var column:TableColElement = this.createColumnElement(idx,format);
         this.columns.splice(idx,0,column);
      }
      
      public function getColumnAt(columnIndex:int) : TableColElement
      {
         if(columnIndex < 0 || columnIndex >= this.numColumns)
         {
            return null;
         }
         return this.columns[columnIndex];
      }
      
      public function getRowAt(rowIndex:int) : TableRowElement
      {
         if(rowIndex < 0 || rowIndex >= this.numRows)
         {
            return null;
         }
         return this.rows[rowIndex];
      }
      
      public function getRowIndex(row:TableRowElement) : int
      {
         for(var i:int = 0; i < this.rows.length; i++)
         {
            if(this.rows[i] == row)
            {
               return i;
            }
         }
         return -1;
      }
      
      public function getCellsForRow(row:TableRowElement) : Vector.<TableCellElement>
      {
         return this.getCellsForRowAt(row.rowIndex);
      }
      
      public function getCellsForRowArray(row:TableRowElement) : Array
      {
         return this.getCellsForRowAtArray(row.rowIndex);
      }
      
      public function getCellsForRowAt(index:int) : Vector.<TableCellElement>
      {
         var cell:TableCellElement = null;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         if(index < 0)
         {
            return cells;
         }
         for each(cell in mxmlChildren)
         {
            if(cell.rowIndex == index)
            {
               cells.push(cell);
            }
         }
         return cells;
      }
      
      public function getCellsForRowAtArray(index:int) : Array
      {
         var cell:TableCellElement = null;
         var cells:Array = [];
         if(index < 0)
         {
            return cells;
         }
         for each(cell in mxmlChildren)
         {
            if(cell.rowIndex == index)
            {
               cells.push(cell);
            }
         }
         return cells;
      }
      
      public function getCellsForColumn(column:TableColElement) : Vector.<TableCellElement>
      {
         if(this.columns.indexOf(column) < 0)
         {
            return null;
         }
         return this.getCellsForColumnAt(column.colIndex);
      }
      
      public function getCellsForColumnAt(index:int) : Vector.<TableCellElement>
      {
         var cell:TableCellElement = null;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         if(index < 0)
         {
            return cells;
         }
         for each(cell in mxmlChildren)
         {
            if(cell.colIndex == index)
            {
               cells.push(cell);
            }
         }
         return cells;
      }
      
      public function hasMergedCells() : Boolean
      {
         var cell:TableCellElement = null;
         var child:* = undefined;
         if(mxmlChildren == null)
         {
            return false;
         }
         for each(child in mxmlChildren)
         {
            cell = child as TableCellElement;
            if(cell && (cell.columnSpan > 1 || cell.rowSpan > 1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function insertColumn(column:TableColElement = null, cells:Array = null) : Boolean
      {
         return this.insertColumnAt(this.numColumns,column,cells);
      }
      
      public function insertColumnAt(idx:int, column:TableColElement = null, cells:Array = null) : Boolean
      {
         var cell:TableCellElement = null;
         if(idx < 0 || idx > this.columns.length)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badPropertyValue"));
         }
         if(!column)
         {
            column = this.createColumnElement(idx,this.defaultColumnFormat);
         }
         this.columns.splice(idx,0,column);
         var blockedCoords:Vector.<CellCoords> = this.getBlockedCoords(-1,idx);
         var cellIdx:int = this.getCellIndex(0,idx);
         if(cellIdx < 0)
         {
            cellIdx = numChildren;
         }
         var rowIdx:int = 0;
         if(cells == null)
         {
            cells = [];
         }
         while(cells.length < this.numRows)
         {
            cells.push(new TableCellElement());
         }
         for each(cell in cells)
         {
            while(blockedCoords.length && blockedCoords[0].row == rowIdx)
            {
               rowIdx++;
               blockedCoords.shift();
            }
            cellIdx = this.getCellIndex(rowIdx,idx);
            if(cellIdx < 0)
            {
               cellIdx = this.getCellIndex(rowIdx,idx - 1);
               cellIdx++;
            }
            if(rowIdx < this.numRows)
            {
               addChildAt(cellIdx,cell);
            }
            rowIdx++;
         }
         return true;
      }
      
      public function insertRow(row:TableRowElement = null, cells:Array = null) : Boolean
      {
         return this.insertRowAt(this.numRows,row,cells);
      }
      
      public function insertRowAt(idx:int, row:TableRowElement = null, cells:Array = null) : Boolean
      {
         var cell:TableCellElement = null;
         if(idx < 0 || idx > this.rows.length)
         {
            throw RangeError(GlobalSettings.resourceStringFunction("badPropertyValue"));
         }
         if(!row)
         {
            row = this.createRowElement(idx,this.defaultRowFormat);
         }
         this.rows.splice(idx,0,row);
         row.composedHeight = row.computedFormat.minCellHeight;
         row.isMaxHeight = row.computedFormat.minCellHeight == row.computedFormat.maxCellHeight;
         var cellIdx:int = this.getCellIndex(idx,0);
         if(cellIdx < 0)
         {
            cellIdx = numChildren;
         }
         var colIdx:int = 0;
         if(cells == null)
         {
            cells = [];
         }
         var occupiedColumns:int = 0;
         for each(cell in cells)
         {
            occupiedColumns += cell.columnSpan;
         }
         while(occupiedColumns < this.numColumns)
         {
            cells.push(new TableCellElement());
            occupiedColumns++;
         }
         for each(cell in cells)
         {
            if(colIdx < this.numColumns)
            {
               addChildAt(cellIdx++,cell);
               cell.damage();
            }
            colIdx += cell.columnSpan - 1;
         }
         return true;
      }
      
      public function removeRow(row:TableRowElement) : TableRowElement
      {
         var i:int = this.rows.indexOf(row);
         if(i < 0)
         {
            return null;
         }
         return this.removeRowAt(i);
      }
      
      public function removeRowWithContent(row:TableRowElement) : Array
      {
         var i:int = this.rows.indexOf(row);
         if(i < 0)
         {
            return null;
         }
         return this.removeRowWithContentAt(i);
      }
      
      public function removeRowAt(idx:int) : TableRowElement
      {
         if(idx < 0 || idx > this.rows.length - 1)
         {
            return null;
         }
         var row:TableRowElement = TableRowElement(this.rows.splice(idx,1)[0]);
         this.normalizeCells();
         this.hasCellDamage = true;
         return row;
      }
      
      public function removeRowWithContentAt(idx:int) : Array
      {
         var i:int = 0;
         var child:* = undefined;
         var cell:TableCellElement = null;
         var removedCells:Array = [];
         if(mxmlChildren)
         {
            for(i = mxmlChildren.length - 1; i >= 0; i--)
            {
               child = mxmlChildren[i];
               if(child is TableCellElement)
               {
                  cell = child as TableCellElement;
                  if(cell.rowIndex == idx)
                  {
                     removedCells.unshift(this.removeChild(cell));
                  }
               }
            }
         }
         this.removeRowAt(idx);
         return removedCells;
      }
      
      public function removeAllRowsWithContent() : void
      {
         var rowCount:int = 0;
         var cellCount:int = 0;
         if(this.numRows > -1)
         {
            rowCount = this.numRows - 1;
            while(rowCount > -1)
            {
               this.removeRowWithContentAt(rowCount--);
            }
         }
      }
      
      public function removeAllRows() : void
      {
         var rowCount:int = 0;
         var cellCount:int = 0;
         var i:int = 0;
         if(this.numRows > -1)
         {
            for(rowCount = this.numRows; i < rowCount; )
            {
               this.removeRowAt(i);
               i++;
            }
         }
      }
      
      public function removeColumn(column:TableColElement) : TableColElement
      {
         var i:int = this.columns.indexOf(column);
         if(i < 0)
         {
            return null;
         }
         return this.removeColumnAt(i);
      }
      
      public function removeColumnWithContent(column:TableColElement) : Array
      {
         var i:int = this.columns.indexOf(column);
         if(i < 0)
         {
            return null;
         }
         return this.removeColumnWithContentAt(i);
      }
      
      public function removeColumnAt(idx:int) : TableColElement
      {
         if(idx < 0 || idx > this.columns.length - 1)
         {
            return null;
         }
         var col:TableColElement = this.columns.splice(idx,1)[0];
         this.normalizeCells();
         this.hasCellDamage = true;
         return col;
      }
      
      public function removeColumnWithContentAt(idx:int) : Array
      {
         var i:int = 0;
         var child:* = undefined;
         var cell:TableCellElement = null;
         var removedCells:Array = [];
         if(mxmlChildren)
         {
            for(i = mxmlChildren.length - 1; i >= 0; i--)
            {
               child = mxmlChildren[i];
               if(child is TableCellElement)
               {
                  cell = child as TableCellElement;
                  if(cell.colIndex == idx)
                  {
                     removedCells.unshift(this.removeChild(cell));
                  }
               }
            }
         }
         this.removeColumnAt(idx);
         return removedCells;
      }
      
      override tlf_internal function removed() : void
      {
         this.hasCellDamage = true;
      }
      
      private function getBlockedCoords(inRow:int = -1, inColumn:int = -1) : Vector.<CellCoords>
      {
         var child:* = undefined;
         var cell:TableCellElement = null;
         var curRow:int = 0;
         var curColumn:int = 0;
         var endRow:int = 0;
         var endColumn:int = 0;
         var rowIdx:int = 0;
         var colIdx:int = 0;
         var coords:Vector.<CellCoords> = new Vector.<CellCoords>();
         if(mxmlChildren)
         {
            for each(child in mxmlChildren)
            {
               cell = child as TableCellElement;
               if(cell != null)
               {
                  if(!(cell.columnSpan == 1 && cell.rowSpan == 1))
                  {
                     curRow = cell.rowIndex;
                     if(!(inRow >= 0 && curRow != inRow))
                     {
                        if(!(inColumn >= 0 && inColumn != curColumn))
                        {
                           curColumn = cell.colIndex;
                           endRow = curRow + cell.rowSpan - 1;
                           endColumn = curColumn + cell.columnSpan - 1;
                           for(rowIdx = curRow; rowIdx <= endRow; rowIdx++)
                           {
                              for(colIdx = curColumn; colIdx <= endColumn; colIdx++)
                              {
                                 if(!(rowIdx == curRow && colIdx == curColumn))
                                 {
                                    coords.push(new CellCoords(colIdx,rowIdx));
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return coords;
      }
      
      public function normalizeCells() : void
      {
         var i:int = 0;
         var child:* = undefined;
         var cell:TableCellElement = null;
         var endRow:int = 0;
         var endColumn:int = 0;
         var rowIdx:int = 0;
         var colIdx:int = 0;
         var advanced:Boolean = false;
         this.numColumns;
         this.numRows;
         var blockedCoords:Vector.<CellCoords> = new Vector.<CellCoords>();
         if(!mxmlChildren)
         {
            return;
         }
         var curRow:int = 0;
         var curColumn:int = 0;
         loop0:
         for each(child in mxmlChildren)
         {
            if(child is TableCellElement)
            {
               cell = child as TableCellElement;
               if(cell.rowIndex != curRow || cell.colIndex != curColumn)
               {
                  cell.rowIndex = curRow;
                  cell.colIndex = curColumn;
                  cell.damage();
               }
               endRow = curRow + cell.rowSpan - 1;
               endColumn = curColumn + cell.columnSpan - 1;
               for(rowIdx = curRow; rowIdx <= endRow; rowIdx++)
               {
                  for(colIdx = curColumn; colIdx <= endColumn; colIdx++)
                  {
                     if(!(rowIdx == curRow && colIdx == curColumn))
                     {
                        blockedCoords.push(new CellCoords(colIdx,rowIdx));
                     }
                  }
               }
               while(true)
               {
                  curColumn++;
                  if(curColumn >= this.numColumns)
                  {
                     curColumn = 0;
                     curRow++;
                  }
                  advanced = true;
                  for(i = 0; i < blockedCoords.length; i++)
                  {
                     if(blockedCoords[i].column == curColumn && blockedCoords[i].row == curRow)
                     {
                        advanced = false;
                        blockedCoords.splice(i,1);
                     }
                  }
                  if(advanced)
                  {
                     break;
                  }
                  if(!1)
                  {
                     continue loop0;
                  }
               }
            }
         }
      }
      
      public function setColumnWidth(columnIndex:int, value:*) : Boolean
      {
         var tableColElement:TableColElement = this.getColumnAt(columnIndex);
         if(!tableColElement)
         {
            return false;
         }
         tableColElement.tableColumnWidth = value;
         return true;
      }
      
      public function setRowHeight(rowIdx:int, value:*) : Boolean
      {
         var row:TableRowElement = this.getRowAt(rowIdx);
         if(!row)
         {
            return false;
         }
         return true;
      }
      
      public function getColumnWidth(columnIndex:int) : *
      {
         var tableColElement:TableColElement = this.getColumnAt(columnIndex) as TableColElement;
         if(tableColElement)
         {
            return tableColElement.tableColumnWidth;
         }
         return 0;
      }
      
      public function composeCells() : void
      {
         var cell:TableCellElement = null;
         var row:TableRowElement = null;
         var xPos:Number = NaN;
         var col:TableColElement = null;
         var minH:Number = NaN;
         var maxH:Number = NaN;
         var i:int = 0;
         var cellHeight:Number = NaN;
         var rowVec:Vector.<TableCellElement> = null;
         this.normalizeCells();
         this._composedRowIndex = 0;
         if(!this.hasCellDamage)
         {
            return;
         }
         var damagedCells:Vector.<TableCellElement> = this.getDamagedCells();
         for each(cell in damagedCells)
         {
            cell.compose();
         }
         for each(row in this.rows)
         {
            minH = row.computedFormat.minCellHeight;
            maxH = row.computedFormat.maxCellHeight;
            row.totalHeight = row.composedHeight = minH;
            if(maxH > minH)
            {
               row.isMaxHeight = false;
            }
            else
            {
               row.isMaxHeight = true;
            }
         }
         xPos = 0;
         for each(col in this.columns)
         {
            col.x = xPos;
            xPos += col.columnWidth;
         }
         if(mxmlChildren)
         {
            for(i = 0; i < mxmlChildren.length; i++)
            {
               if(mxmlChildren[i] is TableCellElement)
               {
                  cell = mxmlChildren[i] as TableCellElement;
                  while(this.rows.length < cell.rowIndex + 1)
                  {
                     this.addRow(this.defaultRowFormat);
                  }
                  row = this.getRowAt(cell.rowIndex);
                  if(!row)
                  {
                     throw new Error("this should not happen...");
                  }
                  if(!row.isMaxHeight)
                  {
                     cellHeight = cell.getComposedHeight();
                     if(cell.rowSpan > 1)
                     {
                        row.totalHeight = Math.max(row.totalHeight,cellHeight);
                     }
                     else
                     {
                        row.composedHeight = Math.max(row.composedHeight,cellHeight);
                        row.composedHeight = Math.min(row.composedHeight,row.computedFormat.maxCellHeight);
                        row.totalHeight = Math.max(row.composedHeight,row.totalHeight);
                     }
                     if(row.composedHeight == row.computedFormat.maxCellHeight)
                     {
                        row.isMaxHeight = true;
                     }
                  }
               }
            }
         }
         if(!this._tableRowsComputed)
         {
            this._bodyRows = new Vector.<Vector.<TableCellElement>>();
            if(mxmlChildren)
            {
               for(i = 0; i < mxmlChildren.length; i++)
               {
                  if(mxmlChildren[i] is TableCellElement)
                  {
                     cell = mxmlChildren[i] as TableCellElement;
                     while(cell.rowIndex >= this._bodyRows.length)
                     {
                        this._bodyRows.push(new Vector.<TableCellElement>());
                     }
                     rowVec = this._bodyRows[cell.rowIndex] as Vector.<TableCellElement>;
                     if(!rowVec)
                     {
                        rowVec = new Vector.<TableCellElement>();
                        this._bodyRows[cell.rowIndex] = rowVec;
                     }
                     if(rowVec.length > cell.colIndex && rowVec[cell.colIndex])
                     {
                        throw new Error("Two cells cannot have the same coordinates");
                     }
                     rowVec.push(cell);
                  }
               }
            }
            if(this.headerRowCount > 0)
            {
               this._headerRows = this._bodyRows.splice(0,this.headerRowCount);
            }
            else
            {
               this._headerRows = null;
            }
            if(this.footerRowCount > 0)
            {
               this._footerRows = this._bodyRows.splice(-this.footerRowCount,Number.MAX_VALUE);
            }
            else
            {
               this._footerRows = null;
            }
         }
      }
      
      public function getHeaderRows() : Vector.<Vector.<TableCellElement>>
      {
         return this._headerRows;
      }
      
      public function getFooterRows() : Vector.<Vector.<TableCellElement>>
      {
         return this._footerRows;
      }
      
      public function getBodyRows() : Vector.<Vector.<TableCellElement>>
      {
         return this._bodyRows;
      }
      
      public function getNextRow() : Vector.<TableCellElement>
      {
         if(this._composedRowIndex >= this._bodyRows.length)
         {
            return null;
         }
         return this._bodyRows[this._composedRowIndex++];
      }
      
      public function getNextCell(tableCell:TableCellElement) : TableCellElement
      {
         var cell:TableCellElement = null;
         var element:FlowElement = null;
         for each(element in mxmlChildren)
         {
            cell = element as TableCellElement;
            if(cell)
            {
               if(cell.rowIndex == tableCell.rowIndex && cell.colIndex - 1 == tableCell.colIndex)
               {
                  return cell;
               }
               if(cell.rowIndex - 1 == tableCell.rowIndex && cell.colIndex == 0)
               {
                  return cell;
               }
            }
         }
         return null;
      }
      
      public function getPreviousCell(tableCell:TableCellElement) : TableCellElement
      {
         var cell:TableCellElement = null;
         var element:FlowElement = null;
         var highestCellIndex:int = -1;
         var rowIndex:int = -1;
         for each(element in mxmlChildren)
         {
            cell = element as TableCellElement;
            if(cell)
            {
               if(cell.rowIndex == tableCell.rowIndex && cell.colIndex + 1 == tableCell.colIndex)
               {
                  return cell;
               }
               if(cell.rowIndex + 1 == tableCell.rowIndex)
               {
                  rowIndex = cell.rowIndex;
                  if(highestCellIndex < cell.colIndex)
                  {
                     highestCellIndex = cell.colIndex;
                  }
               }
            }
         }
         if(rowIndex > -1 && highestCellIndex > -1)
         {
            return this.getCellAt(rowIndex,highestCellIndex);
         }
         return null;
      }
      
      public function getCellAt(rowIndex:int, columnIndex:int) : TableCellElement
      {
         var cell:TableCellElement = null;
         var element:FlowElement = null;
         for each(element in mxmlChildren)
         {
            cell = element as TableCellElement;
            if(cell && cell.rowIndex == rowIndex && cell.colIndex == columnIndex)
            {
               return cell;
            }
         }
         return null;
      }
      
      public function getHeaderHeight() : Number
      {
         return 0;
      }
      
      public function getFooterHeight() : Number
      {
         return 0;
      }
      
      public function normalizeColumnWidths(suggestedWidth:Number = 600) : void
      {
         var w:Number = NaN;
         var col:TableColElement = null;
         var cCount:Number = NaN;
         var setCount:* = computedFormat.columnCount;
         if(setCount)
         {
            if(setCount != FormatValue.AUTO)
            {
               cCount = computedFormat.columnCount;
            }
         }
         while(cCount > this.columns.length)
         {
            this.addColumn();
         }
         switch(typeof computedFormat.tableWidth)
         {
            case "number":
               w = suggestedWidth;
               break;
            case "string":
               if(computedFormat.tableWidth.indexOf("%") > 0)
               {
                  w = suggestedWidth / (parseFloat(computedFormat.tableWidth) / 100);
                  break;
               }
            default:
               w = suggestedWidth;
         }
         if(isNaN(w))
         {
            w = 600;
         }
         if(w > 20000)
         {
            w = 600;
         }
         this._computedWidth = w;
         var numNonsetColumns:int = this.numColumns;
         for each(col in this.columns)
         {
            if(typeof col.columnWidth == "number")
            {
               w -= col.columnWidth;
               numNonsetColumns--;
            }
         }
         for each(col in this.columns)
         {
            if(typeof col.columnWidth != "number")
            {
               col.columnWidth = w / numNonsetColumns;
            }
         }
      }
      
      private function getDamagedCells() : Vector.<TableCellElement>
      {
         var cell:* = undefined;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         for each(cell in this.mxmlChildren)
         {
            if(cell is TableCellElement && cell.isDamaged())
            {
               cells.push(cell as TableCellElement);
            }
         }
         return cells;
      }
      
      private function markCellsDamaged() : void
      {
         var cell:* = undefined;
         if(!mxmlChildren)
         {
            return;
         }
         for each(cell in this.mxmlChildren)
         {
            if(cell is TableCellElement)
            {
               cell.damage();
            }
         }
      }
      
      public function getCells() : Vector.<TableCellElement>
      {
         var cell:* = undefined;
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         for each(cell in mxmlChildren)
         {
            if(cell is TableCellElement)
            {
               cells.push(cell as TableCellElement);
            }
         }
         return cells;
      }
      
      public function getCellsArray() : Array
      {
         var cell:* = undefined;
         var cells:Array = [];
         for each(cell in mxmlChildren)
         {
            if(cell is TableCellElement)
            {
               cells.push(cell as TableCellElement);
            }
         }
         return cells;
      }
      
      public function get width() : Number
      {
         return this._computedWidth;
      }
      
      public function set width(value:*) : void
      {
         this.normalizeColumnWidths(value);
      }
      
      public function get hasCellDamage() : Boolean
      {
         return this._hasCellDamage;
      }
      
      public function set hasCellDamage(value:Boolean) : void
      {
         this._hasCellDamage = value;
      }
      
      public function get headerRowCount() : uint
      {
         return this._headerRowCount;
      }
      
      public function set headerRowCount(value:uint) : void
      {
         if(value != this._headerRowCount)
         {
            this._tableRowsComputed = false;
         }
         this._headerRowCount = value;
      }
      
      public function get footerRowCount() : uint
      {
         return this._footerRowCount;
      }
      
      public function set footerRowCount(value:uint) : void
      {
         if(value != this._footerRowCount)
         {
            this._tableRowsComputed = false;
         }
         this._footerRowCount = value;
      }
      
      public function getFirstBlock() : TextFlowTableBlock
      {
         if(this._tableBlocks == null)
         {
            this._tableBlocks = new Vector.<TextFlowTableBlock>();
         }
         if(this._tableBlocks.length == 0)
         {
            this._tableBlocks.push(new TextFlowTableBlock(0));
         }
         this._tableBlockIndex = 0;
         this._tableBlocks[0].parentTable = this;
         return this._tableBlocks[0];
      }
      
      public function getNextBlock() : TextFlowTableBlock
      {
         if(this._tableBlocks == null)
         {
            this._tableBlocks = new Vector.<TextFlowTableBlock>();
         }
         ++this._tableBlockIndex;
         while(this._tableBlocks.length <= this._tableBlockIndex)
         {
            this._tableBlocks.push(new TextFlowTableBlock(this._tableBlocks.length));
         }
         this._tableBlocks[this._tableBlockIndex].parentTable = this;
         return this._tableBlocks[this._tableBlockIndex];
      }
      
      override public function get textLength() : int
      {
         return 1;
      }
      
      private function getCellIndex(rowIdx:int, columnIdx:int) : int
      {
         var item:* = undefined;
         var cell:TableCellElement = null;
         if(rowIdx == 0 && columnIdx == 0)
         {
            return 0;
         }
         for(var i:int = 0; i < mxmlChildren.length; i++)
         {
            item = mxmlChildren[i];
            if(item is TableCellElement)
            {
               cell = item as TableCellElement;
               if(cell.rowIndex == rowIdx && cell.colIndex == columnIdx)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      public function getCellsInRange(anchorCoords:CellCoordinates, activeCoords:CellCoordinates, block:TextFlowTableBlock = null) : Vector.<TableCellElement>
      {
         var col:int = 0;
         var nextCell:TableCellElement = null;
         var firstCoords:CellCoordinates = anchorCoords.clone();
         var lastCoords:CellCoordinates = activeCoords.clone();
         if(lastCoords.row < firstCoords.row || lastCoords.row == firstCoords.row && lastCoords.column < firstCoords.column)
         {
            firstCoords = activeCoords.clone();
            lastCoords = anchorCoords.clone();
         }
         if(lastCoords.column < firstCoords.column)
         {
            col = firstCoords.column;
            firstCoords.column = lastCoords.column;
            lastCoords.column = col;
         }
         var firstCell:TableCellElement = this.findCell(firstCoords);
         var cells:Vector.<TableCellElement> = new Vector.<TableCellElement>();
         if(!block || this.getCellBlock(firstCell) == block)
         {
            cells.push(firstCell);
         }
         var idx:int = mxmlChildren.indexOf(firstCell);
         while(++idx < mxmlChildren.length)
         {
            nextCell = mxmlChildren[idx];
            if(nextCell.rowIndex > lastCoords.row || nextCell.rowIndex == lastCoords.row && nextCell.colIndex > lastCoords.column)
            {
               break;
            }
            if(!(nextCell.colIndex > lastCoords.column || nextCell.colIndex < firstCoords.column))
            {
               if(!block || this.getCellBlock(nextCell) == block)
               {
                  cells.push(nextCell);
               }
            }
         }
         return cells;
      }
      
      public function findCell(coords:CellCoordinates) : TableCellElement
      {
         var nextCell:TableCellElement = null;
         var prevCell:TableCellElement = null;
         var idx:int = (coords.row + 1) * (coords.column + 1) - 1;
         if(idx >= numChildren)
         {
            idx = numChildren - 1;
         }
         var cell:TableCellElement = mxmlChildren[idx];
         while(idx != numChildren - 1)
         {
            nextCell = mxmlChildren[idx + 1];
            if(nextCell.rowIndex > coords.row || nextCell.rowIndex == coords.row && nextCell.colIndex > coords.column)
            {
               break;
            }
            cell = nextCell;
            idx++;
         }
         while(!(cell.colIndex <= coords.column && cell.colIndex + cell.columnSpan - 1 >= coords.column && cell.rowIndex <= coords.row && cell.rowIndex + cell.rowSpan - 1 >= coords.row))
         {
            if(cell.colIndex == 0 && cell.rowIndex == 0)
            {
               break;
            }
            if(idx == 0)
            {
               break;
            }
            prevCell = mxmlChildren[idx - 1];
            cell = prevCell;
            idx--;
         }
         return cell;
      }
      
      public function addCellToBlock(cell:TableCellElement, block:TextFlowTableBlock) : void
      {
         block.addCell(cell.container);
         this.tableBlockDict[cell] = block;
      }
      
      public function getCellBlock(cell:TableCellElement) : TextFlowTableBlock
      {
         return this.tableBlockDict[cell];
      }
      
      private function get tableBlockDict() : Dictionary
      {
         if(this._tableBlockDict == null)
         {
            this._tableBlockDict = new Dictionary();
         }
         return this._tableBlockDict;
      }
      
      public function get tableBlocks() : Vector.<TextFlowTableBlock>
      {
         return this._tableBlocks;
      }
      
      public function getTableBlocksInRange(start:CellCoordinates, end:CellCoordinates) : Vector.<TextFlowTableBlock>
      {
         var coords:CellCoordinates = start.clone();
         if(end.column < start.column)
         {
            coords = end.clone();
            end = start.clone();
         }
         var blocks:Vector.<TextFlowTableBlock> = new Vector.<TextFlowTableBlock>();
         var block:TextFlowTableBlock = this.getCellBlock(this.findCell(coords));
         if(block)
         {
            blocks.push(block);
         }
         while(block)
         {
            ++coords.row;
            if(coords.row > end.row)
            {
               break;
            }
            if(this.getCellBlock(this.findCell(coords)) != block)
            {
               block = this.getCellBlock(this.findCell(coords));
               if(block)
               {
                  blocks.push(block);
               }
            }
         }
         return blocks;
      }
      
      override tlf_internal function getNextLeafHelper(limitElement:FlowGroupElement, child:FlowElement) : FlowLeafElement
      {
         return parent.getNextLeafHelper(limitElement,this);
      }
      
      override tlf_internal function getPreviousLeafHelper(limitElement:FlowGroupElement, child:FlowElement) : FlowLeafElement
      {
         return parent.getPreviousLeafHelper(limitElement,this);
      }
      
      private function getLeaf() : TableLeafElement
      {
         if(this._leaf == null)
         {
            this._leaf = new TableLeafElement(this);
         }
         return this._leaf;
      }
      
      override public function findLeaf(relativePosition:int) : FlowLeafElement
      {
         return this.getLeaf();
      }
      
      override public function getLastLeaf() : FlowLeafElement
      {
         return this.getLeaf();
      }
      
      override public function getFirstLeaf() : FlowLeafElement
      {
         return this.getLeaf();
      }
      
      override tlf_internal function createContentElement() : void
      {
      }
      
      override tlf_internal function releaseContentElement() : void
      {
      }
      
      tlf_internal function createRowElement(index:int, defaultRowFormat:ITextLayoutFormat) : TableRowElement
      {
         var row:TableRowElement = new TableRowElement(defaultRowFormat);
         row.rowIndex = index;
         row.table = this;
         return row;
      }
      
      tlf_internal function createColumnElement(index:int, defaultColumnFormat:ITextLayoutFormat) : TableColElement
      {
         var column:TableColElement = new TableColElement(defaultColumnFormat);
         column.colIndex = index;
         column.table = this;
         return column;
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
      }
   }
}

class CellCoords
{
    
   
   public var column:int;
   
   public var row:int;
   
   function CellCoords(colIdx:int, rowIdx:int)
   {
      super();
      this.column = colIdx;
      this.row = rowIdx;
   }
}
