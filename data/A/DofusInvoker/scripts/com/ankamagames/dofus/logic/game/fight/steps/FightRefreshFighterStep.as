package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightRefreshFighterStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _infos:GameContextActorInformations;
      
      public function FightRefreshFighterStep(pFighterInfos:GameContextActorInformations)
      {
         super();
         this._infos = pFighterInfos;
      }
      
      public function get stepType() : String
      {
         return "refreshFighter";
      }
      
      override public function start() : void
      {
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var currentFighterInfos:GameContextActorInformations = fightEntitiesFrame.getEntityInfos(this._infos.contextualId);
         if(currentFighterInfos)
         {
            currentFighterInfos.disposition = this._infos.disposition;
            currentFighterInfos.look = this._infos.look;
            fightEntitiesFrame.setRealFighterLook(currentFighterInfos.contextualId,this._infos.look);
            fightEntitiesFrame.updateActor(currentFighterInfos,true);
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._infos.contextualId];
      }
   }
}
