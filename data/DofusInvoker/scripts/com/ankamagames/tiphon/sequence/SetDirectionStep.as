package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class SetDirectionStep extends AbstractSequencable
   {
       
      
      private var _nDirection:uint;
      
      private var _target:TiphonSprite;
      
      private var _cellToTarget:MapPoint;
      
      public function SetDirectionStep(target:TiphonSprite, nDirection:uint, cellToTarget:MapPoint = null)
      {
         super();
         this._target = target;
         this._nDirection = nDirection;
         this._cellToTarget = cellToTarget;
      }
      
      override public function start() : void
      {
         if(this._target as IEntity && (this._target as IEntity).position && this._cellToTarget)
         {
            if((this._target as IEntity).position.cellId == this._cellToTarget.cellId)
            {
               executeCallbacks();
               return;
            }
            this._nDirection = (this._target as IEntity).position.advancedOrientationTo(this._cellToTarget);
         }
         if(!this._target.getAnimation() || this._target.hasAnimation(this._target.getAnimation(),this._nDirection))
         {
            this._target.setDirection(this._nDirection);
         }
         else
         {
            _log.error("[SetDirectionStep] La direction " + this._nDirection + " n\'est pas disponible sur l\'animation " + this._target.getAnimation() + " du bones " + this._target.look.getBone());
         }
         executeCallbacks();
      }
      
      override public function toString() : String
      {
         return "set direction " + this._nDirection + " on " + this._target.name;
      }
   }
}
