package Ankama_GameUiCore.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import Ankama_GameUiCore.ui.enums.KISPopupTypeEnum;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDate;
   import com.ankamagames.dofus.datacenter.items.IncarnationLevel;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenAction;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenWithoutUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.GameContextQuitAction;
   import com.ankamagames.dofus.logic.game.common.actions.ToggleShowUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowMountsInFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleHelpWantedAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleWitnessForbiddenAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.HighlightInteractiveElementsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowFightPositionsAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.CharacterBasicMinimalInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import damageCalculation.tools.StatIds;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class Banner extends ContextAwareUi
   {
      
      private static var LOCKET_ARTWORK:uint = 0;
      
      private static var LOCKET_SPRITE:uint = 1;
      
      private static var LOCKET_CLOCK:uint = 3;
      
      private static var HP_1_LINE_DISPLAY:uint = 0;
      
      private static var HP_2_LINES_DISPLAY:uint = 1;
      
      private static var HP_PERCENT_DISPLAY:uint = 2;
      
      private static var XP_GAUGE:uint = 0;
      
      private static var GUILD_GAUGE:uint = 1;
      
      private static var MOUNT_GAUGE:uint = 2;
      
      private static var INCARNATION_GAUGE:uint = 3;
      
      private static var HONOUR_GAUGE:uint = 4;
      
      private static var POD_GAUGE:uint = 5;
      
      private static var ENERGY_GAUGE:uint = 6;
      
      private static var JOB_GAUGE:uint = 7;
      
      private static var PROGRESS_BAR_COLORS:Array = [];
      
      private static const NB_GAUGE:uint = 7;
       
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SecurityApi")]
      public var securityApi:SecurityApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="HighlightApi")]
      public var highlightApi:HighlightApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      private var _turnDuration:uint;
      
      private var _turnElapsedTime:uint;
      
      private var _clockStart:uint;
      
      private var _lifepointMode:uint = 0;
      
      private var _currentPdv:uint;
      
      private var _totalPdv:uint;
      
      private var _percentPdv:uint;
      
      private var _roundPercent:uint;
      
      private var _roundLevel:uint;
      
      private var _roundRemainingValue:Number;
      
      private var _roundGaugeType:uint = 0;
      
      private var _bIsReady:Boolean = false;
      
      private var _bIsSpectator:Boolean = false;
      
      private var _bCellPointed:Boolean = false;
      
      private var _nPa:int;
      
      private var _nPm:int;
      
      private var _currentShieldPoints:int;
      
      private var _lookingForMyGuildPlz:Boolean = false;
      
      private var _jobsByIndex:Array;
      
      private var _spectatorCloseLastRequest:uint = 0;
      
      private var _spectatorCloseLastRequestTime:uint = 1500;
      
      private var _arenaFightLeaver:CharacterBasicMinimalInformations;
      
      private var _btn_help_originalX:Number;
      
      private var _btn_help_originalY:Number;
      
      private var _currentTurnEntityId:Number;
      
      private var _timeFxInitialX:int;
      
      private var _shortcutColor:String;
      
      private var _defaultTimeColor:uint;
      
      private var _hurryTimeColor:uint;
      
      private var _readyTxt:String;
      
      private var _skipTurnTxt:String;
      
      private var disableEndTurnTimer:Timer;
      
      public var mainCtr:GraphicContainer;
      
      public var subUiCtr:GraphicContainer;
      
      public var spectatorUiCtr:GraphicContainer;
      
      public var lbl_pa:Label;
      
      public var lbl_pm:Label;
      
      public var lbl_pdv:Label;
      
      public var lbl_pdvTop:Label;
      
      public var lbl_pdvBottom:Label;
      
      public var tx_hp_separator:TextureBitmap;
      
      public var lbl_shield:Label;
      
      public var tx_background:TextureBitmap;
      
      public var tx_tabsBg:TextureBitmap;
      
      public var btn_leave:ButtonContainer;
      
      public var btn_lockFight:ButtonContainer;
      
      public var btn_creatureMode:ButtonContainer;
      
      public var btn_lockParty:ButtonContainer;
      
      public var btn_pointCell:ButtonContainer;
      
      public var btn_requestHelp:ButtonContainer;
      
      public var btn_noSpectator:ButtonContainer;
      
      public var btn_tacticMode:ButtonContainer;
      
      public var btn_spectaTactic:ButtonContainer;
      
      public var btn_spectaCreature:ButtonContainer;
      
      public var btn_spectaPointCell:ButtonContainer;
      
      public var btn_spectaLeave:ButtonContainer;
      
      public var tx_apBg:Texture;
      
      public var tx_mpBg:Texture;
      
      public var tx_hpBg:Texture;
      
      public var tx_hp:Texture;
      
      public var tx_shield:Texture;
      
      public var mask_hp:GraphicContainer;
      
      public var tx_timeFx:Texture;
      
      public var tx_decoration:Texture;
      
      public var pb_xp:ProgressBar;
      
      public var pb_time:ProgressBar;
      
      public var pb_time2:Texture;
      
      public var fightCtr:GraphicContainer;
      
      public var btn_readyOrSkip:ButtonContainer;
      
      public var btn_lbl_btn_readyOrSkip:Label;
      
      public var actionBarCtr:GraphicContainer;
      
      private var _pokemonModeActivated:Boolean = false;
      
      public function Banner()
      {
         this._jobsByIndex = [];
         this.disableEndTurnTimer = new Timer(500,1);
         super();
      }
      
      override public function main(args:Array) : void
      {
         var guild:GuildWrapper = null;
         var value:Number = NaN;
         var floor:Number = NaN;
         var nextFloor:Number = NaN;
         super.main(args);
         this._defaultTimeColor = sysApi.getConfigEntry("colors.progressbar.yellow");
         this._hurryTimeColor = sysApi.getConfigEntry("colors.progressbar.red");
         this.pb_time.barColor = this._defaultTimeColor;
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.xp"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.guildXp"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.mountXp"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.incarnationXp"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.honorPoints"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.pods"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.energy"));
         PROGRESS_BAR_COLORS.push(sysApi.getConfigEntry("colors.progressbar.jobXp"));
         this.mask_hp.width = this.tx_hpBg.width;
         this.tx_hp.mask = this.mask_hp;
         this._timeFxInitialX = this.tx_timeFx.x;
         sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         sysApi.addHook(FightHookList.SlaveStatsList,this.onSlaveStatsList);
         sysApi.addHook(HookList.ShowTacticMode,this.onShowTacticMode);
         sysApi.addHook(FightHookList.DematerializationChanged,this.onDematerializationChanged);
         sysApi.addHook(HookList.FightEvent,this.onFightEvent);
         sysApi.addHook(FightHookList.ArenaFighterLeave,this.onArenaFighterLeave);
         sysApi.addHook(HookList.GameFightTurnEnd,this.onGameFightTurnEnd);
         sysApi.addHook(HookList.GameFightTurnStart,this.onGameFightTurnStart);
         sysApi.addHook(HookList.GameFightPause,this.onGameFightPause);
         sysApi.addHook(FightHookList.ReadyToFight,this.onReadyToFight);
         sysApi.addHook(FightHookList.NotReadyToFight,this.onNotReadyToFight);
         sysApi.addHook(InventoryHookList.InventoryWeight,this.onInventoryWeight);
         sysApi.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         sysApi.addHook(HookList.ShowCell,this.onShowCell);
         sysApi.addHook(HookList.OptionLockFight,this.onOptionLockFight);
         sysApi.addHook(HookList.OptionLockParty,this.onOptionLockParty);
         sysApi.addHook(HookList.OptionHelpWanted,this.onOptionHelpWanted);
         sysApi.addHook(HookList.OptionWitnessForbidden,this.onOptionWitnessForbidden);
         sysApi.addHook(FightHookList.RemindTurn,this.onRemindTurn);
         sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         sysApi.addHook(MountHookList.MountUnSet,this.onMountUnSet);
         sysApi.addHook(CraftHookList.JobsExpUpdated,this.onJobsExpUpdated);
         sysApi.addHook(SocialHookList.GuildInformationsGeneral,this.onGuildInformationsGeneral);
         sysApi.addHook(HookList.PartyLeave,this.onPartyLeave);
         sysApi.addHook(HookList.PartyJoin,this.onPartyJoin);
         sysApi.addHook(HookList.KISInactivityNotification,this.displayKISPopUp);
         sysApi.addHook(HookList.KISMissingEquipementWarning,this.displayKISMissingEquipement);
         sysApi.addHook(HookList.KISPreventAndSanctionPopup,this.displayFlagsAndSanctionsPopup);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("skipTurn",this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_ALL_NAMES,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_ENTITIES_TOOLTIPS,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_MOUNTS_IN_FIGHT,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_TACTIC_MODE,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_CELL,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.HIGHLIGHT_INTERACTIVE_ELEMENTS,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CAPTURE_SCREEN,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CAPTURE_SCREEN_WITHOUT_UI,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_SHOW_UI,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHOW_FIGHT_POSITIONS,this.onShortcut);
         this.uiApi.addComponentHook(this.tx_hpBg,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_hpBg,"onRollOver");
         this.uiApi.addComponentHook(this.tx_hpBg,"onRollOut");
         this.uiApi.addComponentHook(this.tx_apBg,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_apBg,"onRollOver");
         this.uiApi.addComponentHook(this.tx_apBg,"onRollOut");
         this.uiApi.addComponentHook(this.tx_mpBg,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_mpBg,"onRollOver");
         this.uiApi.addComponentHook(this.tx_mpBg,"onRollOut");
         this.uiApi.addComponentHook(this.pb_xp,"onRollOver");
         this.uiApi.addComponentHook(this.pb_xp,"onRollOut");
         this.uiApi.addComponentHook(this.pb_xp,"onRightClick");
         this.uiApi.addComponentHook(this.pb_time,"onRightClick");
         this.uiApi.addComponentHook(this.pb_time2,"onRightClick");
         this.uiApi.addComponentHook(this.btn_readyOrSkip,"onRightClick");
         this.uiApi.addComponentHook(this.btn_tacticMode,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tacticMode,"onRollOut");
         this.uiApi.addComponentHook(this.btn_creatureMode,"onRollOver");
         this.uiApi.addComponentHook(this.btn_creatureMode,"onRollOut");
         this.uiApi.addComponentHook(this.btn_noSpectator,"onRollOver");
         this.uiApi.addComponentHook(this.btn_noSpectator,"onRollOut");
         this.uiApi.addComponentHook(this.btn_pointCell,"onRollOver");
         this.uiApi.addComponentHook(this.btn_pointCell,"onRollOut");
         this.uiApi.addComponentHook(this.btn_leave,"onRollOver");
         this.uiApi.addComponentHook(this.btn_leave,"onRollOut");
         this.uiApi.addComponentHook(this.btn_lockFight,"onRollOver");
         this.uiApi.addComponentHook(this.btn_lockFight,"onRollOut");
         this.uiApi.addComponentHook(this.btn_requestHelp,"onRollOver");
         this.uiApi.addComponentHook(this.btn_requestHelp,"onRollOut");
         this.uiApi.addComponentHook(this.btn_lockParty,"onRollOver");
         this.uiApi.addComponentHook(this.btn_lockParty,"onRollOut");
         this.uiApi.addComponentHook(this.btn_spectaTactic,"onRollOver");
         this.uiApi.addComponentHook(this.btn_spectaTactic,"onRollOut");
         this.uiApi.addComponentHook(this.btn_spectaCreature,"onRollOver");
         this.uiApi.addComponentHook(this.btn_spectaCreature,"onRollOut");
         this.uiApi.addComponentHook(this.btn_spectaPointCell,"onRollOver");
         this.uiApi.addComponentHook(this.btn_spectaPointCell,"onRollOut");
         this.uiApi.addComponentHook(this.btn_spectaLeave,"onRollOver");
         this.uiApi.addComponentHook(this.btn_spectaLeave,"onRollOut");
         StatsManager.getInstance().addListenerToStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.SHIELD,this.onUpdateShieldPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.MOVEMENT_POINTS,this.onUpdateMovementPoints);
         StatsManager.getInstance().addListenerToStat(StatIds.ACTION_POINTS,this.onUpdateActionPoints);
         this._readyTxt = this.uiApi.getText("ui.banner.ready");
         this._skipTurnTxt = this.uiApi.getText("ui.shortcuts.skipTurn");
         this.lbl_pdvBottom.visible = false;
         this.lbl_pdvTop.visible = false;
         var lpModeObject:Object = sysApi.getData("lifepointMode");
         if(lpModeObject)
         {
            this._lifepointMode = lpModeObject.mode;
            this.changeLifepointDisplay(this._lifepointMode);
         }
         var roundGaugeMode:int = sysApi.getData("roundGaugeMode_" + this.playerApi.id());
         this._roundGaugeType = roundGaugeMode;
         if(this._roundGaugeType == GUILD_GAUGE)
         {
            guild = this.socialApi.getGuild();
            if(guild)
            {
               value = guild.experience;
               floor = guild.expLevelFloor;
               nextFloor = guild.expNextLevelFloor;
               this.setXp(value,floor,nextFloor,guild.level);
            }
            else
            {
               this._lookingForMyGuildPlz = true;
               this._roundGaugeType = XP_GAUGE;
            }
         }
         else
         {
            this.onChangeXpGauge(this._roundGaugeType);
         }
         sysApi.sendAction(new QuestListRequestAction([]));
         this.configApi.setConfigProperty("dofus","creaturesFightMode",false);
         this._btn_help_originalX = this.btn_requestHelp.x;
         this._btn_help_originalY = this.btn_requestHelp.y;
         this.uiApi.loadUiInside("actionBar",this.actionBarCtr,"bannerActionBar");
         changeContext(ContextEnum.ROLEPLAY);
      }
      
      public function setHealthPoints(currentPdv:Number, maxPdv:Number) : void
      {
         var currentHeartPos:uint = 0;
         this._percentPdv = int(currentPdv / maxPdv * 100);
         if(currentPdv != this._currentPdv)
         {
            currentHeartPos = this._percentPdv;
            if(currentHeartPos > 100)
            {
               currentHeartPos = 100;
            }
            if(this._currentShieldPoints)
            {
               currentHeartPos += 100;
            }
            this.mask_hp.finalized = false;
            this.mask_hp.height = this.tx_hpBg.height * this._percentPdv / 100;
            this.mask_hp.y = this.tx_hpBg.y + (this.tx_hpBg.height - this.mask_hp.height);
            this.mask_hp.finalize();
         }
         this._currentPdv = currentPdv;
         this._totalPdv = maxPdv;
         switch(this._lifepointMode)
         {
            case HP_1_LINE_DISPLAY:
               this.lbl_pdv.visible = true;
               this.lbl_pdvBottom.visible = false;
               this.lbl_pdvTop.visible = false;
               this.lbl_pdv.text = this._currentPdv.toString();
               this.tx_hp_separator.visible = false;
               break;
            case HP_2_LINES_DISPLAY:
               this.lbl_pdvTop.text = this._currentPdv.toString();
               this.lbl_pdvBottom.text = this._totalPdv.toString();
               this.tx_hp_separator.finalized = false;
               this.tx_hp_separator.width = Math.max(this.lbl_pdvTop.textWidth,this.lbl_pdvBottom.textWidth);
               this.tx_hp_separator.x = this.lbl_pdvBottom.x + (this.lbl_pdvBottom.width - this.tx_hp_separator.width) / 2 + 2;
               this.tx_hp_separator.finalize();
               this.tx_hp_separator.visible = true;
               break;
            case HP_PERCENT_DISPLAY:
               this.lbl_pdv.text = this._percentPdv.toString() + "%";
               this.lbl_pdv.visible = true;
               this.lbl_pdvBottom.visible = false;
               this.lbl_pdvTop.visible = false;
               this.tx_hp_separator.visible = false;
         }
      }
      
      public function setShieldPoints(currentShield:uint) : void
      {
         this._currentShieldPoints = currentShield;
         if(this._currentShieldPoints > 0)
         {
            this.tx_shield.visible = this.lbl_shield.visible = true;
            this.changePdvCssClass("hpshield");
            this.lbl_pdvTop.y = parseInt(this.uiApi.me().getConstant("pdvTopShieldY"));
            this.tx_hp_separator.y = parseInt(this.uiApi.me().getConstant("pdvSeparatorShieldY"));
            this.lbl_pdvBottom.y = parseInt(this.uiApi.me().getConstant("pdvBottomShieldY"));
            this.tx_hp.transform.colorTransform = new ColorTransform(1,1,1,1,-46,75,170);
            this.lbl_shield.text = this._currentShieldPoints.toString();
            if(this._lifepointMode == 0)
            {
               if(this.lbl_pdv.visible)
               {
                  this.lbl_pdv.visible = false;
                  this.lbl_pdvBottom.visible = true;
                  this.lbl_pdvTop.visible = true;
                  this.lbl_pdvTop.text = this._currentPdv.toString();
               }
            }
         }
         else
         {
            this.tx_shield.visible = this.lbl_shield.visible = false;
            this.changePdvCssClass("hp");
            this.lbl_pdvTop.y = parseInt(this.uiApi.me().getConstant("pdvTopY"));
            this.tx_hp_separator.y = parseInt(this.uiApi.me().getConstant("pdvSeparatorY"));
            this.lbl_pdvBottom.y = parseInt(this.uiApi.me().getConstant("pdvBottomY"));
            this.tx_hp.transform.colorTransform = new ColorTransform();
            if(this._lifepointMode == 0 && !this.lbl_pdv.visible)
            {
               this.lbl_pdv.visible = true;
               this.lbl_pdvBottom.visible = false;
               this.lbl_pdvTop.visible = false;
               this.lbl_pdv.text = this._currentPdv.toString();
            }
         }
      }
      
      private function changePdvCssClass(cssClass:String) : void
      {
         this.lbl_pdvTop.cssClass = cssClass;
         this.lbl_pdvTop.text = this._currentPdv.toString();
         this.lbl_pdvBottom.cssClass = cssClass;
         this.lbl_pdvBottom.text = this._totalPdv.toString();
         this.tx_hp_separator.width = Math.max(this.lbl_pdvTop.textWidth,this.lbl_pdvBottom.textWidth);
         this.tx_hp_separator.x = this.lbl_pdvBottom.x + (this.lbl_pdvBottom.width - this.tx_hp_separator.width) / 2 + 2;
      }
      
      public function setActionPoints(currentPA:int) : void
      {
         if(this.lbl_pa.text == "")
         {
            this.lbl_pa.text = String(this._nPa);
         }
         if(this._nPa != currentPA)
         {
            this._nPa = currentPA;
            this.lbl_pa.text = String(currentPA);
         }
      }
      
      public function setMovementPoints(currentPM:int) : void
      {
         if(this.lbl_pm.text == "")
         {
            this.lbl_pm.text = String(this._nPm);
         }
         if(this._nPm != currentPM)
         {
            this._nPm = currentPM;
            this.lbl_pm.text = String(currentPM);
         }
      }
      
      public function setTimeFromPercent(currentPercentTime:Number) : void
      {
         var currentTimePos:Number = Math.max(Math.min(currentPercentTime,100),1);
         var currentTimePercent:Number = currentTimePos / 100;
         this.pb_time.value = 1 - currentTimePercent;
         this.tx_timeFx.alpha = currentTimePercent == 1 ? Number(0) : Number(1);
         this.tx_timeFx.x = this._timeFxInitialX + this.pb_time.width * (1 - currentTimePercent);
         if(currentTimePercent < 0.75)
         {
            this.pb_time.barColor = this._defaultTimeColor;
         }
         else
         {
            this.pb_time.barColor = this._hurryTimeColor;
         }
         if(this.pb_time2.visible)
         {
            this.pb_time2.gotoAndStop = int(currentTimePercent * 100);
            if(currentTimePercent >= 0.75 && this.pb_time2.colorTransform.greenMultiplier == 1)
            {
               this.pb_time2.colorTransform = new ColorTransform(1,0.4,0.4);
            }
            else if(currentTimePercent < 0.75 && this.pb_time2.colorTransform.greenMultiplier != 1)
            {
               this.pb_time2.colorTransform = new ColorTransform();
            }
         }
      }
      
      public function setXp(currentXp:Number, seuilInfXp:Number, seuilSupXp:Number, level:int = 0, bonusCeilXp:Number = 0) : void
      {
         var percentBonus:Number = NaN;
         var percentLvl:Number = (currentXp - seuilInfXp) / (seuilSupXp - seuilInfXp) * 100;
         var gauge:uint = this._roundGaugeType;
         if(gauge > NB_GAUGE)
         {
            gauge = NB_GAUGE;
         }
         var color:* = PROGRESS_BAR_COLORS[gauge];
         if(this._roundGaugeType == XP_GAUGE && level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            color = sysApi.getConfigEntry("colors.progressbar.gold");
         }
         if(this._roundGaugeType == XP_GAUGE && bonusCeilXp > currentXp)
         {
            if(bonusCeilXp > seuilSupXp)
            {
               this.pb_xp.innerValue = 1;
            }
            else
            {
               percentBonus = (bonusCeilXp - seuilInfXp) / (seuilSupXp - seuilInfXp);
               this.pb_xp.innerValue = percentBonus;
            }
            this.pb_xp.innerBarColor = color;
            this.pb_xp.innerBarAlpha = 0.3;
         }
         else
         {
            this.pb_xp.innerValue = 0;
         }
         this.pb_xp.value = percentLvl / 100;
         this.pb_xp.barColor = color;
         this._roundPercent = Math.floor(percentLvl);
         this._roundLevel = level;
         if(this._roundGaugeType == GUILD_GAUGE && level == ProtocolConstantsEnum.MAX_GUILD_LEVEL || this._roundGaugeType == MOUNT_GAUGE && level == ProtocolConstantsEnum.MAX_MOUNT_LEVEL || this._roundGaugeType == INCARNATION_GAUGE && this._roundRemainingValue == 0 || this._roundGaugeType == HONOUR_GAUGE && level == ProtocolConstantsEnum.MAX_HONOR || this._roundGaugeType == JOB_GAUGE && level == ProtocolConstantsEnum.MAX_JOB_LEVEL)
         {
            this._roundRemainingValue = 0;
         }
         else
         {
            this._roundRemainingValue = seuilSupXp - currentXp;
         }
      }
      
      public function get tacticModeActivated() : Boolean
      {
         if(PlayerManager.getInstance().kisServerPort > 0)
         {
            return sysApi.getSetData("tacticModeActivated_" + PlayedCharacterManager.getInstance().currentMap.mapId,false);
         }
         return sysApi.getSetData("tacticModeActivated",false);
      }
      
      public function set tacticModeActivated(pActivated:Boolean) : void
      {
         if(PlayerManager.getInstance().kisServerPort > 0)
         {
            sysApi.setData("tacticModeActivated_" + PlayedCharacterManager.getInstance().currentMap.mapId,pActivated);
         }
         else
         {
            sysApi.setData("tacticModeActivated",pActivated);
         }
      }
      
      private function onUpdateHealthPoints(stat:Stat) : void
      {
         var entityStats:EntityStats = null;
         if(this.isUpdatedStatDisplayed(stat))
         {
            entityStats = StatsManager.getInstance().getStats(stat.entityId);
            this.setHealthPoints(entityStats.getHealthPoints(),entityStats.getMaxHealthPoints());
         }
      }
      
      private function onUpdateShieldPoints(stat:Stat) : void
      {
         if(this.isUpdatedStatDisplayed(stat))
         {
            this.setShieldPoints(stat.totalValue);
         }
      }
      
      private function onUpdateMovementPoints(stat:Stat) : void
      {
         if(this.isUpdatedStatDisplayed(stat))
         {
            this.setMovementPoints(stat.totalValue);
         }
      }
      
      private function onUpdateActionPoints(stat:Stat) : void
      {
         if(this.isUpdatedStatDisplayed(stat))
         {
            this.setActionPoints(stat.totalValue);
         }
      }
      
      private function isUpdatedStatDisplayed(stat:Stat) : Boolean
      {
         return stat !== null && this.getPlayerId() === stat.entityId;
      }
      
      override protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         var tacticModeActive:Boolean = false;
         if(previousContext == ContextEnum.SPECTATOR)
         {
            this._bIsSpectator = false;
            this.onCharacterStatsList();
         }
         this.setTimeFromPercent(100);
         this._turnElapsedTime = 0;
         switch(context)
         {
            case ContextEnum.SPECTATOR:
               this.btn_lockParty.visible = false;
               this.btn_lockFight.visible = false;
               this.btn_requestHelp.visible = false;
               this.tx_tabsBg.visible = true;
               this.btn_creatureMode.visible = true;
               this.btn_noSpectator.visible = false;
               this.btn_pointCell.visible = true;
               this.btn_leave.visible = true;
               this.btn_tacticMode.visible = true;
               this.btn_spectaTactic.visible = true;
               this.btn_spectaCreature.visible = true;
               this.btn_spectaPointCell.visible = true;
               this.btn_spectaLeave.visible = true;
               this.tx_decoration.visible = false;
               this.btn_leave.disabled = false;
               this.btn_creatureMode.selected = this._pokemonModeActivated;
               this.setupFightUiComponents();
               break;
            case ContextEnum.PREFIGHT:
               if(this.partyApi.getPartyMembers().length > 0 && !this.partyApi.isArenaRegistered())
               {
                  this.btn_lockParty.visible = true;
               }
               else
               {
                  this.btn_lockParty.visible = false;
               }
               this.btn_lockFight.visible = true;
               this.btn_requestHelp.visible = true;
               this.tx_tabsBg.visible = true;
               this.btn_creatureMode.visible = true;
               this.btn_noSpectator.visible = true;
               this.btn_pointCell.visible = true;
               this.btn_tacticMode.visible = true;
               this.btn_leave.visible = true;
               this.btn_spectaTactic.visible = false;
               this.btn_spectaCreature.visible = false;
               this.btn_spectaPointCell.visible = false;
               this.btn_spectaLeave.visible = false;
               this.tx_decoration.visible = true;
               this.btn_leave.disabled = false;
               if(this.fightApi.isWaitingBeforeFight())
               {
                  this.btn_readyOrSkip.disabled = true;
               }
               this.btn_readyOrSkip.selected = false;
               this.btn_readyOrSkip.soundId = SoundEnum.READY_TO_FIGHT;
               this.btn_lbl_btn_readyOrSkip.cssClass = "condensed";
               this.btn_lbl_btn_readyOrSkip.text = this._readyTxt;
               this.btn_lockParty.selected = false;
               this.btn_lockFight.selected = false;
               this.btn_requestHelp.selected = false;
               this.btn_creatureMode.selected = this._pokemonModeActivated;
               this.btn_noSpectator.selected = false;
               this.btn_pointCell.selected = false;
               this._bIsReady = false;
               this.setupFightUiComponents();
               break;
            case ContextEnum.FIGHT:
               this.btn_lockParty.visible = false;
               this.btn_lockFight.visible = false;
               this.btn_requestHelp.visible = false;
               this.tx_tabsBg.visible = false;
               this.btn_creatureMode.visible = true;
               this.btn_noSpectator.visible = true;
               this.btn_pointCell.visible = true;
               this.btn_tacticMode.visible = true;
               this.btn_leave.visible = true;
               this.btn_spectaTactic.visible = false;
               this.btn_spectaCreature.visible = false;
               this.btn_spectaPointCell.visible = false;
               this.btn_spectaLeave.visible = false;
               this.tx_decoration.visible = true;
               this.btn_leave.disabled = false;
               this.btn_readyOrSkip.selected = false;
               this.btn_readyOrSkip.disabled = true;
               this.btn_readyOrSkip.soundId = SoundEnum.END_TURN;
               this.btn_lbl_btn_readyOrSkip.cssClass = "condensed";
               this.btn_lbl_btn_readyOrSkip.text = this._skipTurnTxt;
               this.setupFightUiComponents();
               break;
            case ContextEnum.ROLEPLAY:
               this.resetTimeButton();
               this.setShieldPoints(0);
               this.setupRoleplayUiComponents();
         }
         if(context != ContextEnum.ROLEPLAY)
         {
            tacticModeActive = this.tacticModeActivated;
            if(tacticModeActive)
            {
               sysApi.sendAction(new ShowTacticModeAction([true]));
            }
            this.updateBtnTactic(tacticModeActive);
         }
      }
      
      private function setupFightUiComponents() : void
      {
         var currentBuild:uint = sysApi.getBuildType();
         var useBetaTurnTime:Boolean = sysApi.getSetData("betaTurnTime2",currentBuild == BuildTypeEnum.BETA,DataStoreEnum.BIND_COMPUTER);
         useBetaTurnTime = false;
         this.pb_time.visible = !useBetaTurnTime;
         this.tx_timeFx.visible = this.pb_time.visible;
         this.pb_time2.visible = useBetaTurnTime;
         this.pb_xp.visible = false;
         if(this.btn_spectaLeave.visible)
         {
            this.tx_tabsBg.width = this.uiApi.me().getConstant("spectatorTabsBgWidth");
         }
         else if(this.btn_lockParty.visible)
         {
            this.tx_tabsBg.width = this.uiApi.me().getConstant("partyTabsBgWidth");
         }
         else
         {
            this.tx_tabsBg.width = this.uiApi.me().getConstant("noPartyTabsBgWidth");
         }
         this.fightCtr.visible = true;
         this.tx_background.width = this.uiApi.me().getConstant("fightBackgroundWidth");
         this.uiApi.me().render();
         var bannerMapUi:* = this.uiApi.getUi("bannerMap");
         if(bannerMapUi)
         {
            bannerMapUi.visible = false;
         }
      }
      
      private function setupRoleplayUiComponents() : void
      {
         this.pb_time.visible = false;
         this.tx_timeFx.visible = false;
         this.pb_xp.visible = true;
         this.fightCtr.visible = false;
         this.tx_decoration.visible = true;
         this.tx_background.width = this.uiApi.me().getConstant("rpBackgroundWidth");
         this.uiApi.me().render();
         var bannerMapUi:* = this.uiApi.getUi("bannerMap");
         if(bannerMapUi && sysApi.getOption("showMiniMap","dofus"))
         {
            bannerMapUi.visible = true;
         }
      }
      
      private function changeLifepointDisplay(mode:int) : void
      {
         if(mode != this._lifepointMode)
         {
            sysApi.setData("lifepointMode",{"mode":mode});
            this._lifepointMode = mode;
         }
         switch(this._lifepointMode)
         {
            case 0:
            case 3:
               this._lifepointMode = 0;
               this.lbl_pdv.visible = true;
               this.lbl_pdvBottom.visible = false;
               this.lbl_pdvTop.visible = false;
               break;
            case 1:
            case 2:
               this.lbl_pdv.visible = false;
               this.lbl_pdvBottom.visible = true;
               this.lbl_pdvTop.visible = true;
         }
         this.setHealthPoints(this._currentPdv,this._totalPdv);
      }
      
      private function resetTimeButton() : void
      {
         this.setTimeFromPercent(100);
         if(this.btn_lbl_btn_readyOrSkip.cssClass == "big")
         {
            this.btn_lbl_btn_readyOrSkip.cssClass = "condensed";
         }
         if(this.btn_lbl_btn_readyOrSkip.text.length == 1)
         {
            this.btn_lbl_btn_readyOrSkip.text = this._skipTurnTxt;
         }
         sysApi.removeEventListener(this.onEnterFrame);
      }
      
      private function onMountSet() : void
      {
         var mount:MountData = this.playerApi.getMount();
         if(this._roundGaugeType == MOUNT_GAUGE && mount)
         {
            this.setXp(mount.experience,mount.experienceForLevel,mount.experienceForNextLevel,mount.level);
         }
      }
      
      private function onMountUnSet() : void
      {
         if(this._roundGaugeType == MOUNT_GAUGE && !this.playerApi.getMount())
         {
            this.onChangeXpGauge(0);
         }
      }
      
      private function onJobsExpUpdated(jobId:uint) : void
      {
         var i:int = 0;
         var jobs:Array = null;
         var job:KnownJobWrapper = null;
         var jobInfo:KnownJobWrapper = null;
         var alreadyKnown:Boolean = false;
         var job2:KnownJobWrapper = null;
         var currentIndex:int = 0;
         var value:int = 0;
         var floor:int = 0;
         var nextFloor:int = 0;
         if(jobId == 0)
         {
            i = 0;
            jobs = this.jobsApi.getKnownJobs();
            for each(job in jobs)
            {
               if(job.jobXP > 0)
               {
                  this._jobsByIndex[i] = job;
                  i++;
               }
            }
         }
         else
         {
            jobInfo = this.jobsApi.getKnownJob(jobId);
            alreadyKnown = false;
            for each(job2 in this._jobsByIndex)
            {
               if(job2.id == jobId)
               {
                  job2 = jobInfo;
                  alreadyKnown = true;
               }
            }
            if(!alreadyKnown)
            {
               this._jobsByIndex[this._jobsByIndex.length] = jobInfo;
            }
         }
         if(this._roundGaugeType >= JOB_GAUGE)
         {
            currentIndex = this._roundGaugeType - JOB_GAUGE;
            if(!this._jobsByIndex[currentIndex])
            {
               return;
            }
            if(jobId != 0 && this._jobsByIndex[currentIndex].id != jobId)
            {
               return;
            }
            if(this._jobsByIndex[currentIndex].jobLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
            {
               value = 1;
               floor = 0;
               nextFloor = 1;
            }
            else
            {
               value = this._jobsByIndex[currentIndex].jobXP;
               floor = this._jobsByIndex[currentIndex].jobXpLevelFloor;
               nextFloor = this._jobsByIndex[currentIndex].jobXpNextLevelFloor;
            }
            this.setXp(value,floor,nextFloor,this._jobsByIndex[currentIndex].jobLevel);
         }
      }
      
      private function onGuildInformationsGeneral(expLevelFloor:Number, experience:Number, expNextLevelFloor:Number, level:uint, creationDate:uint, warning:Boolean, nbConnectedMembers:int, nbMembers:int) : void
      {
         var value:Number = NaN;
         var floor:Number = NaN;
         var nextFloor:Number = NaN;
         if(this._lookingForMyGuildPlz)
         {
            this._roundGaugeType = GUILD_GAUGE;
            this._lookingForMyGuildPlz = false;
         }
         if(this._roundGaugeType == GUILD_GAUGE)
         {
            value = experience;
            floor = expLevelFloor;
            nextFloor = expNextLevelFloor;
            this.setXp(value,floor,nextFloor,level);
         }
      }
      
      public function onSlaveStatsList(charac:Object) : void
      {
         this.onCharacterStatsList(false,charac);
         var summonedEntityStats:EntityStats = StatsManager.getInstance().getStats(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(summonedEntityStats !== null)
         {
            this.setHealthPoints(summonedEntityStats.getHealthPoints(),summonedEntityStats.getMaxHealthPoints());
            this.setShieldPoints(summonedEntityStats.getStatTotalValue(StatIds.SHIELD));
            this.setMovementPoints(summonedEntityStats.getStatTotalValue(StatIds.MOVEMENT_POINTS));
            this.setActionPoints(summonedEntityStats.getStatTotalValue(StatIds.ACTION_POINTS));
         }
      }
      
      public function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false, charac:Object = null) : void
      {
         var entityId:Number = NaN;
         var mount:MountData = null;
         if(this._bIsSpectator)
         {
            return;
         }
         if(!charac)
         {
            charac = this.playerApi.characteristics();
         }
         if(!this.fightApi.preFightIsActive() && this.playerApi.isInFight())
         {
            entityId = this.fightApi.getCurrentPlayedFighterId();
         }
         else
         {
            entityId = this.playerApi.id();
         }
         var stats:EntityStats = StatsManager.getInstance().getStats(entityId);
         switch(this._roundGaugeType)
         {
            case XP_GAUGE:
               if(!this.configApi.isFeatureWithKeywordEnabled("character.xp"))
               {
                  this.setXp(this.playerApi.getPlayedCharacterInfo().level,0,ProtocolConstantsEnum.MAX_LEVEL,this.playerApi.getPlayedCharacterInfo().level);
               }
               else if(charac !== null)
               {
                  this.setXp(charac.experience,charac.experienceLevelFloor,charac.experienceNextLevelFloor,this.playerApi.getPlayedCharacterInfo().level,charac.experienceBonusLimit);
               }
               break;
            case ENERGY_GAUGE:
               if(stats !== null)
               {
                  this.setXp(stats.getStatTotalValue(StatIds.ENERGY_POINTS),0,stats.getStatTotalValue(StatIds.MAX_ENERGY_POINTS));
               }
               break;
            case HONOUR_GAUGE:
               if(charac !== null && charac.alignmentInfos && charac.alignmentInfos.alignmentSide > 0)
               {
                  this.setXp(charac.alignmentInfos.honor,charac.alignmentInfos.honorGradeFloor,charac.alignmentInfos.honorNextGradeFloor,charac.alignmentInfos.alignmentGrade);
               }
               else
               {
                  this.onChangeXpGauge(0);
               }
               break;
            case POD_GAUGE:
               this.setXp(this.playerApi.inventoryWeight() + this.playerApi.shopWeight(),0,this.playerApi.inventoryWeightMax());
               break;
            case MOUNT_GAUGE:
               mount = this.playerApi.getMount();
               if(mount)
               {
                  this.setXp(mount.experience,mount.experienceForLevel,mount.experienceForNextLevel,mount.level);
               }
         }
      }
      
      public function onInventoryWeight(inventoryWeight:uint, shopWeight:uint, maxWeight:uint) : void
      {
         if(this._roundGaugeType == POD_GAUGE)
         {
            this.setXp(inventoryWeight + shopWeight,0,maxWeight);
         }
      }
      
      public function onObjectModified(item:Object) : void
      {
         var effectIncarnation:EffectInstanceDate = null;
         var level:int = 0;
         var floor:int = 0;
         var nextFloor:int = 0;
         var effect:EffectInstance = null;
         var value:int = 0;
         var incLevel:IncarnationLevel = null;
         var incLevelPlusOne:IncarnationLevel = null;
         if(item.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON && this._roundGaugeType == INCARNATION_GAUGE)
         {
            level = 1;
            floor = 0;
            nextFloor = 0;
            for each(effect in this.playerApi.getWeapon().effects)
            {
               if(effect.effectId == ActionIds.ACTION_INCARNATION)
               {
                  effectIncarnation = effect as EffectInstanceDate;
               }
            }
            value = int(effectIncarnation.parameter3);
            do
            {
               incLevel = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0),level);
               if(incLevel)
               {
                  floor = incLevel.requiredXp;
               }
               level++;
               incLevelPlusOne = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0),level);
               if(incLevelPlusOne)
               {
                  nextFloor = incLevelPlusOne.requiredXp;
               }
            }
            while(nextFloor < value && incLevelPlusOne);
            
            this._roundRemainingValue = 1;
            if(!incLevelPlusOne)
            {
               if(value >= nextFloor)
               {
                  this._roundRemainingValue = 0;
               }
               nextFloor = value;
            }
            this.setXp(value,floor,nextFloor,level - 1);
         }
      }
      
      public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int) : void
      {
         if(!pItemWrapper && oldPosition == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON && this._roundGaugeType == INCARNATION_GAUGE)
         {
            this.onChangeXpGauge(0);
         }
      }
      
      public function onGameFightTurnStart(id:Number, waitTime:int, remainingTime:uint, picture:Boolean) : void
      {
         var stats:EntityStats = null;
         this._currentTurnEntityId = id;
         var isPlayer:* = id == this.fightApi.getCurrentPlayedFighterId();
         if(isPlayer || this._bIsSpectator)
         {
            this._clockStart = getTimer();
            this._turnDuration = waitTime;
            this._turnElapsedTime = waitTime - remainingTime;
            sysApi.addEventListener(this.onEnterFrame,"FightBannerA");
            if(this.btn_readyOrSkip.disabled == false && sysApi.getOption("delaySkipTurn","dofus"))
            {
               this.btn_readyOrSkip.disabled = true;
               this.disableEndTurnTimer.addEventListener(TimerEvent.TIMER,this.enableEndTurn);
               this.disableEndTurnTimer.start();
            }
            else
            {
               this.btn_readyOrSkip.disabled = false;
            }
         }
         if(this._bIsSpectator)
         {
            stats = StatsManager.getInstance().getStats(id);
            if(stats !== null)
            {
               this.setShieldPoints(stats.getStatTotalValue(StatIds.SHIELD));
               this.setHealthPoints(stats.getHealthPoints(),stats.getMaxHealthPoints());
               this.setActionPoints(stats.getStatTotalValue(StatIds.ACTION_POINTS));
               this.setMovementPoints(stats.getStatTotalValue(StatIds.MOVEMENT_POINTS));
            }
            this.btn_readyOrSkip.disabled = false;
         }
         else if(!isPlayer)
         {
            this.resetTimeButton();
            this.btn_readyOrSkip.disabled = true;
         }
      }
      
      public function onGameFightTurnEnd(id:Number) : void
      {
         if(id == this._currentTurnEntityId)
         {
            this.resetTimeButton();
         }
      }
      
      public function onGameFightPause(paused:Boolean) : void
      {
         if(paused)
         {
            sysApi.removeEventListener(this.onEnterFrame);
         }
      }
      
      override public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean) : void
      {
         var txt:TextTooltipInfo = null;
         super.onGameFightJoin(canBeCancelled,canSayReady,isSpectator,timeMaxBeforeFightStart,fightType,alliesPreparation);
         this._bIsSpectator = isSpectator;
         this.btn_readyOrSkip.disabled = false;
         if(!this._bIsSpectator)
         {
            if(timeMaxBeforeFightStart)
            {
               if(!alliesPreparation)
               {
                  txt = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.fight.otherTeamPreparation"));
                  this.uiApi.showTooltip(txt,this.pb_time,true,"standard",7,1,3,null,null,null,"TextInfo");
               }
               this._turnDuration = timeMaxBeforeFightStart == -1 ? uint(0) : uint(timeMaxBeforeFightStart);
               this._clockStart = getTimer();
               sysApi.addEventListener(this.onEnterFrame,"FightBannerB");
            }
         }
      }
      
      private function onReadyToFight() : void
      {
         this.onRelease(this.btn_readyOrSkip);
      }
      
      private function onNotReadyToFight() : void
      {
         this._bIsReady = this.btn_readyOrSkip.selected = false;
      }
      
      override public function onGameFightStart() : void
      {
         super.onGameFightStart();
         this.resetTimeButton();
         this._arenaFightLeaver = null;
      }
      
      public function onArenaFighterLeave(leaver:CharacterBasicMinimalInformations) : void
      {
         this._arenaFightLeaver = leaver;
      }
      
      public function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void
      {
         var spectatorModeCurrentPlayer:Boolean = false;
         var targetId:Number = NaN;
         var characteristics:FighterInformations = null;
         var stats:EntityStats = null;
         var life:int = 0;
         var maxLife:int = 0;
         var currentPlayerStats:EntityStats = null;
         if(targetList == null || targetList == [] || targetList.length == 0)
         {
            targetList = [];
            if(params.length)
            {
               targetList[0] = params[0];
            }
         }
         var num:int = targetList.length;
         for(var i:int = 0; i < num; i++)
         {
            targetId = targetList[i];
            if(targetId == 0)
            {
               sysApi.log(4,"Pas de traitement du fight Event " + eventName + " : aucune cible définie");
               return;
            }
            characteristics = this.fightApi.getFighterInformations(targetId);
            stats = StatsManager.getInstance().getStats(targetId);
            if((!characteristics || !stats) && currentContext == ContextEnum.FIGHT)
            {
               sysApi.log(4,"Pas de traitement du fight Event " + eventName + " : le combattant " + targetId + " n\'existe pas.");
               return;
            }
            spectatorModeCurrentPlayer = this._bIsSpectator && targetId == this.fightApi.getPlayingFighterId();
            switch(eventName)
            {
               case FightEventEnum.FIGHTER_LIFE_GAIN:
               case FightEventEnum.FIGHTER_LIFE_LOSS:
               case FightEventEnum.FIGHTER_SUMMONED:
               case FightEventEnum.FIGHTER_PERMANENT_DAMAGE:
                  if(targetId == this.fightApi.getCurrentPlayedFighterId() || spectatorModeCurrentPlayer)
                  {
                     if(currentContext == ContextEnum.FIGHT || spectatorModeCurrentPlayer)
                     {
                        maxLife = stats.getMaxHealthPoints();
                        life = stats.getHealthPoints();
                     }
                     else
                     {
                        currentPlayerStats = StatsManager.getInstance().getStats(this.fightApi.getCurrentPlayedFighterId());
                        maxLife = currentPlayerStats.getMaxHealthPoints();
                        life = currentPlayerStats.getHealthPoints();
                     }
                     this.setHealthPoints(life,maxLife);
                  }
                  break;
               case FightEventEnum.FIGHTER_DEATH:
               case FightEventEnum.FIGHTER_LEAVE:
                  if(targetId == this.fightApi.getCurrentPlayedFighterId() || spectatorModeCurrentPlayer)
                  {
                     this.setHealthPoints(0,stats.getMaxHealthPoints());
                  }
                  break;
               case FightEventEnum.FIGHTER_CASTED_SPELL:
                  break;
            }
         }
      }
      
      public function unload() : void
      {
         this.resetTimeButton();
         this.disableEndTurnTimer.removeEventListener(TimerEvent.TIMER,this.enableEndTurn);
         this.disableEndTurnTimer.reset();
         StatsManager.getInstance().removeListenerFromStat(StatIds.CUR_LIFE,this.onUpdateHealthPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.CUR_PERMANENT_DAMAGE,this.onUpdateHealthPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.MAX_LIFE,this.onUpdateHealthPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.LIFE_POINTS,this.onUpdateHealthPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.VITALITY,this.onUpdateHealthPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.SHIELD,this.onUpdateShieldPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.MOVEMENT_POINTS,this.onUpdateMovementPoints);
         StatsManager.getInstance().removeListenerFromStat(StatIds.ACTION_POINTS,this.onUpdateActionPoints);
         this.uiApi.unloadUi("bannerActionBar");
      }
      
      public function onEnterFrame(e:Event) : void
      {
         if(this._turnDuration == 0)
         {
            this.resetTimeButton();
            return;
         }
         var clock:uint = getTimer();
         var percentTime:Number = (clock - this._clockStart + this._turnElapsedTime) / this._turnDuration * 100;
         var remainedTime:Number = (this._turnDuration - (clock - this._clockStart + this._turnElapsedTime)) / 1000;
         this.setTimeFromPercent(percentTime);
         if(remainedTime < 5 && remainedTime >= 0)
         {
            this.btn_lbl_btn_readyOrSkip.cssClass = "big";
            this.btn_lbl_btn_readyOrSkip.text = (Math.floor(remainedTime) + 1).toString();
         }
         if(percentTime >= 100)
         {
            this.resetTimeButton();
         }
      }
      
      private function onShowCell() : void
      {
         this.btn_pointCell.selected = false;
         this._bCellPointed = false;
      }
      
      private function onOptionLockFight(state:Boolean) : void
      {
         this.btn_lockFight.selected = state;
      }
      
      private function onOptionLockParty(state:Boolean) : void
      {
         this.btn_lockParty.selected = state;
      }
      
      private function onOptionHelpWanted(state:Boolean) : void
      {
         this.btn_requestHelp.selected = state;
      }
      
      private function onOptionWitnessForbidden(state:Boolean) : void
      {
         this.btn_noSpectator.selected = state;
      }
      
      private function addContextMenu() : void
      {
         var job:KnownJobWrapper = null;
         var gaugeMenu:Array = null;
         var current:* = false;
         var disabled:Boolean = false;
         var gaugeNames:Array = [this.uiApi.getText("ui.banner.xpCharacter"),this.uiApi.getText("ui.banner.xpGuild"),this.uiApi.getText("ui.banner.xpMount"),this.uiApi.getText("ui.banner.xpIncarnation"),this.uiApi.getText("ui.pvp.honourPoints"),this.uiApi.getText("ui.common.weight"),this.uiApi.getText("ui.common.energyPoints")];
         for each(job in this._jobsByIndex)
         {
            gaugeNames.push(this.uiApi.getText("ui.common.xp") + " " + job.name);
         }
         gaugeMenu = [];
         if(this._roundGaugeType > gaugeNames.length - 1)
         {
            this._roundGaugeType = 0;
         }
         for(var i:int = 0; i < gaugeNames.length; i++)
         {
            current = this._roundGaugeType == i;
            if(i == GUILD_GAUGE && !this.socialApi.hasGuild() || i == MOUNT_GAUGE && this.playerApi.getMount() == null || i == INCARNATION_GAUGE && !this.playerApi.isIncarnation() || i == HONOUR_GAUGE && this.playerApi.characteristics().alignmentInfos.alignmentSide == 0)
            {
               disabled = true;
            }
            else
            {
               disabled = false;
            }
            gaugeMenu.push(this.modContextMenu.createContextMenuItemObject(gaugeNames[i],this.onChangeXpGauge,[i],disabled,null,current,true));
         }
         var menu:ContextMenuData = this.menuApi.create(this.playerApi.getPlayedCharacterInfo().name);
         menu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.banner.customGauge"),null,null,false,gaugeMenu));
         this.modContextMenu.createContextMenu(menu);
      }
      
      private function onChangeXpGauge(param:uint) : void
      {
         var guild:GuildWrapper = null;
         var mount:MountData = null;
         var effectIncarnation:EffectInstanceDate = null;
         var levelInc:int = 0;
         var incLevel:IncarnationLevel = null;
         var incLevelPlusOne:IncarnationLevel = null;
         var jobInfo:KnownJobWrapper = null;
         var effect:EffectInstance = null;
         var value:Number = 0;
         var floor:Number = 0;
         var nextFloor:Number = 0;
         var experienceBonusLimit:Number = 0;
         var level:int = 0;
         var charac:CharacterCharacteristicsInformations = this.playerApi.characteristics();
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         switch(param)
         {
            case XP_GAUGE:
               if(!charac)
               {
                  return;
               }
               value = charac.experience;
               floor = charac.experienceLevelFloor;
               nextFloor = charac.experienceNextLevelFloor;
               level = this.playerApi.getPlayedCharacterInfo().level;
               experienceBonusLimit = charac.experienceBonusLimit;
               break;
            case GUILD_GAUGE:
               guild = this.socialApi.getGuild();
               if(!guild)
               {
                  return;
               }
               value = guild.experience;
               floor = guild.expLevelFloor;
               nextFloor = guild.expNextLevelFloor;
               level = guild.level;
               break;
            case MOUNT_GAUGE:
               mount = this.playerApi.getMount();
               if(!mount)
               {
                  return;
               }
               value = mount.experience;
               floor = mount.experienceForLevel;
               nextFloor = mount.experienceForNextLevel;
               level = mount.level;
               break;
            case INCARNATION_GAUGE:
               levelInc = 1;
               if(!this.playerApi.getWeapon())
               {
                  return;
               }
               for each(effect in this.playerApi.getWeapon().effects)
               {
                  if(effect.effectId == ActionIds.ACTION_INCARNATION)
                  {
                     effectIncarnation = effect as EffectInstanceDate;
                  }
               }
               value = int(effectIncarnation.parameter3);
               do
               {
                  incLevel = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0),levelInc);
                  if(incLevel)
                  {
                     floor = incLevel.requiredXp;
                  }
                  levelInc++;
                  incLevelPlusOne = this.dataApi.getIncarnationLevel(int(effectIncarnation.parameter0),levelInc);
                  if(incLevelPlusOne)
                  {
                     nextFloor = incLevelPlusOne.requiredXp;
                  }
               }
               while(nextFloor < value && incLevelPlusOne);
               
               this._roundRemainingValue = 1;
               if(!incLevelPlusOne)
               {
                  if(value >= nextFloor)
                  {
                     this._roundRemainingValue = 0;
                  }
                  nextFloor = value;
               }
               level = levelInc - 1;
               break;
            case HONOUR_GAUGE:
               if(!charac)
               {
                  return;
               }
               value = charac.alignmentInfos.honor;
               floor = charac.alignmentInfos.honorGradeFloor;
               nextFloor = charac.alignmentInfos.honorNextGradeFloor;
               level = charac.alignmentInfos.alignmentGrade;
               break;
            case POD_GAUGE:
               value = this.playerApi.inventoryWeight() + this.playerApi.shopWeight();
               floor = 0;
               nextFloor = this.playerApi.inventoryWeightMax();
               break;
            case ENERGY_GAUGE:
               if(!this.playerApi.characteristics())
               {
                  break;
               }
               value = stats.getStatTotalValue(StatIds.ENERGY_POINTS);
               floor = 0;
               nextFloor = stats.getStatTotalValue(StatIds.MAX_ENERGY_POINTS);
               break;
            case JOB_GAUGE:
            default:
               jobInfo = this._jobsByIndex[param - JOB_GAUGE];
               if(!jobInfo)
               {
                  return;
               }
               if(jobInfo.jobLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
               {
                  value = 1;
                  floor = 0;
                  nextFloor = 1;
               }
               else
               {
                  value = jobInfo.jobXP;
                  floor = jobInfo.jobXpLevelFloor;
                  nextFloor = jobInfo.jobXpNextLevelFloor;
               }
               level = jobInfo.jobLevel;
               break;
         }
         this._roundGaugeType = param;
         if(this._roundGaugeType != GUILD_GAUGE)
         {
            this._lookingForMyGuildPlz = false;
         }
         sysApi.setData("roundGaugeMode_" + this.playerApi.id(),this._roundGaugeType);
         this.setXp(value,floor,nextFloor,level,experienceBonusLimit);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var lpMode:int = 0;
         var server:Server = null;
         var giveUp:String = null;
         switch(target)
         {
            case this.btn_tacticMode:
            case this.btn_spectaTactic:
               sysApi.sendAction(new ShowTacticModeAction([]));
               break;
            case this.tx_hpBg:
               if(sysApi.isFightContext() && this.uiApi.keyIsDown(Keyboard.ALTERNATE))
               {
                  sysApi.sendAction(new ChatTextOutputAction([this.uiApi.getText("ui.fightAutomsg.lifePoints",this._currentPdv,this._totalPdv),ChatActivableChannelsEnum.CHANNEL_TEAM,null,null]));
               }
               else
               {
                  lpMode = this._lifepointMode + 1;
                  this.changeLifepointDisplay(lpMode);
               }
               break;
            case this.tx_apBg:
               if(sysApi.isFightContext() && this.uiApi.keyIsDown(Keyboard.ALTERNATE))
               {
                  sysApi.sendAction(new ChatTextOutputAction([this.uiApi.getText("ui.fightAutomsg.actionPoints",this._nPa),ChatActivableChannelsEnum.CHANNEL_TEAM,null,null]));
               }
               break;
            case this.tx_mpBg:
               if(sysApi.isFightContext() && this.uiApi.keyIsDown(Keyboard.ALTERNATE))
               {
                  sysApi.sendAction(new ChatTextOutputAction([this.uiApi.getText("ui.fightAutomsg.movementPoints",this._nPm),ChatActivableChannelsEnum.CHANNEL_TEAM,null,null]));
               }
               break;
            case this.btn_readyOrSkip:
               if(currentContext == ContextEnum.PREFIGHT)
               {
                  if(this._bIsReady)
                  {
                     this._bIsReady = false;
                     sysApi.sendAction(new GameFightReadyAction([false]));
                     this.btn_readyOrSkip.selected = false;
                  }
                  else
                  {
                     this._bIsReady = true;
                     sysApi.sendAction(new GameFightReadyAction([true]));
                     this.btn_readyOrSkip.selected = true;
                  }
               }
               else if(currentContext == ContextEnum.FIGHT)
               {
                  sysApi.sendAction(new GameFightTurnFinishAction([]));
               }
               break;
            case this.btn_leave:
            case this.btn_spectaLeave:
               if(!this._bIsSpectator)
               {
                  server = sysApi.getCurrentServer();
                  if(this.configApi.isFeatureWithKeywordEnabled("server.heroic") && this.fightApi.getFightType() != FightTypeEnum.FIGHT_TYPE_CHALLENGE || server.gameTypeId == 4 && (this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_MXvM || this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_PvM))
                  {
                     giveUp = this.uiApi.getText("ui.popup.hardcoreGiveup");
                  }
                  else
                  {
                     giveUp = this.uiApi.getText("ui.popup.giveup");
                  }
                  if(this.fightApi.getFightType() == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
                  {
                     this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.party.arenaLeaveWarning"),[this.uiApi.getText("ui.fight.option.dontGiveUp"),this.uiApi.getText("ui.fight.option.giveUp")],[this.onPopupClose,this.onPopupLeaveFight]);
                     return;
                  }
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),giveUp,[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupLeaveFight,this.onPopupClose],this.onPopupLeaveFight,this.onPopupClose);
               }
               else
               {
                  sysApi.sendAction(new GameContextQuitAction([]));
               }
               break;
            case this.btn_pointCell:
            case this.btn_spectaPointCell:
               if(!this._bCellPointed)
               {
                  this.btn_pointCell.selected = true;
                  this._bCellPointed = true;
               }
               else
               {
                  this.btn_pointCell.selected = false;
                  this._bCellPointed = false;
               }
               sysApi.sendAction(new TogglePointCellAction([]));
               break;
            case this.btn_noSpectator:
               this.toggleSpectatorForbiden();
               break;
            case this.btn_creatureMode:
            case this.btn_spectaCreature:
               this._pokemonModeActivated = !this._pokemonModeActivated;
               this.configApi.setConfigProperty("dofus","creaturesFightMode",this._pokemonModeActivated);
               sysApi.sendAction(new ToggleDematerializationAction([]));
               break;
            case this.btn_requestHelp:
               sysApi.sendAction(new ToggleHelpWantedAction([]));
               break;
            case this.btn_lockFight:
               sysApi.sendAction(new ToggleLockFightAction([]));
               break;
            case this.btn_lockParty:
               sysApi.sendAction(new ToggleLockPartyAction([]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var textKey:String = null;
         var data:Object = null;
         var percentStorage:Number = NaN;
         var levelValueTxt:String = null;
         var jobInfo:KnownJobWrapper = null;
         var unitTxt:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         var shortcutKey:String = null;
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         switch(target)
         {
            case this.tx_apBg:
               tooltipText = this.uiApi.getText("ui.stats.actionPoints");
               break;
            case this.tx_mpBg:
               tooltipText = this.uiApi.getText("ui.stats.movementPoints");
               break;
            case this.btn_readyOrSkip:
               if(currentContext == ContextEnum.PREFIGHT)
               {
                  tooltipText = this.uiApi.getText("ui.fight.ready");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.nextTurn");
               }
               shortcutKey = this.bindsApi.getShortcutBindStr("skipTurn");
               break;
            case this.btn_leave:
            case this.btn_spectaLeave:
               if(!this._bIsSpectator)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.giveUp");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.giveupSpectator");
               }
               break;
            case this.btn_pointCell:
            case this.btn_spectaPointCell:
               tooltipText = this.uiApi.getText("ui.fight.option.flagHelp");
               shortcutKey = this.bindsApi.getShortcutBindStr("showCell");
               break;
            case this.btn_noSpectator:
               if(this.btn_noSpectator.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.unblockSpectator");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.blockSpectator");
               }
               break;
            case this.btn_creatureMode:
            case this.btn_spectaCreature:
               if(this.btn_creatureMode.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.noCreatureMode");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.creatureMode");
               }
               shortcutKey = this.bindsApi.getShortcutBindStr(ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION);
               break;
            case this.btn_requestHelp:
               if(this.btn_requestHelp.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.noHelp");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.help");
               }
               break;
            case this.btn_tacticMode:
            case this.btn_spectaTactic:
               if(this.btn_tacticMode.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.noTacticMode");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.tacticMode");
               }
               shortcutKey = this.bindsApi.getShortcutBindStr(ShortcutHookListEnum.SHOW_TACTIC_MODE);
               break;
            case this.btn_lockFight:
               if(this.btn_lockFight.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.noBlockJoiner");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.blockJoiner");
               }
               break;
            case this.btn_lockParty:
               if(this.btn_lockParty.selected)
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.noBlockJoinerExceptParty");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.fight.option.blockJoinerExceptParty");
               }
               break;
            case this.tx_hpBg:
               tooltipText = this.uiApi.getText("ui.common.lifePoints");
               break;
            case this.pb_xp:
               if(this._roundPercent < 0)
               {
                  this._roundPercent = 0;
               }
               if(this._roundPercent > 100)
               {
                  this._roundPercent = 100;
               }
               tooltipText = "";
               if(this._roundGaugeType == ENERGY_GAUGE)
               {
                  tooltipText = this.uiApi.getText("ui.common.energyPoints") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(stats.getStatTotalValue(StatIds.ENERGY_POINTS),"") + " / " + this.utilApi.kamasToString(stats.getStatTotalValue(StatIds.MAX_ENERGY_POINTS),"");
                  break;
               }
               if(this._roundGaugeType == POD_GAUGE)
               {
                  percentStorage = Math.floor((this.playerApi.inventoryWeight() + this.playerApi.shopWeight()) * 100 / this.playerApi.inventoryWeightMax());
                  tooltipText = this.uiApi.getText("ui.common.player.inventoryWeight",this.utilApi.kamasToString(this.playerApi.inventoryWeight() + this.playerApi.shopWeight(),""),this.utilApi.kamasToString(this.playerApi.inventoryWeightMax(),""),this.utilApi.kamasToString(this.playerApi.inventoryWeight(),""),this.utilApi.kamasToString(this.playerApi.shopWeight(),""),percentStorage > 100 ? 100 : percentStorage);
               }
               if(this._roundGaugeType != POD_GAUGE && this._roundLevel > 0)
               {
                  levelValueTxt = this.uiApi.getText("ui.common.colon") + this._roundLevel;
                  if(!this.configApi.isFeatureWithKeywordEnabled("character.xp"))
                  {
                     levelValueTxt += "/" + ProtocolConstantsEnum.MAX_LEVEL;
                  }
                  if(this._roundGaugeType == HONOUR_GAUGE)
                  {
                     tooltipText += this.uiApi.getText("ui.pvp.rank");
                  }
                  else if(this._roundGaugeType == XP_GAUGE)
                  {
                     if(this._roundLevel > ProtocolConstantsEnum.MAX_LEVEL)
                     {
                        tooltipText += this.uiApi.getText("ui.common.prestige");
                        levelValueTxt = this.uiApi.getText("ui.common.colon") + (this._roundLevel - ProtocolConstantsEnum.MAX_LEVEL);
                     }
                     else
                     {
                        tooltipText += this.uiApi.getText("ui.common.level");
                     }
                  }
                  else if(this._roundGaugeType == GUILD_GAUGE)
                  {
                     tooltipText += this.uiApi.getText("ui.guild.guildLevel");
                  }
                  else if(this._roundGaugeType == MOUNT_GAUGE)
                  {
                     tooltipText += this.uiApi.getText("ui.mount.level");
                  }
                  else if(this._roundGaugeType == INCARNATION_GAUGE)
                  {
                     tooltipText += this.uiApi.getText("ui.banner.incarnationLevel");
                  }
                  else if(this._roundGaugeType >= JOB_GAUGE)
                  {
                     jobInfo = this._jobsByIndex[this._roundGaugeType - JOB_GAUGE];
                     if(!jobInfo)
                     {
                        return;
                     }
                     tooltipText += this.uiApi.getText("ui.craft.jobLevel") + " " + jobInfo.name;
                  }
                  tooltipText += levelValueTxt;
               }
               if(this._roundRemainingValue > 0)
               {
                  if(this._roundGaugeType == POD_GAUGE)
                  {
                     tooltipText += "\n" + this.uiApi.getText("ui.common.remaining") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(this._roundRemainingValue,this.uiApi.getText("ui.common.weight"));
                  }
                  else if(this._roundGaugeType != XP_GAUGE || this.configApi.isFeatureWithKeywordEnabled("character.xp"))
                  {
                     tooltipText += "\n" + this.uiApi.getText("ui.banner.percentDone",this._roundPercent);
                     if(this._roundGaugeType == HONOUR_GAUGE)
                     {
                        unitTxt = this.uiApi.getText("ui.pvp.honourPoints");
                        tooltipText += "\n" + this.uiApi.getText("ui.banner.nextRankIn",this.utilApi.kamasToString(this._roundRemainingValue,unitTxt));
                     }
                     else
                     {
                        unitTxt = this.uiApi.getText("ui.common.xp");
                        tooltipText += "\n" + this.uiApi.getText("ui.banner.nextLevelIn",this.utilApi.kamasToString(this._roundRemainingValue,unitTxt));
                        tooltipText += "\n" + this.uiApi.getText("ui.banner.xpBonus",this.playerApi.getExperienceBonusPercent() + 100);
                     }
                  }
               }
               if(this.configApi.isFeatureWithKeywordEnabled("character.xp") && this._roundGaugeType == XP_GAUGE && this.playerApi.characteristics().experienceBonusLimit > 0 && this.playerApi.characteristics().experience < this.playerApi.characteristics().experienceBonusLimit)
               {
                  tooltipText += "\n<i>" + this.uiApi.getText("ui.help.xpBonus",2) + "</i>";
               }
               if(this.dataApi.getCurrentTemporisSeasonNumber() == 5)
               {
                  tooltipText += "\n" + this.uiApi.getText("ui.temporis.xpInformation");
                  if(this._roundLevel < ProtocolConstantsEnum.MAX_LEVEL)
                  {
                     tooltipText += "\n" + this.uiApi.getText("ui.temporis.xpEcaflipCityInformation");
                  }
               }
               break;
            case this.lbl_shield:
               tooltipText = this.uiApi.getText("ui.common.shieldPoints.value");
         }
         if(shortcutKey)
         {
            if(!this._shortcutColor)
            {
               this._shortcutColor = sysApi.getConfigEntry("colors.shortcut");
               this._shortcutColor = this._shortcutColor.replace("0x","#");
            }
            if(tooltipText)
            {
               data = this.uiApi.textTooltipInfo(tooltipText + " <font color=\'" + this._shortcutColor + "\'>(" + shortcutKey + ")</font>");
            }
            else if(textKey)
            {
               data = this.uiApi.textTooltipInfo(this.uiApi.getText(textKey,"<font color=\'" + this._shortcutColor + "\'>(" + shortcutKey + ")</font>"));
            }
         }
         else if(tooltipText)
         {
            data = this.uiApi.textTooltipInfo(tooltipText);
         }
         if(data)
         {
            this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var menu:Array = null;
         switch(target)
         {
            case this.pb_xp:
               if(!this._bIsSpectator)
               {
                  this.addContextMenu();
               }
               break;
            case this.btn_readyOrSkip:
            case this.pb_time:
            case this.pb_time2:
               if(sysApi.getBuildType() != BuildTypeEnum.RELEASE)
               {
                  menu = [];
                  menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.banner.switchTimeProgressBar"),this.onSwitchTimeProgressBar));
                  this.modContextMenu.createContextMenu(menu);
               }
         }
      }
      
      private function onSwitchTimeProgressBar() : void
      {
         this.pb_time.visible = !this.pb_time.visible;
         this.pb_time2.visible = !this.pb_time2.visible;
         this.tx_timeFx.visible = this.pb_time.visible;
         sysApi.setData("betaTurnTime2",this.pb_time2.visible,DataStoreEnum.BIND_COMPUTER);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var showMounts:Boolean = false;
         var bannerActionBar:* = undefined;
         switch(s)
         {
            case "skipTurn":
            case this.btn_readyOrSkip:
               if(currentContext == ContextEnum.PREFIGHT)
               {
                  if(this._bIsReady)
                  {
                     this._bIsReady = false;
                     sysApi.sendAction(new GameFightReadyAction([false]));
                     this.btn_readyOrSkip.selected = false;
                     return true;
                  }
                  this._bIsReady = true;
                  sysApi.sendAction(new GameFightReadyAction([true]));
                  this.btn_readyOrSkip.selected = true;
                  return true;
               }
               if(!this.btn_readyOrSkip.disabled)
               {
                  sysApi.sendAction(new GameFightTurnFinishAction([]));
               }
               return true;
               break;
            case "validUi":
               sysApi.dispatchHook(ChatHookList.ChatFocus);
               return true;
            case "closeUi":
               if(!this.inventoryApi.removeSelectedItem())
               {
                  if(!this.fightApi.isCastingSpell())
                  {
                     return false;
                  }
                  bannerActionBar = this.uiApi.getUi("bannerActionBar");
                  if(bannerActionBar)
                  {
                     (bannerActionBar.uiClass as ActionBar).unselectSpell();
                  }
               }
               return true;
            case ShortcutHookListEnum.SHOW_CELL:
               if(!this._bCellPointed)
               {
                  this.btn_pointCell.selected = true;
                  this._bCellPointed = true;
               }
               else
               {
                  this.btn_pointCell.selected = false;
                  this._bCellPointed = false;
               }
               sysApi.sendAction(new TogglePointCellAction([]));
               return true;
            case ShortcutHookListEnum.TOGGLE_DEMATERIALIZATION:
               sysApi.sendAction(new ToggleDematerializationAction([]));
               return true;
            case ShortcutHookListEnum.SHOW_ALL_NAMES:
               sysApi.sendAction(new ShowAllNamesAction([]));
               return true;
            case ShortcutHookListEnum.SHOW_ENTITIES_TOOLTIPS:
               sysApi.sendAction(new ShowEntitiesTooltipsAction([]));
               return true;
            case ShortcutHookListEnum.SHOW_MOUNTS_IN_FIGHT:
               showMounts = sysApi.getOption("showMountsInFight","dofus");
               sysApi.sendAction(new ShowMountsInFightAction([!showMounts]));
               return true;
            case ShortcutHookListEnum.SHOW_TACTIC_MODE:
               sysApi.sendAction(new ShowTacticModeAction([]));
               return true;
            case ShortcutHookListEnum.CAPTURE_SCREEN:
               sysApi.sendAction(new CaptureScreenAction([]));
               return true;
            case ShortcutHookListEnum.CAPTURE_SCREEN_WITHOUT_UI:
               sysApi.sendAction(new CaptureScreenWithoutUIAction([]));
               return true;
            case ShortcutHookListEnum.HIGHLIGHT_INTERACTIVE_ELEMENTS:
               sysApi.sendAction(new HighlightInteractiveElementsAction([]));
               return true;
            case ShortcutHookListEnum.SHOW_FIGHT_POSITIONS:
               sysApi.sendAction(new ShowFightPositionsAction([]));
               return true;
            case ShortcutHookListEnum.TOGGLE_SHOW_UI:
               sysApi.sendAction(new ToggleShowUIAction([]));
               return true;
            default:
               return false;
         }
      }
      
      public function onShowTacticMode(state:Boolean) : void
      {
         this.updateBtnTactic(state);
         this.tacticModeActivated = state;
      }
      
      public function updateBtnTactic(state:Boolean) : void
      {
         this.btn_tacticMode.selected = this.btn_spectaTactic.selected = state;
      }
      
      private function onDematerializationChanged(pCreaturesMode:Boolean) : void
      {
         this.btn_creatureMode.selected = this.btn_spectaCreature.selected = pCreaturesMode;
         this._pokemonModeActivated = pCreaturesMode;
         this.configApi.setConfigProperty("dofus","creaturesFightMode",this._pokemonModeActivated);
      }
      
      public function onRemindTurn() : void
      {
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupLeaveFight() : void
      {
         sysApi.sendAction(new GameContextQuitAction([]));
      }
      
      private function toggleSpectatorForbiden() : void
      {
         if(getTimer() - this._spectatorCloseLastRequest < this._spectatorCloseLastRequestTime)
         {
            this.btn_noSpectator.selected = !this.btn_noSpectator.selected;
            return;
         }
         this._spectatorCloseLastRequest = getTimer();
         sysApi.sendAction(new ToggleWitnessForbiddenAction([]));
      }
      
      private function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void
      {
         if(!this.btn_lockParty.visible && id == this.partyApi.getPartyId() && this.playerApi.isInPreFight())
         {
            this.btn_lockParty.visible = true;
         }
      }
      
      private function onPartyLeave(id:int, isArena:Boolean) : void
      {
         if(this.btn_lockParty.visible && id == this.partyApi.getPartyId() && this.playerApi.isInPreFight())
         {
            this.btn_lockParty.visible = false;
         }
      }
      
      public function dragUpdate() : void
      {
         var spectatorPanel:* = this.uiApi.getUi("spectatorPanel");
         if(spectatorPanel && spectatorPanel.uiClass && spectatorPanel.uiClass.entityDisplayer.characterReady)
         {
            spectatorPanel.uiClass.entityDisplayer.updateScaleAndOffsets();
         }
      }
      
      private function getPlayerId() : Number
      {
         var fightBattleFrame:FightBattleFrame = null;
         if(this.playerApi.isInFight())
         {
            if(this._bIsSpectator)
            {
               fightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
               if(fightBattleFrame !== null)
               {
                  return fightBattleFrame.currentPlayerId;
               }
               return 0;
            }
            return this.fightApi.getCurrentPlayedFighterId();
         }
         return this.playerApi.id();
      }
      
      private function formatShortcut(text:String, shortcutKey:String) : String
      {
         if(shortcutKey)
         {
            if(!this._shortcutColor)
            {
               this._shortcutColor = sysApi.getConfigEntry("colors.shortcut");
               this._shortcutColor = this._shortcutColor.replace("0x","#");
            }
            return text + " <font color=\'" + this._shortcutColor + "\'>(" + shortcutKey + ")</font>";
         }
         return text;
      }
      
      private function enableEndTurn(e:TimerEvent) : void
      {
         this.btn_readyOrSkip.disabled = false;
         this.disableEndTurnTimer.removeEventListener(TimerEvent.TIMER,this.enableEndTurn);
         this.disableEndTurnTimer.reset();
      }
      
      private function displayKISPopUp(... args) : void
      {
         if(this.uiApi.getUiByName(UIEnum.KIS_POPUP) !== null)
         {
            this.uiApi.unloadUi(UIEnum.KIS_POPUP);
         }
         this.uiApi.loadUi(UIEnum.KIS_POPUP,UIEnum.KIS_POPUP,[KISPopupTypeEnum.INACTIVITY]);
      }
      
      private function displayKISMissingEquipement(... args) : void
      {
         if(this.uiApi.getUiByName(UIEnum.KIS_POPUP) !== null)
         {
            this.uiApi.unloadUi(UIEnum.KIS_POPUP);
         }
         this.uiApi.loadUi(UIEnum.KIS_POPUP,UIEnum.KIS_POPUP,[KISPopupTypeEnum.MISSING_EQUIPMENT,args[0]]);
      }
      
      private function displayFlagsAndSanctionsPopup(flags:Vector.<String>, sanctions:Vector.<String>, banTime:uint) : void
      {
         var params:Array = null;
         var popupType:String = null;
         if(flags.length)
         {
            if(sanctions.length)
            {
               popupType = UIEnum.KIS_PREVENT_SANCTION_POPUP;
               params = [flags,sanctions,banTime];
            }
            else
            {
               popupType = UIEnum.KIS_INFRACTION_POPUP;
               params = [KISPopupTypeEnum.PREVENT,flags];
            }
         }
         else if(sanctions.length)
         {
            popupType = UIEnum.KIS_INFRACTION_POPUP;
            params = [KISPopupTypeEnum.SANCTION,sanctions,banTime];
         }
         if(this.uiApi.getUiByName(popupType) !== null)
         {
            this.uiApi.unloadUi(popupType);
         }
         this.uiApi.loadUi(popupType,popupType,params);
      }
   }
}
