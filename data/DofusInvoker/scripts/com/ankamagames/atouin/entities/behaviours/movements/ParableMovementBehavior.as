package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.TweenEntityData;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ParableMovementBehavior extends AnimatedMovementBehavior
   {
      
      private static const LINEAR_VELOCITY:Number = 1 / 400;
      
      private static const HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 500;
      
      private static const VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 450;
      
      private static const ANIMATION:String = "FX";
      
      private static var _curvePoint:Point;
      
      private static var _velocity:Number;
      
      private static var _angle:Number;
      
      private static var _self:ParableMovementBehavior;
       
      
      public function ParableMovementBehavior()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : ParableMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
      }
      
      public static function getInstance() : ParableMovementBehavior
      {
         if(!_self)
         {
            _self = new ParableMovementBehavior();
         }
         return _self;
      }
      
      override protected function getLinearVelocity() : Number
      {
         return LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number
      {
         return HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number
      {
         return VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String
      {
         return ANIMATION;
      }
      
      override public function move(entity:IMovable, path:MovementPath, callback:Function = null) : void
      {
         var tweenData:TweenEntityData = new TweenEntityData();
         tweenData.path = path;
         tweenData.entity = entity;
         var currentCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(tweenData.path.start.cellId);
         var nextCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(tweenData.path.end.cellId);
         var initPoint:Point = new Point(currentCellSprite.x,currentCellSprite.y);
         var finalPoint:Point = new Point(nextCellSprite.x,nextCellSprite.y);
         var distance:Number = Point.distance(initPoint,finalPoint);
         _curvePoint = Point.interpolate(initPoint,finalPoint,0.5);
         _curvePoint.y -= distance / 2;
         _velocity = 1 / (500 + path.start.distanceTo(path.end) * 50);
         _angle = this.checkAngle(initPoint,finalPoint);
         var displayObject:DisplayObject = DisplayObject(tweenData.entity);
         displayObject.rotation -= _angle + (90 - _angle) / 2;
         initMovement(entity,tweenData);
      }
      
      override protected function processMovement(tweenData:TweenEntityData, currentTime:uint) : void
      {
         var gravity2:Number = NaN;
         tweenData.barycentre = _velocity * (currentTime - tweenData.start);
         if(tweenData.barycentre > 1)
         {
            tweenData.barycentre = 1;
         }
         var displayObject:DisplayObject = DisplayObject(tweenData.entity);
         var currentCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(tweenData.currentCell.cellId);
         var nextCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(tweenData.nextCell.cellId);
         displayObject.x = (1 - tweenData.barycentre) * (1 - tweenData.barycentre) * currentCellSprite.x + 2 * (1 - tweenData.barycentre) * tweenData.barycentre * _curvePoint.x + tweenData.barycentre * tweenData.barycentre * nextCellSprite.x;
         displayObject.y = (1 - tweenData.barycentre) * (1 - tweenData.barycentre) * currentCellSprite.y + 2 * (1 - tweenData.barycentre) * tweenData.barycentre * _curvePoint.y + tweenData.barycentre * tweenData.barycentre * nextCellSprite.y;
         var initRotation:Number = -(_angle + (90 - _angle) / 2);
         var gravity:Number = 2.5 * (90 + initRotation) * tweenData.barycentre;
         displayObject.rotation = initRotation + gravity;
         if(nextCellSprite.y > currentCellSprite.y)
         {
            gravity2 = 2 * (90 + initRotation) * (1 - tweenData.barycentre);
            displayObject.rotation = -initRotation - gravity2;
         }
         displayObject.scaleX = 1 - tweenData.barycentre * (90 - Math.abs(90 - _angle)) / 90;
         if(!tweenData.wasOrdered && tweenData.barycentre > 0.5)
         {
            EntitiesDisplayManager.getInstance().orderEntity(displayObject,nextCellSprite);
         }
         if(tweenData.barycentre >= 1)
         {
            IEntity(tweenData.entity).position = tweenData.nextCell;
            goNextCell(IMovable(tweenData.entity));
            EntitiesManager.getInstance().removeEntity(IEntity(tweenData.entity).id);
         }
      }
      
      private function checkAngle(initPoint:Point, finalPoint:Point) : Number
      {
         var A:Number = Point.distance(initPoint,new Point(finalPoint.x,initPoint.y));
         var B:Number = Point.distance(initPoint,finalPoint);
         var angle:Number = Math.acos(A / B) * 180 / Math.PI;
         if(initPoint.x > finalPoint.x)
         {
            angle = 180 - angle;
         }
         return angle;
      }
   }
}
