package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   
   public class FightSpellCastStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _fighterId:Number;
      
      private var _cellId:int;
      
      private var _sourceCellId:int;
      
      private var _spellId:int;
      
      private var _spellRank:uint;
      
      private var _critical:uint;
      
      private var _portalIds:Vector.<int>;
      
      private var _verboseCast:Boolean;
      
      public function FightSpellCastStep(fighterId:Number, cellId:int, sourceCellId:int, spellId:int, spellRank:uint, critical:uint, verboseCast:Boolean)
      {
         super();
         this._fighterId = fighterId;
         this._cellId = cellId;
         this._sourceCellId = sourceCellId;
         this._spellId = spellId;
         this._spellRank = spellRank;
         this._critical = critical;
         this._verboseCast = verboseCast;
      }
      
      public function get stepType() : String
      {
         return "spellCast";
      }
      
      override public function start() : void
      {
         var fighterInfos:GameFightFighterInformations = null;
         var seq:SerialSequencer = null;
         var bubble:ChatBubble = null;
         var fighterEntity:IDisplayable = null;
         if(Spell.getSpellById(this._spellId).verbose_cast && this._verboseCast)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CASTED_SPELL,[this._fighterId,this._cellId,this._sourceCellId,this._spellId,this._spellRank,this._critical],0,castingSpellId,false);
         }
         if(this._critical != FightSpellCastCriticalEnum.NORMAL)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            seq = new SerialSequencer();
            if(this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT && fighterInfos.disposition.cellId != -1)
            {
               seq.addStep(new AddGfxEntityStep(1062,fighterInfos.disposition.cellId));
            }
            else if(this._critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
            {
               bubble = new ChatBubble(I18n.getUiText("ui.fight.criticalMiss"));
               fighterEntity = DofusEntities.getEntity(this._fighterId) as IDisplayable;
               if(fighterEntity)
               {
                  TooltipManager.show(bubble,fighterEntity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"ec" + this._fighterId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null);
               }
               seq.addStep(new AddGfxEntityStep(1070,fighterInfos.disposition.cellId));
            }
            seq.start();
         }
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._fighterId];
      }
   }
}
