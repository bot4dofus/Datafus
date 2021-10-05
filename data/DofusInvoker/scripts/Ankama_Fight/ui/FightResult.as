package Ankama_Fight.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeCategory;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeResult;
   import com.ankamagames.dofus.internalDatacenter.fight.FightResultEntryWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.FightOutcomeEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.types.enums.ScreenshotTypeEnum;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.CaptureApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import damageCalculation.tools.StatIds;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class FightResult
   {
      
      private static const MAXIMAL_SIZE:uint = 18;
      
      private static const PNJ_FIGHTER_GAME_1:uint = 6606;
      
      private static const PNJ_FIGHTER_GAME_2:uint = 6610;
      
      private static const PNJ_FIGHTER_GAME_3:uint = 6621;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="CaptureApi")]
      public var captureApi:CaptureApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var ctr_drop:GraphicContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_fightResult:GraphicContainer;
      
      public var ctr_gridResult:GraphicContainer;
      
      public var fightResultWindow:GraphicContainer;
      
      public var ctr_challenges:GraphicContainer;
      
      public var ctr_paginationElements:GraphicContainer;
      
      public var ctr_previousChallengeButton:GraphicContainer;
      
      public var ctr_nextChallengeButton:GraphicContainer;
      
      public var btn_close_fightResultWindow:ButtonContainer;
      
      public var btn_close2:ButtonContainer;
      
      public var btn_closeDrop:ButtonContainer;
      
      public var btn_idols:ButtonContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var ctr_rewardRate:GraphicContainer;
      
      public var tx_rewardRate:GraphicContainer;
      
      public var lbl_rewardRate:Label;
      
      public var lbl_result:Label;
      
      public var lbl_time:Label;
      
      public var lbl_honour:Label;
      
      public var lbl_drop:Label;
      
      public var lbl_score:Label;
      
      public var lbl_objects:Label;
      
      public var lbl_kamas:Label;
      
      public var lbl_successfulChallengeCounter:Label;
      
      public var gd_fighters:Grid;
      
      public var gd_drop:Grid;
      
      public var gd_idols:Grid;
      
      public var gd_challenges:Grid;
      
      public var tx_gdFighterBg:Texture;
      
      public var tx_gridHeader:Texture;
      
      public var tx_result:TextureBitmap;
      
      public var tx_honor_separator:TextureBitmap;
      
      public var tx_minimizeBg:TextureBitmap;
      
      public var tx_kamaItemSeparator:TextureBitmap;
      
      public var tx_breachItemSeparator:TextureBitmap;
      
      public var btn_share:ButtonContainer;
      
      public var btn_previousChallengeButton:ButtonContainer;
      
      public var btn_nextChallengeButton:ButtonContainer;
      
      private var CTR_TYPE_TITLE:String = "ctr_title";
      
      private var CTR_TYPE_FIGHTER:String = "ctr_fighter";
      
      private var CHALLENGE_PAGE_PACE:uint = 1;
      
      private var _challenges:Array;
      
      private var _rewardRate:int;
      
      private var _isPvpFight:Boolean;
      
      private var _winnersName:String;
      
      private var _losersName:String;
      
      private var _widthName:int;
      
      private var _widthXp:int;
      
      private var _widthXpWithHonour:int;
      
      private var _pictoUris:Array;
      
      private var _objectsLists:Dictionary;
      
      private var _hookGridObjects:Dictionary;
      
      private var _headsUri:String;
      
      private var _bgLevelUri:Object;
      
      private var _bgPrestigeUri:Object;
      
      private var _helpColor:String;
      
      private var _idols:Object;
      
      private var _totalScore:uint;
      
      private var _totalExp:uint;
      
      private var _totalLoot:uint;
      
      private var _objectsGridCoord:Array;
      
      private var _breachMode:Boolean = false;
      
      private var _budget:int;
      
      private var _challengeMap:Dictionary;
      
      private var _currentChallengeStartIndex:Number = 0;
      
      private var _lastChallengeToDisplayNumber:Number = NaN;
      
      private var _fightResults:Object = null;
      
      public function FightResult()
      {
         this._pictoUris = [];
         this._objectsLists = new Dictionary(true);
         this._hookGridObjects = new Dictionary(true);
         this._objectsGridCoord = [];
         this._challengeMap = new Dictionary();
         super();
      }
      
      private static function sortChallenges(challenge1:ChallengeWrapper, challenge2:ChallengeWrapper) : Number
      {
         if(challenge1.categoryId < challenge2.categoryId)
         {
            return -1;
         }
         if(challenge1.categoryId > challenge2.categoryId)
         {
            return 1;
         }
         if(challenge1.result !== challenge2.result)
         {
            if(challenge1.result === EnumChallengeResult.COMPLETED || challenge1.result === EnumChallengeResult.IN_PROGRESS && challenge2.result !== EnumChallengeResult.COMPLETED)
            {
               return -1;
            }
            if(challenge2.result === EnumChallengeResult.COMPLETED || challenge2.result === EnumChallengeResult.IN_PROGRESS)
            {
               return 1;
            }
         }
         return 0;
      }
      
      public function main(fightResults:Object) : void
      {
         var i:int = 0;
         var idol:Idol = null;
         var coeff:Number = NaN;
         this._fightResults = fightResults;
         if(this.uiApi.getUi("levelUp"))
         {
            this.uiApi.me().visible = false;
         }
         this.uiApi.addComponentHook(this.btn_close_fightResultWindow,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_rewardRate,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_rewardRate,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_drop,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_share,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_share,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         if(this._fightResults.isSpectator)
         {
            this.tx_minimizeBg.visible = false;
            this.btn_minimize.visible = false;
            this.tx_result.visible = false;
            this.lbl_result.visible = false;
         }
         if(this._fightResults.budget != null)
         {
            this._breachMode = true;
            this.tx_kamaItemSeparator.visible = false;
            this.tx_breachItemSeparator.visible = true;
            this.lbl_objects.x = this.uiApi.me().getConstant("lbl_objects_x_in_breach");
            this._objectsGridCoord[0] = this.uiApi.me().getConstant("gd_objects_x_in_breach");
            this.lbl_kamas.width = 220;
            this.lbl_kamas.text = this.uiApi.getText("ui.fightend.teamDreamPoints");
         }
         else
         {
            this.lbl_objects.x = this.uiApi.me().getConstant("lbl_objects_x_standart");
            this._objectsGridCoord[0] = this.uiApi.me().getConstant("gd_objects_x_standart");
         }
         this._objectsGridCoord[1] = this.uiApi.me().getConstant("gd_objects_y");
         this.lbl_objects.y = this.uiApi.me().getConstant("lbl_objects_y");
         this.ctr_drop.visible = false;
         if(this._breachMode)
         {
            this._budget = this._fightResults.budget;
         }
         var duration:int = this._fightResults.duration;
         this._rewardRate = this._fightResults.rewardRate;
         var results:Object = this._fightResults.results;
         this._challenges = this._fightResults.challenges;
         if(this._challenges !== null)
         {
            this._challenges.sort(sortChallenges);
         }
         this._winnersName = this._fightResults.winnersName;
         this._losersName = this._fightResults.losersName;
         this._headsUri = this.uiApi.me().getConstant("heads");
         this._pictoUris.push(this.uiApi.me().getConstant("winner_uri"));
         this._pictoUris.push(this.uiApi.me().getConstant("loser_uri"));
         this._pictoUris.push(this.uiApi.me().getConstant("pony_uri"));
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this._widthName = int(this.uiApi.me().getConstant("name_width"));
         this._widthXp = this.uiApi.me().getConstant("lbl_xp_full_width");
         this._widthXpWithHonour = this.uiApi.me().getConstant("lbl_xp_limited_width");
         this._helpColor = this.sysApi.getConfigEntry("colors.text.help").toString().replace("0x","#");
         var turns:* = " (" + this.uiApi.getText("ui.fight.turnCount",this._fightResults.turns) + ")";
         turns = this.uiApi.processText(turns,"m",this._fightResults.turns <= 1,this._fightResults.turns === 0);
         this.lbl_time.text = this.timeApi.getShortDuration(duration,true) + turns;
         if(this._fightResults.fightType == FightTypeEnum.FIGHT_TYPE_AGRESSION || this._fightResults.fightType == FightTypeEnum.FIGHT_TYPE_PvMA)
         {
            this._isPvpFight = true;
         }
         this.lbl_honour.visible = this._isPvpFight;
         this.tx_honor_separator.visible = this._isPvpFight;
         this.displayBonuses();
         this.displayChallenges();
         this.displayResults(results,this._fightResults.playSound);
         this._fightResults.playSound = false;
         this._idols = this._fightResults.idols;
         var idols:Array = [];
         var numIdols:uint = this._idols.length;
         for(i = 0; i < numIdols; i++)
         {
            idol = this.dataApi.getIdol(this._idols[i]);
            coeff = this.getIdolCoeff(idol);
            this._totalScore += Math.floor(idol.score * coeff);
            this._totalExp += Math.floor(idol.experienceBonus * coeff);
            this._totalLoot += Math.floor(idol.dropBonus * coeff);
            idols.push(this.dataApi.getItemWrapper(idol.itemId));
         }
         this.gd_idols.dataProvider = idols;
         var areIdolsVisible:* = idols.length > 0;
         this.gd_idols.visible = this.btn_idols.visible = areIdolsVisible;
         if(areIdolsVisible)
         {
            this.gd_idols.width = (this.gd_idols.slotWidth + this.gd_idols.staticGap) * idols.length - this.gd_idols.staticGap;
         }
         this.lbl_score.text = this._totalScore.toString();
         var level:uint = this.playerApi.getPlayedCharacterInfo().level;
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         if(level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            level = ProtocolConstantsEnum.MAX_LEVEL;
         }
         var wisdom:int = stats.getStatTotalValue(StatIds.WISDOM);
         var pp:int = stats.getStatTotalValue(StatIds.MAGIC_FIND);
         this._totalExp = (2.5 * level + 100) * this._totalExp / (wisdom + 100);
         this._totalLoot = (0.5 * level + 100) * this._totalLoot / (pp + 100);
         if(this.sysApi.getPlayerManager().subscriptionEndDate == 0)
         {
            this.btn_share.softDisabled = true;
         }
         else if(this.uiApi.getUi("sharePopup"))
         {
            this.uiApi.unloadUi("sharePopup");
         }
      }
      
      public function unload() : void
      {
         if(this.uiApi.getUi("sharePopup"))
         {
            this.uiApi.unloadUi("sharePopup");
         }
         this.uiApi.hideTooltip();
         this.sysApi.dispatchHook(FightHookList.FightResultClosed);
      }
      
      private function getPlayerExperienceBonusPercent() : uint
      {
         return Math.floor(this.playerApi.getExperienceBonusPercent() / 100) + 1;
      }
      
      public function updateLine(data:*, compRef:*, selected:Boolean, line:uint) : void
      {
         var name:* = null;
         var server:Server = null;
         var visibleObjectsCount:int = 0;
         var monster:Monster = null;
         var percentXp:int = 0;
         var xpMultiplicator:int = 0;
         var heroicEpicXpMultiplicator:int = 0;
         var objects:Array = null;
         var o:Object = null;
         var objectsList:String = null;
         var i:int = 0;
         switch(this.getLineType(data,line))
         {
            case this.CTR_TYPE_TITLE:
               compRef.tx_titleIcon.uri = this.uiApi.createUri(this._pictoUris[data.icon]);
               compRef.lbl_titleName.text = data.name;
               compRef.lbl_breachBudget.text = data.budget;
               if(this._breachMode)
               {
                  compRef.lbl_breachBudget.visible = true;
                  if(data.budget != "")
                  {
                     compRef.tx_breachBudget.visible = true;
                  }
               }
               break;
            case this.CTR_TYPE_FIGHTER:
               if(!this._hookGridObjects[compRef.gd_objects.name])
               {
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_ROLL_OUT);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_SELECT_ITEM);
                  this.uiApi.addComponentHook(compRef.gd_objects,ComponentHookList.ON_ITEM_RIGHT_CLICK);
               }
               this._hookGridObjects[compRef.gd_objects.name] = data;
               if(!this._hookGridObjects[compRef.btn_seeMore.name])
               {
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_RELEASE);
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.btn_seeMore,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.btn_seeMore.name] = data;
               if(!this._hookGridObjects[compRef.pb_xpGauge.name])
               {
                  this.uiApi.addComponentHook(compRef.pb_xpGauge,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.pb_xpGauge,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.pb_xpGauge.name] = data;
               if(!this._hookGridObjects[compRef.tx_xpBonusPicto.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_xpBonusPicto,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_xpBonusPicto,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.tx_xpBonusPicto.name] = data;
               if(!this._hookGridObjects[compRef.lbl_xpPerso.name])
               {
                  this.uiApi.addComponentHook(compRef.lbl_xpPerso,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.lbl_xpPerso,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.lbl_xpPerso.name] = data;
               if(!this._hookGridObjects[compRef.lbl_honour.name])
               {
                  this.uiApi.addComponentHook(compRef.lbl_honour,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.lbl_honour,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.lbl_honour.name] = data;
               if(!this._hookGridObjects[compRef.tx_arrow.name])
               {
                  this.uiApi.addComponentHook(compRef.tx_arrow,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_arrow,ComponentHookList.ON_ROLL_OUT);
               }
               this._hookGridObjects[compRef.tx_arrow.name] = data;
               compRef.gd_objects.x = this._objectsGridCoord[0];
               compRef.gd_objects.y = this._objectsGridCoord[1];
               if(this._breachMode)
               {
                  compRef.lbl_kamas.visible = false;
               }
               compRef.tx_deathPicto.visible = !data.alive;
               if(data.id == this.playerApi.id() || data.fightInitiator)
               {
                  compRef.lbl_name.width = this._widthName - compRef.tx_arrow.width - 3;
                  compRef.tx_arrow.visible = true;
                  if(data.fightInitiator)
                  {
                     compRef.tx_arrow.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "tx_pictoattaquant.png");
                  }
                  else
                  {
                     compRef.tx_arrow.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_man.png");
                  }
               }
               else
               {
                  compRef.tx_arrow.visible = false;
               }
               name = data.name;
               if(data.type == 0)
               {
                  name = "{player," + data.name + "," + data.id + "::" + data.name + "}";
               }
               else if(data.type == 1)
               {
                  monster = this.dataApi.getMonsterFromId(data.id);
                  if(monster)
                  {
                     name = "{bestiary," + data.id + "::" + data.name + "}";
                  }
               }
               compRef.lbl_name.text = name;
               if(data.type == 0 && data.level > ProtocolConstantsEnum.MAX_LEVEL)
               {
                  compRef.lbl_level.text = "" + (data.level - ProtocolConstantsEnum.MAX_LEVEL);
                  compRef.tx_level.uri = this._bgPrestigeUri;
                  this.uiApi.addComponentHook(compRef.tx_level,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(compRef.tx_level,ComponentHookList.ON_ROLL_OUT);
                  compRef.lbl_level.cssClass = "darkboldcenter";
               }
               else
               {
                  compRef.lbl_level.text = data.level;
                  compRef.tx_level.uri = this._bgLevelUri;
                  compRef.lbl_level.cssClass = "boldcenter";
               }
               if(data.breed > 0)
               {
                  compRef.tx_head.uri = this.uiApi.createUri(this._headsUri + "" + data.breed + "" + int(data.gender) + ".png");
                  compRef.tx_head.visible = true;
                  compRef.tx_fighterHeadSlot.visible = true;
               }
               else
               {
                  compRef.tx_head.visible = false;
                  compRef.tx_fighterHeadSlot.visible = false;
               }
               if(data.showExperience && this.configApi.isFeatureWithKeywordEnabled("character.xp"))
               {
                  if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
                  {
                     compRef.pb_xpGauge.barColor = this.sysApi.getConfigEntry("colors.progressbar.gold");
                  }
                  else
                  {
                     compRef.pb_xpGauge.barColor = this.sysApi.getConfigEntry("colors.progressbar.xp");
                  }
                  compRef.pb_xpGauge.visible = true;
                  percentXp = (data.experience - data.experienceLevelFloor) * 100 / (data.experienceNextLevelFloor - data.experienceLevelFloor);
                  compRef.pb_xpGauge.value = percentXp / 100;
                  compRef.tx_level.x = 308;
                  compRef.lbl_level.x = 315;
               }
               else
               {
                  compRef.pb_xpGauge.visible = false;
                  if(!this.configApi.isFeatureWithKeywordEnabled("character.xp"))
                  {
                     compRef.tx_level.x = 348;
                     compRef.lbl_level.x = 355;
                  }
               }
               if(this._isPvpFight)
               {
                  compRef.lbl_xpPerso.width = this._widthXpWithHonour;
               }
               else
               {
                  compRef.lbl_xpPerso.width = this._widthXp;
               }
               compRef.lbl_xpPerso.finalize();
               if(data.honorDelta == -1)
               {
                  compRef.lbl_honour.visible = false;
               }
               else
               {
                  compRef.lbl_honour.visible = true;
                  compRef.lbl_honour.text = data.honorDelta;
               }
               server = this.sysApi.getCurrentServer();
               if(data.honorDelta == -1 && data.rerollXpMultiplicator > 1)
               {
                  xpMultiplicator = data.rerollXpMultiplicator - 1;
                  if(xpMultiplicator > 3)
                  {
                     xpMultiplicator = 4;
                  }
                  compRef.tx_xpBonusPicto.visible = true;
                  compRef.tx_xpBonusPicto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "XPBonus" + xpMultiplicator.toString() + ".png");
               }
               else if(data.type == 0 && (server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC))
               {
                  heroicEpicXpMultiplicator = this.getPlayerExperienceBonusPercent();
                  if(heroicEpicXpMultiplicator > 1 && heroicEpicXpMultiplicator < 7)
                  {
                     compRef.tx_xpBonusPicto.visible = true;
                     compRef.tx_xpBonusPicto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "XPBonus" + (heroicEpicXpMultiplicator - 1).toString() + ".png");
                  }
                  else
                  {
                     compRef.tx_xpBonusPicto.visible = false;
                  }
               }
               else
               {
                  compRef.tx_xpBonusPicto.visible = false;
               }
               if(data.showExperienceFightDelta)
               {
                  compRef.lbl_xpPerso.text = this.utilApi.kamasToString(data.experienceFightDelta,"");
               }
               else
               {
                  compRef.lbl_xpPerso.text = data.breed > 0 ? "0" : "";
               }
               if(data.rewards.kamas > 0)
               {
                  compRef.lbl_kamas.text = this.utilApi.kamasToString(data.rewards.kamas,"");
               }
               else if(data.type != 0)
               {
                  compRef.lbl_kamas.text = "";
               }
               else
               {
                  compRef.lbl_kamas.text = "0";
               }
               if(data.rewards.objects.length > 0)
               {
                  objects = [];
                  for each(o in data.rewards.objects)
                  {
                     objects.push(o);
                  }
                  compRef.gd_objects.dataProvider = objects;
               }
               else
               {
                  compRef.gd_objects.dataProvider = [];
               }
               visibleObjectsCount = compRef.gd_objects.slotByRow;
               if(data.rewards.objects.length > visibleObjectsCount)
               {
                  compRef.btn_seeMore.visible = true;
                  objectsList = "";
                  for(i = visibleObjectsCount; i < data.rewards.objects.length; i++)
                  {
                     objectsList += data.rewards.objects[i].quantity + " x " + data.rewards.objects[i].name + " \n";
                  }
                  this._objectsLists[data.id] = objectsList;
               }
               else
               {
                  compRef.btn_seeMore.visible = false;
               }
         }
      }
      
      public function getLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data && data.hasOwnProperty("level"))
         {
            return this.CTR_TYPE_FIGHTER;
         }
         return this.CTR_TYPE_TITLE;
      }
      
      public function getDataLength(data:*, selected:Boolean) : *
      {
         if(!selected)
         {
         }
         return 2 + (!!selected ? data.subcats.length : 0);
      }
      
      public function displayBonuses() : void
      {
         var colorTransform:ColorTransform = new ColorTransform();
         this.lbl_rewardRate.text = this._rewardRate.toString() + "%";
         if(this._rewardRate < 100)
         {
            this.ctr_rewardRate.visible = true;
            colorTransform.color = this.uiApi.me().getConstant("malus_color");
            this.tx_rewardRate.colorTransform = colorTransform;
         }
         else
         {
            this.ctr_rewardRate.visible = true;
            colorTransform.color = this.uiApi.me().getConstant("bonus_color");
            this.tx_rewardRate.colorTransform = colorTransform;
            this.lbl_rewardRate.text = "+" + this.lbl_rewardRate.text;
         }
      }
      
      public function turnChallengePage(isRight:Boolean) : void
      {
         if(this._challenges === null || this._challenges.length <= 0)
         {
            return;
         }
         if(isRight)
         {
            this._currentChallengeStartIndex += this.CHALLENGE_PAGE_PACE;
         }
         else
         {
            this._currentChallengeStartIndex -= this.CHALLENGE_PAGE_PACE;
         }
         this.displayChallenges();
      }
      
      public function displayChallenges() : void
      {
         var isPreviousButton:* = false;
         var isNextButton:* = false;
         var challenge:ChallengeWrapper = null;
         var successfulChallengeNumber:uint = 0;
         var index:uint = 0;
         var newGridWidth:Number = NaN;
         var newContainerWidth:Number = NaN;
         var newXPos:Number = NaN;
         if(this._challenges === null || this._challenges.length <= 0)
         {
            this.ctr_challenges.visible = false;
            return;
         }
         var totalChallengeToDisplayNumber:Number = this._challenges.length;
         var me:UiRootContainer = this.uiApi.me();
         if(me === null)
         {
            this.ctr_challenges.visible = false;
            return;
         }
         this.ctr_challenges.visible = true;
         this._currentChallengeStartIndex = Math.max(0,Math.min(this._currentChallengeStartIndex,totalChallengeToDisplayNumber - 1));
         var challengeSlotLength:Number = me.getConstant("challenge_slot_length");
         var maxChallengesToDisplayNumber:Number = me.getConstant("challenge_max_displayed");
         var challengeToDisplayNumber:Number = Math.max(0,Math.min(totalChallengeToDisplayNumber,maxChallengesToDisplayNumber));
         var challengeMargin:Number = me.getConstant("challenge_margin");
         var challengeMinX:Number = this.mainCtr.x;
         var challengeMaxX:Number = challengeMinX + this.mainCtr.width;
         var indexDelta:uint = totalChallengeToDisplayNumber - this._currentChallengeStartIndex;
         if(totalChallengeToDisplayNumber > maxChallengesToDisplayNumber && indexDelta < maxChallengesToDisplayNumber)
         {
            this._currentChallengeStartIndex = totalChallengeToDisplayNumber - maxChallengesToDisplayNumber;
         }
         var arePaginationElementsNeeded:* = totalChallengeToDisplayNumber > maxChallengesToDisplayNumber;
         this.ctr_paginationElements.visible = arePaginationElementsNeeded;
         if(arePaginationElementsNeeded)
         {
            isPreviousButton = this._currentChallengeStartIndex > 0;
            isNextButton = indexDelta > maxChallengesToDisplayNumber;
            this.ctr_previousChallengeButton.visible = isPreviousButton;
            this.ctr_nextChallengeButton.visible = isNextButton;
            if(isPreviousButton)
            {
               this.uiApi.addComponentHook(this.ctr_previousChallengeButton,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(this.btn_previousChallengeButton,ComponentHookList.ON_RELEASE);
            }
            else
            {
               this.uiApi.removeComponentHook(this.ctr_previousChallengeButton,ComponentHookList.ON_RELEASE);
               this.uiApi.removeComponentHook(this.btn_previousChallengeButton,ComponentHookList.ON_RELEASE);
            }
            if(isNextButton)
            {
               this.uiApi.addComponentHook(this.ctr_nextChallengeButton,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(this.btn_nextChallengeButton,ComponentHookList.ON_RELEASE);
            }
            else
            {
               this.uiApi.removeComponentHook(this.ctr_nextChallengeButton,ComponentHookList.ON_RELEASE);
               this.uiApi.removeComponentHook(this.btn_nextChallengeButton,ComponentHookList.ON_RELEASE);
            }
         }
         else
         {
            this.uiApi.removeComponentHook(this.ctr_previousChallengeButton,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(this.ctr_nextChallengeButton,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(this.btn_previousChallengeButton,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(this.btn_nextChallengeButton,ComponentHookList.ON_RELEASE);
         }
         this.gd_challenges.dataProvider = this._challenges.slice(this._currentChallengeStartIndex,this._currentChallengeStartIndex + challengeToDisplayNumber);
         this.gd_challenges.visible = true;
         if(challengeToDisplayNumber !== this._lastChallengeToDisplayNumber)
         {
            this._lastChallengeToDisplayNumber = challengeToDisplayNumber;
            challenge = null;
            successfulChallengeNumber = 0;
            for(index = 0; index < this._challenges.length; index++)
            {
               challenge = this._challenges[index];
               if(challenge !== null && challenge.result === EnumChallengeResult.COMPLETED)
               {
                  successfulChallengeNumber++;
               }
            }
            this.lbl_successfulChallengeCounter.text = successfulChallengeNumber.toString() + "/" + totalChallengeToDisplayNumber.toString();
            newGridWidth = challengeToDisplayNumber * challengeSlotLength + challengeMargin / 2 * (challengeToDisplayNumber - 1);
            if(newGridWidth !== this.gd_challenges.width)
            {
               this.gd_challenges.width = newGridWidth;
            }
            newContainerWidth = this.lbl_successfulChallengeCounter.x + this.lbl_successfulChallengeCounter.width - this.ctr_previousChallengeButton.x;
            newXPos = (challengeMaxX - challengeMinX) / 2 - newContainerWidth / 2;
            if(newXPos !== this.ctr_challenges.x)
            {
               this.ctr_challenges.x = newXPos;
            }
         }
      }
      
      public function updateChallenge(challengeData:*, components:*, isSelected:Boolean) : void
      {
         if(challengeData === null)
         {
            components.slot_challengeIcon.data = null;
            components.tx_challengeResult.visible = false;
            delete this._challengeMap[components.tx_challengeResult.name];
            this.uiApi.removeComponentHook(components.slot_challengeIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.slot_challengeIcon,ComponentHookList.ON_ROLL_OUT);
            return;
         }
         components.slot_challengeIcon.data = challengeData;
         this._challengeMap[components.slot_challengeIcon.name] = challengeData;
         this.uiApi.addComponentHook(components.slot_challengeIcon,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.slot_challengeIcon,ComponentHookList.ON_ROLL_OUT);
         switch(challengeData.result)
         {
            case EnumChallengeResult.COMPLETED:
               components.tx_challengeResult.visible = true;
               components.tx_challengeResult.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_check.png");
               break;
            case EnumChallengeResult.FAILED:
               components.tx_challengeResult.visible = true;
               components.tx_challengeResult.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/filter_iconChallenge_cross.png");
               break;
            default:
               components.tx_challengeResult.visible = false;
         }
      }
      
      public function displayResults(results:Object, playSound:Boolean) : void
      {
         var i:* = undefined;
         var winnerBudget:String = null;
         var LoserBudget:String = null;
         var w:Object = null;
         var losersStr:String = null;
         var l:Object = null;
         var playerTeamLost:Boolean = false;
         var budgetString:String = null;
         var p:Object = null;
         var gridHeight:int = 0;
         var interfaceHeight:int = 0;
         var dataprovider:Array = [];
         var winners:Array = [];
         var losers:Array = [];
         var pony:Array = [];
         for(i in results)
         {
            results[i].rewards.objects.sort(this.compareItemsAveragePrices);
            if(this.dataApi.getCurrentTemporisSeasonNumber() == 5 && results[i].outcome != FightOutcomeEnum.RESULT_TAX && this.isMiniGameFight(results))
            {
               if(this.checkVictoryTemporisMiniGame(results))
               {
                  if(results[i].id == this.playerApi.id())
                  {
                     winners.push(results[i]);
                     this.lbl_result.text = this.uiApi.getText("ui.fightend.victory");
                     this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "tx_flag_victory.png");
                     if(playSound)
                     {
                        this.soundApi.playSound(SoundTypeEnum.FIGHT_WIN);
                     }
                  }
                  else
                  {
                     losers.push(results[i]);
                  }
               }
               else if(results[i].id == this.playerApi.id())
               {
                  losers.push(results[i]);
                  this.lbl_result.text = this.uiApi.getText("ui.fightend.loss");
                  this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "tx_flag_defeat.png");
                  if(playSound)
                  {
                     this.soundApi.playSound(SoundTypeEnum.FIGHT_LOSE);
                  }
               }
               else
               {
                  winners.push(results[i]);
               }
            }
            else if(results[i].outcome == FightOutcomeEnum.RESULT_VICTORY)
            {
               winners.push(results[i]);
               if(results[i].id == this.playerApi.id())
               {
                  this.lbl_result.text = this.uiApi.getText("ui.fightend.victory");
                  this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "tx_flag_victory.png");
                  if(playSound)
                  {
                     this.soundApi.playSound(SoundTypeEnum.FIGHT_WIN);
                  }
               }
            }
            else if(results[i].outcome == FightOutcomeEnum.RESULT_LOST)
            {
               losers.push(results[i]);
               if(results[i].id == this.playerApi.id())
               {
                  this.lbl_result.text = this.uiApi.getText("ui.fightend.loss");
                  this.tx_result.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "tx_flag_defeat.png");
                  if(playSound)
                  {
                     this.soundApi.playSound(SoundTypeEnum.FIGHT_LOSE);
                  }
               }
            }
            else if(results[i].outcome == FightOutcomeEnum.RESULT_TAX)
            {
               pony.push(results[i]);
            }
         }
         winnerBudget = "";
         LoserBudget = "";
         if(this._breachMode)
         {
            playerTeamLost = false;
            if(this._budget < 0)
            {
               playerTeamLost = true;
               this._budget = Math.abs(this._budget);
            }
            budgetString = this.utilApi.kamasToString(this._budget,"");
            if(!playerTeamLost)
            {
               winnerBudget = budgetString;
            }
            else
            {
               LoserBudget = "-" + budgetString;
            }
         }
         var winnersStr:String = this._winnersName != "" ? this._winnersName : this.uiApi.getText("ui.fightend.winners");
         dataprovider.push({
            "name":winnersStr,
            "icon":0,
            "budget":winnerBudget
         });
         for each(w in winners)
         {
            dataprovider.push(w);
         }
         losersStr = this._losersName != "" ? this._losersName : this.uiApi.getText("ui.fightend.losers");
         dataprovider.push({
            "name":losersStr,
            "icon":1,
            "budget":LoserBudget
         });
         for each(l in losers)
         {
            dataprovider.push(l);
         }
         if(pony.length > 0)
         {
            dataprovider.push({
               "name":this.uiApi.getText("ui.common.taxCollector"),
               "icon":2
            });
            for each(p in pony)
            {
               dataprovider.push(p);
            }
         }
         if(dataprovider.length < MAXIMAL_SIZE)
         {
            gridHeight = dataprovider.length * this.gd_fighters.slotHeight;
            interfaceHeight = this.ctr_fightResult.height + 164 + gridHeight;
            this.fightResultWindow.height = interfaceHeight;
            this.mainCtr.height = interfaceHeight;
            this.ctr_gridResult.height = gridHeight + this.tx_gridHeader.height + 24;
            this.gd_fighters.height = gridHeight;
            this.tx_gdFighterBg.height = gridHeight;
            this.uiApi.me().render();
         }
         this.gd_fighters.dataProvider = dataprovider;
      }
      
      private function checkVictoryTemporisMiniGame(results:Object) : Boolean
      {
         var result:FightResultEntryWrapper = null;
         var playerResult:FightResultEntryWrapper = null;
         var reward:ItemWrapper = null;
         var containMiniGameReward:Boolean = false;
         for each(result in results)
         {
            if(result.id == this.playerApi.id())
            {
               playerResult = result;
            }
         }
         if(playerResult != null && playerResult.rewards.objects.length != 0)
         {
            for each(reward in playerResult.rewards.objects)
            {
               if(reward.typeId == DataEnum.ITEM_TYPE_TEMPORIS_RICHETON_BAG)
               {
                  containMiniGameReward = true;
                  break;
               }
            }
         }
         return this.isMiniGameFight(results) && containMiniGameReward;
      }
      
      private function isMiniGameFight(results:Object) : Boolean
      {
         var result:FightResultEntryWrapper = null;
         for each(result in results)
         {
            if(result.id == PNJ_FIGHTER_GAME_1 || result.id == PNJ_FIGHTER_GAME_2 || result.id == PNJ_FIGHTER_GAME_3)
            {
               return true;
            }
         }
         return false;
      }
      
      private function compareItemsAveragePrices(pItemA:Object, pItemB:Object) : int
      {
         var itemAPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity;
         var itemBPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity;
         return itemAPrice < itemBPrice ? 1 : (itemAPrice > itemBPrice ? -1 : 0);
      }
      
      private function getIdolCoeff(pIdol:Idol) : Number
      {
         var i:int = 0;
         var j:int = 0;
         var coeff:Number = 1;
         var synergiesIds:Vector.<int> = pIdol.synergyIdolsIds;
         var synergiesCoeffs:Vector.<Number> = pIdol.synergyIdolsCoeff;
         var numSynergies:uint = synergiesIds.length;
         var numActiveIdols:uint = this._idols.length;
         for(i = 0; i < numActiveIdols; i++)
         {
            for(j = 0; j < numSynergies; j++)
            {
               if(synergiesIds[j] == this._idols[i])
               {
                  coeff *= synergiesCoeffs[j];
               }
            }
         }
         return coeff;
      }
      
      private function onUrlReceived(url:String = null) : void
      {
         if(this.btn_share)
         {
            this.btn_share.disabled = false;
            this.btn_share.visible = true;
            if(url)
            {
               this.uiApi.loadUi("Ankama_Web::sharePopup","sharePopup",{"url":url},StrataEnum.STRATA_HIGH,null,true);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var sharePopup:* = undefined;
         var screenshotAsBase64:String = null;
         var data:Object = null;
         switch(target)
         {
            case this.btn_close_fightResultWindow:
            case this.btn_close2:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_minimize:
               this.sysApi.setData("useFightResultSimple",true,DataStoreEnum.BIND_ACCOUNT);
               this.uiApi.loadUi("fightResultSimple","fightResultSimple",this._fightResults);
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_closeDrop:
               this.ctr_drop.visible = false;
               break;
            case this.btn_share:
               sharePopup = this.uiApi.getUi("sharePopup");
               if(!sharePopup)
               {
                  this.uiApi.hideTooltip();
                  screenshotAsBase64 = this.captureApi.getScreenAsJpgCompressedBase64();
                  if(screenshotAsBase64)
                  {
                     this.sysApi.getUrltoShareContent({
                        "title":this.uiApi.getText("ui.social.share.staticPage.defaultTitle",this.playerApi.getPlayedCharacterInfo().name),
                        "description":this.uiApi.getText("ui.social.share.staticPage.defaultDescription"),
                        "image":screenshotAsBase64
                     },this.onUrlReceived,ScreenshotTypeEnum.ENDFIGHT);
                     this.btn_share.disabled = true;
                     this.btn_share.visible = false;
                  }
                  else
                  {
                     this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.social.share.popup.error"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
                     this.sysApi.log(16,"Failed to get screenshot of the game view as base64!");
                  }
               }
               else
               {
                  sharePopup.uiClass.toggleVisibility();
               }
               break;
            case this.btn_idols:
               if(!this.uiApi.getUi("idolsTab"))
               {
                  this.sysApi.sendAction(new OpenIdolsAction([]));
               }
               else
               {
                  this.sysApi.sendAction(new OpenBookAction(["idolsTab"]));
               }
               break;
            case this.ctr_previousChallengeButton:
            case this.btn_previousChallengeButton:
               this.turnChallengePage(false);
               break;
            case this.ctr_nextChallengeButton:
            case this.btn_nextChallengeButton:
               this.turnChallengePage(true);
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(this.ctr_drop.visible && this.lbl_drop.text == data.name)
                  {
                     this.ctr_drop.visible = false;
                  }
                  else
                  {
                     this.ctr_drop.visible = true;
                     this.gd_drop.dataProvider = data.rewards.objects;
                     this.lbl_drop.text = data.name;
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:Object = null;
         var percentXp:int = 0;
         var bonusXp:int = 0;
         var challenge:ChallengeWrapper = null;
         var makerParam:Object = null;
         var targetMonsterId:Number = NaN;
         var turnsRequired:Number = NaN;
         var text:* = "";
         var pos:Object = {
            "point":7,
            "relativePoint":7,
            "offset":0
         };
         var server:Server = this.sysApi.getCurrentServer();
         switch(target)
         {
            case this.btn_minimize:
               text = this.uiApi.getText("ui.common.minimize");
               break;
            case this.ctr_rewardRate:
               if(this._rewardRate < 0)
               {
                  text = this.uiApi.getText("ui.fightend.malus");
               }
               else
               {
                  text = this.uiApi.getText("ui.fightend.bonus");
               }
               break;
            case this.lbl_score:
               text = this.gd_idols.dataProvider && this.gd_idols.dataProvider.length > 0 ? this.uiApi.getText("ui.idol.fightScore",this._totalScore,this._totalLoot + "%",this._totalExp + "%") : this.uiApi.getText("ui.idol.noIdols");
               break;
            case this.btn_share:
               if(!this.btn_share.softDisabled)
               {
                  text = this.uiApi.getText("ui.common.socialNetworkShare");
               }
               else
               {
                  text = this.uiApi.getText("ui.payzone.limit");
               }
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  text = this._objectsLists[this._hookGridObjects[target.name].id];
                  text += "<br/><font color=\'" + this._helpColor + "\'><i>" + this.uiApi.getText("ui.tooltip.loot.more") + "</i></font>";
               }
               else if(target.name.indexOf("lbl_honour") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     text = this.uiApi.getText("ui.pvp.rank") + this.uiApi.getText("ui.common.colon") + data.grade + "\n" + this.uiApi.getText("ui.pvp.honourPoints") + this.uiApi.getText("ui.common.colon") + (data.honorDelta > 0 ? "+" : "") + data.honorDelta;
                  }
               }
               else if(target.name.indexOf("lbl_xpPerso") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     if(!this.configApi.isFeatureWithKeywordEnabled("character.xp") && data.breed > 0)
                     {
                        if(data.showExperienceForGuild)
                        {
                           text += this.uiApi.getText("ui.common.guild") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForGuild,"") + " " + this.uiApi.getText("ui.common.xp") + "\n";
                        }
                        if(data.showExperienceForRide)
                        {
                           text += this.uiApi.getText("ui.common.ride") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForRide,"") + " " + this.uiApi.getText("ui.common.xp") + "\n";
                        }
                        text += (text != "" ? "\n" : "") + this.uiApi.getText("ui.temporis.xpInformation");
                     }
                     else
                     {
                        if(data.showExperienceFightDelta)
                        {
                           text = this.uiApi.getText("ui.fightend.xp") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceFightDelta,"");
                           if(data.isIncarnationExperience)
                           {
                              text += " (" + this.uiApi.getText("ui.common.incarnation") + ")";
                           }
                        }
                        if(data.showExperienceForGuild)
                        {
                           text += "\n" + this.uiApi.getText("ui.common.guild") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForGuild,"");
                        }
                        if(data.showExperienceForRide)
                        {
                           text += "\n" + this.uiApi.getText("ui.common.ride") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(data.experienceForRide,"");
                        }
                     }
                  }
               }
               else if(target.name.indexOf("pb_xpGauge") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     percentXp = Math.floor((data.experience - data.experienceLevelFloor) * 100 / (data.experienceNextLevelFloor - data.experienceLevelFloor));
                     text = "" + percentXp + "% (" + this.utilApi.kamasToString(data.experience - data.experienceLevelFloor,"") + " / " + this.utilApi.kamasToString(data.experienceNextLevelFloor - data.experienceLevelFloor,"") + ")";
                  }
               }
               else if(target.name.indexOf("tx_xpBonusPicto") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     bonusXp = 0;
                     if(server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
                     {
                        bonusXp = this.getPlayerExperienceBonusPercent();
                        if(bonusXp == 6)
                        {
                           text += this.uiApi.getText("ui.information.xpHardcoreEpicDeathBonus");
                        }
                        else
                        {
                           text += this.uiApi.getText("ui.information.xpHardcoreEpicBonus");
                        }
                     }
                     else
                     {
                        bonusXp = data.rerollXpMultiplicator;
                        if(bonusXp > 1)
                        {
                           text = this.uiApi.getText("ui.common.experiencePoint") + " x " + bonusXp + "\n\n" + this.uiApi.getText("ui.information.xpFamilyBonus");
                        }
                     }
                  }
               }
               else if(target.name.indexOf("tx_arrow") != -1)
               {
                  data = this._hookGridObjects[target.name];
                  if(data)
                  {
                     if(data.fightInitiator)
                     {
                        text = this.uiApi.getText("ui.fightend.fightInitiator");
                     }
                  }
               }
               else if(target.name.indexOf("tx_level") != -1)
               {
                  text = this.uiApi.getText("ui.tooltip.OmegaLevel");
               }
               else if(target.name.indexOf("slot_challengeIcon") !== -1 && target.name in this._challengeMap)
               {
                  challenge = this._challengeMap[target.name];
                  makerParam = null;
                  if(challenge.categoryId === EnumChallengeCategory.ACHIEVEMENT)
                  {
                     makerParam = {
                        "name":true,
                        "description":true,
                        "effects":false,
                        "boundAchievements":challenge.boundAchievements,
                        "results":true
                     };
                     targetMonsterId = challenge.getTargetMonsterId();
                     if(!isNaN(targetMonsterId))
                     {
                        makerParam.bossId = targetMonsterId;
                     }
                     turnsRequired = challenge.getTurnsNumberForCompletion();
                     if(!isNaN(turnsRequired))
                     {
                        makerParam.turnsRequired = turnsRequired;
                     }
                  }
                  this.uiApi.showTooltip(this._challengeMap[target.name],target,false,"standard",2,8,0,null,null,makerParam);
               }
         }
         if(text != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,pos.offset,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         if(target.name.indexOf("gd_objects") != -1 || target == this.gd_drop)
         {
            if(!this.sysApi.getOption("displayTooltips","dofus") && (selectMethod == GridItemSelectMethodEnum.CLICK || selectMethod == GridItemSelectMethodEnum.MANUAL))
            {
               item = (target as Grid).selectedItem;
               this.sysApi.dispatchHook(ChatHookList.ShowObjectLinked,item);
            }
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var idol:Idol = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:* = undefined;
         if(item.data)
         {
            if(item.data.typeId == 178)
            {
               idol = this.dataApi.getIdolByItemId(item.data.objectGID);
               this.uiApi.showTooltip(idol.spellPair,item.container,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_BOTTOM,0,null,null,{
                  "smallSpell":true,
                  "header":false,
                  "footer":false,
                  "isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus"),
                  "spellTab":false
               });
            }
            else
            {
               itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
               if(!itemTooltipSettings)
               {
                  itemTooltipSettings = this.tooltipApi.createItemSettings();
                  this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
               }
               tooltipData = item.data;
               if(!itemTooltipSettings.header && !itemTooltipSettings.conditions && !itemTooltipSettings.effects && !itemTooltipSettings.description && !itemTooltipSettings.averagePrice)
               {
                  tooltipData = item.data.name;
               }
               this.uiApi.showTooltip(item.data,item.container,false,"standard",7,7,0,"itemName",null,{
                  "header":itemTooltipSettings.header,
                  "conditions":itemTooltipSettings.conditions,
                  "description":itemTooltipSettings.description,
                  "averagePrice":itemTooltipSettings.averagePrice,
                  "showEffects":itemTooltipSettings.effects
               },"ItemInfo");
            }
         }
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         if(item.data == null)
         {
            return;
         }
         var data:Object = item.data;
         var contextMenu:ContextMenuData = this.menuApi.create(data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemDetails(item:Object, target:Object) : void
      {
         this.uiApi.showTooltip(item,target,false,"Hyperlink",0,2,3,null,null,null,null,true);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               if(this.ctr_drop.visible)
               {
                  this.ctr_drop.visible = false;
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               return true;
            default:
               return false;
         }
      }
   }
}
