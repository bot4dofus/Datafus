package flashx.textLayout.property
{
   [ExcludeClass]
   public class NumberPropertyHandler extends PropertyHandler
   {
       
      
      private var _minValue:Number;
      
      private var _maxValue:Number;
      
      private var _limits:String;
      
      public function NumberPropertyHandler(minValue:Number, maxValue:Number, limits:String = "allLimits")
      {
         super();
         this._minValue = minValue;
         this._maxValue = maxValue;
         this._limits = limits;
      }
      
      public function get minValue() : Number
      {
         return this._minValue;
      }
      
      public function get maxValue() : Number
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
         var newNumber:Number = newVal is String ? Number(parseFloat(newVal)) : Number(Number(newVal));
         if(isNaN(newNumber))
         {
            return undefined;
         }
         if(this.checkLowerLimit() && newNumber < this._minValue)
         {
            return undefined;
         }
         if(this.checkUpperLimit() && newNumber > this._maxValue)
         {
            return undefined;
         }
         return newNumber;
      }
      
      public function clampToRange(val:Number) : Number
      {
         if(this.checkLowerLimit() && val < this._minValue)
         {
            return this._minValue;
         }
         if(this.checkUpperLimit() && val > this._maxValue)
         {
            return this._maxValue;
         }
         return val;
      }
   }
}
