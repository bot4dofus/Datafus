package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.scripts.ScriptsUtil;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   
   public class MoveStep extends AbstractSequencable
   {
       
      
      private var _entity:AnimatedCharacter;
      
      private var _args:Array;
      
      private var _behavior:IMovementBehavior;
      
      private var _allowDiag:Boolean;
      
      public function MoveStep(pEntity:AnimatedCharacter, pArgs:Array, pMovementBehavior:IMovementBehavior = null)
      {
         super();
         this._entity = pEntity;
         this._args = pArgs;
         if(pMovementBehavior)
         {
            this._behavior = pMovementBehavior;
         }
         this._allowDiag = true;
         for(var i:int = 0; i <= 6; )
         {
            if(!this._entity.hasAnimation(AnimationEnum.ANIM_MARCHE,i) || !this._entity.hasAnimation(AnimationEnum.ANIM_COURSE,i))
            {
               this._allowDiag = false;
               break;
            }
            i += 2;
         }
         timeout = 20000;
      }
      
      override public function start() : void
      {
         TooltipManager.hide("textBubble" + this._entity.id);
         TooltipManager.hide("smiley" + this._entity.id);
         if(this._entity.isMoving)
         {
            this._entity.stop();
         }
         var path:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),this._entity.position,ScriptsUtil.getMapPoint(this._args),this._allowDiag,true);
         if(this._behavior)
         {
            this._entity.movementBehavior = this._behavior;
            this._behavior.move(this._entity,path,this.onMovementEnd);
         }
         else
         {
            this._entity.move(path,this.onMovementEnd);
         }
      }
      
      private function onMovementEnd() : void
      {
         executeCallbacks();
      }
   }
}
