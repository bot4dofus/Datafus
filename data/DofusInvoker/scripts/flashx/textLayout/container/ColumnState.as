package flashx.textLayout.container
{
   import flash.geom.Rectangle;
   import flashx.textLayout.elements.TableCellElement;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.LineBreak;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.utils.Twips;
   
   use namespace tlf_internal;
   
   public class ColumnState
   {
       
      
      private var _inputsChanged:Boolean;
      
      private var _blockProgression:String;
      
      private var _columnDirection:String;
      
      private var _paddingTop:Number;
      
      private var _paddingBottom:Number;
      
      private var _paddingLeft:Number;
      
      private var _paddingRight:Number;
      
      private var _compositionWidth:Number;
      
      private var _compositionHeight:Number;
      
      private var _forceSingleColumn:Boolean;
      
      private var _inputColumnWidth:Object;
      
      private var _inputColumnGap:Number;
      
      private var _inputColumnCount:Object;
      
      private var _columnWidth:Number;
      
      private var _columnCount:int;
      
      private var _columnGap:Number;
      
      private var _inset:Number;
      
      private var _columnArray:Array;
      
      private var _tableCellArray:Array;
      
      private var _singleColumn:Rectangle;
      
      public function ColumnState(blockProgression:String, columnDirection:String, controller:ContainerController, compositionWidth:Number, compositionHeight:Number)
      {
         super();
         this._inputsChanged = true;
         this._columnCount = 0;
         if(blockProgression != null)
         {
            this.updateInputs(blockProgression,columnDirection,controller,compositionWidth,compositionHeight);
            this.computeColumns();
         }
      }
      
      public function get columnWidth() : Number
      {
         return this._columnWidth;
      }
      
      public function get columnCount() : int
      {
         return this._columnCount;
      }
      
      public function get cellCount() : int
      {
         if(this._tableCellArray)
         {
            return this._tableCellArray.length;
         }
         return -1;
      }
      
      public function get columnGap() : Number
      {
         return this._columnGap;
      }
      
      public function getColumnAt(index:int) : Rectangle
      {
         return this._columnCount == 1 ? this._singleColumn : this._columnArray[index];
      }
      
      public function getCellAt(index:int) : TableCellElement
      {
         return this._tableCellArray[index];
      }
      
      public function pushTableCell(cell:TableCellElement) : void
      {
         if(this._tableCellArray == null)
         {
            this._tableCellArray = new Array();
         }
         this._tableCellArray.push(cell);
      }
      
      public function clearCellList() : void
      {
         this._tableCellArray = null;
      }
      
      tlf_internal function updateInputs(newBlockProgression:String, newColumnDirection:String, controller:ContainerController, newCompositionWidth:Number, newCompositionHeight:Number) : void
      {
         var newPaddingTop:Number = controller.getTotalPaddingTop();
         var newPaddingBottom:Number = controller.getTotalPaddingBottom();
         var newPaddingLeft:Number = controller.getTotalPaddingLeft();
         var newPaddingRight:Number = controller.getTotalPaddingRight();
         var containerAttr:ITextLayoutFormat = controller.computedFormat;
         var newColumnWidth:Object = containerAttr.columnWidth;
         var newColumnGap:Number = containerAttr.columnGap;
         var newColumnCount:Object = containerAttr.columnCount;
         var newForceSingleColumn:Boolean = containerAttr.columnCount == FormatValue.AUTO && (containerAttr.columnWidth == FormatValue.AUTO || Number(containerAttr.columnWidth) == 0) || controller.rootElement.computedFormat.lineBreak == LineBreak.EXPLICIT || isNaN(newBlockProgression == BlockProgression.RL ? Number(newCompositionHeight) : Number(newCompositionWidth));
         if(this._inputsChanged == false)
         {
            this._inputsChanged = newCompositionWidth != this._compositionHeight || newCompositionHeight != this._compositionHeight || this._paddingTop != newPaddingTop || this._paddingBottom != newPaddingBottom || this._paddingLeft != newPaddingLeft || this._paddingRight != newPaddingRight || this._blockProgression != this._blockProgression || this._columnDirection != newColumnDirection || this._forceSingleColumn != newForceSingleColumn || this._inputColumnWidth != newColumnWidth || this._inputColumnGap != newColumnGap || this._inputColumnCount != newColumnCount;
         }
         if(this._inputsChanged)
         {
            this._blockProgression = newBlockProgression;
            this._columnDirection = newColumnDirection;
            this._paddingTop = newPaddingTop;
            this._paddingBottom = newPaddingBottom;
            this._paddingLeft = newPaddingLeft;
            this._paddingRight = newPaddingRight;
            this._compositionWidth = newCompositionWidth;
            this._compositionHeight = newCompositionHeight;
            this._forceSingleColumn = newForceSingleColumn;
            this._inputColumnWidth = newColumnWidth;
            this._inputColumnGap = newColumnGap;
            this._inputColumnCount = newColumnCount;
         }
      }
      
      tlf_internal function computeColumns() : void
      {
         var newColumnGap:Number = NaN;
         var newColumnCount:int = 0;
         var newColumnWidth:Number = NaN;
         var xPos:Number = NaN;
         var yPos:Number = NaN;
         var delX:Number = NaN;
         var delY:Number = NaN;
         var colH:Number = NaN;
         var colW:Number = NaN;
         var insetHeight:Number = NaN;
         var i:int = 0;
         if(!this._inputsChanged)
         {
            return;
         }
         var totalColumnWidth:Number = this._blockProgression == BlockProgression.RL ? Number(this._compositionHeight) : Number(this._compositionWidth);
         var newColumnInset:Number = this._blockProgression == BlockProgression.RL ? Number(this._paddingTop + this._paddingBottom) : Number(this._paddingLeft + this._paddingRight);
         totalColumnWidth = totalColumnWidth > newColumnInset && !isNaN(totalColumnWidth) ? Number(totalColumnWidth - newColumnInset) : Number(0);
         if(this._forceSingleColumn)
         {
            newColumnCount = 1;
            newColumnWidth = totalColumnWidth;
            newColumnGap = 0;
         }
         else
         {
            newColumnGap = this._inputColumnGap;
            if(this._inputColumnWidth == FormatValue.AUTO)
            {
               newColumnCount = Number(this._inputColumnCount);
               if((newColumnCount - 1) * newColumnGap < totalColumnWidth)
               {
                  newColumnWidth = (totalColumnWidth - (newColumnCount - 1) * newColumnGap) / newColumnCount;
               }
               else if(newColumnGap > totalColumnWidth)
               {
                  newColumnCount = 1;
                  newColumnWidth = totalColumnWidth;
                  newColumnGap = 0;
               }
               else
               {
                  newColumnCount = Math.floor(totalColumnWidth / newColumnGap);
                  newColumnWidth = (totalColumnWidth - (newColumnCount - 1) * newColumnGap) / newColumnCount;
               }
            }
            else if(this._inputColumnCount == FormatValue.AUTO)
            {
               newColumnWidth = Number(this._inputColumnWidth);
               if(newColumnWidth >= totalColumnWidth)
               {
                  newColumnCount = 1;
                  newColumnWidth = totalColumnWidth;
                  newColumnGap = 0;
               }
               else
               {
                  newColumnCount = Math.floor((totalColumnWidth + newColumnGap) / (newColumnWidth + newColumnGap));
                  newColumnWidth = (totalColumnWidth + newColumnGap) / newColumnCount - newColumnGap;
               }
            }
            else
            {
               newColumnCount = Number(this._inputColumnCount);
               newColumnWidth = Number(this._inputColumnWidth);
               if(newColumnCount * newColumnWidth + (newColumnCount - 1) * newColumnGap > totalColumnWidth)
               {
                  if(newColumnWidth >= totalColumnWidth)
                  {
                     newColumnCount = 1;
                     newColumnGap = 0;
                  }
                  else
                  {
                     newColumnCount = Math.floor((totalColumnWidth + newColumnGap) / (newColumnWidth + newColumnGap));
                     newColumnWidth = (totalColumnWidth + newColumnGap) / newColumnCount - newColumnGap;
                  }
               }
            }
         }
         this._columnWidth = newColumnWidth;
         this._columnCount = newColumnCount;
         this._columnGap = newColumnGap;
         this._inset = newColumnInset;
         if(this._blockProgression == BlockProgression.TB)
         {
            if(this._columnDirection == Direction.LTR)
            {
               xPos = this._paddingLeft;
               delX = this._columnWidth + this._columnGap;
               colW = this._columnWidth;
            }
            else
            {
               xPos = !!isNaN(this._compositionWidth) ? Number(this._paddingLeft) : Number(this._compositionWidth - this._paddingRight - this._columnWidth);
               delX = -(this._columnWidth + this._columnGap);
               colW = this._columnWidth;
            }
            yPos = this._paddingTop;
            delY = 0;
            insetHeight = this._paddingTop + this._paddingBottom;
            colH = this._compositionHeight > insetHeight && !isNaN(this._compositionHeight) ? Number(this._compositionHeight - insetHeight) : Number(0);
         }
         else if(this._blockProgression == BlockProgression.RL)
         {
            xPos = !!isNaN(this._compositionWidth) ? Number(-this._paddingRight) : Number(this._paddingLeft - this._compositionWidth);
            yPos = this._paddingTop;
            delX = 0;
            delY = this._columnWidth + this._columnGap;
            insetHeight = this._paddingLeft + this._paddingRight;
            colW = this._compositionWidth > insetHeight ? Number(this._compositionWidth - insetHeight) : Number(0);
            colH = this._columnWidth;
         }
         if(colW == 0)
         {
            colW = Twips.ONE_TWIP;
            if(this._blockProgression == BlockProgression.RL)
            {
               xPos -= colW;
            }
         }
         if(colH == 0)
         {
            colH = Twips.ONE_TWIP;
         }
         if(this._columnCount == 1)
         {
            this._singleColumn = new Rectangle(xPos,yPos,colW,colH);
            this._columnArray = null;
         }
         else if(this._columnCount == 0)
         {
            this._singleColumn = null;
            this._columnArray = null;
         }
         else
         {
            if(this._columnArray)
            {
               this._columnArray.splice(0);
            }
            else
            {
               this._columnArray = new Array();
            }
            for(i = 0; i < this._columnCount; i++)
            {
               this._columnArray.push(new Rectangle(xPos,yPos,colW,colH));
               xPos += delX;
               yPos += delY;
            }
         }
      }
   }
}
