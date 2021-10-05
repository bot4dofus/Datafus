package damageCalculation.tools
{
   public class Interval
   {
       
      
      public var min:int;
      
      public var max:int;
      
      public function Interval(param1:int = 0, param2:int = 0)
      {
         min = param1;
         max = param2;
      }
      
      public function toString() : String
      {
         return "[" + min + " - " + max + "]";
      }
      
      public function toArray() : Array
      {
         return [min,max];
      }
      
      public function subInterval(param1:Interval) : Interval
      {
         min -= param1.min;
         max -= param1.max;
         return this;
      }
      
      public function setToZero() : Interval
      {
         min = 0;
         max = 0;
         return this;
      }
      
      public function multiplyInterval(param1:Interval) : Interval
      {
         min *= param1.min;
         max *= param1.max;
         return this;
      }
      
      public function multiply(param1:Number) : Interval
      {
         min *= param1;
         max *= param1;
         return this;
      }
      
      public function minimizeByInterval(param1:Interval) : Interval
      {
         if(min < param1.min)
         {
            min = param1.min;
         }
         if(max < param1.max)
         {
            max = param1.max;
         }
         return this;
      }
      
      public function minimizeBy(param1:int) : Interval
      {
         if(min < param1)
         {
            min = param1;
         }
         if(max < param1)
         {
            max = param1;
         }
         return this;
      }
      
      public function maximizeByInterval(param1:Interval) : Interval
      {
         if(min > param1.min)
         {
            min = param1.min;
         }
         if(max > param1.max)
         {
            max = param1.max;
         }
         return this;
      }
      
      public function maximizeBy(param1:int) : Interval
      {
         if(min > param1)
         {
            min = param1;
         }
         if(max > param1)
         {
            max = param1;
         }
         return this;
      }
      
      public function isZero() : Boolean
      {
         if(min == 0)
         {
            return max == 0;
         }
         return false;
      }
      
      public function increaseByPercent(param1:int) : Interval
      {
         return multiply((100 + param1) / 100);
      }
      
      public function decreaseByPercent(param1:int) : Interval
      {
         return multiply((100 - param1) / 100);
      }
      
      public function copy() : Interval
      {
         return new Interval(min,max);
      }
      
      public function addInterval(param1:Interval) : Interval
      {
         min += param1.min;
         max += param1.max;
         return this;
      }
      
      public function add(param1:int) : Interval
      {
         min += param1;
         max += param1;
         return this;
      }
      
      public function abs() : Interval
      {
         if(min < 0)
         {
            min = -min;
         }
         if(max < 0)
         {
            max = -max;
         }
         return this;
      }
   }
}
