package org.flintparticles.common.energyEasing
{
   public class Quadratic
   {
       
      
      public function Quadratic()
      {
         super();
      }
      
      public static function easeIn(age:Number, lifetime:Number) : Number
      {
         return 1 - (age = age / lifetime) * age;
      }
      
      public static function easeOut(age:Number, lifetime:Number) : Number
      {
         return (age = 1 - age / lifetime) * age;
      }
      
      public static function easeInOut(age:Number, lifetime:Number) : Number
      {
         if((age = age / (lifetime * 0.5)) < 1)
         {
            return 1 - age * age * 0.5;
         }
         return (age = age - 2) * age * 0.5;
      }
   }
}
