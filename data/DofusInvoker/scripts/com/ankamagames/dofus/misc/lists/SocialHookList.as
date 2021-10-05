package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class SocialHookList
   {
      
      public static const OpenSocial:String = "OpenSocial";
      
      public static const FailInvitation:String = "FailInvitation";
      
      public static const OpenOneGuild:String = "OpenOneGuild";
      
      public static const OpenOneAlliance:String = "OpenOneAlliance";
      
      public static const FriendsListUpdated:String = "FriendsListUpdated";
      
      public static const ContactsListUpdated:String = "ContactsListUpdated";
      
      public static const EnemiesListUpdated:String = "EnemiesListUpdated";
      
      public static const SpouseUpdated:String = "SpouseUpdated";
      
      public static const IgnoredListUpdated:String = "IgnoredListUpdated";
      
      public static const FriendWarningState:String = "FriendWarningState";
      
      public static const ShareStatusState:String = "ShareStatusState";
      
      public static const MemberWarningState:String = "MemberWarningState";
      
      public static const FriendOrGuildMemberLevelUpWarningState:String = "FriendOrGuildMemberLevelUpWarningState";
      
      public static const FriendGuildWarnOnAchievementCompleteState:String = "FriendGuildWarnOnAchievementCompleteState";
      
      public static const WarnOnHardcoreDeathState:String = "WarnOnHardcoreDeathState";
      
      public static const SpouseFollowStatusUpdated:String = "SpouseFollowStatusUpdated";
      
      public static const GuildInformationsMembers:String = "GuildInformationsMembers";
      
      public static const GuildMembershipUpdated:String = "GuildMembershipUpdated";
      
      public static const GuildCreationStarted:String = "GuildCreationStarted";
      
      public static const GuildCreationResult:String = "GuildCreationResult";
      
      public static const GuildInvited:String = "GuildInvited";
      
      public static const GuildInvitationStateRecruter:String = "GuildInvitationStateRecruter";
      
      public static const GuildInvitationStateRecruted:String = "GuildInvitationStateRecruted";
      
      public static const GuildInformationsGeneral:String = "GuildInformationsGeneral";
      
      public static const GuildInformationsMemberUpdate:String = "GuildInformationsMemberUpdate";
      
      public static const GuildMemberLeaving:String = "GuildMemberLeaving";
      
      public static const GuildLeft:String = "GuildLeft";
      
      public static const GuildInfosUpgrade:String = "GuildInfosUpgrade";
      
      public static const GuildFightEnnemiesListUpdate:String = "GuildFightEnnemiesListUpdate";
      
      public static const GuildFightAlliesListUpdate:String = "GuildFightAlliesListUpdate";
      
      public static const GuildHousesInformation:String = "GuildHousesInformation";
      
      public static const GuildHousesUpdate:String = "GuildHousesUpdate";
      
      public static const TaxCollectorMovement:String = "TaxCollectorMovement";
      
      public static const AlliancePrismDialogQuestion:String = "AlliancePrismDialogQuestion";
      
      public static const TaxCollectorDialogQuestionExtended:String = "TaxCollectorDialogQuestionExtended";
      
      public static const AllianceTaxCollectorDialogQuestionExtended:String = "AllianceTaxCollectorDialogQuestionExtended";
      
      public static const TaxCollectorDialogQuestionBasic:String = "TaxCollectorDialogQuestionBasic";
      
      public static const TaxCollectorAttackedResult:String = "TaxCollectorAttackedResult";
      
      public static const TaxCollectorError:String = "TaxCollectorError";
      
      public static const TaxCollectorListUpdate:String = "TaxCollectorListUpdate";
      
      public static const TaxCollectorUpdate:String = "TaxCollectorUpdate";
      
      public static const TaxCollectorMovementAdd:String = "TaxCollectorMovementAdd";
      
      public static const TaxCollectorMovementRemove:String = "TaxCollectorMovementRemove";
      
      public static const GuildInformationsFarms:String = "GuildInformationsFarms";
      
      public static const GuildMotd:String = "GuildMotd";
      
      public static const GuildBulletin:String = "GuildBulletin";
      
      public static const GuildPaddockAdd:String = "GuildPaddockAdd";
      
      public static const GuildPaddockRemoved:String = "GuildPaddockRemoved";
      
      public static const GuildHouseAdd:String = "GuildHouseAdd";
      
      public static const GuildHouseRemoved:String = "GuildHouseRemoved";
      
      public static const GuildTaxCollectorAdd:String = "GuildTaxCollectorAdd";
      
      public static const GuildTaxCollectorRemoved:String = "GuildTaxCollectorRemoved";
      
      public static const AllianceTaxCollectorRemoved:String = "AllianceTaxCollectorRemoved";
      
      public static const GuildList:String = "GuildList";
      
      public static const AllianceMembershipUpdated:String = "AllianceMembershipUpdated";
      
      public static const AllianceCreationStarted:String = "AllianceCreationStarted";
      
      public static const AllianceCreationResult:String = "AllianceCreationResult";
      
      public static const AllianceInvited:String = "AllianceInvited";
      
      public static const AllianceInvitationStateRecruter:String = "AllianceInvitationStateRecruter";
      
      public static const AllianceInvitationStateRecruted:String = "AllianceInvitationStateRecruted";
      
      public static const AllianceJoined:String = "AllianceJoined";
      
      public static const AllianceGuildLeaving:String = "AllianceGuildLeaving";
      
      public static const AllianceLeft:String = "AllianceLeft";
      
      public static const AllianceUpdateInformations:String = "AllianceUpdateInformations";
      
      public static const AllianceList:String = "AllianceList";
      
      public static const AllianceMotd:String = "AllianceMotd";
      
      public static const AllianceBulletin:String = "AllianceBulletin";
      
      public static const ContactLookById:String = "ContactLookById";
      
      public static const AttackPlayer:String = "AttackPlayer";
      
      public static const DishonourChanged:String = "DishonourChanged";
      
      public static const PlayerStatusUpdate:String = "PlayerStatusUpdate";
      
      public static const NewAwayMessage:String = "NewAwayMessage";
      
      public static const ShowTopTaxCollectors:String = "ShowTopTaxCollectors";
       
      
      public function SocialHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(OpenSocial);
         Hook.createHook(FailInvitation);
         Hook.createHook(OpenOneGuild);
         Hook.createHook(OpenOneAlliance);
         Hook.createHook(FriendsListUpdated);
         Hook.createHook(ContactsListUpdated);
         Hook.createHook(EnemiesListUpdated);
         Hook.createHook(SpouseUpdated);
         Hook.createHook(IgnoredListUpdated);
         Hook.createHook(FriendWarningState);
         Hook.createHook(ShareStatusState);
         Hook.createHook(MemberWarningState);
         Hook.createHook(FriendOrGuildMemberLevelUpWarningState);
         Hook.createHook(FriendGuildWarnOnAchievementCompleteState);
         Hook.createHook(WarnOnHardcoreDeathState);
         Hook.createHook(SpouseFollowStatusUpdated);
         Hook.createHook(GuildInformationsMembers);
         Hook.createHook(GuildMembershipUpdated);
         Hook.createHook(GuildCreationStarted);
         Hook.createHook(GuildCreationResult);
         Hook.createHook(GuildInvited);
         Hook.createHook(GuildInvitationStateRecruter);
         Hook.createHook(GuildInvitationStateRecruted);
         Hook.createHook(GuildInformationsGeneral);
         Hook.createHook(GuildInformationsMemberUpdate);
         Hook.createHook(GuildMemberLeaving);
         Hook.createHook(GuildLeft);
         Hook.createHook(GuildInfosUpgrade);
         Hook.createHook(GuildFightEnnemiesListUpdate);
         Hook.createHook(GuildFightAlliesListUpdate);
         Hook.createHook(GuildHousesInformation);
         Hook.createHook(GuildHousesUpdate);
         Hook.createHook(TaxCollectorMovement);
         Hook.createHook(AlliancePrismDialogQuestion);
         Hook.createHook(TaxCollectorDialogQuestionExtended);
         Hook.createHook(AllianceTaxCollectorDialogQuestionExtended);
         Hook.createHook(TaxCollectorDialogQuestionBasic);
         Hook.createHook(TaxCollectorAttackedResult);
         Hook.createHook(TaxCollectorError);
         Hook.createHook(TaxCollectorListUpdate);
         Hook.createHook(TaxCollectorUpdate);
         Hook.createHook(TaxCollectorMovementAdd);
         Hook.createHook(TaxCollectorMovementRemove);
         Hook.createHook(GuildInformationsFarms);
         Hook.createHook(GuildMotd);
         Hook.createHook(GuildBulletin);
         Hook.createHook(GuildPaddockAdd);
         Hook.createHook(GuildPaddockRemoved);
         Hook.createHook(GuildHouseAdd);
         Hook.createHook(GuildHouseRemoved);
         Hook.createHook(GuildTaxCollectorAdd);
         Hook.createHook(GuildTaxCollectorRemoved);
         Hook.createHook(AllianceTaxCollectorRemoved);
         Hook.createHook(GuildList);
         Hook.createHook(AllianceMembershipUpdated);
         Hook.createHook(AllianceCreationStarted);
         Hook.createHook(AllianceCreationResult);
         Hook.createHook(AllianceInvited);
         Hook.createHook(AllianceInvitationStateRecruter);
         Hook.createHook(AllianceInvitationStateRecruted);
         Hook.createHook(AllianceJoined);
         Hook.createHook(AllianceGuildLeaving);
         Hook.createHook(AllianceLeft);
         Hook.createHook(AllianceUpdateInformations);
         Hook.createHook(AllianceList);
         Hook.createHook(AllianceMotd);
         Hook.createHook(AllianceBulletin);
         Hook.createHook(ContactLookById);
         Hook.createHook(AttackPlayer);
         Hook.createHook(DishonourChanged);
         Hook.createHook(PlayerStatusUpdate);
         Hook.createHook(NewAwayMessage);
         Hook.createHook(ShowTopTaxCollectors);
      }
   }
}
