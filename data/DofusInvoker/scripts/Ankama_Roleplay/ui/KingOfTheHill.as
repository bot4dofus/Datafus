package Ankama_Roleplay.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.conquest.AllianceOnTheHillWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class KingOfTheHill
   {
      
      private static const VIEW_NONE:int = 0;
      
      private static const VIEW_SMALL:int = 1;
      
      private static const VIEW_FULL:int = 2;
      
      private static const MAX_ALLIANCE:uint = 5;
      
      private static const TIME_UNLOAD_AFTER_END:uint = 1000 * 60;
      
      private static const SERVER_CONST_KOH_DURATION:int = 2;
      
      private static const SERVER_CONST_KOH_WINNING_SCORE:int = 3;
      
      private static const SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH:int = 5;
      
      private static const TEAM_PLAYER_COLOR:uint = 10802701;
      
      private static const TEAM_PLAYER_BG_COLOR:uint = 6453255;
      
      private static const TEAM_DEFENDER_COLOR:uint = 52479;
      
      private static const TEAM_DEFENDER_BG_COLOR:uint = 3431610;
      
      private static const TEAM_ATTACKER_COLOR:uint = 16711680;
      
      private static const TEAM_ATTACKER_BG_COLOR:uint = 10751759;
      
      private static var _self:KingOfTheHill;
      
      public static var SERVER_KOH_DURATION:int;
      
      public static var SERVER_KOH_WINNING_SCORE:int;
      
      public static var SERVER_TIME_BEFORE_WEIGH_IN_KOH:int;
      
      private static var _lastViewType:int;
       
      
      public var currentSubArea:uint;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      private var _kohRealDuration:uint;
      
      private var _kohStartTime:uint;
      
      private var _endOfPrequalifiedTime:uint;
      
      private var _mapScoreUpdateTime:uint;
      
      private var _compHookData:Dictionary;
      
      private var _alliances:Array;
      
      private var _currentWinnerAlliance:AllianceOnTheHillWrapper;
      
      private var _unexpectedWinnerAllianceName:String;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _currentView:int;
      
      private var _iconPath:String;
      
      private var _barWidth:uint;
      
      private var _barHeight:uint;
      
      private var _bar:Dictionary;
      
      private var _barCtr:Dictionary;
      
      private var _closeTimer:BenchmarkTimer;
      
      private var _end:Boolean;
      
      private var _myAllianceId:uint;
      
      private var _prismAllianceId:uint;
      
      private var _kohPlayerStatus:uint = 4.294967295E9;
      
      private var _maxBgHeigt:uint;
      
      private var _foldBgHeight:uint;
      
      public var btn_smallView:ButtonContainer;
      
      public var btn_fullView:ButtonContainer;
      
      public var btn_whoswhoTab:ButtonContainer;
      
      public var btn_allianceTab:ButtonContainer;
      
      public var btn_playersTab:ButtonContainer;
      
      public var btn_mapsTab:ButtonContainer;
      
      public var btn_scoreTab:ButtonContainer;
      
      public var ctr_progressBar:GraphicContainer;
      
      public var ctr_details:GraphicContainer;
      
      public var ctr_bar:GraphicContainer;
      
      public var ctr_prequalified:GraphicContainer;
      
      public var tx_bg:TextureBitmap;
      
      public var tx_swords:Texture;
      
      public var tx_svArrow:Texture;
      
      public var tx_fvPlusMinux:Texture;
      
      public var lbl_remainingTime:Label;
      
      public var lbl_empty:Label;
      
      public var lbl_prequalifiedTime:Label;
      
      public var lbl_mapConquest:Label;
      
      public var gd_alliances:Grid;
      
      public function KingOfTheHill()
      {
         this._compHookData = new Dictionary(true);
         this._alliances = [];
         this._bar = new Dictionary();
         this._barCtr = new Dictionary();
         this._closeTimer = new BenchmarkTimer(TIME_UNLOAD_AFTER_END,0,"KingOfTheHill._closeTimer");
         super();
      }
      
      public static function get instance() : KingOfTheHill
      {
         return _self;
      }
      
      public function main(param:Object) : void
      {
         _self = this;
         var prismInfo:PrismSubAreaWrapper = param.prism;
         this.currentSubArea = prismInfo.subAreaId;
         this.sysApi.addHook(AlignmentHookList.KohUpdate,this.onKohUpdate);
         this.sysApi.addHook(PrismHookList.PvpAvaStateChange,this.onPvpAvaStateChange);
         this.sysApi.addHook(PrismHookList.PrismsListUpdate,this.onPrismsListUpdate);
         this.uiApi.addComponentHook(this.tx_swords,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_swords,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_empty,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_empty,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_remainingTime,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_remainingTime,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_prequalified,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_prequalified,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_mapConquest,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_mapConquest,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_playersTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_playersTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_mapsTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_mapsTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_scoreTab,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_scoreTab,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_smallView,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_fullView,ComponentHookList.ON_RELEASE);
         this._maxBgHeigt = this.uiApi.me().getConstant("mainBgHeight");
         this._foldBgHeight = this.uiApi.me().getConstant("foldBgHeight");
         this.ctr_progressBar.visible = false;
         this.ctr_details.visible = false;
         this._closeTimer.addEventListener(TimerEvent.TIMER,this.unloadUi);
         this._iconPath = this.uiApi.me().getConstant("icons_uri");
         this._barWidth = this.uiApi.me().getConstant("bar_width");
         this._barHeight = this.uiApi.me().getConstant("bar_height");
         SERVER_KOH_DURATION = int(this.configApi.getServerConstant(SERVER_CONST_KOH_DURATION));
         SERVER_KOH_WINNING_SCORE = int(this.configApi.getServerConstant(SERVER_CONST_KOH_WINNING_SCORE));
         SERVER_TIME_BEFORE_WEIGH_IN_KOH = int(this.configApi.getServerConstant(SERVER_CONST_TIME_BEFORE_WEIGH_IN_KOH));
         this._kohStartTime = getTimer();
         var date:Date = new Date();
         this._kohRealDuration = prismInfo.nextVulnerabilityDate * 1000 + SERVER_KOH_DURATION - date.time;
         this._currentView = -1;
         this.updateKohStatus(param.probationTime);
         this.switchView(_lastViewType);
         this.sysApi.addEventListener(this.onEnterFrame,"kohTimers");
      }
      
      public function unload() : void
      {
         _self = null;
         this.sysApi.removeEventListener(this.onEnterFrame);
         if(this._closeTimer)
         {
            this._closeTimer.removeEventListener(TimerEvent.TIMER,this.unloadUi);
            this._closeTimer.stop();
         }
      }
      
      public function get barHeight() : int
      {
         return this._barHeight;
      }
      
      public function updateAllianceLine(data:*, components:*, selected:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         if(!this._compHookData[components.tx_emblemBack.name])
         {
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_emblemBack,ComponentHookList.ON_ROLL_OUT);
         }
         this._compHookData[components.tx_emblemBack.name] = data;
         if(!this._compHookData[components.tx_type.name])
         {
            this.uiApi.addComponentHook(components.tx_type,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_type,ComponentHookList.ON_ROLL_OUT);
         }
         this._compHookData[components.tx_type.name] = data;
         if(data != null)
         {
            components.lbl_tag.text = this.chatApi.getAllianceLink(data,data.allianceTag);
            components.lbl_players.text = data.nbMembers;
            components.lbl_points.text = data.roundWeigth;
            components.lbl_score.text = data.matchScore + "/" + SERVER_KOH_WINNING_SCORE;
            components.tx_type.uri = this.uiApi.createUri(this._iconPath + (this._myAllianceId == data.allianceId ? "ownTeam" : (this._prismAllianceId == data.allianceId ? "defender" : "forward")));
            components.tx_emblemBack.uri = data.backEmblem.iconUri;
            components.tx_emblemUp.uri = data.upEmblem.iconUri;
            this.utilApi.changeColor(components.tx_emblemBack,data.backEmblem.color,1);
            icon = this.dataApi.getEmblemSymbol(data.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(components.tx_emblemUp,data.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(components.tx_emblemUp,data.upEmblem.color,0,true);
            }
         }
         else
         {
            components.lbl_tag.text = "";
            components.lbl_players.text = "";
            components.lbl_points.text = "";
            components.lbl_score.text = "";
            components.tx_type.uri = null;
            components.tx_emblemBack.uri = null;
            components.tx_emblemUp.uri = null;
         }
      }
      
      public function onEnterFrame(e:Event) : void
      {
         this.updateTime();
         if(this._endOfPrequalifiedTime != 0)
         {
            this.updatePrequalifiedTime();
         }
         if(this._mapScoreUpdateTime != 0)
         {
            this.updateMapScoreUpdateTime();
         }
      }
      
      private function updateTheHill() : void
      {
         var alliance:AllianceOnTheHillWrapper = null;
         var bar:Bar = null;
         var width:int = 0;
         var allianceId:* = undefined;
         var b:Bar = null;
         var totalMapCount:int = 0;
         var totalPlayersNumber:int = 0;
         var currentX:uint = 1;
         var i:uint = 0;
         for each(alliance in this._alliances)
         {
            if(i++ == MAX_ALLIANCE)
            {
               break;
            }
            totalMapCount += alliance.roundWeigth;
            totalPlayersNumber += alliance.nbMembers;
         }
         if(!this.socialApi.hasAlliance())
         {
            this._myAllianceId = 0;
         }
         else
         {
            this._myAllianceId = this.socialApi.getAlliance().allianceId;
         }
         var prism:PrismSubAreaWrapper = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id);
         if(!prism)
         {
            return;
         }
         if(prism.alliance)
         {
            this._prismAllianceId = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id).alliance.allianceId;
         }
         else
         {
            this._prismAllianceId = this._myAllianceId;
         }
         this._currentWinnerAlliance = this._alliances[0];
         var updated:Dictionary = new Dictionary();
         var zeroPlayerInConquest:* = totalPlayersNumber == 0;
         this.lbl_empty.visible = zeroPlayerInConquest;
         i = 0;
         for each(alliance in this._alliances)
         {
            if(i++ == MAX_ALLIANCE)
            {
               break;
            }
            updated[alliance.allianceId] = true;
            if(zeroPlayerInConquest || totalMapCount == 0)
            {
               width = Math.max(1,Math.floor((this._barWidth - this._alliances.length + 1) / this._alliances.length));
            }
            else
            {
               width = Math.max(1,Math.floor((this._barWidth - this._alliances.length + 1) / totalMapCount * alliance.roundWeigth));
            }
            bar = this._bar[alliance.allianceId];
            if(!bar)
            {
               bar = new Bar(this.uiApi);
               bar.container.y = 1;
               this._bar[alliance.allianceId] = bar;
               if(alliance.allianceId == this._myAllianceId)
               {
                  bar.colorBackground = TEAM_PLAYER_BG_COLOR;
                  bar.colorScore = TEAM_PLAYER_COLOR;
               }
               else if(alliance.allianceId == this._prismAllianceId)
               {
                  bar.colorBackground = TEAM_DEFENDER_BG_COLOR;
                  bar.colorScore = TEAM_DEFENDER_COLOR;
               }
               else
               {
                  bar.colorBackground = TEAM_ATTACKER_BG_COLOR;
                  bar.colorScore = TEAM_ATTACKER_COLOR;
               }
               this.uiApi.addComponentHook(bar.container,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(bar.container,ComponentHookList.ON_ROLL_OUT);
               this.ctr_bar.addChild(bar.container);
            }
            bar.score = alliance.matchScore;
            bar.update();
            bar.container.visible = true;
            this._barCtr[bar.container] = alliance;
            bar.width = width;
            bar.container.x = currentX;
            currentX += width + 1;
         }
         for(allianceId in this._bar)
         {
            if(!updated[allianceId])
            {
               b = this._bar[allianceId];
               b.container.visible = false;
            }
         }
         if(this._currentWinnerAlliance && this._currentWinnerAlliance.matchScore >= SERVER_KOH_WINNING_SCORE)
         {
            this.kohOver();
         }
         if(this._currentView == VIEW_FULL)
         {
            this.gd_alliances.dataProvider = this._alliances;
         }
      }
      
      private function kohOver() : void
      {
         if(this._unexpectedWinnerAllianceName)
         {
            this.lbl_remainingTime.text = this.uiApi.getText("ui.koh.win",this._unexpectedWinnerAllianceName);
            this._unexpectedWinnerAllianceName = null;
         }
         else
         {
            this.lbl_remainingTime.text = this.uiApi.getText("ui.koh.win",this._currentWinnerAlliance.allianceName);
         }
         this.lbl_remainingTime.removeTooltipExtension();
         this.updateRemainingTimeLabelWidth();
         this._end = true;
         this.sysApi.removeEventListener(this.onEnterFrame);
         this._closeTimer.start();
      }
      
      private function unloadUi(e:Event = null) : void
      {
         if(this.uiApi && this.uiApi.me())
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function switchView(viewType:int) : void
      {
         if(this._currentView == viewType)
         {
            return;
         }
         switch(viewType)
         {
            case VIEW_NONE:
               this.ctr_progressBar.visible = false;
               this.ctr_details.visible = false;
               this.btn_smallView.selected = this.btn_fullView.selected = false;
               this.tx_bg.visible = false;
               this.btn_smallView.visible = false;
               this.tx_svArrow.visible = false;
               this.tx_fvPlusMinux.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png");
               break;
            case VIEW_SMALL:
               this.tx_bg.visible = true;
               this.ctr_progressBar.visible = true;
               this.ctr_details.visible = false;
               if(this.tx_bg.height == this._maxBgHeigt)
               {
                  this.tx_bg.height = this._foldBgHeight;
               }
               this.btn_smallView.selected = true;
               this.btn_fullView.selected = false;
               this.btn_smallView.visible = true;
               this.tx_svArrow.visible = true;
               this.tx_svArrow.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_arrowDown_floating_menu.png");
               this.tx_fvPlusMinux.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png");
               break;
            case VIEW_FULL:
               this.tx_bg.visible = true;
               this.ctr_progressBar.visible = true;
               this.ctr_details.visible = true;
               this.tx_bg.height = this._maxBgHeigt;
               this.gd_alliances.dataProvider = this._alliances;
               this.btn_smallView.selected = false;
               this.btn_fullView.selected = true;
               this.btn_smallView.visible = true;
               this.tx_svArrow.visible = true;
               this.tx_svArrow.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_arrowUp_floating_menu.png");
               this.tx_fvPlusMinux.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png");
               this.updateTheHill();
         }
         this._currentView = viewType;
         _lastViewType = this._currentView;
      }
      
      private function updateKohStatus(pProbationTime:uint) : void
      {
         var prequalifiedTime:Number = NaN;
         var currentStatus:uint = this.playerApi.characteristics().alignmentInfos.aggressable;
         if(this._kohPlayerStatus == currentStatus || currentStatus == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE && pProbationTime == 0)
         {
            return;
         }
         this._kohPlayerStatus = currentStatus;
         if(currentStatus == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE)
         {
            this._mapScoreUpdateTime = 0;
            this.ctr_prequalified.visible = true;
            prequalifiedTime = (pProbationTime + 1) * 1000 - new Date().time;
            this._endOfPrequalifiedTime = prequalifiedTime + getTimer();
            this.updatePrequalifiedTime();
         }
         else
         {
            this.ctr_prequalified.visible = false;
         }
      }
      
      private function onKohUpdate(alliances:Vector.<AllianceOnTheHillWrapper>, allianceMapWinners:Vector.<BasicAllianceInformations>, allianceMapWinnerScore:uint, allianceMapMyAllianceScore:uint, nextTickTime:Number) : void
      {
         var alliance:AllianceOnTheHillWrapper = null;
         var mapInfos:WorldPointWrapper = null;
         var winnerTagText:String = null;
         var winnerScoreText:String = null;
         var conquestText:String = null;
         var ts:Number = NaN;
         var allianceWinnerInfo:BasicAllianceInformations = null;
         if(allianceMapMyAllianceScore == 0 && this.playerApi.characteristics().alignmentInfos.aggressable == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE)
         {
            ts = new Date().time;
            if(nextTickTime > ts)
            {
               this._mapScoreUpdateTime = nextTickTime - ts + getTimer();
               this.ctr_prequalified.visible = true;
            }
         }
         this._alliances = [];
         for each(alliance in alliances)
         {
            this._alliances.push(alliance);
         }
         this._alliances.sortOn(["roundWeigth","matchScore"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
         this.updateTheHill();
         mapInfos = this.playerApi.currentMap();
         winnerTagText = "";
         winnerScoreText = "";
         if(allianceMapWinnerScore == 0)
         {
            winnerTagText = this.uiApi.getText("ui.common.neutral");
         }
         else if(allianceMapWinners.length > 1)
         {
            for each(allianceWinnerInfo in allianceMapWinners)
            {
               winnerTagText += this.chatApi.getAllianceLink(allianceWinnerInfo,allianceWinnerInfo.allianceTag) + " - ";
            }
            winnerTagText = winnerTagText.slice(0,winnerTagText.length - 3);
            winnerScoreText = this.uiApi.getText("ui.koh.draw",allianceMapWinnerScore.toString());
         }
         else
         {
            winnerTagText = this.chatApi.getAllianceLink(allianceMapWinners[0],allianceMapWinners[0].allianceTag);
            winnerScoreText = allianceMapWinnerScore.toString() + " " + this.uiApi.getText("ui.short.points");
         }
         conquestText = this.uiApi.getText("ui.option.worldOption") + " [" + mapInfos.outdoorX + "," + mapInfos.outdoorY + "]" + this.uiApi.getText("ui.common.colon");
         if(allianceMapWinnerScore > 0)
         {
            conquestText += " " + winnerScoreText;
         }
         conquestText += "   " + winnerTagText;
         this.lbl_mapConquest.text = conquestText;
      }
      
      private function onPvpAvaStateChange(state:uint, probationTime:uint) : void
      {
         this.updateKohStatus(probationTime);
      }
      
      public function onPrismsListUpdate(pPrismSubAreas:Object) : void
      {
         var subAreaId:int = 0;
         var prismSubAreaInfo:PrismSubAreaWrapper = null;
         var currentSubAreaId:int = this.playerApi.currentSubArea().id;
         for each(subAreaId in pPrismSubAreas)
         {
            if(currentSubAreaId == subAreaId)
            {
               prismSubAreaInfo = this.socialApi.getPrismSubAreaById(subAreaId);
               if(prismSubAreaInfo.state != PrismStateEnum.PRISM_STATE_VULNERABLE)
               {
                  this._unexpectedWinnerAllianceName = prismSubAreaInfo.alliance.allianceName;
                  this.kohOver();
               }
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_smallView:
               if(this._currentView == VIEW_SMALL)
               {
                  this.switchView(VIEW_FULL);
               }
               else
               {
                  this.switchView(VIEW_SMALL);
               }
               break;
            case this.btn_fullView:
               if(this._currentView == VIEW_FULL)
               {
                  this.switchView(VIEW_NONE);
               }
               else
               {
                  this.switchView(VIEW_FULL);
               }
               break;
            case this.btn_whoswhoTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("side",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("side",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_allianceTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("allianceTag",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_alliances.sortOn("allianceTag",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_playersTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("nbMembers",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("nbMembers",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_mapsTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("roundWeigth",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("roundWeigth",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_scoreTab:
               if(this._bDescendingSort)
               {
                  this.gd_alliances.sortOn("matchScore",Array.NUMERIC);
               }
               else
               {
                  this.gd_alliances.sortOn("matchScore",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSort = !this._bDescendingSort;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:* = null;
         var data:AllianceOnTheHillWrapper = null;
         var point:uint = 6;
         var relPoint:uint = 0;
         switch(true)
         {
            case target.name.indexOf("tx_type") != -1:
               data = this._compHookData[target.name];
               if(!data)
               {
                  return;
               }
               tooltipText = tooltipText = this.uiApi.getText(this._myAllianceId == data.allianceId ? "ui.alliance.myAlliance" : (this._prismAllianceId == data.allianceId ? "ui.alliance.allianceInDefense" : "ui.alliance.allianceInAttack"));
               break;
            case target.name.indexOf("tx_emblemBack") != -1:
               data = this._compHookData[target.name];
               if(!data)
               {
                  return;
               }
               tooltipText = data.allianceName + " [" + data.allianceTag + "]";
               break;
            case target == this.lbl_empty:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.emptyConquest");
               break;
            case this._barCtr[target] != null:
               data = this._barCtr[target];
               if(!data)
               {
                  return;
               }
               tooltipText = data.allianceName + " [" + data.allianceTag + "] " + "(" + data.roundWeigth + ") : " + data.matchScore + " / " + SERVER_KOH_WINNING_SCORE + "\n" + this.uiApi.getText(this._myAllianceId == data.allianceId ? "ui.alliance.myAlliance" : (this._prismAllianceId == data.allianceId ? "ui.alliance.allianceInDefense" : "ui.alliance.allianceInAttack"));
               break;
            case target == this.tx_swords:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.rules",SERVER_KOH_WINNING_SCORE,this.timeApi.getShortDuration(SERVER_KOH_DURATION));
               break;
            case target == this.btn_playersTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.members");
               break;
            case target == this.btn_mapsTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.maps");
               break;
            case target == this.btn_scoreTab:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.time");
               break;
            case target == this.lbl_remainingTime:
               if(!this._end)
               {
                  tooltipText = this.uiApi.getText("ui.koh.tooltip.remainingTime");
               }
               break;
            case target == this.ctr_prequalified:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.prequalifiedTime");
               break;
            case target == this.lbl_mapConquest:
               tooltipText = this.uiApi.getText("ui.koh.tooltip.winnerPoints");
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function updateTime() : void
      {
         var remainingTime:int = this._kohStartTime + this._kohRealDuration - getTimer();
         if(remainingTime <= 0)
         {
            if(!this._end)
            {
               this.lbl_remainingTime.text = "-";
            }
         }
         else
         {
            this.lbl_remainingTime.text = this.timeApi.getShortDuration(remainingTime,true);
         }
         this.updateRemainingTimeLabelWidth();
      }
      
      private function updatePrequalifiedTime() : void
      {
         var remainingTime:int = this._endOfPrequalifiedTime - getTimer();
         if(remainingTime <= 0)
         {
            this.ctr_prequalified.visible = false;
            this._endOfPrequalifiedTime = 0;
         }
         else
         {
            this.lbl_prequalifiedTime.text = this.timeApi.getShortDuration(remainingTime,true);
         }
      }
      
      private function updateMapScoreUpdateTime() : void
      {
         var remainingTime:int = this._mapScoreUpdateTime - getTimer();
         if(remainingTime <= 0)
         {
            this.ctr_prequalified.visible = false;
            this._mapScoreUpdateTime = 0;
         }
         else
         {
            this.lbl_prequalifiedTime.text = this.timeApi.getShortDuration(remainingTime,true);
         }
      }
      
      private function updateRemainingTimeLabelWidth() : void
      {
         this.lbl_remainingTime.fullWidthAndHeight(this.uiApi.getTextSize(this.lbl_remainingTime.text,this.lbl_remainingTime.css,this.lbl_remainingTime.cssClass).width + this.lbl_remainingTime.anchorX);
      }
   }
}

import com.ankamagames.berilia.api.UiApi;
import com.ankamagames.berilia.types.graphic.GraphicContainer;

class Bar
{
    
   
   public var colorBackground:uint;
   
   public var colorScore:uint;
   
   public var score:uint;
   
   public var container:GraphicContainer;
   
   private var bg:GraphicContainer;
   
   private var ctr_score:GraphicContainer;
   
   function Bar(uiApi:UiApi)
   {
      super();
      this.container = uiApi.createContainer("GraphicContainer");
      this.ctr_score = uiApi.createContainer("GraphicContainer");
      this.bg = uiApi.createContainer("GraphicContainer");
      this.ctr_score.x = this.ctr_score.y = this.ctr_score.width = this.ctr_score.height = 0;
      this.container.addChild(this.bg);
      this.container.addChild(this.ctr_score);
      this.bg.mouseEnabled = true;
      this.ctr_score.mouseEnabled = true;
   }
   
   public function set width(v:int) : void
   {
      this.ctr_score.width = v;
      this.bg.width = v;
   }
   
   public function update() : void
   {
      var prc:Number = (KingOfTheHill.SERVER_KOH_WINNING_SCORE - this.score) / KingOfTheHill.SERVER_KOH_WINNING_SCORE;
      var size:uint = 20;
      this.bg.bgColor = this.colorBackground;
      this.bg.width = 5;
      this.bg.height = Math.round(size * prc);
      this.ctr_score.bgColor = this.colorScore;
      this.ctr_score.y = this.bg.height;
      this.ctr_score.height = Math.round(size - size * prc);
   }
}
