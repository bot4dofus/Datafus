package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class FightChangeLookStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _newLook:TiphonEntityLook;
      
      public function FightChangeLookStep(fighterId:Number, newLook:TiphonEntityLook)
      {
         super();
         this._fighterId = fighterId;
         this._newLook = newLook;
      }
      
      public function get stepType() : String
      {
         return "changeLook";
      }
      
      override public function start() : void
      {
         var gcrelmsg:GameContextRefreshEntityLookMessage = new GameContextRefreshEntityLookMessage();
         gcrelmsg.initGameContextRefreshEntityLookMessage(this._fighterId,EntityLookAdapter.toNetwork(this._newLook));
         Kernel.getWorker().getFrame(FightEntitiesFrame).process(gcrelmsg);
         this._newLook = TiphonUtility.getLookWithoutMount(this._newLook);
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CHANGE_LOOK,[this._fighterId,this._newLook],this._fighterId,castingSpellId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
