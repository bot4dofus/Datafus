package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.jerakine.managers.OptionManager;
   
   public class FightActionPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public static const COLOR:uint = 255;
      
      private static const BLOCKING:Boolean = false;
       
      
      private var _intValue:int;
      
      private var _voluntarlyUsed:Boolean;
      
      private var _updateFighterInfos:Boolean;
      
      private var _showChatmessage:Boolean;
      
      public function FightActionPointsVariationStep(entityId:Number, value:int, voluntarlyUsed:Boolean, updateFighterInfos:Boolean = true, showChatmessage:Boolean = true)
      {
         updateFighterInfos = false;
         super(COLOR,value > 0 ? "+" + value : value.toString(),entityId,GameContextEnum.FIGHT,BLOCKING);
         this._showChatmessage = showChatmessage;
         this._intValue = value;
         this._voluntarlyUsed = voluntarlyUsed;
         _virtual = this._voluntarlyUsed && !OptionManager.getOptionManager("dofus").getOption("showUsedPaPm");
         this._updateFighterInfos = updateFighterInfos;
      }
      
      public function get stepType() : String
      {
         return "actionPointsVariation";
      }
      
      public function get value() : int
      {
         return this._intValue;
      }
      
      public function get voluntarlyUsed() : Boolean
      {
         return this._voluntarlyUsed;
      }
      
      override public function start() : void
      {
         if(this._updateFighterInfos)
         {
            if(this._voluntarlyUsed)
            {
            }
         }
         SpellWrapper.refreshAllPlayerSpellHolder(_targetId);
         if(this._showChatmessage)
         {
            if(this._intValue > 0)
            {
               FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_GAINED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
            }
            else if(this._intValue < 0)
            {
               if(this._voluntarlyUsed)
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_USED,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
               }
               else
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_AP_LOST,[_targetId,Math.abs(this._intValue)],_targetId,castingSpellId,false,2);
               }
            }
         }
         super.start();
      }
   }
}
