package org.flintparticles.common.energyEasing
{
   public class Linear
   {
       
      
      public function Linear()
      {
         super();
      }
      
      public static function easeNone(age:Number, lifetime:Number) : Number
      {
         return 1 - age / lifetime;
      }
      
      public static function easeIn(age:Number, lifetime:Number) : Number
      {
         return 1 - age / lifetime;
      }
      
      public static function easeOut(age:Number, lifetime:Number) : Number
      {
         return 1 - age / lifetime;
      }
      
      public static function easeInOut(age:Number, lifetime:Number) : Number
      {
         return 1 - age / lifetime;
      }
   }
}
