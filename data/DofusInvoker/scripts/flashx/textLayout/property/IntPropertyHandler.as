package flashx.textLayout.property
{
   [ExcludeClass]
   public class IntPropertyHandler extends PropertyHandler
   {
       
      
      private var _minValue:int;
      
      private var _maxValue:int;
      
      private var _limits:String;
      
      public function IntPropertyHandler(minValue:int, maxValue:int, limits:String = "allLimits")
      {
         super();
         this._minValue = minValue;
         this._maxValue = maxValue;
         this._limits = limits;
      }
      
      public function get minValue() : int
      {
         return this._minValue;
      }
      
      public function get maxValue() : int
      {
         return this._maxValue;
      }
      
      public function checkLowerLimit() : Boolean
      {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.LOWER_LIMIT;
      }
      
      public function checkUpperLimit() : Boolean
      {
         return this._limits == Property.ALL_LIMITS || this._limits == Property.UPPER_LIMIT;
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         var newNumber:Number = newVal is String ? Number(parseInt(newVal)) : Number(int(newVal));
         if(isNaN(newNumber))
         {
            return undefined;
         }
         var newInt:int = int(newNumber);
         if(this.checkLowerLimit() && newInt < this._minValue)
         {
            return undefined;
         }
         if(this.checkUpperLimit() && newInt > this._maxValue)
         {
            return undefined;
         }
         return newInt;
      }
   }
}
