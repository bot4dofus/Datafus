package flashx.textLayout.elements
{
   public class TextRange
   {
       
      
      private var _textFlow:TextFlow;
      
      private var _anchorPosition:int;
      
      private var _activePosition:int;
      
      public function TextRange(root:TextFlow, anchorIndex:int, activeIndex:int)
      {
         super();
         this._textFlow = root;
         if(anchorIndex != -1 || activeIndex != -1)
         {
            anchorIndex = this.clampToRange(anchorIndex);
            activeIndex = this.clampToRange(activeIndex);
         }
         this._anchorPosition = anchorIndex;
         this._activePosition = activeIndex;
      }
      
      private function clampToRange(index:int) : int
      {
         if(index < 0)
         {
            return 0;
         }
         if(index > this._textFlow.textLength)
         {
            return this._textFlow.textLength;
         }
         return index;
      }
      
      public function updateRange(newAnchorPosition:int, newActivePosition:int) : Boolean
      {
         if(newAnchorPosition != -1 || newActivePosition != -1)
         {
            newAnchorPosition = this.clampToRange(newAnchorPosition);
            newActivePosition = this.clampToRange(newActivePosition);
         }
         if(this._anchorPosition != newAnchorPosition || this._activePosition != newActivePosition)
         {
            this._anchorPosition = newAnchorPosition;
            this._activePosition = newActivePosition;
            return true;
         }
         return false;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function set textFlow(value:TextFlow) : void
      {
         this._textFlow = value;
      }
      
      public function get anchorPosition() : int
      {
         return this._anchorPosition;
      }
      
      public function set anchorPosition(value:int) : void
      {
         this._anchorPosition = value;
      }
      
      public function get activePosition() : int
      {
         return this._activePosition;
      }
      
      public function set activePosition(value:int) : void
      {
         this._activePosition = value;
      }
      
      public function get absoluteStart() : int
      {
         return this._activePosition < this._anchorPosition ? int(this._activePosition) : int(this._anchorPosition);
      }
      
      public function set absoluteStart(value:int) : void
      {
         if(this._activePosition < this._anchorPosition)
         {
            this._activePosition = value;
         }
         else
         {
            this._anchorPosition = value;
         }
      }
      
      public function get absoluteEnd() : int
      {
         return this._activePosition > this._anchorPosition ? int(this._activePosition) : int(this._anchorPosition);
      }
      
      public function set absoluteEnd(value:int) : void
      {
         if(this._activePosition > this._anchorPosition)
         {
            this._activePosition = value;
         }
         else
         {
            this._anchorPosition = value;
         }
      }
   }
}
