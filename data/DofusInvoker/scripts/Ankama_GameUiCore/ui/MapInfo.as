package Ankama_GameUiCore.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.datacenter.breach.BreachInfinityLevel;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkOpenAnomaly;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   
   public class MapInfo
   {
      
      private static const OUTLINE_BONUS_COLOR:int = 3815990;
      
      private static const OUTLINE_ANOMALY_COLOR:int = 4658310;
      
      private static const OUTLINE_WIDTH:int = 2;
       
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      private var _serverHeroicActivated:Boolean;
      
      private var _currentSubAreaId:int;
      
      private var _currentMap:WorldPointWrapper;
      
      private var _allianceEmblemBgShape:uint;
      
      private var _allianceEmblemBgColor:uint;
      
      private var _allianceEmblemIconShape:uint;
      
      private var _allianceEmblemIconColor:uint;
      
      private var _showAlliance:Boolean;
      
      private var _allowAggression:Boolean;
      
      private var _currentAllianceId:int;
      
      private var _currentPlayerAlignment:ActorExtendedAlignmentInformations;
      
      private var _myVeryOwnAlliance:AllianceWrapper;
      
      private var _inFight:Boolean;
      
      private var _zoneBonusUri:String;
      
      private var _zoneMalusUri:String;
      
      private var _anomalyUri:String;
      
      private var _anomalyClosingTime:Number;
      
      private var _subAreaRewardRate:int;
      
      private var outlineFilter:GlowFilter;
      
      public var lbl_info:Label;
      
      public var lbl_coordAndLevel:Label;
      
      public var lbl_noMapTemplateWarning:Label;
      
      public var tx_warning:Texture;
      
      public var tx_mapReward:Texture;
      
      public var tx_anomaly:Texture;
      
      public var infoContainer:GraphicContainer;
      
      public var tx_allianceEmblemBack:Texture;
      
      public var tx_allianceEmblemUp:Texture;
      
      public var lbl_alliance:Label;
      
      public var lbl_rewardBonus:Label;
      
      public function MapInfo()
      {
         this.outlineFilter = new GlowFilter();
         super();
      }
      
      public function main(... args) : void
      {
         var hudPath:String = this.uiApi.me().getConstant("hud");
         this._zoneBonusUri = hudPath + "icon_bonus_reward.png";
         this._zoneMalusUri = hudPath + "icon_malus_reward.png";
         this._anomalyUri = hudPath + "icon_anomaly.png";
         this.tx_allianceEmblemBack.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_allianceEmblemBack,"onTextureReady");
         this.tx_allianceEmblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_allianceEmblemUp,"onTextureReady");
         this.sysApi.addHook(HookList.MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         this.sysApi.addHook(BreachHookList.BreachMapInfos,this.onBreachMapInfos);
         this.sysApi.addHook(HookList.AnomalyMapInfos,this.onAnomalyMapInfos);
         this.sysApi.addHook(HookList.AnomalyState,this.onAnomalyState);
         this.sysApi.addHook(HookList.MapRewardRate,this.onMapRewardRate);
         this.sysApi.addHook(SocialHookList.AllianceUpdateInformations,this.onAllianceUpdateInformations);
         this.sysApi.addHook(PrismHookList.PrismsList,this.onPrismsList);
         this.sysApi.addHook(PrismHookList.PrismsListUpdate,this.onPrismsListUpdate);
         this.sysApi.addHook(HookList.HouseEntered,this.houseEntered);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.GameFightLeave,this.onGameFightLeave);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(PrismHookList.PvpAvaStateChange,this.onPvpAvaStateChange);
         this.sysApi.addHook(HookList.ConfigPropertyChange,this.onConfigChange);
         this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_mapReward,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_mapReward,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_mapReward,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_anomaly,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_anomaly,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_anomaly,ComponentHookList.ON_RELEASE);
         this._serverHeroicActivated = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER);
         this._myVeryOwnAlliance = this.socialApi.getAlliance();
         this.outlineFilter.blurX = this.outlineFilter.blurY = OUTLINE_WIDTH;
         this.outlineFilter.color = 0;
         this.outlineFilter.quality = BitmapFilterQuality.HIGH;
         this.outlineFilter.strength = 100;
         this.tx_mapReward.handCursor = true;
         this.tx_anomaly.handCursor = true;
         this.lbl_rewardBonus.handCursor = true;
         this.lbl_rewardBonus.useTooltipExtension = false;
      }
      
      public function set visible(visible:Boolean) : void
      {
         this.infoContainer.visible = visible;
      }
      
      public function onPrismsList(pPrismsInfo:Object) : void
      {
         var prismSubAreaInformation:PrismSubAreaWrapper = null;
         if(!this._showAlliance)
         {
            prismSubAreaInformation = this.socialApi.getPrismSubAreaById(this._currentSubAreaId);
            if(prismSubAreaInformation && prismSubAreaInformation.mapId != -1)
            {
               this.showAllianceInfo(!prismSubAreaInformation.alliance ? this._myVeryOwnAlliance : prismSubAreaInformation.alliance);
               this._showAlliance = true;
            }
         }
      }
      
      public function onPrismsListUpdate(pPrismSubAreas:Object) : void
      {
         var subAreaId:int = 0;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         for each(subAreaId in pPrismSubAreas)
         {
            if(this._currentSubAreaId == subAreaId)
            {
               prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
               if(prismSubAreaInfo.mapId != -1)
               {
                  if(this._currentAllianceId == prismSubAreaInfo.alliance.allianceId)
                  {
                     this._currentAllianceId = -1;
                  }
                  this.showAllianceInfo(!prismSubAreaInfo.alliance ? this._myVeryOwnAlliance : prismSubAreaInfo.alliance);
                  this._showAlliance = true;
               }
               else
               {
                  this._currentAllianceId = -1;
                  this._showAlliance = false;
                  this.lbl_alliance.visible = false;
                  this.tx_allianceEmblemBack.visible = false;
                  this.tx_allianceEmblemUp.visible = false;
               }
            }
         }
      }
      
      public function onAllianceUpdateInformations() : void
      {
         this._myVeryOwnAlliance = this.socialApi.getAlliance();
         if(this._currentAllianceId == this._myVeryOwnAlliance.allianceId)
         {
            this._currentAllianceId = -1;
            this.showAllianceInfo(this._myVeryOwnAlliance);
         }
      }
      
      private function showAllianceInfo(pAllianceInfo:AllianceWrapper) : void
      {
         var allianceEmblemBackWrapper:EmblemWrapper = null;
         var allianceEmblemUpWrapper:EmblemWrapper = null;
         if(!this._inFight && this._currentAllianceId != pAllianceInfo.allianceId)
         {
            this.lbl_alliance.text = this.chatApi.getAllianceLink(pAllianceInfo,"[" + pAllianceInfo.allianceTag + "]");
            this.lbl_alliance.visible = true;
            if(this._allianceEmblemBgShape != pAllianceInfo.backEmblem.idEmblem || this._allianceEmblemBgColor != pAllianceInfo.backEmblem.color || !this._showAlliance)
            {
               this._allianceEmblemBgShape = pAllianceInfo.backEmblem.idEmblem;
               this._allianceEmblemBgColor = pAllianceInfo.backEmblem.color;
               this.tx_allianceEmblemBack.visible = false;
               allianceEmblemBackWrapper = EmblemWrapper.create(this._allianceEmblemBgShape,EmblemWrapper.BACK,this._allianceEmblemBgColor);
               this.tx_allianceEmblemBack.uri = allianceEmblemBackWrapper.fullSizeIconUri;
            }
            if(this._allianceEmblemIconShape != pAllianceInfo.upEmblem.idEmblem || this._allianceEmblemIconColor != pAllianceInfo.upEmblem.color || !this._showAlliance)
            {
               this._allianceEmblemIconShape = pAllianceInfo.upEmblem.idEmblem;
               this._allianceEmblemIconColor = pAllianceInfo.upEmblem.color;
               this.tx_allianceEmblemUp.visible = false;
               allianceEmblemUpWrapper = EmblemWrapper.create(this._allianceEmblemIconShape,EmblemWrapper.UP,this._allianceEmblemIconColor);
               this.tx_allianceEmblemUp.uri = allianceEmblemUpWrapper.fullSizeIconUri;
            }
            this._currentAllianceId = pAllianceInfo.allianceId;
            this.renderUpdate();
         }
      }
      
      private function updateAttackWarning() : void
      {
         if(this._inFight)
         {
            return;
         }
         this._allowAggression = this.tx_warning.visible = false;
         var mapPos:MapPosition = this.mapApi.getMapPositionById(this._currentMap.mapId);
         if(mapPos && !mapPos.allowAggression)
         {
            return;
         }
         var subarea:SubArea = this.dataApi.getSubArea(this._currentSubAreaId);
         if(subarea && subarea.basicAccountAllowed)
         {
            return;
         }
         if(!this._serverHeroicActivated && (!this._currentPlayerAlignment || !this._myVeryOwnAlliance || (this._currentPlayerAlignment.aggressable == AggressableStatusEnum.AvA_DISQUALIFIED || this._currentPlayerAlignment.aggressable == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE || this._currentPlayerAlignment.aggressable == AggressableStatusEnum.NON_AGGRESSABLE || this._currentPlayerAlignment.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)))
         {
            return;
         }
         this._allowAggression = this.tx_warning.visible = true;
         this.renderUpdate();
      }
      
      private function onBreachMapInfos(bosses:Vector.<MonsterInGroupLightInformations>) : void
      {
         var infinityLevel:BreachInfinityLevel = this.dataApi.getBreachInfinityLevelByLevel(this.breachApi.getInfinityLevel());
         this.lbl_info.text = this.dataApi.getBreachWorldMapSectorByFloor(Math.min(this.breachApi.getFloor(),this.dataApi.getBreachMaxStageWorldMapCoordinate().mapStage)).name;
         if(infinityLevel)
         {
            this.lbl_info.text += " " + infinityLevel.name;
         }
         this.lbl_coordAndLevel.text = this.uiApi.getText("ui.breach.floor",this.breachApi.getFloor());
         if(this.breachApi.getRoom() > 0)
         {
            this.lbl_coordAndLevel.text += " - " + this.uiApi.getText("ui.breach.roomNumber",this.breachApi.getRoom());
         }
         this._currentAllianceId = -1;
         this._showAlliance = false;
         this.lbl_alliance.visible = false;
         this.tx_allianceEmblemBack.visible = false;
         this.tx_allianceEmblemUp.visible = false;
      }
      
      private function onAnomalyMapInfos(level:int, closingTime:Number) : void
      {
         this.lbl_info.text = this.dataApi.getMapInfo(this._currentMap.mapId).name + " (" + this.dataApi.getMapInfo(this._currentMap.mapId).subArea.name + ")";
         this.lbl_coordAndLevel.text = this.uiApi.getText("ui.common.level") + " " + level;
         this._anomalyClosingTime = closingTime;
         this._currentAllianceId = -1;
         this._showAlliance = false;
         this.lbl_alliance.visible = false;
         this.tx_allianceEmblemBack.visible = false;
         this.tx_allianceEmblemUp.visible = false;
      }
      
      private function onAnomalyState(open:Boolean, closingTime:Number, subAreaId:int) : void
      {
         if(subAreaId != this.playerApi.currentSubArea().id)
         {
            return;
         }
         if(!open)
         {
            this.onMapRewardRate(this._subAreaRewardRate);
            return;
         }
         this._anomalyClosingTime = closingTime;
         this.tx_anomaly.visible = open && subAreaId > 0;
         this.tx_mapReward.visible = !this.tx_anomaly.visible && this.tx_mapReward.visible;
         this.tx_anomaly.uri = this.uiApi.createUri(this._anomalyUri);
         this.lbl_rewardBonus.text = this._subAreaRewardRate + "%";
         if(this.tx_anomaly.visible)
         {
            this.outlineFilter.color = OUTLINE_ANOMALY_COLOR;
         }
         this.renderUpdate();
      }
      
      private function onMapRewardRate(subAreaRate:int) : void
      {
         this._subAreaRewardRate = subAreaRate;
         if(this._subAreaRewardRate >= 50)
         {
            this.tx_mapReward.uri = this.uiApi.createUri(this._zoneBonusUri);
         }
         else
         {
            this.tx_mapReward.uri = this.uiApi.createUri(this._zoneMalusUri);
         }
         this.outlineFilter.color = OUTLINE_BONUS_COLOR;
         this.lbl_rewardBonus.text = subAreaRate + "%";
         this.tx_mapReward.visible = true;
         this.tx_anomaly.visible = false;
         this.renderUpdate();
      }
      
      public function onMapComplementaryInformationsData(map:WorldPointWrapper, subAreaId:uint, show:Boolean) : void
      {
         var mapInfo:MapPosition = null;
         var currentPrism:PrismSubAreaWrapper = null;
         var areaName:String = null;
         var subArea:SubArea = null;
         var subAreaName:String = null;
         var subAreaLevel:String = null;
         var mapName:String = null;
         this._currentSubAreaId = subAreaId;
         this._currentMap = map as WorldPointWrapper;
         this.tx_mapReward.visible = false;
         this.tx_anomaly.visible = false;
         this.lbl_rewardBonus.visible = false;
         this.lbl_coordAndLevel.visible = true;
         if(show)
         {
            if(!this.breachApi.isInBreach())
            {
               this.infoContainer.visible = true;
               mapInfo = this.dataApi.getMapInfo(this._currentMap.mapId);
               this.lbl_coordAndLevel.text = this._currentMap.outdoorX + "," + this._currentMap.outdoorY;
               this.lbl_coordAndLevel.visible = this.playerApi.currentSubArea().id != DataEnum.SUBAREA_INFINITE_BREACH;
               if(!mapInfo || !mapInfo.name)
               {
                  try
                  {
                     areaName = this.dataApi.getArea(this.dataApi.getSubArea(subAreaId).areaId).name;
                     subArea = this.dataApi.getSubArea(subAreaId);
                     subAreaName = subArea.name;
                     subAreaLevel = subArea.level.toString();
                  }
                  catch(e:Error)
                  {
                  }
                  if(!subAreaName)
                  {
                     subAreaName = "???????";
                  }
                  if(!areaName)
                  {
                     areaName = "???????";
                  }
                  if(!subAreaLevel)
                  {
                     subAreaLevel = "";
                  }
                  mapName = "";
                  if(areaName.length > 1 && areaName.substr(0,2) != "//")
                  {
                     mapName += areaName;
                  }
                  if(subAreaName.length > 1 && subAreaName != areaName && subAreaName.substr(0,2) != "//")
                  {
                     mapName += " (" + subAreaName + ")";
                  }
                  this.lbl_info.text = mapName;
                  this.lbl_coordAndLevel.text += ", " + this.uiApi.getText("ui.common.averageLevel") + " " + subAreaLevel;
               }
               else
               {
                  this.lbl_info.text = mapInfo.name;
               }
               if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING)
               {
                  this.lbl_noMapTemplateWarning.visible = !mapInfo.mapHasTemplate;
               }
               currentPrism = this.socialApi.getPrismSubAreaById(this._currentSubAreaId);
               if(currentPrism && currentPrism.mapId != -1)
               {
                  this.showAllianceInfo(!currentPrism.alliance ? this._myVeryOwnAlliance : currentPrism.alliance);
                  this._showAlliance = true;
               }
               else
               {
                  this._currentAllianceId = -1;
                  this._showAlliance = false;
                  this.lbl_alliance.visible = false;
                  this.tx_allianceEmblemBack.visible = false;
                  this.tx_allianceEmblemUp.visible = false;
               }
            }
            else if(!this.infoContainer.visible)
            {
               this.onBreachMapInfos(null);
               this.infoContainer.visible = true;
            }
         }
         else
         {
            this.infoContainer.visible = false;
         }
         this.updateAttackWarning();
         this.renderUpdate();
      }
      
      public function onTextureReady(pTexture:Texture) : void
      {
         var icon:EmblemSymbol = null;
         if(!this._showAlliance)
         {
            return;
         }
         if(pTexture == this.tx_allianceEmblemBack)
         {
            this.utilApi.changeColor(this.tx_allianceEmblemBack.getChildByName("back"),this._allianceEmblemBgColor,1);
            this.tx_allianceEmblemBack.mouseEnabled = this.tx_allianceEmblemBack.mouseChildren = false;
            this.tx_allianceEmblemBack.visible = true;
         }
         else if(pTexture == this.tx_allianceEmblemUp)
         {
            icon = this.dataApi.getEmblemSymbol(this._allianceEmblemIconShape);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(this.tx_allianceEmblemUp,this._allianceEmblemIconColor,0);
            }
            else
            {
               this.utilApi.changeColor(this.tx_allianceEmblemUp,this._allianceEmblemIconColor,0,true);
            }
            this.tx_allianceEmblemUp.mouseEnabled = this.tx_allianceEmblemUp.mouseChildren = false;
            this.tx_allianceEmblemUp.visible = true;
         }
      }
      
      public function onGameFightJoin(... rest) : void
      {
         this._inFight = true;
         this.lbl_alliance.visible = false;
         this.tx_allianceEmblemBack.visible = false;
         this.tx_allianceEmblemUp.visible = false;
         this.tx_warning.visible = false;
      }
      
      public function onGameFightEnd(... rest) : void
      {
         this._inFight = false;
         this.lbl_alliance.visible = this.tx_allianceEmblemBack.visible = this.tx_allianceEmblemUp.visible = this._showAlliance;
         this.tx_warning.visible = this._allowAggression;
      }
      
      public function onGameFightLeave(charId:Number) : void
      {
         this._inFight = false;
         this.lbl_alliance.visible = this.tx_allianceEmblemBack.visible = this.tx_allianceEmblemUp.visible = this._showAlliance;
         this.tx_warning.visible = this._allowAggression;
      }
      
      private function onPvpAvaStateChange(status:uint, probationTime:uint) : void
      {
         if(this._currentMap)
         {
            this._currentPlayerAlignment = this.playerApi.characteristics().alignmentInfos;
            this.updateAttackWarning();
         }
      }
      
      public function onConfigChange(target:String, name:String, value:*, oldValue:*) : void
      {
         if(target == "dofus" && name == "smallScreenFont")
         {
            this.renderUpdate();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target != this.tx_anomaly && target != this.tx_mapReward && target != this.lbl_rewardBonus)
         {
            return;
         }
         HyperlinkOpenAnomaly.open();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var timeLeft:int = 0;
         var hours:int = 0;
         var hoursStr:String = null;
         var mins:int = 0;
         var minsStr:String = null;
         var seconds:int = 0;
         var secondsStr:String = null;
         var timeLeftStr:String = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         switch(target)
         {
            case this.tx_warning:
               text = this.uiApi.getText("ui.map.warningAttack");
               break;
            case this.tx_mapReward:
               text = this.uiApi.getText("ui.anomaly.mapInfos.bonus",this._subAreaRewardRate + "%");
               break;
            case this.tx_anomaly:
               timeLeft = this._anomalyClosingTime - new Date().valueOf();
               hours = Math.ceil(timeLeft % 86400000 / 3600000);
               hoursStr = hours <= 1 ? "" : hours - 1 + this.uiApi.processText(this.uiApi.getText("ui.time.short.hour"),"m",hours - 1 == 1,hours - 1 == 0);
               mins = Math.ceil(timeLeft % 3600000 / 60000);
               minsStr = mins <= 1 ? "" : mins - 1 + "" + (!!hoursStr ? "" : " " + this.uiApi.processText(this.uiApi.getText("ui.time.minutes"),"m",mins - 1 == 1,mins - 1 == 0));
               if(mins <= 10 && hoursStr)
               {
                  minsStr = "0" + minsStr;
               }
               seconds = Math.ceil(timeLeft % 60000 / 1000);
               secondsStr = seconds <= 1 ? "" : seconds - 1 + " " + this.uiApi.processText(this.uiApi.getText("ui.time.seconds"),"m",seconds - 1 == 1,seconds - 1 == 0);
               timeLeftStr = hoursStr + minsStr;
               if(timeLeftStr == "")
               {
                  timeLeftStr = secondsStr;
               }
               text = this.uiApi.getText("ui.anomaly.mapInfos.anomaly",this._subAreaRewardRate + "%") + (timeLeftStr != "" ? " " + this.uiApi.getText("ui.anomaly.mapInfos.anomalyClosingTime",timeLeftStr) : "");
         }
         if(text && text != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function houseEntered(isPlayerHouse:Boolean, worldX:int, worldY:int, houseWrapper:HouseWrapper) : void
      {
         this.lbl_coordAndLevel.text = worldX + "," + worldY;
      }
      
      public function renderUpdate() : void
      {
         this.lbl_coordAndLevel.fullWidthAndHeight();
         var posX:int = this.lbl_coordAndLevel.x + this.lbl_coordAndLevel.width + 10;
         if(this.tx_warning.visible)
         {
            this.tx_warning.x = posX;
            posX += this.tx_warning.width + 10;
         }
         if(this.tx_mapReward.visible)
         {
            this.tx_mapReward.x = posX;
         }
         else if(this.tx_anomaly.visible)
         {
            this.tx_anomaly.x = posX;
         }
         this.lbl_rewardBonus.visible = this.tx_anomaly.visible || this.tx_mapReward.visible;
         this.lbl_rewardBonus.fullWidthAndHeight(0,10);
         this.lbl_rewardBonus.x = posX - Math.floor((this.lbl_rewardBonus.width - this.tx_mapReward.width) / 2);
         this.applyFilter();
         if(!this._inFight && this._currentAllianceId > 0)
         {
            this.lbl_alliance.fullWidthAndHeight();
            this.tx_allianceEmblemBack.x = this.lbl_alliance.width + 8;
            this.tx_allianceEmblemUp.x = this.tx_allianceEmblemBack.x + 8;
            this.tx_allianceEmblemUp.y = this.tx_allianceEmblemBack.y + 8;
         }
      }
      
      private function applyFilter() : void
      {
         this.lbl_rewardBonus.filters = [this.outlineFilter];
      }
   }
}
