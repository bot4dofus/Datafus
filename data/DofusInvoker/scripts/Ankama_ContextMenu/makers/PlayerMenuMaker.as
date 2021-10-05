package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import chat.protocol.user.data.Friend;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.BasicWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
   import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationByNameAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShowVendorTaxAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAbdicateThroneAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyCancelInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAction;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionAlliance;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionGuild;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   
   public class PlayerMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      protected var _playerName:String = null;
      
      protected var _playerAccountId:int = 0;
      
      protected var _playerAccountIdStr:String = null;
      
      protected var _cellId:int = -1;
      
      protected var _partyId:int = 0;
      
      protected var _ava:Boolean;
      
      private var _chatService:ChatService;
      
      public function PlayerMenuMaker()
      {
         super();
      }
      
      protected function onWhisperMessage(playerName:String) : void
      {
         Api.system.dispatchHook(ChatHookList.ChatFocus,playerName);
      }
      
      protected function onWhisperMessageInterGame(playerName:String, playerTag:String) : void
      {
         Api.system.dispatchHook(ChatHookList.ChatFocusInterGame,playerName,playerTag);
      }
      
      protected function onFightChallenge(targetId:Number) : void
      {
         Api.system.sendAction(new PlayerFightRequestAction([targetId,false,true,true,this._cellId]));
      }
      
      protected function onAttack(targetId:Number) : void
      {
         Api.system.sendAction(new PlayerFightRequestAction([targetId,this._ava,false,false,this._cellId]));
      }
      
      protected function onInviteMenuClicked(playerName:String) : void
      {
         Api.system.sendAction(new PartyInvitationAction([playerName,0,false]));
      }
      
      protected function onArenaInvite(playerName:String) : void
      {
         Api.system.sendAction(new PartyInvitationAction([playerName,0,true]));
      }
      
      protected function onExchangeMenuClicked(playerID:Number) : void
      {
         Api.system.sendAction(new ExchangePlayerRequestAction([1,playerID]));
      }
      
      protected function onGuildInvite(playerID:*) : void
      {
         if(playerID is String)
         {
            Api.system.sendAction(new GuildInvitationByNameAction([playerID as String]));
         }
         else
         {
            Api.system.sendAction(new GuildInvitationAction([playerID as Number]));
         }
      }
      
      protected function onHavenbagInvite(playerID:Number) : void
      {
         Api.system.sendAction(new HavenbagInvitePlayerAction([playerID,true]));
      }
      
      protected function onHavenbagKick(playerID:Number) : void
      {
         Api.system.sendAction(new HavenbagInvitePlayerAction([playerID,false]));
      }
      
      protected function onBreachInvite(playerID:Number) : void
      {
         Api.system.sendAction(new BreachInvitationRequestAction([new <Number>[playerID]]));
      }
      
      protected function onBreachKick(playerID:Number) : void
      {
         Api.system.sendAction(new BreachKickRequestAction([playerID]));
      }
      
      protected function onAddEnemy(playerName:String) : void
      {
         this._playerName = playerName;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.confirmAddEnemy",playerName),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptAddEnemy],this.onAcceptAddEnemy);
      }
      
      protected function onAcceptAddEnemy() : void
      {
         Api.system.sendAction(new AddEnemyAction([this._playerName,""]));
      }
      
      protected function onAddFriend(playerName:String) : void
      {
         this._playerName = playerName;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.confirmAddFriend",playerName),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptAddFriend],this.onAcceptAddFriend);
      }
      
      protected function onAcceptAddFriend() : void
      {
         Api.system.sendAction(new AddFriendAction([this._playerName,""]));
      }
      
      protected function onRemoveContact(playerName:String, playerAccountId:int) : void
      {
         this._playerAccountId = playerAccountId;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.doUDeleteContact",playerName),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptRemoveContact],this.onAcceptRemoveContact);
      }
      
      protected function onAcceptRemoveContact() : void
      {
         Api.system.sendAction(new RemoveFriendAction([this._playerAccountId]));
      }
      
      protected function onRemoveFriends(accountName:String, accountTag:String, accountId:String) : void
      {
         this._playerAccountIdStr = accountId;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.doUDeleteFriend",PlayerManager.getInstance().formatTagName(accountName,accountTag,null,false)),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptRemoveFriends],this.onAcceptRemoveFriends);
      }
      
      protected function onAcceptRemoveFriends() : void
      {
         this._chatService.deleteUserFriend(this._playerAccountIdStr);
      }
      
      protected function onIgnorePlayer(playerName:String) : void
      {
         Api.system.sendAction(new AddIgnoredAction([playerName,""]));
      }
      
      protected function onUnignorePlayer(playerAccountId:int) : void
      {
         Api.system.sendAction(new RemoveIgnoredAction([playerAccountId]));
      }
      
      protected function onHouseKickOff(playerID:Number) : void
      {
         Api.system.sendAction(new HouseKickAction([playerID]));
      }
      
      protected function onMultiCraftCustomerAskClicked(pCrafterId:Number, pSkillId:uint) : void
      {
         Api.system.sendAction(new ExchangePlayerMultiCraftRequestAction([ExchangeTypeEnum.MULTICRAFT_CUSTOMER,pCrafterId,pSkillId]));
      }
      
      protected function onMultiCraftCrafterAskClicked(pCustomerId:Number, pSkillId:uint) : void
      {
         Api.system.sendAction(new ExchangePlayerMultiCraftRequestAction([ExchangeTypeEnum.MULTICRAFT_CRAFTER,pCustomerId,pSkillId]));
      }
      
      protected function onInformations(playerName:String, shouldIOpenCharacterPage:Boolean = false, playerId:Number = 0) : void
      {
         var uid:Number = NaN;
         var uri:String = null;
         if(!shouldIOpenCharacterPage)
         {
            Api.system.sendAction(new BasicWhoIsRequestAction([playerName,true]));
         }
         else
         {
            uid = Math.floor(playerId / 65536) * 100000 + Math.floor(playerId % 65536);
            uri = Api.ui.getText("ui.link.characterPage",uid,playerName.toLowerCase());
            Api.system.goToUrl(uri);
         }
      }
      
      protected function onGuildInformations(guildId:uint) : void
      {
         Api.system.sendAction(new GuildFactsRequestAction([guildId]));
      }
      
      protected function onAllianceInformations(allianceId:uint) : void
      {
         Api.system.sendAction(new AllianceFactsRequestAction([allianceId]));
      }
      
      protected function onManageShoppingModMenuClicked() : void
      {
         Api.system.sendAction(new ExchangeRequestOnShopStockAction([]));
      }
      
      protected function onWantFreeSoul() : void
      {
         Api.system.sendAction(new GameRolePlayFreeSoulRequestAction([]));
      }
      
      protected function onShoppingModMenuClicked() : void
      {
         Api.system.sendAction(new ExchangeShowVendorTaxAction([]));
      }
      
      protected function onPivotCharacter() : void
      {
         Api.system.sendAction(new PivotCharacterAction([]));
      }
      
      protected function onZoom(playerID:Number) : void
      {
         Api.system.sendAction(new StartZoomAction([playerID,2]));
      }
      
      protected function onReportClicked(playerID:Number, playerName:String, context:Object = null) : void
      {
         Api.system.dispatchHook(CustomUiHookList.OpenReport,playerID,playerName,context);
      }
      
      protected function onSlapMenuClicked() : void
      {
         Api.system.sendAction(new ChatTextOutputAction([Api.ui.getText("ui.dialog.slapSentence"),0,null,null]));
      }
      
      protected function onReady() : void
      {
         Api.system.dispatchHook(FightHookList.ReadyToFight);
      }
      
      protected function onKick(targetId:Number) : void
      {
         Api.system.sendAction(new GameContextKickAction([targetId]));
      }
      
      protected function onJoinFriend(targetName:String) : void
      {
         Api.system.sendAction(new JoinFriendAction([targetName]));
      }
      
      protected function onJoinSpouse() : void
      {
         Api.system.sendAction(new JoinSpouseAction([]));
      }
      
      protected function promoteLeader(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyAbdicateThroneAction([pPartyId,pPlayerId]));
      }
      
      protected function kickPlayer(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyKickRequestAction([pPartyId,pPlayerId]));
      }
      
      protected function leaveParty(pPartyId:int) : void
      {
         Api.system.sendAction(new PartyLeaveRequestAction([pPartyId]));
      }
      
      protected function followThisMember(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyFollowMemberAction([pPartyId,pPlayerId]));
      }
      
      protected function followAllThisMember(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyAllFollowMemberAction([pPartyId,pPlayerId]));
      }
      
      protected function stopFollowingThisMember(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyStopFollowingMemberAction([pPartyId,pPlayerId]));
      }
      
      protected function stopAllFollowingThisMember(pPartyId:int, pPlayerId:Number) : void
      {
         Api.system.sendAction(new PartyAllStopFollowingMemberAction([pPartyId,pPlayerId]));
      }
      
      protected function cancelPartyInvitation(pPartyId:int, pGuestId:Number) : void
      {
         Api.system.sendAction(new PartyCancelInvitationAction([pPartyId,pGuestId]));
      }
      
      protected function addPartyMenu(pPlayerId:Number, bIsGuest:Boolean, hostId:Number = 0, arena:Boolean = false) : Array
      {
         var leaderId:Number = NaN;
         var partyId:int = 0;
         var isFollowed:* = false;
         var disablePromotion:Boolean = false;
         var menu:Array = [];
         this._chatService = Api.chatServiceApi.service;
         if(!arena)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.common.party")));
         }
         else
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.common.koliseum")));
         }
         var playerId:Number = Api.player.id();
         if(arena)
         {
            partyId = Api.party.getArenaPartyId();
            leaderId = Api.party.getPartyLeaderId(partyId);
         }
         else
         {
            partyId = Api.party.getPartyId();
            leaderId = Api.party.getPartyLeaderId(partyId);
         }
         var allMemberFollowPlayerId:Number = Api.party.getAllMemberFollowPlayerId(this._partyId);
         if(pPlayerId == playerId)
         {
            if(!arena)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.leaveParty"),this.leaveParty,[partyId]));
            }
            else
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.arenaQuit"),this.leaveParty,[partyId]));
            }
            if(!arena)
            {
               if(allMemberFollowPlayerId == playerId)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopAllFollowingMe"),this.stopAllFollowingThisMember,[partyId,pPlayerId]));
               }
               else
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.followMeAll"),this.followAllThisMember,[partyId,pPlayerId]));
               }
            }
         }
         else if(bIsGuest)
         {
            if(playerId == leaderId || playerId == hostId)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.cancelInvitation"),this.cancelPartyInvitation,[partyId,pPlayerId]));
            }
         }
         else
         {
            if(!arena)
            {
               isFollowed = Api.player.getFollowingPlayerIds().indexOf(pPlayerId) != -1;
               if(isFollowed)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopFollowing"),this.stopFollowingThisMember,[partyId,pPlayerId]));
               }
               else
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.follow"),this.followThisMember,[partyId,pPlayerId]));
               }
            }
            if(leaderId == playerId)
            {
               disablePromotion = false;
               if(Api.player.isInBreach())
               {
                  disablePromotion = true;
               }
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickPlayer"),this.kickPlayer,[partyId,pPlayerId]));
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.promotePartyLeader"),this.promoteLeader,[partyId,pPlayerId],disablePromotion));
               if(!arena)
               {
                  if(allMemberFollowPlayerId == pPlayerId)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.stopAllFollowingHim"),this.stopAllFollowingThisMember,[partyId,pPlayerId]));
                  }
                  else
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.followHimAll"),this.followAllThisMember,[partyId,pPlayerId]));
                  }
               }
            }
         }
         if(menu.length > 1)
         {
            return menu;
         }
         return [];
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var infos:GameRolePlayHumanoidInformations = null;
         var entity:Object = null;
         var guildInfo:GuildInformations = null;
         var allianceInfo:HumanOptionAlliance = null;
         var alignInfo:ActorAlignmentInformations = null;
         var cantBeChallenged:Boolean = false;
         var cantExchange:Boolean = false;
         var option:* = undefined;
         var fightInfos:GameFightCharacterInformations = null;
         if(data is GameRolePlayHumanoidInformations)
         {
            infos = data as GameRolePlayHumanoidInformations;
            entity = param[0];
            if(entity.hasOwnProperty("position") && entity.position && entity.position.hasOwnProperty("cellId"))
            {
               this._cellId = entity.position.cellId;
            }
            guildInfo = null;
            allianceInfo = null;
            alignInfo = null;
            cantBeChallenged = false;
            cantExchange = false;
            if(infos.humanoidInfo is HumanInformations)
            {
               for each(option in (infos.humanoidInfo as HumanInformations).options)
               {
                  if(option is HumanOptionGuild)
                  {
                     guildInfo = option.guildInformations;
                  }
                  if(option is HumanOptionAlliance)
                  {
                     allianceInfo = option;
                  }
               }
               cantBeChallenged = infos.humanoidInfo.restrictions.cantChallenge;
               cantExchange = infos.humanoidInfo.restrictions.cantExchange;
            }
            if(infos is GameRolePlayCharacterInformations)
            {
               alignInfo = (infos as GameRolePlayCharacterInformations).alignmentInfos;
            }
            return this.createMenu2(infos.name,entity.id,this.getIsMutant(infos),alignInfo,guildInfo,allianceInfo,param[0],infos.accountId,cantBeChallenged,cantExchange);
         }
         if(data is GameFightCharacterInformations)
         {
            fightInfos = data as GameFightCharacterInformations;
            return this.createMenu2(fightInfos.name,fightInfos.contextualId,false);
         }
         return this.createMenu2(data,0,false);
      }
      
      public function getIsMutant(infos:GameRolePlayHumanoidInformations) : Boolean
      {
         return infos is GameRolePlayMutantInformations;
      }
      
      public function createMenu2(pPlayerName:String, pPlayerId:Number, isMutant:Boolean, pPlayerAlignement:ActorAlignmentInformations = null, pPlayerGuild:GuildInformations = null, pPlayerAlliance:HumanOptionAlliance = null, pContext:Object = null, pPlayerAccountId:uint = 0, cantBeChallenged:Boolean = false, cantExchange:Boolean = false) : Array
      {
         var partyHostId:Number = NaN;
         var arenaPartyHostId:Number = NaN;
         var partyMember:PartyMemberWrapper = null;
         var isInMap:* = false;
         var friend:Friend = null;
         var informationsMenu:Array = null;
         var feature:OptionalFeature = null;
         var entityTemp:IEntity = null;
         var entityInfos:Object = null;
         var canJoin:Boolean = false;
         var currSubArea:SubArea = null;
         var superArea:SuperArea = null;
         var zoomAvailable:Boolean = false;
         var playerInBreach:Vector.<Number> = null;
         var playerSkills:Array = null;
         var inviteTo:String = null;
         var skill:Object = null;
         var otherSkills:Array = null;
         var askTo:String = null;
         var menu:Array = new Array();
         var dead:* = !Api.player.isAlive();
         var playerIsInParty:Boolean = false;
         var playerIsGuestInParty:* = false;
         var playerIsInArenaParty:Boolean = false;
         var playerIsGuestInArenaParty:* = false;
         var playerInfos:Object = Api.player.getPlayedCharacterInfo();
         if(playerInfos.name == pPlayerName)
         {
            pPlayerId = playerInfos.id;
         }
         var playerFightInfos:FighterInformations = Api.fight.getFighterInformations(Api.player.id());
         var targetFightInfos:FighterInformations = Api.fight.getFighterInformations(pPlayerId);
         for each(partyMember in Api.party.getPartyMembers(0))
         {
            if(partyMember.id == pPlayerId)
            {
               playerIsInParty = true;
               playerIsGuestInParty = !partyMember.isMember;
               if(playerIsGuestInParty)
               {
                  partyHostId = partyMember.hostId;
               }
            }
         }
         for each(partyMember in Api.party.getPartyMembers(1))
         {
            if(partyMember.id == pPlayerId)
            {
               playerIsInArenaParty = true;
               playerIsGuestInArenaParty = !partyMember.isMember;
               if(playerIsGuestInArenaParty)
               {
                  arenaPartyHostId = partyMember.hostId;
               }
            }
         }
         if(pPlayerId != playerInfos.id && pPlayerName != playerInfos.name)
         {
            isInMap = false;
            if(pPlayerName != null)
            {
               if(!Api.player.isInFight() && !Api.player.isInPreFight())
               {
                  entityTemp = Api.roleplay.getEntityByName(pPlayerName);
                  isInMap = entityTemp != null;
                  if(entityTemp)
                  {
                     entityInfos = Api.roleplay.getEntityInfos(entityTemp);
                     if(entityInfos)
                     {
                        pPlayerId = entityInfos.contextualId;
                     }
                  }
               }
            }
            else if(pPlayerId)
            {
               isInMap = Boolean(Api.roleplay.getPlayerIsInCurrentMap(pPlayerId));
            }
            menu.push(ContextMenu.static_createContextMenuTitleObject(pPlayerName));
            if(Api.player.isInPreFight() && targetFightInfos.team == playerFightInfos.team)
            {
               if(Api.fight.isFightLeader())
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.fight.kick"),this.onKick,[pPlayerId],disabled || dead));
                  menu.push(ContextMenu.static_createContextMenuSeparatorObject());
               }
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.switchPlaces"),this.onSwitchPlaces,[targetFightInfos.currentCell,pPlayerId]));
               menu.push(ContextMenu.static_createContextMenuSeparatorObject());
            }
            friend = this._chatService === null ? null : this._chatService.getFriend(pPlayerAccountId.toString());
            if(friend)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.wisperMessage"),this.onWhisperMessageInterGame,[friend.user.name,friend.user.tag],disabled));
            }
            else
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.wisperMessage"),this.onWhisperMessage,[pPlayerName],disabled));
            }
            if(!Api.player.isInFight())
            {
               if(isInMap)
               {
                  if(!Api.player.restrictions().cantChallenge && !cantBeChallenged && !dead)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.challenge"),this.onFightChallenge,[pPlayerId],disabled || dead));
                  }
                  if(pPlayerAlignement && !dead)
                  {
                     switch(this.allowAgression(pPlayerAlignement,pPlayerAlliance,isMutant,pPlayerId))
                     {
                        case -1:
                           break;
                        case 0:
                           menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.pvp.assault"),null,null,true));
                           break;
                        case 1:
                           menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.pvp.assault"),this.onAttack,[pPlayerId],disabled || dead));
                     }
                  }
               }
               if(isInMap && Api.player.isInHisHouse())
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.kickOff"),this.onHouseKickOff,[pPlayerId],disabled || dead));
               }
               canJoin = false;
               currSubArea = Api.map.getCurrentSubArea();
               if(currSubArea && currSubArea.area && currSubArea.area.superArea)
               {
                  superArea = currSubArea.area.superArea;
                  if(currSubArea.area.superArea.id == DataEnum.WORLD_STARTZONE)
                  {
                     canJoin = true;
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.join"),this.onJoinFriend,[pPlayerName],disabled || dead));
                  }
               }
               if(!canJoin && Api.social.hasSpouse() && Api.social.getSpouse() && Api.social.getSpouse().id == pPlayerId)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.join"),this.onJoinSpouse,null,disabled || dead));
               }
               if(isInMap)
               {
                  zoomAvailable = false;
                  if(pPlayerId)
                  {
                     zoomAvailable = true;
                  }
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom"),this.onZoom,[pPlayerId],disabled || !zoomAvailable));
               }
            }
            informationsMenu = [];
            informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.details"),this.onInformations,[pPlayerName,false],disabled));
            informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.characterPage"),this.onInformations,[pPlayerName,true,pPlayerId],disabled));
            if(pPlayerGuild)
            {
               informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.guild.guildInformations"),this.onGuildInformations,[pPlayerGuild.guildId],disabled));
               if(pPlayerAlliance)
               {
                  informationsMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.alliance.allianceInformations"),this.onAllianceInformations,[pPlayerAlliance.allianceInformations.allianceId],disabled));
               }
            }
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.informations"),null,null,false,informationsMenu));
            menu.push(ContextMenu.static_createContextMenuSeparatorObject());
            if(!Api.player.isInFight())
            {
               if(isInMap && !Api.player.restrictions().cantExchange && !cantExchange)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.exchangeProp"),this.onExchangeMenuClicked,[pPlayerId],disabled || dead));
               }
            }
            if(!playerIsInParty && Api.party.getPartyMembers(0).length < 8)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.addToParty"),this.onInviteMenuClicked,[pPlayerName],disabled));
            }
            feature = Api.data.getOptionalFeatureByKeyword("pvp.kis");
            if(feature)
            {
               if((!playerIsInArenaParty || Api.party.getPartyMembers(1).length < PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM) && Api.config.isFeatureEnabled(feature))
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.addToArena"),this.onArenaInvite,[pPlayerName],disabled));
               }
            }
            if(Api.social.hasGuild() && Api.social.hasGuildRight(playerInfos.id,"inviteNewMembers"))
            {
               if(!pPlayerGuild)
               {
                  if(pPlayerId == 0)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.inviteInGuild"),this.onGuildInvite,[pPlayerName],disabled));
                  }
                  else
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.inviteInGuild"),this.onGuildInvite,[pPlayerId],disabled));
                  }
               }
            }
            if(Api.player.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG)
            {
               if(Api.player.isInHisHavenbag() && isInMap)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.havenbag.kick.player"),this.onHavenbagKick,[pPlayerId],disabled));
               }
               else
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.havenbag.invite.player"),this.onHavenbagInvite,[pPlayerId],disabled));
               }
            }
            if(Api.player.isInBreach() && Api.breachApi.getOwnerId() == Api.player.id())
            {
               playerInBreach = Api.breachApi.getBreachPlayers() as Vector.<Number>;
               if(playerInBreach && playerInBreach.indexOf(pPlayerId) == -1)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.addToBreach"),this.onBreachInvite,[pPlayerId]));
               }
               else
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickFromBreach"),this.onBreachKick,[pPlayerId]));
               }
            }
            if(!Api.player.isInFight() && isInMap)
            {
               playerSkills = Api.jobs.getUsableSkillsInMap(playerInfos.id);
               inviteTo = Api.ui.getText("ui.common.inviteTo");
               for each(skill in playerSkills)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(inviteTo + " " + skill.name,this.onMultiCraftCrafterAskClicked,[pPlayerId,skill.id],disabled || dead));
               }
               otherSkills = Api.jobs.getUsableSkillsInMap(pPlayerId);
               askTo = Api.ui.getText("ui.common.askTo");
               for each(skill in otherSkills)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(askTo + " " + skill.name,this.onMultiCraftCustomerAskClicked,[pPlayerId,skill.id],disabled || dead));
               }
            }
            menu.push(ContextMenu.static_createContextMenuSeparatorObject());
            if(friend)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromAnkamaFriends"),this.onRemoveFriends,[friend.user.name,friend.user.tag,friend.user.userId],disabled));
            }
            if(Api.social.isFriendOrContact(pPlayerName))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromContacts"),this.onRemoveContact,[pPlayerName,pPlayerAccountId],disabled));
            }
            else if(!Api.social.isEnemy(pPlayerName))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.addToContacts"),this.onAddFriend,[pPlayerName],disabled));
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.addToEnemy"),this.onAddEnemy,[pPlayerName],disabled));
            }
            if(Api.social.isIgnored(pPlayerName,pPlayerAccountId))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.blackListRemove"),this.onUnignorePlayer,[pPlayerAccountId],disabled));
            }
            else if(!Api.social.isFriendOrContact(pPlayerName) && !Api.social.isEnemy(pPlayerName))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.blackListTemporarly"),this.onIgnorePlayer,[pPlayerName],disabled));
            }
            if(Api.system.getBuildType() == BuildTypeEnum.DEBUG || Api.system.getBuildType() == BuildTypeEnum.INTERNAL)
            {
               if(pContext && (!pContext.hasOwnProperty("chan") || pContext.chan == DataEnum.CHAT_CHANNEL_GENERAL || pContext.chan == DataEnum.CHAT_CHANNEL_ALLIANCE || pContext.chan == DataEnum.CHAT_CHANNEL_TRADE || pContext.chan == DataEnum.CHAT_CHANNEL_RECRUITMENT || pContext.chan == DataEnum.CHAT_CHANNEL_PRIVATE))
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.report"),this.onReportClicked,[pPlayerId,pPlayerName,pContext],disabled));
               }
            }
         }
         else
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(pPlayerName));
            switch(Api.player.state())
            {
               case 1:
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.freeSoul"),this.onWantFreeSoul,null,disabled));
                  break;
               case 0:
               case 2:
                  if(Api.player.isInPreFight())
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.banner.ready"),this.onReady,null,disabled || Api.fight.isWaitingBeforeFight()));
                  }
                  else
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.dialog.slapHimself"),this.onSlapMenuClicked,null,disabled));
                  }
                  if(!Api.player.isInFight())
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.humanVendor.organizeShop"),this.onManageShoppingModMenuClicked,null,disabled || Api.player.state() == 2));
                     if(!Api.player.restrictions().cantBeMerchant)
                     {
                        menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.humanVendor.switchToMerchantMode"),this.onShoppingModMenuClicked,null,disabled || Api.player.state() == 2 || Api.player.hasDebt()));
                     }
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.orientCharacter"),this.onPivotCharacter,null,disabled || Api.roleplay.isUsingInteractive()));
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom"),this.onZoom,[pPlayerId],disabled));
                  }
            }
         }
         if(Api.player.isInParty())
         {
            if(playerIsInParty)
            {
               menu = menu.concat(this.addPartyMenu(pPlayerId,playerIsGuestInParty,partyHostId,false));
            }
            if(playerIsInArenaParty)
            {
               menu = menu.concat(this.addPartyMenu(pPlayerId,playerIsGuestInArenaParty,arenaPartyHostId,true));
            }
         }
         return menu;
      }
      
      private function allowAgression(pTargetAlignment:ActorAlignmentInformations, pTargetAlliance:HumanOptionAlliance, targetIsMutant:Boolean, pId:Number) : int
      {
         var worldPoint:WorldPointWrapper = Api.player.currentMap();
         var subArea:SubArea = Api.player.currentSubArea();
         var currentPrism:PrismSubAreaWrapper = Api.social.getPrismSubAreaById(subArea.id);
         var playerAlignment:ActorExtendedAlignmentInformations = Api.player.characteristics().alignmentInfos;
         var mapPos:MapPosition = Api.map.getMapPositionById(worldPoint.mapId);
         if(mapPos && !mapPos.allowAggression)
         {
            return -1;
         }
         if(Api.player.isMutant())
         {
            if(!Api.player.restrictions().cantAttack)
            {
               if(targetIsMutant)
               {
                  return 0;
               }
               return 1;
            }
            return 0;
         }
         if(targetIsMutant)
         {
            return 1;
         }
         var serverType:int = Api.system.getPlayerManager().serverGameType;
         var sh:* = serverType == GameServerTypeEnum.SERVER_TYPE_HARDCORE;
         var myAlliance:AllianceWrapper = Api.social.getAlliance();
         var subAreaWithPrism:Boolean = currentPrism && currentPrism.mapId != -1;
         var prismNotVulnerableAndSH:Boolean = false;
         if(subAreaWithPrism)
         {
            if(!sh)
            {
               if(currentPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE)
               {
                  if(myAlliance)
                  {
                     if(!this.isAggressableAvA(playerAlignment.aggressable))
                     {
                        return -1;
                     }
                     if(pTargetAlliance == null)
                     {
                        return -1;
                     }
                  }
               }
               else
               {
                  prismNotVulnerableAndSH = true;
               }
            }
            else if(myAlliance)
            {
               if(currentPrism.alliance.allianceId != myAlliance.allianceId)
               {
                  if(!this.isAggressableAvA(playerAlignment.aggressable))
                  {
                     return -1;
                  }
               }
               else if(!this.isAggressableAvA(playerAlignment.aggressable) && playerAlignment.aggressable != AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE)
               {
                  return -1;
               }
            }
            if(!prismNotVulnerableAndSH && !myAlliance)
            {
               return -1;
            }
            if(!prismNotVulnerableAndSH && pTargetAlliance && (sh || currentPrism.state == PrismStateEnum.PRISM_STATE_VULNERABLE))
            {
               if(pTargetAlliance.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED)
               {
                  return 0;
               }
               if(!this.isAggressableAvA(pTargetAlliance.aggressable))
               {
                  return -1;
               }
               if(myAlliance.allianceId == pTargetAlliance.allianceInformations.allianceId && !sh)
               {
                  return -1;
               }
            }
            this._ava = true;
         }
         if(!sh)
         {
            if(!subAreaWithPrism || prismNotVulnerableAndSH)
            {
               if(playerAlignment == null || pTargetAlignment == null)
               {
                  return -1;
               }
               if(playerAlignment.aggressable != AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE)
               {
                  return -1;
               }
               if(pTargetAlignment.alignmentSide <= AlignmentSideEnum.ALIGNMENT_NEUTRAL || pTargetAlignment.alignmentGrade == 0)
               {
                  return -1;
               }
               if(playerAlignment.alignmentSide == pTargetAlignment.alignmentSide)
               {
                  return -1;
               }
               if(playerAlignment.alignmentSide == AlignmentSideEnum.ALIGNMENT_NEUTRAL)
               {
                  return -1;
               }
               this._ava = false;
            }
         }
         else if(!subAreaWithPrism)
         {
            if(myAlliance && pTargetAlliance)
            {
               if(!this.isAggressableAvA(playerAlignment.aggressable) || !this.isAggressableAvA(pTargetAlliance.aggressable))
               {
                  return -1;
               }
            }
            else if(!myAlliance || !this.isAggressableAvA(playerAlignment.aggressable))
            {
               return -1;
            }
            this._ava = true;
         }
         var gap:int = 50;
         var lvl:int = Api.player.getPlayedCharacterInfo().level;
         if(lvl > ProtocolConstantsEnum.MAX_LEVEL)
         {
            lvl = ProtocolConstantsEnum.MAX_LEVEL;
         }
         var otherLvl:int = int(pTargetAlignment.characterPower - pId);
         if(otherLvl > ProtocolConstantsEnum.MAX_LEVEL)
         {
            otherLvl = ProtocolConstantsEnum.MAX_LEVEL;
         }
         if(lvl + gap < otherLvl)
         {
            return -1;
         }
         return 1;
      }
      
      private function isAggressableAvA(pAggressableStatus:uint) : Boolean
      {
         return !(pAggressableStatus != AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE && pAggressableStatus != AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE);
      }
      
      private function onSwitchPlaces(cellId:int, allyId:Number) : void
      {
         Api.system.sendAction(new GameFightPlacementSwapPositionsRequestAction([cellId,allyId]));
      }
   }
}
