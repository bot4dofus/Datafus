package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class FightMarkTriggeredStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _casterId:Number;
      
      private var _markId:int;
      
      public function FightMarkTriggeredStep(fighterId:Number, casterId:Number, markId:int)
      {
         super();
         this._fighterId = fighterId;
         this._casterId = casterId;
         this._markId = markId;
      }
      
      public function get stepType() : String
      {
         return "markTriggered";
      }
      
      override public function start() : void
      {
         var mi:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(!mi)
         {
            _log.error("Trying to trigger an unknown mark (" + this._markId + "). Aborting.");
            executeCallbacks();
            return;
         }
         var evt:String = FightEventEnum.UNKNOWN_FIGHT_EVENT;
         switch(mi.markType)
         {
            case GameActionMarkTypeEnum.GLYPH:
               evt = FightEventEnum.FIGHTER_TRIGGERED_GLYPH;
               break;
            case GameActionMarkTypeEnum.TRAP:
               evt = FightEventEnum.FIGHTER_TRIGGERED_TRAP;
               break;
            case GameActionMarkTypeEnum.PORTAL:
               evt = FightEventEnum.FIGHTER_TRIGGERED_PORTAL;
               break;
            default:
               _log.warn("Unknown mark type triggered (" + mi.markType + ").");
         }
         FightEventsHelper.sendFightEvent(evt,[this._fighterId,this._casterId,mi.associatedSpell.id],0,castingSpellId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
