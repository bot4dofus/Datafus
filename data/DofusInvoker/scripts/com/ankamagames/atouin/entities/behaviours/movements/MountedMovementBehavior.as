package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class MountedMovementBehavior extends AnimatedMovementBehavior
   {
      
      private static const RUN_LINEAR_VELOCITY:Number = 1 / 135;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 200;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 120;
      
      private static const RUN_ANIMATION:String = "AnimCourse";
      
      private static var _self:MountedMovementBehavior;
       
      
      public function MountedMovementBehavior()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : MountedMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
      }
      
      public static function getInstance() : MountedMovementBehavior
      {
         if(!_self)
         {
            _self = new MountedMovementBehavior();
         }
         return _self;
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
