package com.ankamagames.atouin.entities.behaviours.movements
{
   public class MountedMovementBehavior extends AnimatedMovementBehavior
   {
      
      private static const RUN_LINEAR_VELOCITY:Number = 1 / 135;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 200;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 120;
      
      private static const RUN_ANIMATION:String = "AnimCourse";
       
      
      public function MountedMovementBehavior()
      {
         super();
      }
      
      public static function getInstance(speedAdjust:Number = 0.0) : MountedMovementBehavior
      {
         return getFromCache(speedAdjust,MountedMovementBehavior) as MountedMovementBehavior;
      }
      
      override protected function getLinearVelocity() : Number
      {
         return RUN_LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number
      {
         return RUN_HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number
      {
         return RUN_VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String
      {
         return RUN_ANIMATION;
      }
   }
}
