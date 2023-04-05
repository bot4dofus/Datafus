package com.ankamagames.dofus.misc
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.entities.behaviours.movements.AnimatedMovementBehavior;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class BenchmarkMovementBehavior extends AnimatedMovementBehavior
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BenchmarkMovementBehavior));
      
      private static var _self:BenchmarkMovementBehavior;
      
      private static const RUN_LINEAR_VELOCITY:Number = 1 / 170;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 255;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 212.5;
      
      private static const RUN_ANIMATION:String = AnimationEnum.ANIM_COURSE;
       
      
      public function BenchmarkMovementBehavior()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : RunningMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
      }
      
      public static function getInstance() : BenchmarkMovementBehavior
      {
         if(!_self)
         {
            _self = new BenchmarkMovementBehavior();
         }
         return _self;
      }
      
      public static function getRandomCell() : MapPoint
      {
         var count:uint = 40;
         var mapPoint:MapPoint = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
         while(!MapPoint.isInMap(mapPoint.x,mapPoint.y) && --count)
         {
            mapPoint = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
         }
         return mapPoint;
      }
      
      public static function getRandomPath(entity:IMovable) : MovementPath
      {
         var j:int = 0;
         var movementPath:MovementPath = new MovementPath();
         movementPath.start = entity.position;
         var freeCells:Array = new Array();
         for(var i:int = -1; i < 2; i++)
         {
            for(j = -1; j < 2; j++)
            {
               if(MapPoint.isInMap(movementPath.start.x + i,movementPath.start.y + j) && (i != 0 || j != 0) && DataMapProvider.getInstance().pointMov(movementPath.start.x + i,movementPath.start.y + j))
               {
                  freeCells.push(MapPoint.fromCoords(movementPath.start.x + i,movementPath.start.y + j));
               }
            }
         }
         movementPath.end = freeCells[Math.floor(Math.random() * freeCells.length)];
         var pathElement:PathElement = new PathElement();
         pathElement.step = movementPath.start;
         pathElement.orientation = movementPath.start.orientationTo(movementPath.end);
         movementPath.addPoint(pathElement);
         return movementPath;
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
      
      override protected function stopMovement(entity:IMovable) : void
      {
         super.stopMovement(entity);
         var path:MovementPath = getRandomPath(entity);
         if(path.path.length > 0)
         {
            entity.move(path);
         }
         else
         {
            stop(entity,true);
            AnimatedCharacter(entity).remove();
         }
      }
   }
}
