package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.EntityMovementStartMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.atouin.types.TweenEntityData;
   import com.ankamagames.atouin.utils.errors.AtouinError;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.interfaces.ISoundPositionListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class AnimatedMovementBehavior implements IMovementBehavior
   {
      
      public static var updateRealtime:Boolean = true;
      
      public static var updateForcedFps:int = 50;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedMovementBehavior));
      
      protected static var _movingCount:uint;
      
      protected static var _aEntitiesMoving:Array = new Array();
      
      private static var _stoppingEntity:Dictionary = new Dictionary(true);
      
      private static var _enterFrameRegistered:Boolean;
      
      private static var _cellsManager:InteractiveCellManager = InteractiveCellManager.getInstance();
      
      protected static const _cache:Dictionary = new Dictionary();
       
      
      public var speedAdjust:Number = 0.0;
      
      public function AnimatedMovementBehavior()
      {
         super();
      }
      
      protected static function getFromCache(speedAdjust:Number, type:Class) : AnimatedMovementBehavior
      {
         var m:* = undefined;
         var newInstance:AnimatedMovementBehavior = null;
         if(!_cache[type])
         {
            _cache[type] = new Dictionary(true);
         }
         for(m in _cache[type])
         {
            if(AnimatedMovementBehavior(m).speedAdjust == speedAdjust)
            {
               return m;
            }
         }
         newInstance = new type() as AnimatedMovementBehavior;
         newInstance.speedAdjust = speedAdjust;
         _cache[type][newInstance] = true;
         return newInstance;
      }
      
      public function move(entity:IMovable, path:MovementPath, callback:Function = null) : void
      {
         var tweenData:TweenEntityData = new TweenEntityData();
         tweenData.path = path;
         tweenData.entity = entity;
         if(this.getAnimation())
         {
            tweenData.animation = this.getAnimation();
         }
         tweenData.linearVelocity = this.getLinearVelocity() * (this.speedAdjust / 10 + 1);
         tweenData.hDiagVelocity = this.getHorizontalDiagonalVelocity() * (this.speedAdjust / 10 + 1);
         tweenData.vDiagVelocity = this.getVerticalDiagonalVelocity() * (this.speedAdjust / 10 + 1);
         tweenData.callback = callback;
         this.initMovement(entity,tweenData);
         Atouin.getInstance().handler.process(new EntityMovementStartMessage(entity));
      }
      
      public function synchroniseSubEntitiesPosition(entityRef:IMovable, subEntityContainer:DisplayObject = null) : void
      {
         var ts:TiphonSprite = null;
         var carriedEntity:IMovable = null;
         var subEntities:Array = null;
         var subEntity:* = undefined;
         var mount:TiphonSprite = null;
         var subSubEntities:Array = null;
         var subSubEntity:* = undefined;
         if(entityRef is TiphonSprite)
         {
            ts = entityRef as TiphonSprite;
            if(subEntityContainer && subEntityContainer is TiphonSprite)
            {
               ts = TiphonSprite(subEntityContainer);
            }
            if(ts.carriedEntity)
            {
               carriedEntity = ts.carriedEntity as IMovable;
            }
            else
            {
               mount = ts.getSubEntitySlot(2,0) as TiphonSprite;
               if(mount && mount.carriedEntity)
               {
                  carriedEntity = mount.carriedEntity as IMovable;
               }
            }
            while(carriedEntity)
            {
               if(carriedEntity.position && entityRef.position)
               {
                  carriedEntity.position.x = entityRef.position.x;
                  carriedEntity.position.y = entityRef.position.y;
                  carriedEntity.position.cellId = entityRef.position.cellId;
               }
               carriedEntity = (carriedEntity as TiphonSprite).carriedEntity as IMovable;
            }
            subEntities = ts.getSubEntitiesList();
            for each(subEntity in subEntities)
            {
               if(subEntity is IMovable)
               {
                  if(subEntity.position && entityRef.position)
                  {
                     subEntity.position.x = entityRef.position.x;
                     subEntity.position.y = entityRef.position.y;
                  }
                  if(subEntity.movementBehavior && subEntity != entityRef)
                  {
                     subEntity.movementBehavior.synchroniseSubEntitiesPosition(subEntity);
                  }
               }
               else if(subEntity is TiphonSprite)
               {
                  subSubEntities = TiphonSprite(subEntity).getSubEntitiesList();
                  for each(subSubEntity in subSubEntities)
                  {
                     if(subSubEntity is IMovable && subSubEntity.movementBehavior && subSubEntity != entityRef)
                     {
                        IMovable(subSubEntity).movementBehavior.synchroniseSubEntitiesPosition(entityRef,subEntity);
                     }
                  }
               }
            }
         }
      }
      
      public function jump(entity:IMovable, newPosition:MapPoint) : void
      {
         this.processJump(entity,newPosition);
      }
      
      public function stop(entity:IMovable, forceStop:Boolean = false) : void
      {
         var animsList:Array = null;
         if(forceStop)
         {
            animsList = (entity as TiphonSprite).animationList;
            if(animsList && animsList.indexOf("AnimStatique") != -1)
            {
               IAnimated(entity).setAnimation("AnimStatique");
            }
            _aEntitiesMoving[entity.id] = null;
            delete _aEntitiesMoving[entity.id];
         }
         else
         {
            _stoppingEntity[entity] = true;
         }
      }
      
      public function isMoving(entity:IMovable) : Boolean
      {
         return _aEntitiesMoving[entity.id] != null;
      }
      
      public function getNextCell(entity:IMovable) : MapPoint
      {
         return _aEntitiesMoving[entity.id] != null ? TweenEntityData(_aEntitiesMoving[entity.id]).nextCell : null;
      }
      
      protected function getLinearVelocity() : Number
      {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getHorizontalDiagonalVelocity() : Number
      {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getVerticalDiagonalVelocity() : Number
      {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function getAnimation() : String
      {
         throw new AtouinError("Abstract function call.");
      }
      
      protected function mustChangeOrientation() : Boolean
      {
         return true;
      }
      
      protected function initMovement(oMobile:IMovable, tweenData:TweenEntityData, wasLinked:Boolean = false) : void
      {
         var firstPe:PathElement = null;
         if(_aEntitiesMoving[oMobile.id] != null)
         {
            _log.warn("Moving an already moving entity. Replacing the previous move.");
            --_movingCount;
         }
         _aEntitiesMoving[oMobile.id] = tweenData;
         ++_movingCount;
         if(!wasLinked)
         {
            firstPe = tweenData.path.path.shift();
            if(this.mustChangeOrientation() && firstPe)
            {
               tweenData.orientation = firstPe.orientation;
               IAnimated(oMobile).setAnimationAndDirection(tweenData.animation,firstPe.orientation);
            }
            else
            {
               IAnimated(oMobile).setAnimation(tweenData.animation);
            }
         }
         delete _stoppingEntity[oMobile];
         this.goNextCell(oMobile);
         this.checkIfEnterFrameNeeded();
      }
      
      protected function goNextCell(entity:IMovable) : void
      {
         var pe:PathElement = null;
         var tweenData:TweenEntityData = _aEntitiesMoving[entity.id];
         tweenData.currentCell = entity.position;
         if(_stoppingEntity[entity])
         {
            this.stopMovement(entity);
            Atouin.getInstance().handler.process(new EntityMovementStoppedMessage(entity));
            delete _stoppingEntity[entity];
            return;
         }
         if(tweenData.path.path.length > 0)
         {
            pe = tweenData.path.path.shift() as PathElement;
            if(this.mustChangeOrientation())
            {
               IAnimated(entity).setAnimationAndDirection(tweenData.animation,tweenData.orientation);
            }
            else
            {
               IAnimated(entity).setAnimation(tweenData.animation);
            }
            tweenData.velocity = this.getVelocity(tweenData,tweenData.orientation);
            tweenData.nextCell = pe.step;
            if(this.mustChangeOrientation() && pe)
            {
               tweenData.orientation = pe.orientation;
            }
            tweenData.start = this.getCurrentTime();
         }
         else if(!tweenData.currentCell.equals(tweenData.path.end))
         {
            tweenData.velocity = this.getVelocity(tweenData,IAnimated(entity).getDirection());
            if(this.mustChangeOrientation() && tweenData.orientation != -1)
            {
               IAnimated(entity).setDirection(tweenData.orientation);
            }
            tweenData.nextCell = tweenData.path.end;
            tweenData.start = this.getCurrentTime();
         }
         else
         {
            this.stopMovement(entity);
            (Atouin.getInstance().handler as Worker).processImmediately(new EntityMovementCompleteMessage(entity));
         }
         tweenData.barycentre = 0;
      }
      
      protected function stopMovement(entity:IMovable) : void
      {
         if(IAnimated(entity).getAnimation() != "AnimMort")
         {
            IAnimated(entity).setAnimation("AnimStatique");
         }
         var callback:Function = (_aEntitiesMoving[entity.id] as TweenEntityData).callback;
         delete _aEntitiesMoving[entity.id];
         --_movingCount;
         this.checkIfEnterFrameNeeded();
         if(callback != null)
         {
            callback();
         }
      }
      
      private function getVelocity(ted:TweenEntityData, orientation:uint) : Number
      {
         if(orientation % 2 == 0)
         {
            if(orientation % 4 == 0)
            {
               return ted.hDiagVelocity;
            }
            return ted.vDiagVelocity;
         }
         return ted.linearVelocity;
      }
      
      protected function processMovement(tweenData:TweenEntityData, currentTime:uint) : void
      {
         var listener:ISoundPositionListener = null;
         var newPoint:Point = null;
         tweenData.barycentre = tweenData.velocity * (currentTime - tweenData.start);
         if(tweenData.barycentre > 1)
         {
            tweenData.barycentre = 1;
         }
         if(!tweenData.currentCellSprite)
         {
            tweenData.currentCellSprite = _cellsManager.getCell(tweenData.currentCell.cellId);
            tweenData.nextCellSprite = _cellsManager.getCell(tweenData.nextCell.cellId);
         }
         var displayObject:DisplayObject = DisplayObject(tweenData.entity);
         displayObject.x = (1 - tweenData.barycentre) * tweenData.currentCellSprite.x + tweenData.barycentre * tweenData.nextCellSprite.x + tweenData.currentCellSprite.width / 2;
         displayObject.y = (1 - tweenData.barycentre) * tweenData.currentCellSprite.y + tweenData.barycentre * tweenData.nextCellSprite.y + tweenData.currentCellSprite.height / 2;
         for each(listener in Atouin.getInstance().movementListeners)
         {
            newPoint = new Point(displayObject.x,displayObject.y);
            listener.setSoundSourcePosition(tweenData.entity.id,newPoint);
         }
         if(!tweenData.wasOrdered && tweenData.barycentre > 0.5)
         {
            EntitiesDisplayManager.getInstance().orderEntity(displayObject,tweenData.nextCellSprite);
         }
         if(tweenData.barycentre >= 1)
         {
            tweenData.clear();
            IEntity(tweenData.entity).position = tweenData.nextCell;
            this.synchroniseSubEntitiesPosition(IMovable(tweenData.entity));
            this.goNextCell(IMovable(tweenData.entity));
         }
      }
      
      protected function processJump(entity:IMovable, newPosition:MapPoint) : void
      {
         var newCellSprite:Sprite = InteractiveCellManager.getInstance().getCell(newPosition.cellId);
         var displayObject:DisplayObject = entity as DisplayObject;
         displayObject.x = newCellSprite.x + newCellSprite.width / 2;
         displayObject.y = newCellSprite.y + newCellSprite.height / 2;
         if(displayObject.stage != null)
         {
            EntitiesDisplayManager.getInstance().orderEntity(displayObject,newCellSprite);
         }
         entity.position = newPosition;
         this.synchroniseSubEntitiesPosition(entity);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var tweenData:TweenEntityData = null;
         var currentTime:uint = this.getCurrentTime();
         for each(tweenData in _aEntitiesMoving)
         {
            this.processMovement(tweenData,currentTime);
         }
      }
      
      private function getCurrentTime() : int
      {
         return !!updateRealtime ? int(getTimer()) : int(FrameIdManager.frameId * 1000 / updateForcedFps);
      }
      
      protected function checkIfEnterFrameNeeded() : void
      {
         if(_movingCount == 0 && _enterFrameRegistered)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            _enterFrameRegistered = false;
         }
         else if(_movingCount > 0 && !_enterFrameRegistered)
         {
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.ANIMATED_MOVEMENT_BEHAVIOUR,50);
            _enterFrameRegistered = true;
         }
      }
   }
}
