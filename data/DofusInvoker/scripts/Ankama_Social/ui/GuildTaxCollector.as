package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import Ankama_Social.ui.data.SocialEntityDisplayInfo;
   import Ankama_Social.utils.JoinFightUtil;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class GuildTaxCollector
   {
      
      private static const PONY_LOCATION_LABEL_MAX_WIDTH:uint = 250;
      
      private static const PONY_POSITION_LABEL_WIDTH_OFFSET:uint = 10;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _myName:String;
      
      private var _poniesList:Array;
      
      private var _interactiveComponentsList:Dictionary;
      
      private var _defenders:Dictionary;
      
      private var _attackers:Dictionary;
      
      private var _poniesInfoForDisplay:Dictionary;
      
      private var _stateUriPath:String;
      
      private var _levelText:String;
      
      private var _prestigeText:String;
      
      private var _fightsTimerInfos:Array;
      
      public var lbl_ponyCount:Label;
      
      public var gd_pony:Grid;
      
      public function GuildTaxCollector()
      {
         this._poniesList = [];
         this._interactiveComponentsList = new Dictionary(true);
         this._defenders = new Dictionary(true);
         this._attackers = new Dictionary(true);
         this._poniesInfoForDisplay = new Dictionary(true);
         this._fightsTimerInfos = [];
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(SocialHookList.TaxCollectorListUpdate,this.onTaxCollectorListUpdate);
         this.sysApi.addHook(SocialHookList.GuildTaxCollectorRemoved,this.onGuildTaxCollectorRemoved);
         this.sysApi.addHook(SocialHookList.TaxCollectorError,this.onTaxCollectorError);
         this.sysApi.addHook(SocialHookList.TaxCollectorUpdate,this.onTaxCollectorUpdate);
         this.sysApi.addHook(SocialHookList.GuildFightEnnemiesListUpdate,this.onGuildFightEnnemiesListUpdate);
         this.sysApi.addHook(SocialHookList.GuildFightAlliesListUpdate,this.onGuildFightAlliesListUpdate);
         this._stateUriPath = this.uiApi.me().getConstant("state_uri");
         this._levelText = this.uiApi.getText("ui.common.short.level");
         this._prestigeText = this.uiApi.getText("ui.common.short.prestige");
         this._myName = this.playerApi.getPlayedCharacterInfo().name;
         this.onTaxCollectorListUpdate();
      }
      
      public function unload() : void
      {
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function updateGridLine(data:*, components:*, selected:Boolean) : void
      {
         var info:SocialEntityDisplayInfo = null;
         var textWidth:uint = 0;
         var textOffset:uint = 0;
         if(!this._interactiveComponentsList[components.gd_defenseTeam.name])
         {
            this.uiApi.addComponentHook(components.gd_defenseTeam,ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(components.gd_defenseTeam,"onSelectEmptyItem");
            this.uiApi.addComponentHook(components.gd_defenseTeam,ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(components.gd_defenseTeam,ComponentHookList.ON_ITEM_ROLL_OUT);
         }
         this._interactiveComponentsList[components.gd_defenseTeam.name] = data;
         if(!this._interactiveComponentsList[components.gd_attackTeam.name])
         {
            this.uiApi.addComponentHook(components.gd_attackTeam,ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(components.gd_attackTeam,ComponentHookList.ON_ITEM_ROLL_OUT);
         }
         this._interactiveComponentsList[components.gd_attackTeam.name] = data;
         if(!this._interactiveComponentsList[components.tx_attackTeam.name])
         {
            this.uiApi.addComponentHook(components.tx_attackTeam,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_attackTeam,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_attackTeam.name] = data;
         if(!this._interactiveComponentsList[components.tx_defenseTeam.name])
         {
            this.uiApi.addComponentHook(components.tx_defenseTeam,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_defenseTeam,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_defenseTeam.name] = data;
         if(!this._interactiveComponentsList[components.lbl_ponyPodsXp.name])
         {
            this.uiApi.addComponentHook(components.lbl_ponyPodsXp,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_ponyPodsXp,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.lbl_ponyPodsXp.name] = data;
         if(!this._interactiveComponentsList[components.ctr_mine.name])
         {
            this.uiApi.addComponentHook(components.ctr_mine,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.ctr_mine,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.ctr_mine.name] = data;
         if(!this._interactiveComponentsList[components.tx_mine.name])
         {
            this.uiApi.addComponentHook(components.tx_mine,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_mine,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_mine.name] = data;
         if(!this._interactiveComponentsList[components.tx_spectate.name])
         {
            this.uiApi.addComponentHook(components.tx_spectate,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.tx_spectate,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_spectate,ComponentHookList.ON_ROLL_OUT);
         }
         this._interactiveComponentsList[components.tx_spectate.name] = data;
         if(data)
         {
            info = this._poniesInfoForDisplay[data.uniqueId];
            components.lbl_ponyName.text = info.name;
            components.lbl_ponyLoc.text = info.location;
            components.lbl_ponyPosition.text = info.position;
            components.lbl_ponyPodsXp.text = info.podsAndXp;
            textWidth = PONY_LOCATION_LABEL_MAX_WIDTH;
            textOffset = PONY_POSITION_LABEL_WIDTH_OFFSET;
            if(components.lbl_ponyLoc.textWidth > textWidth)
            {
               components.lbl_ponyLoc.width = textWidth;
               textOffset *= 2;
            }
            else
            {
               textWidth = components.lbl_ponyLoc.textWidth;
            }
            components.lbl_ponyPosition.x = components.lbl_ponyLoc.x + textWidth + textOffset;
            if(info.belongsToMe)
            {
               components.ctr_mine.bgAlpha = 0.1;
               components.tx_mine.visible = true;
            }
            else
            {
               components.ctr_mine.bgAlpha = 0;
               components.tx_mine.visible = false;
            }
            if(data.state == TaxCollectorStateEnum.STATE_COLLECTING)
            {
               components.tx_attackTeam.visible = false;
               components.tx_defenseTeam.visible = false;
               components.tx_spectate.visible = false;
               components.pb_time.value = 0;
               components.pb_time.visible = false;
               components.gd_attackTeam.visible = false;
               components.gd_defenseTeam.visible = false;
            }
            else
            {
               components.pb_time.visible = true;
               components.tx_attackTeam.visible = true;
               components.tx_defenseTeam.visible = true;
               components.tx_spectate.visible = true;
               components.gd_attackTeam.dataProvider = this._attackers[data.uniqueId].charactersInfoList;
               components.gd_defenseTeam.dataProvider = this._defenders[data.uniqueId].charactersInfoList;
               components.gd_attackTeam.visible = true;
               components.gd_defenseTeam.visible = true;
               if(info.state == TaxCollectorStateEnum.STATE_FIGHTING)
               {
                  components.pb_time.value = 0;
                  components.pb_time.visible = false;
               }
               else if(data.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
               {
                  if(!components.pb_time.visible)
                  {
                     components.pb_time.visible = true;
                  }
                  components.pb_time.value = info.elapsedTimePercent;
               }
            }
            components.tx_fightState.uri = info.symbolUri;
         }
         else
         {
            components.tx_fightState.uri = null;
            components.pb_time.visible = false;
            components.tx_attackTeam.visible = false;
            components.tx_defenseTeam.visible = false;
            components.tx_spectate.visible = false;
            components.lbl_ponyName.text = "";
            components.lbl_ponyLoc.text = "";
            components.lbl_ponyPosition.text = "";
            components.lbl_ponyPodsXp.text = "";
            components.ctr_mine.bgAlpha = 0;
            components.tx_mine.visible = false;
            components.gd_attackTeam.visible = false;
            components.gd_defenseTeam.visible = false;
         }
      }
      
      private function refreshGrid() : void
      {
         var currentPoniesCount:uint = this._poniesList.length;
         var maxPoniesCount:uint = this.socialApi.getMaxCollectorCount();
         this.lbl_ponyCount.text = this.uiApi.getText("ui.social.guild.taxCollectorCount",currentPoniesCount,maxPoniesCount);
         this.gd_pony.dataProvider = this._poniesList;
      }
      
      private function refreshOneTaxCollector(ponyId:Number) : void
      {
         var currentPoniesCount:uint = this._poniesList.length;
         for(var i:int = 0; i < currentPoniesCount; )
         {
            if(this._poniesList[i].uniqueId == ponyId)
            {
               this.gd_pony.updateItem(i);
               return;
            }
            i++;
         }
      }
      
      private function prepareOneTaxCollectorData(data:TaxCollectorWrapper) : void
      {
         var previousState:int = -1;
         if(!this._poniesInfoForDisplay[data.uniqueId])
         {
            this._poniesInfoForDisplay[data.uniqueId] = new SocialEntityDisplayInfo(data);
         }
         else
         {
            previousState = this._poniesInfoForDisplay[data.uniqueId].state;
            this._poniesInfoForDisplay[data.uniqueId].podsAndXpUpdate(data);
            this._poniesInfoForDisplay[data.uniqueId].stateUpdate(data.state);
         }
         if(data.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP && previousState != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
         {
            this.addFightTimerInfo(data);
         }
         else if(data.state != TaxCollectorStateEnum.STATE_WAITING_FOR_HELP && previousState == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
         {
            this.removeFightTimerInfo(data.uniqueId);
         }
         this.updateStateSymbol(data.uniqueId,data.state);
         this.updateFightersLists(data.uniqueId,data.state);
      }
      
      private function updateStateSymbol(ponyId:Number, state:int) : void
      {
         if(state == TaxCollectorStateEnum.STATE_COLLECTING)
         {
            this._poniesInfoForDisplay[ponyId].symbolUri = this.uiApi.createUri(this._stateUriPath + state);
         }
         else
         {
            this._poniesInfoForDisplay[ponyId].symbolUri = this.uiApi.createUri(this._stateUriPath + 2);
         }
      }
      
      private function updateFightersLists(ponyId:Number, state:int) : void
      {
         var attackersText:* = null;
         var defendersText:* = null;
         var enemies:Array = null;
         var allies:Array = null;
         var fightTCData:SocialEntityInFightWrapper = null;
         var e2:SocialFightersWrapper = null;
         var a2:* = undefined;
         if(state == TaxCollectorStateEnum.STATE_COLLECTING)
         {
            this._attackers[ponyId] = null;
            this._defenders[ponyId] = null;
         }
         else
         {
            attackersText = this.uiApi.getText("ui.common.attackers") + " : \n";
            defendersText = this.uiApi.getText("ui.common.defenders") + " : \n";
            fightTCData = this.socialApi.getGuildFightingTaxCollector(ponyId);
            if(fightTCData && fightTCData.enemyCharactersInformations && fightTCData.enemyCharactersInformations.length > 0)
            {
               enemies = fightTCData.enemyCharactersInformations;
               for each(e2 in fightTCData.enemyCharactersInformations)
               {
                  attackersText += this.getFighterName(e2.playerCharactersInformations) + "\n";
               }
            }
            if(fightTCData && fightTCData.allyCharactersInformations && fightTCData.allyCharactersInformations.length > 0)
            {
               allies = fightTCData.allyCharactersInformations;
               for each(a2 in fightTCData.allyCharactersInformations)
               {
                  defendersText += this.getFighterName(a2.playerCharactersInformations) + ")\n";
               }
            }
            this.sysApi.log(2,"defendersText : " + defendersText);
            this._attackers[ponyId] = {
               "charactersInfoList":enemies,
               "charactersNameList":attackersText
            };
            this._defenders[ponyId] = {
               "charactersInfoList":allies,
               "charactersNameList":defendersText
            };
         }
      }
      
      private function addFightTimerInfo(data:TaxCollectorWrapper) : void
      {
         var timerInfo:Object = {
            "ponyId":data.uniqueId,
            "clockEnd":data.fightTime,
            "clockDuration":data.waitTimeForPlacement
         };
         if(this._fightsTimerInfos.length == 0)
         {
            this.sysApi.addEventListener(this.onEnterFrame,"time");
         }
         this._fightsTimerInfos.push(timerInfo);
      }
      
      private function removeFightTimerInfo(ponyId:Number) : void
      {
         var i:int = 0;
         for(var fightsCount:int = this._fightsTimerInfos.length; i < fightsCount; )
         {
            if(this._fightsTimerInfos[i].ponyId == ponyId)
            {
               this._fightsTimerInfos.splice(i,1);
               break;
            }
            i++;
         }
         if(this._fightsTimerInfos.length == 0)
         {
            this.sysApi.removeEventListener(this.onEnterFrame);
         }
      }
      
      private function onTaxCollectorListUpdate(infoType:uint = 0) : void
      {
         var tc1:TaxCollectorWrapper = null;
         var tc2:TaxCollectorWrapper = null;
         var tc0:TaxCollectorWrapper = null;
         var myrptc:TaxCollectorWrapper = null;
         var rptc:TaxCollectorWrapper = null;
         this._poniesList = [];
         var inPeacePonies:Array = [];
         var myInPeacePonies:Array = [];
         var taxCollectors:Dictionary = this.socialApi.getTaxCollectors();
         var myGuildId:int = this.socialApi.getGuild().guildId;
         for each(tc1 in taxCollectors)
         {
            if(tc1.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP && (!tc1.guild || tc1.guild.guildId == myGuildId))
            {
               this.prepareOneTaxCollectorData(tc1);
               this._poniesList.push(tc1);
            }
         }
         for each(tc2 in taxCollectors)
         {
            if(tc2.state == TaxCollectorStateEnum.STATE_FIGHTING && (!tc2.guild || tc2.guild.guildId == myGuildId))
            {
               this.prepareOneTaxCollectorData(tc2);
               this._poniesList.push(tc2);
            }
         }
         for each(tc0 in taxCollectors)
         {
            if(tc0.state == TaxCollectorStateEnum.STATE_COLLECTING && (!tc0.guild || tc0.guild.guildId == myGuildId))
            {
               this.prepareOneTaxCollectorData(tc0);
               if(tc0.additionalInformation.collectorCallerName == this._myName)
               {
                  myInPeacePonies.push(tc0);
               }
               else
               {
                  inPeacePonies.push(tc0);
               }
            }
         }
         myInPeacePonies.sortOn("pods",Array.NUMERIC | Array.DESCENDING);
         inPeacePonies.sortOn("pods",Array.NUMERIC | Array.DESCENDING);
         for each(myrptc in myInPeacePonies)
         {
            this._poniesList.push(myrptc);
         }
         for each(rptc in inPeacePonies)
         {
            this._poniesList.push(rptc);
         }
         this.refreshGrid();
      }
      
      private function onGuildTaxCollectorRemoved(tcId:Number) : void
      {
         this.onTaxCollectorListUpdate();
      }
      
      private function onTaxCollectorUpdate(id:Number) : void
      {
         var pony:TaxCollectorWrapper = null;
         var newTC:TaxCollectorWrapper = null;
         for each(pony in this._poniesList)
         {
            if(pony.uniqueId == id)
            {
               pony = this.socialApi.getTaxCollectors()[id];
               this.prepareOneTaxCollectorData(pony);
               this.refreshOneTaxCollector(id);
               return;
            }
         }
         newTC = this.socialApi.getTaxCollectors()[id];
         if(!newTC.guild || newTC.guild.guildId == this.socialApi.getGuild().guildId)
         {
            this._poniesList.push(newTC);
            this.prepareOneTaxCollectorData(newTC);
            this.refreshGrid();
         }
      }
      
      private function onGuildFightEnnemiesListUpdate(type:int, ponyId:Number) : void
      {
         var e2:* = undefined;
         if(type != 0)
         {
            return;
         }
         var enemies:Array = this.socialApi.getGuildFightingTaxCollector(ponyId).enemyCharactersInformations;
         var enemiesNames:* = this.uiApi.getText("ui.common.attackers") + " : \n";
         if(enemies && enemies.length > 0)
         {
            for each(e2 in enemies)
            {
               enemiesNames += this.getFighterName(e2.playerCharactersInformations) + "\n";
            }
         }
         this._attackers[ponyId] = {
            "charactersInfoList":enemies,
            "charactersNameList":enemiesNames
         };
         this.refreshOneTaxCollector(ponyId);
      }
      
      private function onGuildFightAlliesListUpdate(type:int, ponyId:Number) : void
      {
         var a2:* = undefined;
         if(type != 0)
         {
            return;
         }
         var allies:Array = this.socialApi.getGuildFightingTaxCollector(ponyId).allyCharactersInformations;
         var alliesNames:* = this.uiApi.getText("ui.common.defenders") + " : \n";
         if(allies && allies.length > 0)
         {
            for each(a2 in allies)
            {
               alliesNames += this.getFighterName(a2.playerCharactersInformations) + "\n";
            }
         }
         this._defenders[ponyId] = {
            "charactersInfoList":allies,
            "charactersNameList":alliesNames
         };
         this.refreshOneTaxCollector(ponyId);
      }
      
      private function getFighterName(fighterInfo:CharacterMinimalPlusLookInformations) : String
      {
         var breed:Breed = null;
         var breedText:* = null;
         var fullName:* = null;
         if(fighterInfo.breed > 0)
         {
            breed = this.dataApi.getBreed(fighterInfo.breed);
            breedText = breed.name + " ";
         }
         else
         {
            breedText = "";
         }
         if(fighterInfo.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            fullName = fighterInfo.name + "  (" + breedText + this._prestigeText + (fighterInfo.level - ProtocolConstantsEnum.MAX_LEVEL) + ")";
         }
         else
         {
            fullName = fighterInfo.name + "  (" + breedText + this._levelText + fighterInfo.level + ")";
         }
         return fullName;
      }
      
      private function onTaxCollectorError(error:uint) : void
      {
         this.sysApi.log(16,"Tax collector error n°" + error);
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:* = null;
         var data:Object = null;
         var fightersInfo:Object = null;
         var info:SocialEntityDisplayInfo = null;
         if(target.name.indexOf("tx_attackTeam") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            fightersInfo = this._attackers[data.uniqueId];
            if(fightersInfo && fightersInfo.charactersNameList != "")
            {
               text = fightersInfo.charactersNameList;
            }
         }
         else if(target.name.indexOf("tx_defenseTeam") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            fightersInfo = this._defenders[data.uniqueId];
            if(fightersInfo && fightersInfo.charactersNameList != "")
            {
               text = fightersInfo.charactersNameList;
            }
         }
         else if(target.name.indexOf("ctr_mine") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(!data)
            {
               return;
            }
            info = this._poniesInfoForDisplay[data.uniqueId];
            if(info)
            {
               text = info.description;
            }
         }
         else if(target.name.indexOf("tx_mine") != -1)
         {
            text = this.uiApi.getText("ui.social.taxcollector.mine");
         }
         else if(target.name.indexOf("tx_spectate") != -1)
         {
            text = this.uiApi.getText("ui.spectator.clicToJoin");
         }
         else if(target.name.indexOf("lbl_ponyPodsXp") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            if(data)
            {
               if(data.itemsValue > 0)
               {
                  text = this.uiApi.getText("ui.social.taxCollector.itemsValue",this.utilApi.kamasToString(data.itemsValue));
                  if(data.kamas)
                  {
                     text += "\n";
                  }
               }
               if(data.kamas)
               {
                  text += this.uiApi.getText("ui.social.taxCollector.kamasCollected",this.utilApi.kamasToString(data.kamas,""));
               }
            }
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var attackers:Object = null;
         var firstAttacker:SocialFightersWrapper = null;
         if(target.name.indexOf("tx_spectate") != -1)
         {
            data = this._interactiveComponentsList[target.name];
            attackers = this._attackers[data.uniqueId];
            if(data.state != TaxCollectorStateEnum.STATE_COLLECTING && attackers && attackers.charactersInfoList && attackers.charactersInfoList.length > 0)
            {
               firstAttacker = attackers.charactersInfoList[0];
               this.sysApi.sendAction(new GameFightSpectatePlayerRequestAction([firstAttacker.playerCharactersInformations.id]));
            }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var data:Object = null;
         if(target.name.indexOf("gd_defenseTeam") != -1 && selectMethod == SelectMethodEnum.CLICK)
         {
            data = this._interactiveComponentsList[target.name];
            if((target as Grid).selectedItem.hasOwnProperty("playerCharactersInformations"))
            {
               if((target as Grid).selectedItem.playerCharactersInformations.id != this.playerApi.id())
               {
                  JoinFightUtil.swapPlaces(0,data.uniqueId,(target as Grid).selectedItem.playerCharactersInformations);
               }
               else
               {
                  JoinFightUtil.leave(0,data.uniqueId);
               }
            }
         }
      }
      
      public function onSelectEmptyItem(target:GraphicContainer, selectMethod:uint) : void
      {
         var data:Object = null;
         if(target.name.indexOf("gd_defenseTeam") != -1 && selectMethod == SelectMethodEnum.CLICK)
         {
            data = this._interactiveComponentsList[target.name];
            JoinFightUtil.join(0,data.uniqueId);
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var text:String = null;
         if(item && item.data)
         {
            text = this.getFighterName(item.data.playerCharactersInformations);
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onEnterFrame(e:Event) : void
      {
         var percentTime:Number = NaN;
         var fightWithTimer:Object = null;
         var fightId:Number = NaN;
         var clock:uint = getTimer();
         var fightsToRemoveIds:Array = [];
         for each(fightWithTimer in this._fightsTimerInfos)
         {
            percentTime = (fightWithTimer.clockDuration - (fightWithTimer.clockEnd - clock)) / fightWithTimer.clockDuration;
            percentTime = Math.round(percentTime * 100) / 100;
            if(clock >= fightWithTimer.clockEnd)
            {
               this._poniesInfoForDisplay[fightWithTimer.ponyId].startFight();
               this.updateStateSymbol(fightWithTimer.ponyId,TaxCollectorStateEnum.STATE_FIGHTING);
               fightsToRemoveIds.push(fightWithTimer.uniqueId);
            }
            if(this._poniesInfoForDisplay[fightWithTimer.ponyId].elapsedTimePercent != percentTime)
            {
               this._poniesInfoForDisplay[fightWithTimer.ponyId].elapsedTimePercent = percentTime;
               this.refreshOneTaxCollector(fightWithTimer.ponyId);
            }
         }
         for each(fightId in fightsToRemoveIds)
         {
            this.removeFightTimerInfo(fightId);
         }
      }
   }
}
