package damageCalculation.tools
{
   import mapTools.Point;
   
   public class MathUtils
   {
       
      
      public function MathUtils()
      {
      }
      
      public static function computeVector(param1:Point, param2:Point) : Point
      {
         return new Point(param2.x - param1.x,param2.y - param1.y);
      }
      
      public static function getDeterminant(param1:Point, param2:Point) : int
      {
         return param1.x * param2.y - param1.y * param2.x;
      }
      
      public static function getPositiveOrientedAngle(param1:Point, param2:Point, param3:Point) : Number
      {
         switch(MathUtils.compareAngles(param1,param2,param3).index)
         {
            case 0:
               return 0;
            case 1:
               return Math.PI;
            case 2:
               return Number(MathUtils.getAngle(param1,param2,param3));
            case 3:
               return 2 * Math.PI - MathUtils.getAngle(param1,param2,param3);
            default:
               return;
         }
      }
      
      public static function getAngle(param1:Point, param2:Point, param3:Point) : Number
      {
         var _loc4_:Number = Number(MathUtils.getDistanceBetweenPoints(param2,param3));
         var _loc5_:Number = Number(MathUtils.getDistanceBetweenPoints(param1,param2));
         var _loc6_:Number = Number(MathUtils.getDistanceBetweenPoints(param1,param3));
         return Number(Math.acos((_loc5_ * _loc5_ + _loc6_ * _loc6_ - _loc4_ * _loc4_) / (2 * _loc5_ * _loc6_)));
      }
      
      public static function getDistanceBetweenPoints(param1:Point, param2:Point) : Number
      {
         return Number(Math.sqrt(Number(Number(Math.pow(param1.x - param2.x,2)) + Number(Math.pow(param1.y - param2.y,2)))));
      }
      
      public static function compareAngles(param1:Point, param2:Point, param3:Point) : CompareAnglesEnum
      {
         var _loc4_:Point = MathUtils.computeVector(param1,param2);
         var _loc5_:Point = MathUtils.computeVector(param1,param3);
         var _loc6_:int = MathUtils.getDeterminant(_loc4_,_loc5_);
         if(_loc6_ != 0)
         {
            if(_loc6_ > 0)
            {
               return CompareAnglesEnum.CLOCKWISE;
            }
            return CompareAnglesEnum.COUNTERCLOCKWISE;
         }
         if(_loc4_.x >= 0 == _loc5_.x >= 0 && _loc4_.y >= 0 == _loc5_.y >= 0)
         {
            return CompareAnglesEnum.LIKE;
         }
         return CompareAnglesEnum.UNLIKE;
      }
      
      public static function roundWithPrecision(param1:Number, param2:Number) : Number
      {
         param1 *= Number(Math.pow(10,param2));
         return int(Math.round(param1)) / Math.pow(10,param2);
      }
   }
}
