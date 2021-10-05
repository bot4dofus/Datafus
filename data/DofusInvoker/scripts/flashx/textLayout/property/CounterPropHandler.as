package flashx.textLayout.property
{
   [ExcludeClass]
   public class CounterPropHandler extends PropertyHandler
   {
      
      private static const _orderedPattern:RegExp = /^\s*ordered(\s+-?\d+){0,1}\s*$/;
      
      private static const _orderedBeginPattern:RegExp = /^\s*ordered\s*/g;
       
      
      private var _defaultNumber:int;
      
      public function CounterPropHandler(defaultNumber:int)
      {
         super();
         this._defaultNumber = defaultNumber;
      }
      
      public function get defaultNumber() : int
      {
         return this._defaultNumber;
      }
      
      override public function get customXMLStringHandler() : Boolean
      {
         return true;
      }
      
      override public function toXMLString(val:Object) : String
      {
         return val["ordered"] == 1 ? "ordered" : "ordered " + val["ordered"];
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         return newVal is String && _orderedPattern.test(newVal) || newVal.hasOwnProperty("ordered") ? newVal : undefined;
      }
      
      override public function setHelper(newVal:*) : *
      {
         var s:String = newVal as String;
         if(s == null)
         {
            return newVal;
         }
         _orderedBeginPattern.lastIndex = 0;
         _orderedBeginPattern.test(s);
         var number:int = _orderedBeginPattern.lastIndex != s.length ? int(parseInt(s.substr(_orderedBeginPattern.lastIndex))) : int(this._defaultNumber);
         return {"ordered":number};
      }
   }
}
