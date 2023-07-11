package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SocialCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildHouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.TaxCollectorWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SocialEntitiesManager;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.network.enums.SocialFightTypeEnum;
   import com.ankamagames.dofus.network.types.game.alliance.AllianceMemberInfo;
   import com.ankamagames.dofus.network.types.game.guild.GuildMemberInfo;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class SocialApi implements IApi
   {
      
      private static var _datastoreType:DataStoreType = new DataStoreType("Module_Ankama_Social",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function SocialApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(SocialApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function get socialFrame() : SocialFrame
      {
         return SocialFrame.getInstance();
      }
      
      public function get allianceFrame() : AllianceFrame
      {
         return AllianceFrame.getInstance();
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function hasSocialFrame() : Boolean
      {
         return this.socialFrame != null;
      }
      
      public function getFriendsList() : Vector.<SocialCharacterWrapper>
      {
         return this.socialFrame.friendsList;
      }
      
      public function getContactsList() : Vector.<SocialCharacterWrapper>
      {
         return this.socialFrame.contactsList;
      }
      
      public function isFriend(playerName:String) : Boolean
      {
         return this.socialFrame.isFriend(playerName);
      }
      
      public function isContact(playerName:String) : Boolean
      {
         return this.socialFrame.isContact(playerName);
      }
      
      public function isFriendOrContact(playerName:String) : Boolean
      {
         return this.socialFrame.isFriendOrContact(playerName);
      }
      
      public function getEnemiesList() : Vector.<SocialCharacterWrapper>
      {
         return this.socialFrame.enemiesList;
      }
      
      public function isEnemy(playerName:String) : Boolean
      {
         return this.socialFrame.isEnemy(playerName);
      }
      
      public function getIgnoredList() : Vector.<SocialCharacterWrapper>
      {
         return this.socialFrame.ignoredList;
      }
      
      public function isIgnored(name:String, accountId:int = 0) : Boolean
      {
         return this.socialFrame.isIgnored(name,accountId);
      }
      
      public function getAccountName(name:String) : String
      {
         return name;
      }
      
      public function getWarnOnFriendConnec() : Boolean
      {
         return this.socialFrame.warnFriendConnec;
      }
      
      public function getShareStatus() : Boolean
      {
         return this.socialFrame.shareStatus;
      }
      
      public function getWarnOnGuildMemberConnection() : Boolean
      {
         return this.socialFrame.warnGuildMemberConnection;
      }
      
      public function setWarnGuildMemberConnection(value:Boolean) : void
      {
         this.socialFrame.warnGuildMemberConnection = value;
      }
      
      public function getWarnOnAllianceMemberConnection() : Boolean
      {
         return this.socialFrame.warnAllianceMemberConnection;
      }
      
      public function setWarnAllianceMemberConnection(value:Boolean) : void
      {
         this.socialFrame.warnAllianceMemberConnection = value;
      }
      
      public function getWarnWhenFriendOrGuildMemberLvlUp() : Boolean
      {
         return this.socialFrame.warnWhenFriendOrGuildMemberLvlUp;
      }
      
      public function getWarnWhenFriendOrGuildMemberAchieve() : Boolean
      {
         return this.socialFrame.warnWhenFriendOrGuildMemberAchieve;
      }
      
      public function getWarnOnHardcoreDeath() : Boolean
      {
         return this.socialFrame.warnOnHardcoreDeath;
      }
      
      public function getSpouse() : SpouseWrapper
      {
         return this.socialFrame.spouse;
      }
      
      public function hasSpouse() : Boolean
      {
         return this.socialFrame.hasSpouse;
      }
      
      public function getAllowedGuildEmblemSymbolCategories() : int
      {
         var playerFrame:PlayedCharacterUpdatesFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
         return playerFrame.guildEmblemSymbolCategories;
      }
      
      public function hasGuild() : Boolean
      {
         return this.socialFrame.hasGuild;
      }
      
      public function getGuild() : GuildWrapper
      {
         return this.socialFrame.guild;
      }
      
      public function getGuildMembers() : Vector.<GuildMemberInfo>
      {
         return this.socialFrame.guildmembers;
      }
      
      public function hasGuildRight(pPlayerId:Number, pRightId:uint) : Boolean
      {
         var member:GuildMemberInfo = null;
         var rank:RankInformation = null;
         if(!this.socialFrame.hasGuild)
         {
            return false;
         }
         if(pPlayerId == PlayedCharacterManager.getInstance().id)
         {
            return this.socialFrame.playerGuildRank.rights.indexOf(pRightId) != -1;
         }
         for each(member in this.socialFrame.guildmembers)
         {
            if(member.id == pPlayerId)
            {
               rank = this.socialFrame.getGuildRankById(member.rankId);
               return rank.rights.indexOf(pRightId) != -1;
            }
         }
         return false;
      }
      
      public function hasGuildRank(pPlayerId:Number, rankOrder:int) : Boolean
      {
         var member:GuildMemberInfo = null;
         var rank:RankInformation = null;
         if(!this.socialFrame.hasGuild)
         {
            return false;
         }
         for each(member in this.socialFrame.guildmembers)
         {
            if(member.id == pPlayerId)
            {
               rank = this.socialFrame.getGuildRankById(member.rankId);
               return rank != null && rank.order == rankOrder;
            }
         }
         return false;
      }
      
      public function getPlayerGuildRank(playerId:Number) : RankInformation
      {
         var member:GuildMemberInfo = null;
         if(!this.socialFrame.hasGuild)
         {
            return null;
         }
         for each(member in this.socialFrame.guildmembers)
         {
            if(member.id == playerId)
            {
               return this.socialFrame.getGuildRankById(member.rankId);
            }
         }
         return null;
      }
      
      public function getGuildRanks() : Vector.<RankInformation>
      {
         return this.socialFrame.getGuildRanks();
      }
      
      public function getGuildRankById(id:uint) : RankInformation
      {
         return this.socialFrame.getGuildRankById(id);
      }
      
      public function getRankIconIds() : Vector.<uint>
      {
         return this.socialFrame.getRanksIconIds();
      }
      
      public function getRankIconUriById(iconId:uint) : Uri
      {
         return this.socialFrame.getRankIconUriById(iconId);
      }
      
      public function getGuildHouses() : Vector.<GuildHouseWrapper>
      {
         return this.socialFrame.guildHouses;
      }
      
      public function guildHousesUpdateNeeded() : Boolean
      {
         return this.socialFrame.guildHousesUpdateNeeded;
      }
      
      public function getGuildPaddocks() : Vector.<PaddockContentInformations>
      {
         return this.socialFrame.guildPaddocks;
      }
      
      public function getMaxGuildPaddocks() : int
      {
         return this.socialFrame.maxGuildPaddocks;
      }
      
      public function isGuildNameInvalid() : Boolean
      {
         if(this.socialFrame.guild)
         {
            return this.socialFrame.guild.realGroupName == "#NONAME#";
         }
         return false;
      }
      
      public function getTaxCollectors() : Dictionary
      {
         return SocialEntitiesManager.getInstance().taxCollectors;
      }
      
      public function getTaxCollectorById(id:uint) : TaxCollectorWrapper
      {
         return SocialEntitiesManager.getInstance().taxCollectors[id];
      }
      
      public function getAllFightingTaxCollectors() : Dictionary
      {
         return SocialEntitiesManager.getInstance().taxCollectorsInFight;
      }
      
      public function getFightingTaxCollector(pFightUniqueId:String) : SocialEntityInFightWrapper
      {
         return SocialEntitiesManager.getInstance().getFightingEntityById(pFightUniqueId,SocialFightTypeEnum.TaxCollectorFight);
      }
      
      public function hasAlliance() : Boolean
      {
         return this.socialFrame.hasAlliance;
      }
      
      public function getAlliance() : AllianceWrapper
      {
         return this.socialFrame.alliance;
      }
      
      public function getAllianceMembers() : Vector.<AllianceMemberInfo>
      {
         return this.socialFrame.alliancemembers;
      }
      
      public function isAllianceNameInvalid() : Boolean
      {
         if(this.socialFrame.alliance)
         {
            return this.socialFrame.alliance.realGroupName == "#NONAME#";
         }
         return false;
      }
      
      public function isAllianceTagInvalid() : Boolean
      {
         if(this.socialFrame.alliance)
         {
            return this.socialFrame.alliance.realAllianceTag == "#TAG#";
         }
         return false;
      }
      
      public function getAllianceNameAndTag(pPrismInfo:PrismInformation) : String
      {
         var name:* = null;
         var alPrismInfos:AlliancePrismInformation = null;
         var allianceName:String = null;
         var allianceTag:String = null;
         var tag:* = null;
         var myAllianceInfos:AllianceWrapper = null;
         var allianceFrame:AllianceFrame = null;
         if(pPrismInfo is AlliancePrismInformation)
         {
            alPrismInfos = pPrismInfo as AlliancePrismInformation;
            allianceName = alPrismInfos.alliance.allianceName;
            if(allianceName == "#NONAME#")
            {
               allianceName = I18n.getUiText("ui.social.noName");
            }
            allianceTag = alPrismInfos.alliance.allianceTag;
            if(allianceTag == "#TAG#")
            {
               allianceTag = I18n.getUiText("ui.alliance.noTag");
            }
            tag = " \\[" + allianceTag + "]";
            name = allianceName + tag;
         }
         else if(pPrismInfo is AllianceInsiderPrismInformation)
         {
            myAllianceInfos = this.getAlliance();
            name = myAllianceInfos.groupName + " \\[" + myAllianceInfos.allianceTag + "]";
         }
         else
         {
            allianceFrame = Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
            name = allianceFrame.getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id).alliance.groupName;
         }
         return name;
      }
      
      public function hasAllianceRight(pPlayerId:Number, pRightId:uint) : Boolean
      {
         var member:AllianceMemberInfo = null;
         var rank:RankInformation = null;
         if(!this.socialFrame.hasAlliance)
         {
            return false;
         }
         if(pPlayerId == PlayedCharacterManager.getInstance().id)
         {
            return this.socialFrame.playerAllianceRank.rights.indexOf(pRightId) != -1;
         }
         for each(member in this.socialFrame.alliancemembers)
         {
            if(member.id == pPlayerId)
            {
               rank = this.socialFrame.getAllianceRankById(member.rankId);
               return rank.rights.indexOf(pRightId) != -1;
            }
         }
         return false;
      }
      
      public function getCurrentJoinedFight() : SocialFightInfo
      {
         if(!this.allianceFrame)
         {
            return null;
         }
         return this.allianceFrame.currentJoinedFight;
      }
      
      public function getPrismSubAreaById(id:int) : PrismSubAreaWrapper
      {
         return this.allianceFrame.getPrismSubAreaById(id);
      }
      
      public function getFightingPrisms() : Dictionary
      {
         return SocialEntitiesManager.getInstance().prismsInFight;
      }
      
      public function getFightingPrism(pFightId:uint) : SocialEntityInFightWrapper
      {
         return SocialEntitiesManager.getInstance().prismsInFight[pFightId];
      }
      
      public function getChatSentence(timestamp:Number, fingerprint:String) : BasicChatSentence
      {
         var channel:Array = null;
         var sentence:BasicChatSentence = null;
         var found:Boolean = false;
         var se:BasicChatSentence = null;
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         for each(channel in chatFrame.getMessages())
         {
            for each(sentence in channel)
            {
               if(sentence.fingerprint == fingerprint && sentence.timestamp == timestamp)
               {
                  se = sentence;
                  found = true;
                  break;
               }
            }
            if(found)
            {
               break;
            }
         }
         return se;
      }
      
      public function getStatusIcon(statusId:uint) : Uri
      {
         var basePath:* = XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/icon_state_";
         switch(statusId)
         {
            case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
               return new Uri(basePath + "green.png");
            case PlayerStatusEnum.PLAYER_STATUS_AFK:
            case PlayerStatusEnum.PLAYER_STATUS_IDLE:
               return new Uri(basePath + "yellow.png");
            case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
               return new Uri(basePath + "blue.png");
            case PlayerStatusEnum.PLAYER_STATUS_SOLO:
               return new Uri(basePath + "red.png");
            default:
               return new Uri(basePath + "grey.png");
         }
      }
      
      public function getStatusText(statusId:uint, message:String = null) : String
      {
         var toReturn:String = null;
         switch(statusId)
         {
            case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
               toReturn = I18n.getUiText("ui.chat.status.availiable");
               break;
            case PlayerStatusEnum.PLAYER_STATUS_AFK:
               toReturn = I18n.getUiText("ui.chat.status.away");
               break;
            case PlayerStatusEnum.PLAYER_STATUS_IDLE:
               toReturn = I18n.getUiText("ui.chat.status.idle");
               break;
            case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
               toReturn = I18n.getUiText("ui.chat.status.private");
               break;
            case PlayerStatusEnum.PLAYER_STATUS_SOLO:
               toReturn = I18n.getUiText("ui.chat.status.solo");
               break;
            case PlayerStatusEnum.PLAYER_STATUS_OFFLINE:
               toReturn = I18n.getUiText("ui.chat.status.offline");
               break;
            default:
               return null;
         }
         if(message)
         {
            toReturn += I18n.getUiText("ui.common.colon") + message;
         }
         return toReturn;
      }
      
      public function get playerGuildRank() : RankInformation
      {
         return this.socialFrame.playerGuildRank;
      }
      
      public function get playerAllianceRank() : RankInformation
      {
         return this.socialFrame.playerAllianceRank;
      }
      
      public function getAllianceRanks() : Vector.<RankInformation>
      {
         return this.socialFrame.getAllianceRanks();
      }
      
      public function getAllianceRankById(id:uint) : RankInformation
      {
         return this.socialFrame.getAllianceRankById(id);
      }
      
      public function getNuggetsBalance() : Number
      {
         return this.allianceFrame.nuggetsBalance;
      }
   }
}
