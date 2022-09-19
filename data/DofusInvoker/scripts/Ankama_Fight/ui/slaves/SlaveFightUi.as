package Ankama_Fight.ui.slaves
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.CompanionSpell;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.optionalFeatures.Modster;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellPreviewAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import damageCalculation.tools.StatIds;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class SlaveFightUi
   {
      
      public static const INVALID_UI_ID:uint = uint.MAX_VALUE;
      
      public static const SLAVE_UI_NAME_PREFIX:String = UIEnum.SLAVE_FIGHT_UI + "_";
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SlaveFightUi));
      
      private static const UI_TOOLTIP_NAME:String = "standard";
      
      private static const UI_SPELL_TOOLTIP_NAME:String = "spellBanner";
      
      private static const DATA_KEY_CACHED_DATA_PREFIX:String = "SlaveUiCachedDataDataKey_";
      
      private static const UNKNOWN_INITIATIVE_LABEL:String = "?";
      
      private static const SLAVE_HIGHLIGHT_ENABLED_LUMINOSITY:Number = 1.5;
      
      private static const SLAVE_HIGHLIGHT_DISABLED_LUMINOSITY:Number = 1;
      
      private static const MAX_CASCADING_UI_NUMBER:uint = 8;
       
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var btn_changeOrientation:ButtonContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var ctr_content:GraphicContainer;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_slave:GraphicContainer;
      
      public var ed_slaveIcon:EntityDisplayer;
      
      public var lbl_initiative:Label;
      
      public var gd_spells:Grid;
      
      public var pb_slaveHp:ProgressBar;
      
      public var pb_slaveHpThreshold:ProgressBar;
      
      public var pb_slaveShield:ProgressBar;
      
      public var tx_changeOrientationIcon:Texture;
      
      public var tx_separator:Texture;
      
      public var tx_slaveTeamBackground:Texture;
      
      public var tx_slaveTeamDarkBackground:Texture;
      
      public var tx_slaveTeamTimeBackground:Texture;
      
      public var tx_background:TextureBitmap;
      
      public var tx_panel:TextureBitmap;
      
      public var tx_slaveIcon:TextureBitmap;
      
      private var _uiId:uint = 4.294967295E9;
      
      private var _isFatalError:Boolean = false;
      
      private var _slaveId:Number = 1.7976931348623157E308;
      
      private var _slaveLevel:uint = 4.294967295E9;
      
      private var _slaveTeam:uint = 2;
      
      private var _slaveSpellRanks:SpellIdRankMap = null;
      
      private var _slaveLook:TiphonEntityLook = null;
      
      private var _slaveSpellIds:Vector.<uint> = null;
      
      private var _slavePassiveSpellIds:Vector.<uint> = null;
      
      private var _isSlaveHiddenInPreFight:Boolean = false;
      
      private var _isVertical:Boolean = false;
      
      public function SlaveFightUi()
      {
         super();
      }
      
      public static function getUiInstanceNameFromId(uiId:uint) : String
      {
         return SLAVE_UI_NAME_PREFIX + uiId.toString();
      }
      
      private static function parseSpellRank(entityLevel:uint, rawSpellRanks:String) : uint
      {
         var spellRankEntityLevelStrTuple:Array = null;
         var spellRank:Number = NaN;
         var minEntityLevel:Number = NaN;
         var rawSpellRanksByEntityLevel:Array = rawSpellRanks.split(";");
         for(var i:int = rawSpellRanksByEntityLevel.length - 1; i >= 0; i--)
         {
            spellRankEntityLevelStrTuple = rawSpellRanksByEntityLevel[i].split(",");
            spellRank = Number(spellRankEntityLevelStrTuple[0]);
            minEntityLevel = Number(spellRankEntityLevelStrTuple[1]);
            if(!(isNaN(spellRank) || isNaN(minEntityLevel) || minEntityLevel > entityLevel))
            {
               return spellRank;
            }
         }
         return uint.MAX_VALUE;
      }
      
      public function get uiId() : uint
      {
         return this._uiId;
      }
      
      public function get slaveId() : Number
      {
         return this._slaveId;
      }
      
      public function set x(x:Number) : void
      {
         this.ctr_main.x = x;
      }
      
      public function get x() : Number
      {
         return this.ctr_main.x;
      }
      
      public function set y(y:Number) : void
      {
         this.ctr_main.y = y;
      }
      
      public function get y() : Number
      {
         return this.ctr_main.y;
      }
      
      public function main(descr:SlaveFightUiDescr = null) : void
      {
         if(descr === null)
         {
            this.abort("No description provided to initialize the UI.");
            return;
         }
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.sysApi.addHook(FightHookList.FightersInitiative,this.onInitiativeUpdated);
         this.sysApi.addHook(FightHookList.BuffAdd,this.onBuffAdd);
         this.sysApi.addHook(FightHookList.BuffRemove,this.onBuffRemove);
         this.sysApi.addHook(FightHookList.BuffUpdate,this.onBuffUpdate);
         this.sysApi.addHook(FightHookList.BuffDispell,this.onBuffDispel);
         this.sysApi.addHook(FightHookList.FighterInfoUpdate,this.onFighterInfoUpdate);
         this.sysApi.addHook(FightHookList.UpdatePreFightersList,this.onUpdatePreFightersList);
         this.sysApi.addHook(FightHookList.UpdateFightersLook,this.onUpdateFightersLook);
         this.sysApi.addHook(HookList.GameFightTurnStart,this.onTurnStart);
         this.sysApi.addHook(HookList.FightEvent,this.onFightEvent);
         this.uiApi.addComponentHook(this.btn_changeOrientation,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_slave,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slave,ComponentHookList.ON_ROLL_OUT);
         var statsManager:StatsManager = StatsManager.getInstance();
         statsManager.addListenerToStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         statsManager.addListenerToStat(StatIds.SHIELD,this.onUpdateShieldPoints);
         this._uiId = descr.uiId;
         this._slaveId = descr.slaveId;
         this.setSlaveInfo();
         this.setSpells();
         this.setUiElements();
         this.restoreCachedData();
         this.setOrientation(this._isVertical,true);
      }
      
      public function unload() : void
      {
         var statsManager:StatsManager = StatsManager.getInstance();
         statsManager.removeListenerFromStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         statsManager.removeListenerFromStat(StatIds.SHIELD,this.onUpdateShieldPoints);
         if(!this._isFatalError)
         {
            this.saveCachedData();
         }
      }
      
      private function abort(errorMessage:String = null) : void
      {
         this._isFatalError = true;
         if(errorMessage === null)
         {
            errorMessage = "Unknown error!";
         }
         errorMessage = "Critical error for slave fight UI (UI ID: " + this._uiId.toString() + ", slave ID: " + this._slaveId.toString() + "): " + errorMessage + " - Aborting. Trying to close the UI.";
         if(this.uiApi !== null)
         {
            this.uiApi.unloadUi(getUiInstanceNameFromId(this._uiId));
         }
         else
         {
            _log.error("Tried to unload UI, but UI API is no available. What happened?");
         }
         throw new Error(errorMessage);
      }
      
      private function setSlaveInfo() : void
      {
         var monsterInfo:GameFightMonsterInformations = null;
         var monsterData:Monster = null;
         var maxCount:uint = 0;
         var i:uint = 0;
         var modsterData:Modster = null;
         var modsterPassiveSpellId:int = 0;
         var spellId:uint = 0;
         var spellGrades:String = null;
         var monsterSpellRank:uint = 0;
         var fighterInfo:GameFightEntityInformation = null;
         var companionData:Companion = null;
         var companionSpellId:uint = 0;
         var companionSpell:CompanionSpell = null;
         var companionSpellRank:uint = 0;
         var entityInfo:FighterInformations = this.fightApi.getFighterInformations(this._slaveId);
         this._slaveTeam = entityInfo.teamId;
         this._isSlaveHiddenInPreFight = entityInfo.hiddenInPrefight;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(entitiesFrame === null)
         {
            this.abort("Unable to get fight entities frame.");
            return;
         }
         this._slaveSpellIds = null;
         this._slavePassiveSpellIds = null;
         this._slaveSpellRanks = null;
         this._slaveLevel = this.fightApi.getFighterLevel(this._slaveId);
         var slaveInfo:GameContextActorInformations = entitiesFrame.getEntityInfos(this._slaveId);
         if(slaveInfo is GameFightMonsterInformations)
         {
            monsterInfo = slaveInfo as GameFightMonsterInformations;
            monsterData = Monster.getMonsterById(monsterInfo.creatureGenericId);
            if(monsterData !== null)
            {
               this._slaveSpellIds = monsterData.spells;
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.MODSTERS))
               {
                  modsterData = Modster.getModsterByModsterId(monsterInfo.creatureGenericId);
                  if(modsterData !== null && modsterData.modsterPassiveSpells.length > 0)
                  {
                     this._slavePassiveSpellIds = new Vector.<uint>(0);
                     for each(modsterPassiveSpellId in modsterData.modsterPassiveSpells)
                     {
                        this._slavePassiveSpellIds.push(modsterPassiveSpellId as uint);
                     }
                  }
               }
               this._slaveSpellRanks = new SpellIdRankMap();
               maxCount = Math.min(this._slaveSpellIds.length,monsterData.spellGrades.length);
               for(i = 0; i < maxCount; i++)
               {
                  spellId = this._slaveSpellIds[i];
                  spellGrades = monsterData.spellGrades[i];
                  monsterSpellRank = parseSpellRank(this._slaveLevel,spellGrades);
                  if(monsterSpellRank != uint.MAX_VALUE)
                  {
                     this._slaveSpellRanks.setRank(spellId,monsterSpellRank);
                  }
               }
            }
         }
         else if(slaveInfo is GameFightEntityInformation)
         {
            fighterInfo = slaveInfo as GameFightEntityInformation;
            companionData = Companion.getCompanionById(fighterInfo.entityModelId);
            if(companionData !== null)
            {
               this._slaveSpellIds = new Vector.<uint>(0);
               this._slaveSpellRanks = new SpellIdRankMap();
               for each(companionSpellId in companionData.spells)
               {
                  companionSpell = this.dataApi.getCompanionSpell(companionSpellId);
                  if(companionSpell !== null)
                  {
                     this._slaveSpellIds.push(companionSpell.spellId);
                     companionSpellRank = parseSpellRank(this._slaveLevel,companionSpell.gradeByLevel);
                     if(companionSpellRank != uint.MAX_VALUE)
                     {
                        this._slaveSpellRanks.setRank(companionSpell.spellId,companionSpellRank);
                     }
                  }
               }
            }
         }
         if(this._slaveLevel === uint.MAX_VALUE)
         {
            this.abort("Unable to get slave level.");
         }
         if(this._slaveSpellIds === null)
         {
            this.abort("Unable to get slave spells.");
         }
         if(this._slaveSpellRanks === null)
         {
            this.abort("Unable to get slave spell ranks.");
         }
         _log.debug("Entity information retrieved.");
      }
      
      private function setSpells() : void
      {
         var spell:SpellWrapper = null;
         var spellId:uint = 0;
         var i:uint = 0;
         var slaveSpells:Vector.<SpellWrapper> = new Vector.<SpellWrapper>(0);
         if(this._slavePassiveSpellIds !== null)
         {
            for each(spellId in this._slavePassiveSpellIds)
            {
               spell = SpellWrapper.create(spellId,this._slaveSpellRanks.getRank(spellId),false,this._slaveId,false,true,false);
               if(spell === null)
               {
                  _log.error("Passive spell (ID: " + spellId.toString() + ") is null. Ignoring it.");
               }
               else
               {
                  slaveSpells.push(spell);
               }
            }
         }
         if(this._slaveSpellIds !== null)
         {
            for each(spellId in this._slaveSpellIds)
            {
               spell = SpellWrapper.create(spellId,this._slaveSpellRanks.getRank(spellId),true,this._slaveId,false,true,true);
               if(spell === null)
               {
                  _log.error("Spell (ID: " + spellId.toString() + ") is null. Ignoring it.");
               }
               else
               {
                  slaveSpells.push(spell);
               }
            }
            if(CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this.slaveId).needCooldownUpdate)
            {
               CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this.slaveId).updateCooldowns();
            }
         }
         this.gd_spells.dataProvider = slaveSpells;
         if(this._slavePassiveSpellIds !== null)
         {
            for(i = 0; i < this._slavePassiveSpellIds.length; i++)
            {
               (this.gd_spells.slots[i] as Slot).isActiveFunction = function():Boolean
               {
                  return true;
               };
            }
            while(i < this.gd_spells.dataProvider)
            {
               (this.gd_spells.slots[i] as Slot).isActiveFunction = null;
               i++;
            }
         }
      }
      
      private function setUiElements() : void
      {
         this.lbl_initiative.filters = [new GlowFilter(this.sysApi.getConfigEntry("colors.text.glow.dark"),0.8,2,2,6,BitmapFilterQuality.HIGH)];
         this.ed_slaveIcon.view = "timeline";
         this.ed_slaveIcon.setAnimationAndDirection("AnimArtwork",1);
         this.ed_slaveIcon.filters = [new GlowFilter(16777215,0.2,20,20,2,BitmapFilterQuality.HIGH)];
         this.setSlaveLook();
         this.setSlaveHighlightState(false);
         this.setTeam();
         this.setHealthPoints();
         this.setShieldPoints();
         this.setHealthPointThreshold();
         this.setInitiative();
      }
      
      private function setSlaveLook() : void
      {
         var entityInfo:FighterInformations = this.fightApi.getFighterInformations(this._slaveId);
         if(this._slaveLook != entityInfo.look)
         {
            this._slaveLook = entityInfo.look;
            this.ed_slaveIcon.look = this._slaveLook;
         }
      }
      
      private function setOrientation(isVertical:Boolean, isForce:Boolean = false) : void
      {
         if(this._isVertical === isVertical && !isForce)
         {
            return;
         }
         this._isVertical = isVertical;
         var me:UiRootContainer = this.uiApi.me();
         var constantPrefix:String = !!this._isVertical ? "vertical_" : "horizontal_";
         this.tx_background.x = Number(me.getConstant(constantPrefix + "TxBackgroundX"));
         this.tx_background.y = Number(me.getConstant(constantPrefix + "TxBackgroundY"));
         this.tx_background.rotation = Number(me.getConstant(constantPrefix + "TxBackgroundRotation"));
         this.tx_slaveIcon.x = Number(me.getConstant(constantPrefix + "TxSlaveIconX"));
         this.tx_slaveIcon.y = Number(me.getConstant(constantPrefix + "TxSlaveIconY"));
         this.tx_changeOrientationIcon.x = Number(me.getConstant(constantPrefix + "TxChangeOrientationIconX"));
         this.tx_changeOrientationIcon.y = Number(me.getConstant(constantPrefix + "TxChangeOrientationIconY"));
         this.tx_changeOrientationIcon.uri = this.uiApi.createUri(me.getConstant("texture") + me.getConstant(constantPrefix + "TxChangeOrientationIcon"));
         this.tx_separator.x = Number(me.getConstant(constantPrefix + "TxSeparatorX"));
         this.tx_separator.y = Number(me.getConstant(constantPrefix + "TxSeparatorY"));
         this.tx_separator.rotation = Number(me.getConstant(constantPrefix + "TxSeparatorRotation"));
         this.ctr_slave.x = Number(me.getConstant(constantPrefix + "CtrSlaveX"));
         this.ctr_slave.y = Number(me.getConstant(constantPrefix + "CtrSlaveY"));
         this.tx_panel.x = Number(me.getConstant(constantPrefix + "TxPanelX"));
         this.tx_panel.y = Number(me.getConstant(constantPrefix + "TxPanelY"));
         this.tx_panel.rotation = Number(me.getConstant(constantPrefix + "TxPanelRotation"));
         this.btn_minimize.x = Number(me.getConstant(constantPrefix + "BtnMinimizeX"));
         this.btn_minimize.y = Number(me.getConstant(constantPrefix + "BtnMinimizeY"));
         this.gd_spells.x = Number(me.getConstant(constantPrefix + "GdSpellsX"));
         this.gd_spells.y = Number(me.getConstant(constantPrefix + "GdSpellsY"));
         if(this._isVertical)
         {
            if(this.gd_spells.dataProvider && this.gd_spells.dataProvider.length > 0)
            {
               this.gd_spells.height = this.gd_spells.slotHeight * this.gd_spells.dataProvider.length + me.getConstant("spellIconSizeOffset") * (this.gd_spells.dataProvider.length - 1);
            }
            else
            {
               this.gd_spells.height = 0;
            }
            this.gd_spells.width = me.getConstant("spellIconSize");
            this.tx_background.height = this.gd_spells.y + this.gd_spells.height - this.tx_panel.y + Number(me.getConstant(constantPrefix + "TxBackgroundLengthOffset"));
         }
         else
         {
            this.gd_spells.height = me.getConstant("spellIconSize");
            if(this.gd_spells.dataProvider && this.gd_spells.dataProvider.length > 0)
            {
               this.gd_spells.width = this.gd_spells.slotWidth * this.gd_spells.dataProvider.length + me.getConstant("spellIconSizeOffset") * (this.gd_spells.dataProvider.length - 1);
            }
            else
            {
               this.gd_spells.height = 0;
            }
            this.tx_background.height = this.gd_spells.x + this.gd_spells.width - this.tx_panel.x + Number(me.getConstant(constantPrefix + "TxBackgroundLengthOffset"));
         }
      }
      
      private function setContentVisibility(isVisible:Boolean) : void
      {
         this.ctr_content.visible = isVisible;
      }
      
      private function setSlaveHighlightState(isHighlight:Boolean) : void
      {
         if(isHighlight)
         {
            this.tx_slaveTeamBackground.luminosity = SLAVE_HIGHLIGHT_ENABLED_LUMINOSITY;
            this.tx_slaveTeamDarkBackground.luminosity = SLAVE_HIGHLIGHT_ENABLED_LUMINOSITY;
            this.tx_slaveTeamTimeBackground.luminosity = SLAVE_HIGHLIGHT_ENABLED_LUMINOSITY;
         }
         else
         {
            this.tx_slaveTeamBackground.luminosity = SLAVE_HIGHLIGHT_DISABLED_LUMINOSITY;
            this.tx_slaveTeamDarkBackground.luminosity = SLAVE_HIGHLIGHT_DISABLED_LUMINOSITY;
            this.tx_slaveTeamTimeBackground.luminosity = SLAVE_HIGHLIGHT_DISABLED_LUMINOSITY;
         }
      }
      
      private function setTeam() : void
      {
         var color:String = null;
         if(this._slaveTeam === TeamEnum.TEAM_CHALLENGER)
         {
            color = "red";
         }
         else if(this._slaveTeam === TeamEnum.TEAM_DEFENDER)
         {
            color = "blue";
         }
         else
         {
            color = "grey";
         }
         var me:UiRootContainer = this.uiApi.me();
         this.tx_slaveTeamBackground.uri.uri = me.getConstant("texture") + "hud/background_timeline_" + color + "_normal.png";
         this.tx_slaveTeamDarkBackground.uri.uri = me.getConstant("texture") + "hud/background_timeline_" + color + "_dark.png";
         this.tx_slaveTeamTimeBackground.uri.uri = me.getConstant("texture") + "hud/background_timeline_" + color + "_over.png";
         this.tx_slaveTeamBackground.finalize();
         this.tx_slaveTeamDarkBackground.finalize();
         this.tx_slaveTeamTimeBackground.finalize();
      }
      
      private function setHealthPoints() : void
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._slaveId);
         var hp:Number = 0;
         var maxHp:Number = 0;
         if(stats !== null)
         {
            maxHp = Math.max(stats.getMaxHealthPoints(),0);
            hp = Math.max(Math.min(stats.getHealthPoints(),maxHp),0);
         }
         var ratio:Number = maxHp <= 0 ? Number(0) : Number(hp / maxHp);
         this.pb_slaveHp.value = ratio;
      }
      
      private function setShieldPoints() : void
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._slaveId);
         var maxHp:Number = 0;
         var shieldPoints:Number = 0;
         if(stats !== null)
         {
            maxHp = Math.max(stats.getMaxHealthPoints(),0);
            shieldPoints = Math.max(stats.getStatTotalValue(StatIds.SHIELD),0);
         }
         if(shieldPoints <= 0 || maxHp <= 0)
         {
            this.pb_slaveShield.visible = false;
            this.pb_slaveShield.value = 0;
            return;
         }
         this.pb_slaveShield.visible = true;
         var ratio:Number = shieldPoints / maxHp;
         this.pb_slaveShield.value = ratio;
      }
      
      private function setHealthPointThreshold() : void
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._slaveId);
         var maxHp:Number = 0;
         if(stats !== null)
         {
            maxHp = Math.max(stats.getMaxHealthPoints(),0);
         }
         var hpThreshold:uint = Math.min(this.sysApi.getBuffManager().getLifeThreshold(this._slaveId),maxHp);
         if(hpThreshold <= 0 || maxHp <= 0)
         {
            this.pb_slaveHpThreshold.visible = false;
            this.pb_slaveHpThreshold.value = 0;
            return;
         }
         this.pb_slaveHpThreshold.visible = true;
         var ratio:Number = hpThreshold / maxHp;
         this.pb_slaveHpThreshold.value = ratio * this.pb_slaveHp.value;
      }
      
      private function setInitiative() : void
      {
         var initiative:int = 0;
         if(!this.configApi.getConfigProperty("dofus","orderFighters"))
         {
            this.lbl_initiative.text = null;
            this.lbl_initiative.visible = false;
            return;
         }
         if(this._isSlaveHiddenInPreFight && this.playerApi.isInPreFight())
         {
            this.lbl_initiative.text = UNKNOWN_INITIATIVE_LABEL;
         }
         else
         {
            initiative = this.fightApi.getFighterInitiative(this._slaveId);
            this.lbl_initiative.text = initiative >= 0 ? initiative.toString() : UNKNOWN_INITIATIVE_LABEL;
         }
      }
      
      private function handleBuffUpdate(buffId:uint) : void
      {
         var buff:BasicBuff = this.fightApi.getBuffById(buffId,this._slaveId);
         this.setHealthPoints();
         this.setShieldPoints();
         if(buff.actionId === ActionIds.ACTION_CHARACTER_BOOST_THRESHOLD)
         {
            this.setHealthPointThreshold();
         }
      }
      
      private function restoreCachedData() : void
      {
         var me:UiRootContainer = null;
         var rawIsVertical:String = null;
         var rawX:String = null;
         var rawY:String = null;
         var rawYOffset:String = null;
         var rawCachedData:* = this.sysApi.getData(this.getCachedDataKey(),DataStoreEnum.BIND_ACCOUNT);
         var cachedData:SlaveFightUiCachedData = SlaveFightUiCachedData.unpack(rawCachedData as ByteArray);
         if(cachedData === null)
         {
            me = this.uiApi.me();
            rawIsVertical = me.getConstant("default_isVertical");
            rawX = me.getConstant("default_x");
            rawY = me.getConstant("default_y");
            rawYOffset = me.getConstant("default_yOffset");
            this._isVertical = rawIsVertical && rawIsVertical.toLowerCase() === "true" || Number(rawIsVertical) === 1;
            this.x = !!rawX ? Number(Number(rawX)) : Number(0);
            this.y = (!!rawY ? Number(rawY) : 0) + this._uiId % MAX_CASCADING_UI_NUMBER * (!!rawYOffset ? Number(rawYOffset) : 0);
            return;
         }
         this._isVertical = cachedData.isVertical;
         this.setContentVisibility(cachedData.isVisible);
         this.x = cachedData.positionX;
         this.y = cachedData.positionY;
      }
      
      private function saveCachedData() : void
      {
         var cachedData:SlaveFightUiCachedData = new SlaveFightUiCachedData(this._isVertical,this.x,this.y,this.ctr_content.visible);
         this.sysApi.setData(this.getCachedDataKey(),cachedData.pack(),DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function getCachedDataKey() : String
      {
         return DATA_KEY_CACHED_DATA_PREFIX + this._uiId.toString();
      }
      
      private function hideTooltips() : void
      {
         this.uiApi.hideTooltip(UI_TOOLTIP_NAME);
         this.uiApi.hideTooltip(UI_SPELL_TOOLTIP_NAME);
      }
      
      private function refreshSpells() : void
      {
         var slot:Slot = null;
         for each(slot in this.gd_spells.slots)
         {
            slot.refresh();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target === this.ctr_slave)
         {
            this.sysApi.sendAction(new TimelineEntityOverAction([this._slaveId,true]));
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.hideTooltips();
         if(target === this.ctr_slave)
         {
            this.sysApi.sendAction(new TimelineEntityOutAction([this._slaveId]));
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target === this.btn_changeOrientation)
         {
            this.setOrientation(!this._isVertical);
         }
         else if(target === this.btn_minimize)
         {
            this.setContentVisibility(!this.ctr_content.visible);
         }
      }
      
      private function onFoldAll(isVisible:Boolean) : void
      {
         this.setContentVisibility(false);
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(!(target is Grid))
         {
            return;
         }
         var spellWrapper:SpellWrapper = (target as Grid).selectedItem;
         if(spellWrapper === null || !spellWrapper.active)
         {
            return;
         }
         this.sysApi.sendAction(GameFightSpellPreviewAction.create(this._slaveId,spellWrapper));
      }
      
      public function onItemRollOver(target:GraphicContainer, item:GridItem) : void
      {
         var point:uint = 0;
         var relativePoint:uint = 0;
         if(!(item.data is SpellWrapper))
         {
            return;
         }
         var spellWrapper:SpellWrapper = item.data as SpellWrapper;
         if(this._isVertical)
         {
            point = LocationEnum.POINT_LEFT;
            relativePoint = LocationEnum.POINT_RIGHT;
         }
         else
         {
            point = LocationEnum.POINT_BOTTOM;
            relativePoint = LocationEnum.POINT_TOP;
         }
         this.uiApi.showTooltip(this.tooltipApi.getSpellTooltipInfo(spellWrapper),item.container,false,UI_TOOLTIP_NAME,point,relativePoint,3,null,null,null,"spell");
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.hideTooltips();
      }
      
      private function onUpdateHealthPoints(stat:Stat) : void
      {
         if(stat.entityId !== this._slaveId)
         {
            return;
         }
         this.setHealthPoints();
         this.setHealthPointThreshold();
      }
      
      private function onUpdateShieldPoints(stat:Stat) : void
      {
         if(stat.entityId !== this._slaveId)
         {
            return;
         }
         this.setShieldPoints();
      }
      
      private function onInitiativeUpdated() : void
      {
         this.setInitiative();
      }
      
      private function onBuffAdd(buffId:uint, entityId:Number) : void
      {
         if(entityId !== this._slaveId)
         {
            return;
         }
         this.handleBuffUpdate(buffId);
      }
      
      private function onBuffRemove(buffIdOrBasicBuff:*, entityId:Number, reason:String) : void
      {
         if(entityId !== this._slaveId)
         {
            return;
         }
         var buffId:uint = buffIdOrBasicBuff is uint ? uint(buffIdOrBasicBuff as uint) : uint((buffIdOrBasicBuff as BasicBuff).id);
         this.handleBuffUpdate(buffId);
      }
      
      private function onBuffUpdate(buffId:uint, entityId:Number) : void
      {
         if(entityId !== this._slaveId)
         {
            return;
         }
         this.handleBuffUpdate(buffId);
      }
      
      private function onBuffDispel(entityId:Number) : void
      {
         if(entityId !== this._slaveId)
         {
            return;
         }
         this.setHealthPoints();
         this.setShieldPoints();
         this.setHealthPointThreshold();
      }
      
      private function onFighterInfoUpdate(fighterInfo:GameFightFighterInformations = null) : void
      {
         if(fighterInfo === null || fighterInfo.contextualId !== this._slaveId)
         {
            this.setSlaveHighlightState(false);
            return;
         }
         this.setSlaveHighlightState(true);
      }
      
      private function onUpdateFightersLook() : void
      {
         this.setSlaveLook();
      }
      
      private function onUpdatePreFightersList(entityId:Number = 0) : void
      {
         if(entityId !== this._slaveId)
         {
            return;
         }
         this.setSlaveLook();
      }
      
      private function onTurnStart(fighterId:Number, turnTime:uint, remainTime:uint, isPicture:Boolean) : void
      {
         this.refreshSpells();
      }
      
      private function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void
      {
         switch(eventName)
         {
            case FightEventEnum.FIGHTER_CASTED_SPELL:
               if(params[0] !== this._slaveId)
               {
                  return;
               }
               this.refreshSpells();
               break;
            case FightEventEnum.FIGHTER_CHANGE_LOOK:
               this.setSlaveLook();
         }
      }
   }
}

import flash.utils.Dictionary;

class SpellIdRankMap
{
   
   private static const DEFAULT_GRADE:uint = 1;
    
   
   private var _map:Dictionary;
   
   function SpellIdRankMap()
   {
      this._map = new Dictionary();
      super();
   }
   
   public function setRank(spellId:uint, spellRank:uint) : void
   {
      this._map[spellId] = spellRank;
   }
   
   public function getRank(spellId:uint) : uint
   {
      if(!(spellId in this._map))
      {
         return DEFAULT_GRADE;
      }
      return this._map[spellId];
   }
   
   public function removeRank(spellId:uint) : void
   {
      delete this._map[spellId];
   }
   
   public function reset() : void
   {
      this._map = new Dictionary();
   }
}
