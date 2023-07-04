package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class FightHookList
   {
      
      public static const BuffUpdate:String = "BuffUpdate";
      
      public static const BuffRemove:String = "BuffRemove";
      
      public static const BuffDispell:String = "BuffDispell";
      
      public static const BuffAdd:String = "BuffAdd";
      
      public static const FighterSelected:String = "FighterSelected";
      
      public static const ChallengeListUpdate:String = "ChallengeListUpdate";
      
      public static const ChallengeModSelected:String = "ChallengeModSelected";
      
      public static const ChallengeBonusSelected:String = "ChallengeBonusSelected";
      
      public static const ChallengeSelected:String = "ChallengeSelected";
      
      public static const ChallengeProposal:String = "ChallengeProposal";
      
      public static const ChallengeProposalUpdateTimer:String = "ChallengeProposalUpdateTimer";
      
      public static const CloseChallengeProposal:String = "CloseChallengeProposal";
      
      public static const FightLeader:String = "FightLeader";
      
      public static const RemindTurn:String = "RemindTurn";
      
      public static const SpectatorWantLeave:String = "SpectatorWantLeave";
      
      public static const FightResultClosed:String = "FightResultClosed";
      
      public static const GameEntityDisposition:String = "GameEntityDisposition";
      
      public static const FighterInfoUpdate:String = "FighterInfoUpdate";
      
      public static const ReadyToFight:String = "ReadyToFight";
      
      public static const NotReadyToFight:String = "NotReadyToFight";
      
      public static const DematerializationChanged:String = "DematerializationChanged";
      
      public static const AfkModeChanged:String = "AfkModeChanged";
      
      public static const TurnCountUpdated:String = "TurnCountUpdated";
      
      public static const UpdatePreFightersList:String = "UpdatePreFightersList";
      
      public static const UpdateFightersLook:String = "UpdateFightersLook";
      
      public static const SlaveStatsList:String = "SlaveStatsList";
      
      public static const ShowMonsterArtwork:String = "ShowMonsterArtwork";
      
      public static const WaveUpdated:String = "WaveUpdated";
      
      public static const SpectateUpdate:String = "SpectateUpdate";
      
      public static const ShowSwapPositionRequestMenu:String = "ShowSwapPositionRequestMenu";
      
      public static const ArenaFighterLeave:String = "ArenaFighterLeave";
      
      public static const OpenFightResults:String = "OpenFightResults";
      
      public static const FighterRemoved:String = "FighterRemoved";
      
      public static const FightersInitiative:String = "FighterInitiative";
      
      public static const SlaveTurnStart:String = "SlaveTurnStart";
       
      
      public function FightHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(BuffUpdate);
         Hook.createHook(BuffRemove);
         Hook.createHook(BuffDispell);
         Hook.createHook(BuffAdd);
         Hook.createHook(FighterSelected);
         Hook.createHook(ChallengeListUpdate);
         Hook.createHook(ChallengeModSelected);
         Hook.createHook(ChallengeBonusSelected);
         Hook.createHook(ChallengeSelected);
         Hook.createHook(ChallengeProposal);
         Hook.createHook(ChallengeProposalUpdateTimer);
         Hook.createHook(CloseChallengeProposal);
         Hook.createHook(FightLeader);
         Hook.createHook(RemindTurn);
         Hook.createHook(SpectatorWantLeave);
         Hook.createHook(FightResultClosed);
         Hook.createHook(GameEntityDisposition);
         Hook.createHook(FighterInfoUpdate);
         Hook.createHook(ReadyToFight);
         Hook.createHook(NotReadyToFight);
         Hook.createHook(DematerializationChanged);
         Hook.createHook(AfkModeChanged);
         Hook.createHook(TurnCountUpdated);
         Hook.createHook(UpdatePreFightersList);
         Hook.createHook(UpdateFightersLook);
         Hook.createHook(SlaveStatsList);
         Hook.createHook(ShowMonsterArtwork);
         Hook.createHook(WaveUpdated);
         Hook.createHook(SpectateUpdate);
         Hook.createHook(ShowSwapPositionRequestMenu);
         Hook.createHook(ArenaFighterLeave);
         Hook.createHook(OpenFightResults);
         Hook.createHook(FighterRemoved);
         Hook.createHook(FightersInitiative);
         Hook.createHook(SlaveTurnStart);
      }
   }
}
