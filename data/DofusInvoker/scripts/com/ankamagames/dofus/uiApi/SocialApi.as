package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SocialCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
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
      
      public function getWarnOnMemberConnec() : Boolean
      {
         return this.socialFrame.warnMemberConnec;
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
      
      public function getGuildMembers() : Vector.<GuildMember>
      {
         return this.socialFrame.guildmembers;
      }
      
      public function getGuildRights() : Array
      {
         return GuildWrapper.guildRights;
      }
      
      public function getGuildByid(id:int) : GuildFactSheetWrapper
      {
         return this.socialFrame.getGuildById(id);
      }
      
      public function hasGuildRight(pPlayerId:Number, pRightId:String) : Boolean
      {
         var member:GuildMember = null;
         var temporaryWrapper:GuildWrapper = null;
         if(!this.socialFrame.hasGuild)
         {
            return false;
         }
         if(pPlayerId == PlayedCharacterManager.getInstance().id)
         {
            return this.socialFrame.guild.hasRight(pRightId);
         }
         for each(member in this.socialFrame.guildmembers)
         {
            if(member.id == pPlayerId)
            {
               temporaryWrapper = GuildWrapper.create(0,"",null,member.rights);
               return temporaryWrapper.hasRight(pRightId);
            }
         }
         return false;
      }
      
      public function hasGuildRank(pPlayerId:Number, rankId:int) : Boolean
      {
         var member:GuildMember = null;
         if(!this.socialFrame.hasGuild)
         {
            return false;
         }
         for each(member in this.socialFrame.guildmembers)
         {
            if(member.id == pPlayerId)
            {
               return member.rank == rankId;
            }
         }
         return false;
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
            return this.socialFrame.guild.realGuildName == "#NONAME#";
         }
         return false;
      }
      
      public function getMaxCollectorCount() : uint
      {
         return TaxCollectorsManager.getInstance().maxTaxCollectorsCount;
      }
      
      public function getTaxCollectors() : Dictionary
      {
         return TaxCollectorsManager.getInstance().taxCollectors;
      }
      
      public function getTaxCollector(id:Number) : TaxCollectorWrapper
      {
         return TaxCollectorsManager.getInstance().taxCollectors[id];
      }
      
      public function getGuildFightingTaxCollectors() : Dictionary
      {
         return TaxCollectorsManager.getInstance().guildTaxCollectorsFighters;
      }
      
      public function getGuildFightingTaxCollector(pFightId:Number) : SocialEntityInFightWrapper
      {
         return TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pFightId];
      }
      
      public function getAllFightingTaxCollectors() : Dictionary
      {
         return TaxCollectorsManager.getInstance().allTaxCollectorsInFight;
      }
      
      public function getAllFightingTaxCollector(pFightId:Number) : SocialEntityInFightWrapper
      {
         return TaxCollectorsManager.getInstance().allTaxCollectorsInFight[pFightId];
      }
      
      public function isPlayerDefender(pType:int, pPlayerId:Number, pSocialFightId:Number) : Boolean
      {
         var seifw:SocialEntityInFightWrapper = null;
         var defender:SocialFightersWrapper = null;
         if(pType == 0)
         {
            seifw = TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pSocialFightId];
            if(!seifw)
            {
               seifw = TaxCollectorsManager.getInstance().allTaxCollectorsInFight[pSocialFightId];
            }
         }
         else if(pType == 1)
         {
            seifw = TaxCollectorsManager.getInstance().prismsFighters[pSocialFightId];
         }
         if(seifw)
         {
            for each(defender in seifw.allyCharactersInformations)
            {
               if(defender.playerCharactersInformations.id == pPlayerId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function hasAlliance() : Boolean
      {
         return this.allianceFrame.hasAlliance;
      }
      
      public function getAlliance() : AllianceWrapper
      {
         return this.allianceFrame.alliance;
      }
      
      public function getAllianceById(id:int) : AllianceWrapper
      {
         return this.allianceFrame.getAllianceById(id);
      }
      
      public function getAllianceGuilds() : Vector.<GuildFactSheetWrapper>
      {
         return this.allianceFrame.alliance.guilds;
      }
      
      public function isAllianceNameInvalid() : Boolean
      {
         if(this.allianceFrame.alliance)
         {
            return this.allianceFrame.alliance.realAllianceName == "#NONAME#";
         }
         return false;
      }
      
      public function isAllianceTagInvalid() : Boolean
      {
         if(this.allianceFrame.alliance)
         {
            return this.allianceFrame.alliance.realAllianceTag == "#TAG#";
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
         if(pPrismInfo is AlliancePrismInformation)
         {
            alPrismInfos = pPrismInfo as AlliancePrismInformation;
            allianceName = alPrismInfos.alliance.allianceName;
            if(allianceName == "#NONAME#")
            {
               allianceName = I18n.getUiText("ui.guild.noName");
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
            name = myAllianceInfos.allianceName + " \\[" + myAllianceInfos.allianceTag + "]";
         }
         return name;
      }
      
      public function getPrismSubAreaById(id:int) : PrismSubAreaWrapper
      {
         return this.allianceFrame.getPrismSubAreaById(id);
      }
      
      public function getFightingPrisms() : Dictionary
      {
         return TaxCollectorsManager.getInstance().prismsFighters;
      }
      
      public function getFightingPrism(pFightId:uint) : SocialEntityInFightWrapper
      {
         return TaxCollectorsManager.getInstance().prismsFighters[pFightId];
      }
      
      public function isPlayerPrismDefender(pPlayerId:Number, pSubAreaId:int) : Boolean
      {
         var defender:SocialFightersWrapper = null;
         var p:SocialEntityInFightWrapper = TaxCollectorsManager.getInstance().prismsFighters[pSubAreaId];
         if(p)
         {
            for each(defender in p.allyCharactersInformations)
            {
               if(defender.playerCharactersInformations.id == pPlayerId)
               {
                  return true;
               }
            }
         }
         return false;
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
   }
}
