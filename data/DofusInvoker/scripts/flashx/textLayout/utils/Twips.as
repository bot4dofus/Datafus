package flashx.textLayout.utils
{
   [ExcludeClass]
   public final class Twips
   {
      
      public static const ONE_TWIP:Number = 0.05;
      
      public static const TWIPS_PER_PIXEL:int = 20;
      
      public static const MAX_VALUE:int = int.MAX_VALUE;
      
      public static const MIN_VALUE:int = int.MIN_VALUE;
       
      
      public function Twips()
      {
         super();
      }
      
      public static function to(n:Number) : int
      {
         return int(n * 20);
      }
      
      public static function roundTo(n:Number) : int
      {
         return int(Math.round(n) * 20);
      }
      
      public static function from(t:int) : Number
      {
         return Number(t) / 20;
      }
      
      public static function ceil(n:Number) : Number
      {
         return Math.ceil(n * 20) / 20;
      }
      
      public static function floor(n:Number) : Number
      {
         return Math.floor(n * 20) / 20;
      }
      
      public static function round(n:Number) : Number
      {
         return Math.round(n * 20) / 20;
      }
   }
}
