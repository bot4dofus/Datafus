package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightTemporaryBoostStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _statName:String;
      
      private var _duration:int;
      
      private var _durationText:String;
      
      private var _visibleInLog:Boolean;
      
      private var _buff:BasicBuff;
      
      public function FightTemporaryBoostStep(fighterId:Number, statName:String, duration:int, durationText:String, visible:Boolean = true, buff:BasicBuff = null)
      {
         super();
         this._fighterId = fighterId;
         this._statName = statName;
         this._duration = duration;
         this._durationText = durationText;
         this._visibleInLog = visible;
         this._buff = buff;
      }
      
      public function get stepType() : String
      {
         return "temporaryBoost";
      }
      
      override public function start() : void
      {
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TEMPORARY_BOOSTED,[this._fighterId,this._statName,this._duration,this._durationText,this._visibleInLog],this._fighterId,castingSpellId,false,2,1,this._buff);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
