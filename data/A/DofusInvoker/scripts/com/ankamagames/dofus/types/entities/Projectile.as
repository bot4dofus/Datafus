package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.ParableMovementBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.interfaces.ITransparency;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class Projectile extends TiphonSprite implements IDisplayable, IMovable, IEntity, ITransparency
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Projectile));
       
      
      private var _id:Number;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _displayBehavior:IDisplayBehavior;
      
      private var _movementBehavior:IMovementBehavior;
      
      private var _transparencyAllowed:Boolean = true;
      
      public var startPlayingOnlyWhenDisplayed:Boolean;
      
      public function Projectile(nId:Number, look:TiphonEntityLook, postInit:Boolean = false, startPlayingOnlyWhenDisplayed:Boolean = true)
      {
         super(look);
         this.startPlayingOnlyWhenDisplayed = startPlayingOnlyWhenDisplayed;
         this.id = nId;
         if(!postInit)
         {
            this.initDirection();
         }
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void
      {
         this._displayBehavior = oValue;
      }
      
      public function get movementBehavior() : IMovementBehavior
      {
         return this._movementBehavior;
      }
      
      public function set movementBehavior(oValue:IMovementBehavior) : void
      {
         this._movementBehavior = oValue;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function set id(nValue:Number) : void
      {
         this._id = nValue;
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void
      {
         this._position = oValue;
      }
      
      public function get isMoving() : Boolean
      {
         return this._movementBehavior.isMoving(this);
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function getIsTransparencyAllowed() : Boolean
      {
         return this._transparencyAllowed;
      }
      
      public function set transparencyAllowed(allowed:Boolean) : void
      {
         this._transparencyAllowed = allowed;
      }
      
      public function initDirection(direction:int = -1) : void
      {
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this._movementBehavior = ParableMovementBehavior.getInstance();
         setDirection(direction == -1 ? uint(DirectionsEnum.RIGHT) : uint(direction));
         if(!this.startPlayingOnlyWhenDisplayed || parent)
         {
            this.setAnim();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onProjectileAdded);
         }
      }
      
      public function display(strata:uint = 0) : void
      {
         this._displayBehavior.display(this,strata);
         this._displayed = true;
      }
      
      public function remove() : void
      {
         this._displayed = false;
         this._displayBehavior.remove(this);
         clearAnimation();
      }
      
      override public function destroy() : void
      {
         this.remove();
         super.destroy();
      }
      
      public function move(path:MovementPath, callback:Function = null, movementBehavior:IMovementBehavior = null) : void
      {
         this._movementBehavior.move(this,path,callback);
      }
      
      public function jump(newPosition:MapPoint) : void
      {
         this._movementBehavior.jump(this,newPosition);
      }
      
      public function stop(forceStop:Boolean = false) : void
      {
         this._movementBehavior.stop(this);
      }
      
      private function setAnim() : void
      {
         setAnimation("FX");
      }
      
      private function onProjectileAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onProjectileAdded);
         this.setAnim();
      }
   }
}
