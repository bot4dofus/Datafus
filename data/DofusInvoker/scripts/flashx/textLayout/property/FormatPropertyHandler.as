package flashx.textLayout.property
{
   [ExcludeClass]
   public class FormatPropertyHandler extends PropertyHandler
   {
       
      
      private var _converter:Function;
      
      public function FormatPropertyHandler()
      {
         super();
      }
      
      public function get converter() : Function
      {
         return this._converter;
      }
      
      public function set converter(val:Function) : void
      {
         this._converter = val;
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         return newVal is String ? undefined : newVal;
      }
      
      override public function setHelper(newVal:*) : *
      {
         return this._converter(newVal);
      }
   }
}
