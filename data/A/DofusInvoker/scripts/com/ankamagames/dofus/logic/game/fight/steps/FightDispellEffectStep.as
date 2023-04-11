package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.ISequencableListener;
   
   public class FightDispellEffectStep extends AbstractSequencable implements IFightStep, ISequencableListener
   {
       
      
      private var _fighterId:Number;
      
      private var _boostUID:int;
      
      private var _virtualStep:IFightStep;
      
      public function FightDispellEffectStep(fighterId:Number, boostUID:int)
      {
         super();
         this._fighterId = fighterId;
         this._boostUID = boostUID;
      }
      
      public function get stepType() : String
      {
         return "dispellEffect";
      }
      
      override public function start() : void
      {
         var sb:StateBuff = null;
         var buff:BasicBuff = BuffManager.getInstance().getBuff(this._boostUID,this._fighterId);
         if(buff && buff is StateBuff)
         {
            sb = buff as StateBuff;
            if(sb.actionId == ActionIds.ACTION_FIGHT_DISABLE_STATE)
            {
               this._virtualStep = new FightEnteringStateStep(sb.targetId,sb.stateId,sb.effect.durationString,buff);
            }
            else
            {
               this._virtualStep = new FightLeavingStateStep(sb.targetId,sb.stateId,buff);
            }
         }
         BuffManager.getInstance().dispellUniqueBuff(this._fighterId,this._boostUID,true,false,true);
         if(!this._virtualStep)
         {
            executeCallbacks();
         }
         else
         {
            this._virtualStep.addListener(this);
            this._virtualStep.start();
         }
      }
      
      public function stepFinished(step:ISequencable, withTimout:Boolean = false) : void
      {
         this._virtualStep.removeListener(this);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
