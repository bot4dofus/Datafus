package flashx.textLayout.elements
{
   import flash.display.Sprite;
   
   public class CellContainer extends Sprite
   {
       
      
      private var _imeMode:String;
      
      private var _enableIME:Boolean;
      
      public var element:TableCellElement;
      
      public function CellContainer(imeEnabled:Boolean = true)
      {
         super();
         this._enableIME = imeEnabled;
      }
      
      public function get enableIME() : Boolean
      {
         return false;
      }
      
      public function set enableIME(value:Boolean) : void
      {
         this._enableIME = value;
      }
      
      public function get imeMode() : String
      {
         return this._imeMode;
      }
      
      public function set imeMode(value:String) : void
      {
         this._imeMode = value;
      }
   }
}
