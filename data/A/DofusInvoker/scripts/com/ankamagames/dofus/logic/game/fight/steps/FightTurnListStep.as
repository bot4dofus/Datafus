package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   
   public class FightTurnListStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _throwSubSequence:ISequencer;
      
      private var _newTurnsList:Vector.<Number>;
      
      private var _newDeadTurnsList:Vector.<Number>;
      
      private var _turnsList:Vector.<Number>;
      
      private var _deadTurnsList:Vector.<Number>;
      
      public function FightTurnListStep(turnsList:Vector.<Number>, deadTurnsList:Vector.<Number>)
      {
         super();
         this._turnsList = turnsList;
         this._deadTurnsList = deadTurnsList;
      }
      
      public function get stepType() : String
      {
         return "turnList";
      }
      
      override public function start() : void
      {
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fbf)
         {
            fbf.fightersList = this._turnsList;
            fbf.deadFightersList = this._deadTurnsList;
         }
         KernelEventsManager.getInstance().processCallback(HookList.FightersListUpdated);
         if(Dofus.getInstance().options.getOption("orderFighters") && Kernel.getWorker().getFrame(FightEntitiesFrame))
         {
            (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).updateAllEntitiesNumber(this._turnsList);
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return this._turnsList;
      }
   }
}
