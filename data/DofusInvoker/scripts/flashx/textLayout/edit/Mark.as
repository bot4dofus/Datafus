package flashx.textLayout.edit
{
   [ExcludeClass]
   public class Mark
   {
       
      
      private var _position:int;
      
      public function Mark(value:int = 0)
      {
         super();
         this._position = value;
      }
      
      public function get position() : int
      {
         return this._position;
      }
      
      public function set position(value:int) : void
      {
         this._position = value;
      }
   }
}
