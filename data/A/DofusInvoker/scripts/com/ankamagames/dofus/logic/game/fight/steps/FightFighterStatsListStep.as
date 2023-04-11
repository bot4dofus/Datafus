package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class FightFighterStatsListStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _playerId:Number;
      
      private var _stats:CharacterCharacteristicsInformations;
      
      public function FightFighterStatsListStep(stats:CharacterCharacteristicsInformations)
      {
         super();
         this._stats = stats;
      }
      
      public function get stepType() : String
      {
         return "fighterStatsList";
      }
      
      override public function start() : void
      {
         this._playerId = PlayedCharacterManager.getInstance().id;
         var isRealPlayer:Boolean = CurrentPlayedFighterManager.getInstance().isRealPlayer();
         CurrentPlayedFighterManager.getInstance().setCharacteristicsInformations(this._playerId,this._stats);
         var characterFrame:PlayedCharacterUpdatesFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
         if(characterFrame && isRealPlayer)
         {
            characterFrame.updateCharacterStatsList(this._stats);
         }
         SpellWrapper.refreshAllPlayerSpellHolder(this._playerId);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._playerId];
      }
      
      private function displayDetailedStatsDifferences(oldStat:CharacterCharacteristicDetailed, newStat:CharacterCharacteristicDetailed) : String
      {
         var characterBaseCharacteristicChangeDetails:String = "";
         if(newStat.base != oldStat.base)
         {
            characterBaseCharacteristicChangeDetails += "\r        - base : " + oldStat.base + " à " + newStat.base;
         }
         if(newStat.additional != oldStat.additional)
         {
            characterBaseCharacteristicChangeDetails += "\r        - additional : " + oldStat.additional + " à " + newStat.additional;
         }
         if(newStat.objectsAndMountBonus != oldStat.objectsAndMountBonus)
         {
            characterBaseCharacteristicChangeDetails += "\r        - objectsAndMountBonus : " + oldStat.objectsAndMountBonus + " à " + newStat.objectsAndMountBonus;
         }
         if(newStat.alignGiftBonus != oldStat.alignGiftBonus)
         {
            characterBaseCharacteristicChangeDetails += "\r        - alignGiftBonus : " + oldStat.alignGiftBonus + " à " + newStat.alignGiftBonus;
         }
         if(newStat.contextModif != oldStat.contextModif)
         {
            characterBaseCharacteristicChangeDetails += "\r        - contextModif : " + oldStat.contextModif + " à " + newStat.contextModif;
         }
         return characterBaseCharacteristicChangeDetails;
      }
   }
}
