package flashx.textLayout.edit
{
   import flashx.textLayout.elements.CellRange;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   public class SelectionState extends TextRange
   {
       
      
      private var _pointFormat:ITextLayoutFormat;
      
      private var _cellRange:CellRange;
      
      private var _selectionManagerOperationState:Boolean;
      
      public function SelectionState(root:TextFlow, anchorPosition:int, activePosition:int, format:ITextLayoutFormat = null, cellRange:CellRange = null)
      {
         super(root,anchorPosition,activePosition);
         if(format)
         {
            this._pointFormat = format;
         }
         this._cellRange = cellRange;
      }
      
      override public function updateRange(newAnchorPosition:int, newActivePosition:int) : Boolean
      {
         if(super.updateRange(newAnchorPosition,newActivePosition))
         {
            this._pointFormat = null;
            return true;
         }
         return false;
      }
      
      public function get pointFormat() : ITextLayoutFormat
      {
         return this._pointFormat;
      }
      
      public function set pointFormat(format:ITextLayoutFormat) : void
      {
         this._pointFormat = format;
      }
      
      tlf_internal function get selectionManagerOperationState() : Boolean
      {
         return this._selectionManagerOperationState;
      }
      
      tlf_internal function set selectionManagerOperationState(val:Boolean) : void
      {
         this._selectionManagerOperationState = val;
      }
      
      tlf_internal function clone() : SelectionState
      {
         return new SelectionState(textFlow,anchorPosition,activePosition,this.pointFormat);
      }
      
      public function get cellRange() : CellRange
      {
         return this._cellRange;
      }
      
      public function set cellRange(value:CellRange) : void
      {
         this._cellRange = value;
      }
   }
}
