package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class RoleplayHookList
   {
      
      public static const PlayerFightRequestSent:String = "PlayerFightRequestSent";
      
      public static const PlayerFightFriendlyRequested:String = "PlayerFightFriendlyRequested";
      
      public static const FightRequestCanceled:String = "FightRequestCanceled";
      
      public static const PlayerFightFriendlyAnswer:String = "PlayerFightFriendlyAnswer";
      
      public static const PlayerFightFriendlyAnswered:String = "PlayerFightFriendlyAnswered";
      
      public static const EmoteListUpdated:String = "EmoteListUpdated";
      
      public static const EmoteEnabledListUpdated:String = "EmoteEnabledListUpdated";
      
      public static const DocumentReadingBegin:String = "DocumentReadingBegin";
      
      public static const TeleportDestinationList:String = "TeleportDestinationList";
      
      public static const EstateToSellList:String = "EstateToSellList";
      
      public static const DungeonPartyFinderAvailableDungeons:String = "DungeonPartyFinderAvailableDungeons";
      
      public static const DungeonPartyFinderRoomContent:String = "DungeonPartyFinderRoomContent";
      
      public static const DungeonPartyFinderRegister:String = "DungeonPartyFinderRegister";
      
      public static const ArenaRegistrationStatusUpdate:String = "ArenaRegistrationStatusUpdate";
      
      public static const ArenaFightProposition:String = "ArenaFightProposition";
      
      public static const ArenaFighterStatusUpdate:String = "ArenaFighterStatusUpdate";
      
      public static const ArenaUpdateRank:String = "ArenaUpdateRank";
      
      public static const ArenaLeagueRewards:String = "ArenaLeagueRewards";
      
      public static const NpcDialogCreation:String = "NpcDialogCreation";
      
      public static const PonyDialogCreation:String = "PonyDialogCreation";
      
      public static const PrismDialogCreation:String = "PrismDialogCreation";
      
      public static const PortalDialogCreation:String = "PortalDialogCreation";
      
      public static const NpcDialogCreationFailure:String = "NpcDialogCreationFailure";
      
      public static const NpcDialogQuestion:String = "NpcDialogQuestion";
      
      public static const PortalDialogQuestion:String = "PortalDialogQuestion";
      
      public static const GiftsWaitingAllocation:String = "GiftsWaitingAllocation";
      
      public static const MerchantListUpdated:String = "MerchantListUpdated";
       
      
      public function RoleplayHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(PlayerFightRequestSent);
         Hook.createHook(PlayerFightFriendlyRequested);
         Hook.createHook(FightRequestCanceled);
         Hook.createHook(PlayerFightFriendlyAnswer);
         Hook.createHook(PlayerFightFriendlyAnswered);
         Hook.createHook(EmoteListUpdated);
         Hook.createHook(EmoteEnabledListUpdated);
         Hook.createHook(DocumentReadingBegin);
         Hook.createHook(TeleportDestinationList);
         Hook.createHook(EstateToSellList);
         Hook.createHook(DungeonPartyFinderAvailableDungeons);
         Hook.createHook(DungeonPartyFinderRoomContent);
         Hook.createHook(DungeonPartyFinderRegister);
         Hook.createHook(ArenaRegistrationStatusUpdate);
         Hook.createHook(ArenaFightProposition);
         Hook.createHook(ArenaFighterStatusUpdate);
         Hook.createHook(ArenaUpdateRank);
         Hook.createHook(ArenaLeagueRewards);
         Hook.createHook(NpcDialogCreation);
         Hook.createHook(PonyDialogCreation);
         Hook.createHook(PrismDialogCreation);
         Hook.createHook(PortalDialogCreation);
         Hook.createHook(NpcDialogCreationFailure);
         Hook.createHook(NpcDialogQuestion);
         Hook.createHook(PortalDialogQuestion);
         Hook.createHook(GiftsWaitingAllocation);
         Hook.createHook(MerchantListUpdated);
      }
   }
}
