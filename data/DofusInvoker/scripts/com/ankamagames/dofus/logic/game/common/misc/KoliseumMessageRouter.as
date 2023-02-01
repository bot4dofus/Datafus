package com.ankamagames.dofus.logic.game.common.misc
{
   import avmplus.getQualifiedClassName;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.common.basic.*;
   import com.ankamagames.dofus.network.messages.game.achievement.*;
   import com.ankamagames.dofus.network.messages.game.alliance.*;
   import com.ankamagames.dofus.network.messages.game.basic.*;
   import com.ankamagames.dofus.network.messages.game.character.status.*;
   import com.ankamagames.dofus.network.messages.game.chat.*;
   import com.ankamagames.dofus.network.messages.game.chat.channel.*;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.*;
   import com.ankamagames.dofus.network.messages.game.context.mount.*;
   import com.ankamagames.dofus.network.messages.game.context.notification.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaFightAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaRegisterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaUnregisterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.stats.*;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.*;
   import com.ankamagames.dofus.network.messages.game.friend.*;
   import com.ankamagames.dofus.network.messages.game.guild.*;
   import com.ankamagames.dofus.network.messages.game.guild.tax.*;
   import com.ankamagames.dofus.network.messages.game.house.HouseTeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.*;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
   import com.ankamagames.dofus.network.messages.game.look.*;
   import com.ankamagames.dofus.network.messages.game.prism.*;
   import com.ankamagames.dofus.network.messages.game.social.*;
   import com.ankamagames.dofus.network.messages.game.tinsel.*;
   import com.ankamagames.dofus.network.messages.security.*;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.network.IMessageRouter;
   import com.ankamagames.jerakine.network.INetworkMessage;
   
   public class KoliseumMessageRouter implements IMessageRouter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(KoliseumMessageRouter));
       
      
      private var _fightersIds:Vector.<Number>;
      
      private var _fightersNames:Vector.<String>;
      
      public function KoliseumMessageRouter()
      {
         super();
      }
      
      public function getConnectionId(msg:INetworkMessage) : String
      {
         var ccmmsg:ChatClientMultiMessage = null;
         var ccpmsg:ChatClientPrivateMessage = null;
         var bwirmsg:BasicWhoIsRequestMessage = null;
         var nwirmsg:NumericWhoIsRequestMessage = null;
         var clrblmsg:ContactLookRequestByNameMessage = null;
         var clrbimsg:ContactLookRequestByIdMessage = null;
         var returnType:String = ConnectionType.TO_KOLI_SERVER;
         switch(true)
         {
            case msg is ChatClientMultiMessage:
            case msg is ChatClientMultiWithObjectMessage:
               ccmmsg = msg as ChatClientMultiMessage;
               if(ccmmsg.channel != ChatActivableChannelsEnum.CHANNEL_ARENA && ccmmsg.channel != ChatActivableChannelsEnum.CHANNEL_GLOBAL && ccmmsg.channel != ChatActivableChannelsEnum.CHANNEL_TEAM)
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is ChatClientPrivateMessage:
            case msg is ChatClientPrivateWithObjectMessage:
               ccpmsg = msg as ChatClientPrivateMessage;
               if(!this.isPlayerNameInFight(PlayerSearchCharacterNameInformation(ccpmsg.receiver).name))
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is BasicWhoIsRequestMessage:
               bwirmsg = msg as BasicWhoIsRequestMessage;
               if(!this.isPlayerNameInFight(PlayerSearchCharacterNameInformation(bwirmsg.target).name))
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is NumericWhoIsRequestMessage:
               nwirmsg = msg as NumericWhoIsRequestMessage;
               if(!this.isPlayerIdInFight(nwirmsg.playerId))
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is ContactLookRequestByNameMessage:
               clrblmsg = msg as ContactLookRequestByNameMessage;
               if(!this.isPlayerNameInFight(clrblmsg.playerName))
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is ContactLookRequestByIdMessage:
               clrbimsg = msg as ContactLookRequestByIdMessage;
               if(!this.isPlayerIdInFight(clrbimsg.playerId))
               {
                  returnType = ConnectionType.TO_GAME_SERVER;
               }
               break;
            case msg is ChannelEnablingMessage:
            case msg is PlayerStatusUpdateRequestMessage:
            case msg is StatsUpgradeRequestMessage:
            case msg is MountSetXpRatioRequestMessage:
               returnType = ConnectionType.TO_ALL_SERVERS;
               break;
            case msg is MoodSmileyRequestMessage:
            case msg is ClientKeyMessage:
            case msg is BasicStatMessage:
            case msg is BasicStatWithDataMessage:
            case msg is AchievementDetailsRequestMessage:
            case msg is AchievementDetailedListRequestMessage:
            case msg is AchievementRewardRequestMessage:
            case msg is FriendGuildSetWarnOnAchievementCompleteMessage:
            case msg is PartyInvitationRequestMessage:
            case msg is PartyInvitationDungeonRequestMessage:
            case msg is PartyInvitationArenaRequestMessage:
            case msg is PartyInvitationDetailsRequestMessage:
            case msg is PartyAcceptInvitationMessage:
            case msg is PartyRefuseInvitationMessage:
            case msg is PartyCancelInvitationMessage:
            case msg is PartyAbdicateThroneMessage:
            case msg is PartyFollowMemberRequestMessage:
            case msg is PartyFollowThisMemberRequestMessage:
            case msg is PartyStopFollowRequestMessage:
            case msg is PartyLocateMembersRequestMessage:
            case msg is PartyLeaveRequestMessage:
            case msg is PartyKickRequestMessage:
            case msg is PartyPledgeLoyaltyRequestMessage:
            case msg is PartyNameSetRequestMessage:
            case msg is DungeonPartyFinderAvailableDungeonsRequestMessage:
            case msg is DungeonPartyFinderListenRequestMessage:
            case msg is DungeonPartyFinderRegisterRequestMessage:
            case msg is SpouseGetInformationsMessage:
            case msg is FriendSetWarnOnConnectionMessage:
            case msg is FriendSetWarnOnLevelGainMessage:
            case msg is FriendJoinRequestMessage:
            case msg is FriendSpouseJoinRequestMessage:
            case msg is FriendSpouseFollowWithCompassRequestMessage:
            case msg is HouseTeleportRequestMessage:
            case msg is AllianceCreationValidMessage:
            case msg is AllianceModificationEmblemValidMessage:
            case msg is AllianceModificationNameAndTagValidMessage:
            case msg is AllianceModificationValidMessage:
            case msg is AllianceInvitationMessage:
            case msg is AllianceInvitationAnswerMessage:
            case msg is AllianceKickRequestMessage:
            case msg is AllianceFactsRequestMessage:
            case msg is AllianceChangeGuildRightsMessage:
            case msg is AllianceInsiderInfoRequestMessage:
            case msg is AllianceMotdSetRequestMessage:
            case msg is AllianceBulletinSetRequestMessage:
            case msg is GuildGetInformationsMessage:
            case msg is GuildModificationNameValidMessage:
            case msg is GuildModificationEmblemValidMessage:
            case msg is GuildModificationValidMessage:
            case msg is GuildCreationValidMessage:
            case msg is GuildInvitationMessage:
            case msg is GuildInvitationSearchMessage:
            case msg is GuildInvitationAnswerMessage:
            case msg is GuildKickRequestMessage:
            case msg is GuildChangeMemberParametersMessage:
            case msg is GuildSpellUpgradeRequestMessage:
            case msg is GuildCharacsUpgradeRequestMessage:
            case msg is GuildPaddockTeleportRequestMessage:
            case msg is GuildMemberSetWarnOnConnectionMessage:
            case msg is GuildMotdSetRequestMessage:
            case msg is GuildBulletinSetRequestMessage:
            case msg is GuildFactsRequestMessage:
            case msg is GameRolePlayTaxCollectorFightRequestMessage:
            case msg is GuildFightJoinRequestMessage:
            case msg is GuildFightTakePlaceRequestMessage:
            case msg is GuildFightLeaveRequestMessage:
            case msg is PrismFightJoinLeaveRequestMessage:
            case msg is PrismSetSabotagedRequestMessage:
            case msg is PrismFightSwapRequestMessage:
            case msg is PrismInfoJoinLeaveRequestMessage:
            case msg is PrismUseRequestMessage:
            case msg is PrismAttackRequestMessage:
            case msg is PrismsListRegisterMessage:
            case msg is PrismSettingsRequestMessage:
            case msg is PrismModuleExchangeRequestMessage:
            case msg is QuestListRequestMessage:
            case msg is QuestStartRequestMessage:
            case msg is QuestStepInfoRequestMessage:
            case msg is QuestObjectiveValidationMessage:
            case msg is GuidedModeReturnRequestMessage:
            case msg is GuidedModeQuitRequestMessage:
            case msg is NotificationUpdateFlagMessage:
            case msg is NotificationResetMessage:
            case msg is NpcGenericActionRequestMessage:
            case msg is NpcDialogReplyMessage:
            case msg is JobCrafterDirectoryListRequestMessage:
            case msg is JobCrafterDirectoryDefineSettingsMessage:
            case msg is JobCrafterDirectoryEntryRequestMessage:
            case msg is JobBookSubscribeRequestMessage:
            case msg is ObjectAveragePricesGetMessage:
            case msg is MountInformationRequestMessage:
            case msg is MountHarnessDissociateRequestMessage:
            case msg is MountHarnessColorsUpdateRequestMessage:
            case msg is TitleSelectRequestMessage:
            case msg is OrnamentSelectRequestMessage:
            case msg is AccessoryPreviewRequestMessage:
            case msg is TreasureHuntLegendaryRequestMessage:
            case msg is TreasureHuntDigRequestMessage:
            case msg is TreasureHuntFlagRequestMessage:
            case msg is TreasureHuntFlagRemoveRequestMessage:
            case msg is TreasureHuntGiveUpRequestMessage:
            case msg is PortalUseRequestMessage:
            case msg is GameRolePlayArenaRegisterMessage:
            case msg is GameRolePlayArenaUnregisterMessage:
            case msg is GameRolePlayArenaFightAnswerMessage:
               returnType = ConnectionType.TO_GAME_SERVER;
         }
         return returnType;
      }
      
      private function isPlayerNameInFight(name:String) : Boolean
      {
         if(!this._fightersNames || this._fightersNames.length == 0)
         {
            this.updateFighters();
         }
         if(this._fightersNames.indexOf(name.toLocaleUpperCase()) != -1)
         {
            return true;
         }
         return false;
      }
      
      private function isPlayerIdInFight(id:Number) : Boolean
      {
         if(!this._fightersNames || this._fightersNames.length == 0)
         {
            this.updateFighters();
         }
         if(this._fightersIds.indexOf(id) != -1)
         {
            return true;
         }
         return false;
      }
      
      private function updateFighters() : void
      {
         var entityId:Number = NaN;
         var fighter:GameFightFighterNamedInformations = null;
         this._fightersIds = new Vector.<Number>();
         this._fightersNames = new Vector.<String>();
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(entitiesFrame)
         {
            this._fightersIds = entitiesFrame.getEntitiesIdsList();
            for each(entityId in this._fightersIds)
            {
               fighter = entitiesFrame.getEntityInfos(entityId) as GameFightFighterNamedInformations;
               if(fighter)
               {
                  this._fightersNames.push(fighter.name.toLocaleUpperCase());
               }
            }
         }
      }
   }
}
