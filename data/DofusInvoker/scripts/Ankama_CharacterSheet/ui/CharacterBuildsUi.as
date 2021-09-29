package Ankama_CharacterSheet.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.items.PresetIcon;
   import com.ankamagames.dofus.datacenter.optionalFeatures.CustomModeBreedSpell;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellConversion;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.OpenForgettableSpellsUiAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ResetCharacterStatsRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellVariantActivationRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.CharacterPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BoostableCharacteristicEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.SavablePresetTypeEnum;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.presets.CharacterCharacteristicForPreset;
   import com.ankamagames.dofus.network.types.game.presets.SpellForPreset;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import damageCalculation.tools.StatIds;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class CharacterBuildsUi
   {
      
      private static const CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static const CTR_CAT_TYPE_ITEM:String = "ctr_caracAdvancedItem";
      
      private static const MODIFY_STATE:int = 0;
      
      private static const READ_ONLY_STATE:int = 1;
      
      private static const STAT_REGULAR_TAB:int = 0;
      
      private static const STAT_ADVANCED_TAB:int = 1;
      
      private static var ZERO_CENTERED_STATS:Vector.<uint> = new <uint>[StatIds.DEALT_DAMAGE_MULTIPLIER_MELEE,StatIds.DEALT_DAMAGE_MULTIPLIER_DISTANCE,StatIds.DEALT_DAMAGE_MULTIPLIER_WEAPON,StatIds.DEALT_DAMAGE_MULTIPLIER_SPELLS,StatIds.RECEIVED_DAMAGE_MULTIPLIER_MELEE,StatIds.RECEIVED_DAMAGE_MULTIPLIER_DISTANCE,StatIds.RECEIVED_DAMAGE_MULTIPLIER_WEAPON,StatIds.RECEIVED_DAMAGE_MULTIPLIER_SPELLS];
      
      private static var RESIST_PERCENT_STATS:Vector.<uint> = new <uint>[StatIds.EARTH_ELEMENT_RESIST_PERCENT,StatIds.FIRE_ELEMENT_RESIST_PERCENT,StatIds.WATER_ELEMENT_RESIST_PERCENT,StatIds.AIR_ELEMENT_RESIST_PERCENT,StatIds.NEUTRAL_ELEMENT_RESIST_PERCENT];
      
      private static var RECEIVED_DAMAGE_STATS:Vector.<uint> = new <uint>[StatIds.RECEIVED_DAMAGE_MULTIPLIER_MELEE,StatIds.RECEIVED_DAMAGE_MULTIPLIER_DISTANCE,StatIds.RECEIVED_DAMAGE_MULTIPLIER_WEAPON,StatIds.RECEIVED_DAMAGE_MULTIPLIER_SPELLS];
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _componentList:Dictionary;
      
      private var _isUnloading:Boolean = false;
      
      private var _currentUiState:int = -1;
      
      private var _characterLevel:int;
      
      private var _characterCharacteristics:CharacterCharacteristicsInformations;
      
      private var _characterStats:EntityStats;
      
      private var _statCurrentTab:uint = 0;
      
      private var _statsData:Array;
      
      private var _statsCategoriesData:Array;
      
      private var _openedStatCategoryIds:Array;
      
      private var _favStatCategoryIds:Array;
      
      private var _statsUpgradableList:Array;
      
      private var _someStatsMayBeScrolled:Boolean = false;
      
      private var _allUpgradableStatsAreNull:Boolean = true;
      
      private var _textureMinusUri:Uri;
      
      private var _texturePlusUri:Uri;
      
      private var _equipmentSlots:Array;
      
      private var _availableEquipmentPositions:Array;
      
      private var _currentCharacterDirection:int = 2;
      
      private var _characterEquipmentItemsByPos:Array;
      
      private var _equipmentPositionClicked:int = -1;
      
      private var _equippedItemClicked:int = -1;
      
      private var _allSpellDisplayCache:Dictionary;
      
      private var _builds:Array;
      
      private var _currentBuild:BuildWrapper;
      
      private var _currentBuildUsed:BuildWrapper;
      
      private var _waitingBuild:BuildWrapper;
      
      private var _firstFreeIndex:int;
      
      private var _currentBuildHasChanged:Boolean = false;
      
      private var _currentBuildIconId:int;
      
      private var _currentSelectedBuildIconIndex:uint;
      
      private var _currentBuildNameHasChanged:Boolean;
      
      private var _namingRuleBuildName:NamingRule;
      
      private var _delayDoubleClickTimer:BenchmarkTimer;
      
      private var _slotClickedNoDragAllowed:Slot;
      
      private var _popupName:String;
      
      public var wnd_builds:GraphicContainer;
      
      public var tx_mask:Texture;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var ctr_regular:GraphicContainer;
      
      public var lbl_statPoints:Label;
      
      public var lbl_healthPointsValue:Label;
      
      public var lbl_actionPointsValue:Label;
      
      public var lbl_movementPointsValue:Label;
      
      public var gd_carac:Grid;
      
      public var ctr_advanced:GraphicContainer;
      
      public var gd_caracAdvanced:Grid;
      
      public var ctr_pointsToDivide:GraphicContainer;
      
      public var btn_advanced:ButtonContainer;
      
      public var btn_regular:ButtonContainer;
      
      public var btn_reset:ButtonContainer;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lbl_warningCharacter:Label;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var tx_inventoryLight:Texture;
      
      public var slot_0:Slot;
      
      public var slot_1:Slot;
      
      public var slot_2:Slot;
      
      public var slot_3:Slot;
      
      public var slot_4:Slot;
      
      public var slot_5:Slot;
      
      public var slot_6:Slot;
      
      public var slot_7:Slot;
      
      public var slot_8:Slot;
      
      public var slot_9:Slot;
      
      public var slot_10:Slot;
      
      public var slot_11:Slot;
      
      public var slot_12:Slot;
      
      public var slot_13:Slot;
      
      public var slot_14:Slot;
      
      public var slot_15:Slot;
      
      public var slot_28:Slot;
      
      public var slot_30:Slot;
      
      public var gd_spell:Grid;
      
      public var tx_separator:TextureBitmap;
      
      public var gd_builds:Grid;
      
      public var ctr_plusBuild:GraphicContainer;
      
      public var ctr_buildIcons:GraphicContainer;
      
      public var gd_buildIcons:Grid;
      
      public var tx_lockBuild:Texture;
      
      public var tx_unlockBuild:Texture;
      
      public var tx_buildIcon:Texture;
      
      public var ctr_editBuildIcon:GraphicContainer;
      
      public var inp_buildName:Input;
      
      public var btn_equipBuild:ButtonContainer;
      
      public var btn_resetBuild:ButtonContainer;
      
      public var btn_deleteBuild:ButtonContainer;
      
      public var btn_saveBuild:ButtonContainer;
      
      public var btn_lbl_btn_saveBuild:Label;
      
      public var lbl_manageSpellSets:Label;
      
      private var _isForgettableSpellsUi:Boolean = false;
      
      public function CharacterBuildsUi()
      {
         this._componentList = new Dictionary(true);
         this._allSpellDisplayCache = new Dictionary();
         this._builds = [];
         super();
      }
      
      private static function isStatZeroCentered(statId:Number) : Boolean
      {
         return ZERO_CENTERED_STATS.indexOf(statId) !== -1;
      }
      
      private static function isResistPercentStat(statId:Number) : Boolean
      {
         return RESIST_PERCENT_STATS.indexOf(statId) !== -1;
      }
      
      private static function isReceivedDamageStat(statId:Number) : Boolean
      {
         return RECEIVED_DAMAGE_STATS.indexOf(statId) !== -1;
      }
      
      public function main(params:Object) : void
      {
         var shortcutColor:String = null;
         this._isForgettableSpellsUi = this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable");
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(HookList.FightEvent,this.onFightEvent);
         this.sysApi.addHook(HookList.ContextChanged,this.onContextChanged);
         this.sysApi.addHook(HookList.SpellListUpdate,this.onSpellsList);
         this.sysApi.addHook(HookList.CharacterLevelUp,this.onCharacterLevelUp);
         this.sysApi.addHook(InventoryHookList.SpellVariantActivated,this.onSpellVariantActivated);
         this.sysApi.addHook(HookList.PlayedCharacterLookChange,this.updateLook);
         this.sysApi.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         this.sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         this.sysApi.addHook(MountHookList.MountRiding,this.onMountRiding);
         this.sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         this.sysApi.addHook(InventoryHookList.PresetsUpdate,this.onPresetsUpdate);
         this.sysApi.addHook(InventoryHookList.PresetUsed,this.onPresetUsed);
         this.sysApi.addHook(InventoryHookList.PresetSelected,this.onPresetSelected);
         this.sysApi.addHook(InventoryHookList.ShortcutBarViewContent,this.onShortcutBarViewContent);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(InventoryHookList.PresetError,this.onPresetError);
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.uiApi.addComponentHook(this.wnd_builds,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_pointsToDivide,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_pointsToDivide,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_caracAdvanced,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_caracAdvanced,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_builds,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_builds,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_builds,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_buildIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_plusBuild,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_plusBuild,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_plusBuild,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_buildIcons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_deleteBuild,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_deleteBuild,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_resetBuild,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_resetBuild,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_editBuildIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_editBuildIcon,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_editBuildIcon,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_lockBuild,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_lockBuild,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_unlockBuild,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_unlockBuild,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_mask,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_mask,ComponentHookList.ON_ROLL_OUT);
         this.tx_mask.visible = false;
         if(this._isForgettableSpellsUi)
         {
            this.lbl_manageSpellSets.visible = true;
            this.uiApi.addComponentHook(this.lbl_manageSpellSets,ComponentHookList.ON_RELEASE);
         }
         else
         {
            this.lbl_manageSpellSets.visible = false;
         }
         this._characterLevel = this.playerApi.getPlayedCharacterInfo().level;
         this._allSpellDisplayCache = new Dictionary();
         this.ctr_plusBuild.handCursor = true;
         this.tx_buildIcon.handCursor = true;
         var shortcut:String = this.bindsApi.getShortcutBindStr("openBuild");
         if(shortcut != "")
         {
            shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
            shortcutColor = shortcutColor.replace("0x","#");
            this.lbl_title.text = this.uiApi.getText("ui.build.builds") + " <font color=\'" + shortcutColor + "\'>(" + shortcut + ")</font>";
         }
         this.initBuilds();
         this.initEquipementSlot();
         this.initStats();
         this.initEquipment();
         this.onPresetsUpdate();
         if(params.buildId >= 0)
         {
            this.openBuildAtLaunch(params.buildId);
         }
      }
      
      private function openBuildAtLaunch(buildId:int) : void
      {
         var index:int = 0;
         for(index = 0; index < this._builds.length; index++)
         {
            if(this._builds[index] && this._builds[index].id == buildId)
            {
               this.gd_builds.selectedIndex = index;
               this.displayBuild(this._builds[index]);
               break;
            }
         }
      }
      
      public function unload() : void
      {
         if(!this._isUnloading)
         {
            this.sysApi.dispatchHook(CustomUiHookList.SpellMovementAllowed,false);
            this._isUnloading = true;
            if(this._delayDoubleClickTimer)
            {
               this._delayDoubleClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
               this._delayDoubleClickTimer = null;
            }
            this.inventoryApi.setBuildId(-1);
            this.sysApi.dispatchHook(CustomUiHookList.PreviewBuildSpellBar,this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR),false);
            this.uiApi.hideTooltip();
            this.uiApi.unloadUi(this._popupName);
            this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_CLOSE);
            this.uiApi.unloadUi("statBoost");
            this.uiApi.unloadUi("itemsList");
         }
      }
      
      public function updateCaracLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var total:int = 0;
         var statPointName:String = null;
         var statpoints:Array = null;
         var truc:* = undefined;
         var isRoleplayOrPrefight:Boolean = false;
         var i:int = 0;
         if(data)
         {
            if(!this._componentList[componentsRef.btn_plus.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_plus,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_plus,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.btn_plus,ComponentHookList.ON_ROLL_OVER);
            }
            this._componentList[componentsRef.btn_plus.name] = data;
            if(!this._componentList[componentsRef.lbl_nameCarac.name])
            {
               this.uiApi.addComponentHook(componentsRef.lbl_nameCarac,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.lbl_nameCarac,ComponentHookList.ON_ROLL_OVER);
            }
            this._componentList[componentsRef.lbl_nameCarac.name] = data;
            if(!this._componentList[componentsRef.lbl_valueCarac.name])
            {
               this.uiApi.addComponentHook(componentsRef.lbl_valueCarac,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.lbl_valueCarac,ComponentHookList.ON_ROLL_OVER);
            }
            this._componentList[componentsRef.lbl_valueCarac.name] = data;
            if(data.gfxId != "null")
            {
               componentsRef.tx_pictoCarac.visible = true;
               componentsRef.tx_pictoCarac.uri = this.uiApi.createUri(this.uiApi.me().getConstant("characteristics") + data.gfxId + ".png");
            }
            else
            {
               componentsRef.tx_pictoCarac.uri = null;
            }
            componentsRef.tx_gridSeparator.visible = true;
            componentsRef.lbl_nameCarac.text = data.name;
            total = data.base + data.additionnal + data.boost + data.stuff;
            if(total != 0)
            {
               componentsRef.lbl_valueCarac.text = total;
            }
            else
            {
               componentsRef.lbl_valueCarac.text = "-";
            }
            statPointName = data.keyword.substr(0,1).toLocaleUpperCase() + data.keyword.substr(1);
            statpoints = [];
            for each(truc in this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed)["statsPointsFor" + statPointName])
            {
               statpoints.push(truc);
            }
            componentsRef.btn_plus.visible = false;
            isRoleplayOrPrefight = !this.playerApi.isInFight() || this.playerApi.isInPreFight();
            for(i = 0; i < statpoints.length; i++)
            {
               if((statpoints[i + 1] && statpoints[i + 1][0] > data.base && statpoints[i][0] <= data.base || !statpoints[i + 1]) && this._characterStats.getStatBaseValue(StatIds.STATS_POINTS) >= statpoints[i][1] && isRoleplayOrPrefight)
               {
                  componentsRef.btn_plus.visible = true;
               }
               if(data.additionnal < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC && (statpoints[i + 1] && statpoints[i + 1][0] > data.additionnal && statpoints[i][0] <= data.additionnal || !statpoints[i + 1]) && this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS) >= statpoints[i][1] && isRoleplayOrPrefight)
               {
                  componentsRef.btn_plus.visible = true;
               }
            }
            componentsRef.btn_plus.softDisabled = this._currentUiState == READ_ONLY_STATE;
         }
         else
         {
            componentsRef.lbl_valueCarac.text = "";
            componentsRef.lbl_nameCarac.text = "";
            componentsRef.btn_plus.visible = false;
            componentsRef.tx_pictoCarac.visible = false;
            componentsRef.tx_gridSeparator.visible = false;
         }
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var currentBase:Number = NaN;
         var bonusUsed:int = 0;
         var base:int = 0;
         var total:int = 0;
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
               componentsRef.lbl_catName.text = data.name;
               componentsRef.btn_cat.selected = selected;
               if(this._openedStatCategoryIds.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this._textureMinusUri;
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this._texturePlusUri;
               }
               break;
            case CTR_CAT_TYPE_ITEM:
               if(!this._componentList[componentsRef.lbl_name.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lbl_name,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.lbl_name,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.lbl_name.name] = data;
               if(!this._componentList[componentsRef.lbl_value.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lbl_value,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.lbl_value,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.lbl_value.name] = data;
               componentsRef.lbl_name.cssClass = "p";
               if(data.categoryId == -1 && data.numId == -1)
               {
                  componentsRef.lbl_favExplanation.visible = true;
                  componentsRef.lbl_name.visible = false;
                  componentsRef.lbl_value.visible = false;
                  componentsRef.tx_picto.visible = false;
                  break;
               }
               componentsRef.lbl_favExplanation.visible = false;
               componentsRef.lbl_name.visible = true;
               componentsRef.lbl_value.visible = true;
               componentsRef.tx_picto.visible = true;
               if(data.gfxId != "" && data.gfxId != "null")
               {
                  componentsRef.tx_picto.visible = true;
                  componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("characteristics") + data.gfxId + ".png");
               }
               else
               {
                  componentsRef.tx_picto.uri = null;
               }
               componentsRef.lbl_name.text = data.name;
               if(data.keyword == "actionPoints" || data.keyword == "movementPoints")
               {
                  currentBase = this._characterStats.getStatTotalValue(StatIds.getStatIdFromStatName(data.keyword)) - (data.boost + data.stuff);
                  if(currentBase < 0)
                  {
                     bonusUsed = Math.abs(currentBase);
                     currentBase = 0;
                  }
               }
               base = !isNaN(currentBase) ? int(currentBase) : int(data.base + data.additionnal);
               if(String(data.keyword).indexOf("%") != -1)
               {
                  total = Math.min(50,data.base + data.boost + data.stuff);
               }
               else
               {
                  total = base + data.boost + data.stuff - bonusUsed;
               }
               if(total != 0)
               {
                  componentsRef.lbl_value.text = total;
               }
               else
               {
                  componentsRef.lbl_value.text = "-";
               }
               break;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data.isCategory)
         {
            return CTR_CAT_TYPE_CAT;
         }
         return CTR_CAT_TYPE_ITEM;
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : *
      {
         if(!selected)
         {
         }
         return 10;
      }
      
      public function updateSpellLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var buttonMargin:uint = 0;
         if(data)
         {
            componentsRef.tx_spellBound.visible = false;
            componentsRef.ctr_spellButtons.visible = true;
            buttonMargin = 6;
            if(this.gd_spell.dataProvider.length * this.gd_spell.slotHeight <= this.gd_spell.height)
            {
               this.tx_separator.visible = false;
               componentsRef.ctr_spellButtons.width = this.gd_spell.slotWidth * 2;
               componentsRef.ctr_spellButtons.x = buttonMargin;
               componentsRef.ctr_spellButtons.y = buttonMargin;
            }
            else
            {
               this.tx_separator.visible = true;
               componentsRef.tx_spellBound.visible = data.length > 1;
               componentsRef.ctr_spellButtons.width = this.uiApi.me().getConstant("ctrSpellButtonsWidth");
               componentsRef.ctr_spellButtons.x = (this.gd_spell.slotWidth - this.uiApi.me().getConstant("ctrSpellButtonsWidth")) / 2;
               componentsRef.ctr_spellButtons.y = buttonMargin;
            }
            componentsRef.btn_spellVariant.visible = data.length > 1;
            componentsRef.slot_iconVariant.visible = data.length > 1;
            this.updateSpellButtonsLine(data,componentsRef,selected);
         }
         else
         {
            componentsRef.tx_spellBound.visible = false;
            componentsRef.ctr_spellButtons.visible = false;
            this.updateSpellButtonsLine(null,componentsRef,selected);
         }
      }
      
      public function updateSpellButtonsLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var hasVariant:* = false;
         var slotWidth:int = 0;
         if(data)
         {
            hasVariant = data.length > 1;
            componentsRef.btn_spellVariant.visible = hasVariant;
            componentsRef.lbl_spellName.visible = this.gd_spell.dataProvider.length * this.gd_spell.slotHeight <= this.gd_spell.height && !hasVariant;
            componentsRef.lbl_spellVariantName.visible = this.gd_spell.dataProvider.length * this.gd_spell.slotHeight <= this.gd_spell.height && hasVariant;
            if(hasVariant)
            {
               slotWidth = componentsRef.ctr_spellButtons.width / 2;
               componentsRef.btn_spell.width = slotWidth;
               componentsRef.slot_icon.x = componentsRef.btn_spell.width / 2 - componentsRef.slot_icon.width / 2;
               componentsRef.tx_bgSpell.width = slotWidth;
               componentsRef.btn_spellVariant.width = slotWidth;
               componentsRef.slot_iconVariant.x = slotWidth + componentsRef.btn_spellVariant.width / 2 - componentsRef.slot_icon.width / 2;
               componentsRef.tx_bgSpellVariant.width = slotWidth;
               this.updateSpellButton(data[0],componentsRef.btn_spell,componentsRef.slot_icon,componentsRef.lbl_spellName);
               this.updateSpellButton(data[1],componentsRef.btn_spellVariant,componentsRef.slot_iconVariant,componentsRef.lbl_spellVariantName);
            }
            else
            {
               slotWidth = componentsRef.ctr_spellButtons.width;
               componentsRef.btn_spell.width = slotWidth;
               componentsRef.tx_bgSpell.width = slotWidth;
               componentsRef.slot_icon.x = 18;
               this.updateSpellButton(data[0],componentsRef.btn_spell,componentsRef.slot_icon,componentsRef.lbl_spellName);
               this.updateSpellButton(null,componentsRef.btn_spellVariant,componentsRef.slot_iconVariant,componentsRef.lbl_spellVariantName);
            }
         }
         else
         {
            componentsRef.btn_spell.selected = false;
            componentsRef.btn_spellVariant.selected = false;
            componentsRef.slot_icon.data = null;
            componentsRef.slot_iconVariant.data = null;
            componentsRef.btn_spell.softDisabled = true;
            componentsRef.btn_spellVariant.softDisabled = true;
            componentsRef.btn_spell.reset();
            componentsRef.btn_spellVariant.reset();
            componentsRef.btn_spell.visible = false;
            componentsRef.btn_spellVariant.visible = false;
            componentsRef.lbl_spellName.text = null;
            componentsRef.lbl_spellVariantName.text = null;
         }
      }
      
      private function updateSpellButton(spell:SpellWrapper, btn_spell:ButtonContainer, slot_icon:Slot, lbl_spellName:Label) : void
      {
         var spellCache:Object = null;
         var spellLevels:Array = null;
         var levelsCount:int = 0;
         var i:int = 0;
         var isFirstObtentionLevel:Boolean = false;
         var areAllObtentionLevelsTheSame:Boolean = false;
         var playerSpell:Spell = null;
         if(spell)
         {
            if(!this._componentList[btn_spell.name])
            {
               this.uiApi.addComponentHook(btn_spell,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(btn_spell,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(btn_spell,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[btn_spell.name] = spell;
            spellCache = this._allSpellDisplayCache[spell];
            if(!spellCache)
            {
               spellCache = {};
               this._allSpellDisplayCache[spell] = spellCache;
               spellLevels = (spell as SpellWrapper).spell.spellLevelsInfo as Array;
               spellCache.spellLevels = [];
               levelsCount = spellLevels.length;
               areAllObtentionLevelsTheSame = true;
               for(i = 0; i < levelsCount; i++)
               {
                  isFirstObtentionLevel = this._characterLevel < spellLevels[i].minPlayerLevel && i == 0;
                  spellCache.spellLevels[i] = {
                     "spellLevel":spellLevels[i],
                     "isFirstLevel":isFirstObtentionLevel
                  };
                  if(areAllObtentionLevelsTheSame && (levelsCount == 1 || i + 1 < levelsCount && spellLevels[i].minPlayerLevel != spellLevels[i + 1].minPlayerLevel))
                  {
                     areAllObtentionLevelsTheSame = false;
                  }
               }
            }
            if(spellCache.spellLevels[0] && spellCache.spellLevels[0].spellLevel.minPlayerLevel > this._characterLevel)
            {
               btn_spell.greyedOut = true;
               slot_icon.allowDrag = false;
               slot_icon.softDisabled = true;
               btn_spell.selected = false;
            }
            else
            {
               btn_spell.greyedOut = false;
               slot_icon.allowDrag = true;
               slot_icon.softDisabled = false;
               btn_spell.selected = false;
               if(this._currentUiState == READ_ONLY_STATE)
               {
                  if(this._currentBuild && this._currentBuild.spellShortcutsBySpellId[spell.id])
                  {
                     btn_spell.selected = true;
                  }
                  else
                  {
                     playerSpell = !!this.playerApi.isIncarnation() ? this.dataApi.getSpell(spell.id) : spell.spell;
                     btn_spell.selected = !(playerSpell.spellVariant && (!playerSpell.spellVariant.spells || playerSpell.spellVariant.spellIds[0] != spell.id || this._currentBuild.spellShortcutsBySpellId[playerSpell.spellVariant.spellIds[1]]));
                  }
               }
               else
               {
                  btn_spell.selected = spell.variantActivated;
               }
            }
            if(lbl_spellName.visible)
            {
               lbl_spellName.text = spell.spell.name;
            }
            btn_spell.softDisabled = false;
            btn_spell.visible = true;
            if(!slot_icon.data || slot_icon.data.gfxId != spell.gfxId)
            {
               slot_icon.data = spell;
            }
            slot_icon.selected = false;
         }
         else
         {
            btn_spell.selected = false;
            slot_icon.data = null;
            btn_spell.softDisabled = true;
            btn_spell.reset();
            btn_spell.visible = false;
            lbl_spellName.text = null;
         }
      }
      
      public function updateIcon(data:*, components:*, selected:Boolean) : void
      {
         components.btn_icon.selected = false;
         if(data)
         {
            components.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("iconsUri") + "small_" + data.id);
            components.btn_icon.selected = selected;
         }
         else
         {
            components.tx_icon.uri = null;
         }
      }
      
      public function equipObject(objectUID:int) : void
      {
         if(this._equipmentPositionClicked != -1)
         {
            if(objectUID == -1)
            {
               this.sysApi.sendAction(new ObjectSetPositionAction([this._equippedItemClicked,63,1]));
            }
            else
            {
               this.sysApi.sendAction(new ObjectSetPositionAction([objectUID,this._equipmentPositionClicked,1]));
            }
            this._equipmentPositionClicked = -1;
         }
      }
      
      private function switchToUiState(newState:int) : void
      {
         var slot:Slot = null;
         this.log(16,"switchToUiState ! " + this._currentUiState + " -> " + newState);
         if(this._currentUiState == newState)
         {
            return;
         }
         this._currentUiState = newState;
         this.gd_carac.updateItems();
         if(newState == MODIFY_STATE)
         {
            this.sysApi.dispatchHook(CustomUiHookList.SpellMovementAllowed,true);
            this.tx_inventoryLight.visible = true;
            this.lbl_warningCharacter.text = this.uiApi.getText("ui.build.characterChange");
            for each(slot in this._equipmentSlots)
            {
               slot.softDisabled = false;
            }
            this.gd_spell.softDisabled = false;
            this.tx_unlockBuild.visible = true;
            this.tx_lockBuild.visible = false;
         }
         else if(newState == READ_ONLY_STATE)
         {
            this.sysApi.dispatchHook(CustomUiHookList.SpellMovementAllowed,false);
            this.tx_inventoryLight.visible = false;
            for each(slot in this._equipmentSlots)
            {
               slot.softDisabled = true;
            }
            this.gd_spell.softDisabled = true;
            this.tx_unlockBuild.visible = false;
            this.tx_lockBuild.visible = true;
         }
      }
      
      private function wheelChara(sens:int) : void
      {
         this._currentCharacterDirection = (this._currentCharacterDirection + sens + 8) % 8;
         this.entityDisplayer.direction = this._currentCharacterDirection;
      }
      
      private function getParsedStat(stat:Object, forAdvancedTooltip:Boolean = false) : String
      {
         var parsedStat:String = null;
         if(forAdvancedTooltip)
         {
            parsedStat = this.uiApi.getText("ui.common.base") + this.uiApi.getText("ui.common.colon") + (stat.base + stat.additionnal) + "\n" + this.uiApi.getText("ui.common.bonus") + this.uiApi.getText("ui.common.colon") + (stat.boost + stat.stuff);
         }
         else
         {
            parsedStat = this.uiApi.getText("ui.common.base") + " (" + this.uiApi.getText("ui.charaSheet.natural") + " + " + this.uiApi.getText("ui.charaSheet.additionnal") + ")" + this.uiApi.getText("ui.common.colon") + stat.base + "+" + stat.additionnal + "\n" + this.uiApi.getText("ui.common.equipement") + this.uiApi.getText("ui.common.colon") + stat.stuff + "\n" + this.uiApi.getText("ui.charaSheet.temporaryBonus") + this.uiApi.getText("ui.common.colon") + stat.boost;
         }
         return parsedStat;
      }
      
      private function createCharacteristicsDataMatrix() : void
      {
         var caracId:int = 0;
         var cat:CharacteristicCategory = null;
         var categoryItem:CharacteristicGridItem = null;
         var charac:Characteristic = null;
         this._statsData = [];
         for each(cat in this._statsCategoriesData)
         {
            categoryItem = new CharacteristicGridItem(cat.id,"",cat.name);
            categoryItem.isCategory = true;
            this._statsData.push(categoryItem);
            for each(caracId in cat.characteristicIds)
            {
               charac = this.dataApi.getCharacteristic(caracId);
               if(charac && charac.visible)
               {
                  this._statsData.push(new CharacteristicGridItem(caracId,charac.keyword,charac.name,charac.asset,charac.id,charac.upgradable,charac.categoryId));
               }
            }
         }
      }
      
      private function creareFavItemsArray() : Array
      {
         var item:CharacteristicGridItem = null;
         var cloneItem:CharacteristicGridItem = null;
         var favItems:Array = [];
         var categoryFavItem:CharacteristicGridItem = new CharacteristicGridItem(-1,"",this.uiApi.getText("ui.charaSheet.favorite"));
         categoryFavItem.isCategory = true;
         favItems.push(categoryFavItem);
         if(this._favStatCategoryIds.length <= 0)
         {
            cloneItem = new CharacteristicGridItem(-1,"","",null);
            favItems.push(cloneItem);
            return favItems;
         }
         for each(item in this._statsData)
         {
            if(!item.isCategory && this._favStatCategoryIds.indexOf(item.numId) != -1)
            {
               cloneItem = item.clone();
               cloneItem.categoryId = -1;
               favItems.push(cloneItem);
            }
         }
         return favItems;
      }
      
      private function updateStats() : void
      {
         var totalVitality:int = 0;
         var data:CharacteristicGridItem = null;
         var carac:Stat = null;
         var maxLifePoints:int = 0;
         var statsPoints:int = 0;
         var caracBaseValue:int = 0;
         var statDataInBuild:CharacterCharacteristicForPreset = null;
         var detailedCharac:DetailedStat = null;
         if(this._currentUiState == -1)
         {
            return;
         }
         this._statsUpgradableList = [];
         this._someStatsMayBeScrolled = false;
         var characLogs:String = "Remplissage des caracteristiques";
         var basePlayerCaracForceUse:Boolean = false;
         if(this._currentUiState == READ_ONLY_STATE)
         {
            basePlayerCaracForceUse = true;
            for each(data in this._statsData)
            {
               if(!(!data || data.isCategory || !data.upgradable))
               {
                  carac = this._characterStats.getStat(data.id);
                  caracBaseValue = 0;
                  if(carac !== null)
                  {
                     caracBaseValue = carac is DetailedStat ? int((carac as DetailedStat).baseValue) : int(carac.totalValue);
                  }
                  if(this._currentBuild.statsByKeyword[data.keyword].base != caracBaseValue)
                  {
                     basePlayerCaracForceUse = false;
                     break;
                  }
               }
            }
         }
         this._allUpgradableStatsAreNull = true;
         for each(data in this._statsData)
         {
            if(!(!data || data.isCategory))
            {
               carac = this._characterStats.getStat(data.id);
               statDataInBuild = null;
               if(this._currentUiState == READ_ONLY_STATE)
               {
                  statDataInBuild = this._currentBuild.statsByKeyword[data.keyword];
               }
               if(carac === null)
               {
                  if(statDataInBuild)
                  {
                     if(basePlayerCaracForceUse)
                     {
                        data.base = 0;
                     }
                     else
                     {
                        data.base = statDataInBuild.base;
                     }
                  }
                  else
                  {
                     data.base = 0;
                  }
               }
               else if(carac is DetailedStat)
               {
                  detailedCharac = carac as DetailedStat;
                  if(statDataInBuild)
                  {
                     if(basePlayerCaracForceUse)
                     {
                        data.base = detailedCharac.baseValue - (!!isStatZeroCentered(data.id) ? 100 : 0);
                     }
                     else
                     {
                        data.base = statDataInBuild.base;
                     }
                     data.additionnal = statDataInBuild.additionnal;
                     data.stuff = statDataInBuild.stuff;
                  }
                  else
                  {
                     data.base = detailedCharac.baseValue - (!!isStatZeroCentered(data.id) ? 100 : 0);
                     data.additionnal = detailedCharac.additionalValue;
                     data.stuff = detailedCharac.objectsAndMountBonusValue;
                  }
                  data.boost = detailedCharac.contextModifValue;
               }
               else if(statDataInBuild)
               {
                  if(basePlayerCaracForceUse)
                  {
                     data.base = carac.totalValue - (!!isStatZeroCentered(data.id) ? 100 : 0);
                  }
                  else
                  {
                     data.base = statDataInBuild.base;
                  }
               }
               else
               {
                  data.base = carac.totalValue - (!!isStatZeroCentered(data.id) ? 100 : 0);
               }
               if(isResistPercentStat(data.id))
               {
                  carac = this._characterStats.getStat(StatIds.RESIST_PERCENT);
                  if(carac is DetailedStat)
                  {
                     detailedCharac = carac as DetailedStat;
                     data.base += detailedCharac.baseValue - (!!isStatZeroCentered(StatIds.RESIST_PERCENT) ? 100 : 0);
                     data.additionnal += detailedCharac.additionalValue;
                     data.stuff += detailedCharac.objectsAndMountBonusValue;
                     data.boost += detailedCharac.contextModifValue;
                  }
                  else if(carac is Stat)
                  {
                     data.base += carac.totalValue - (!!isStatZeroCentered(StatIds.RESIST_PERCENT) ? 100 : 0);
                  }
               }
               else if(isReceivedDamageStat(data.id))
               {
                  data.base *= -1;
                  data.additionnal *= -1;
                  data.stuff *= -1;
                  data.boost *= -1;
               }
               if(data.keyword == "actionPoints")
               {
                  this.lbl_actionPointsValue.text = this.utilApi.kamasToString(data.base + data.additionnal + data.boost + data.stuff,"");
               }
               else if(data.keyword == "movementPoints")
               {
                  this.lbl_movementPointsValue.text = this.utilApi.kamasToString(data.base + data.additionnal + data.boost + data.stuff,"");
               }
               else if(data.keyword == "vitality")
               {
                  totalVitality = data.base + data.additionnal + data.boost + data.stuff;
               }
               if(data.categoryId == DataEnum.CHARACTERISTIC_TYPE_PRIMARY || data.keyword == "tackleBlock" || data.keyword == "tackleEvade")
               {
                  if(data.upgradable)
                  {
                     this._statsUpgradableList.push(data);
                     characLogs += "\n  - " + data.name + " : " + (data.stuff + data.base);
                     if(data.base > 0)
                     {
                        this._allUpgradableStatsAreNull = false;
                     }
                  }
                  if(data.upgradable && data.additionnal < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
                  {
                     this._someStatsMayBeScrolled = true;
                  }
               }
            }
         }
         this.log(8,characLogs);
         if(this._currentUiState == MODIFY_STATE)
         {
            maxLifePoints = this._characterStats.getMaxHealthPoints();
         }
         else
         {
            maxLifePoints = totalVitality;
            if(basePlayerCaracForceUse)
            {
               maxLifePoints += this._characterStats.getMaxHealthPoints() - this._characterStats.getStatTotalValue(StatIds.VITALITY);
            }
            else
            {
               maxLifePoints += this._currentBuild.statsByKeyword["lifePoints"].base;
            }
         }
         this.lbl_healthPointsValue.text = this.utilApi.kamasToString(maxLifePoints,"");
         if(this._currentUiState == MODIFY_STATE || basePlayerCaracForceUse)
         {
            statsPoints = this._characterStats.getStatBaseValue(StatIds.STATS_POINTS);
         }
         else
         {
            statsPoints = this._currentBuild.statsByKeyword["statsPoints"].base;
         }
         var points:int = !!this._someStatsMayBeScrolled ? int(statsPoints + this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS)) : int(statsPoints);
         this.lbl_statPoints.text = this.utilApi.kamasToString(points,"");
         this.updateStatsResetButton();
         this.gridsUpdate();
      }
      
      private function updateStatsResetButton() : void
      {
         this.btn_reset.softDisabled = this._allUpgradableStatsAreNull || this._currentUiState == READ_ONLY_STATE;
      }
      
      private function gridsUpdate() : void
      {
         if(this.ctr_regular.visible)
         {
            this.gd_carac.dataProvider = this._statsUpgradableList;
         }
         else
         {
            this.displayCategories();
         }
      }
      
      private function displayCategories(selectedCategory:Object = null) : void
      {
         var myIndex:int = 0;
         var entry:CharacteristicGridItem = null;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedStatCategoryIds.indexOf(selecCatId) != -1)
            {
               this._openedStatCategoryIds.splice(this._openedStatCategoryIds.indexOf(selecCatId),1);
            }
            else
            {
               this._openedStatCategoryIds.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = [];
         var favItems:Array = this.creareFavItemsArray();
         var fullArray:Array = favItems.concat(this._statsData);
         for each(entry in fullArray)
         {
            if(entry.isCategory)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            if(!entry.isCategory && this._openedStatCategoryIds.indexOf(entry.categoryId) != -1)
            {
               tempCats.push(entry);
               index++;
            }
         }
         scrollValue = this.gd_caracAdvanced.verticalScrollValue;
         this.gd_caracAdvanced.dataProvider = tempCats;
         if(this.gd_caracAdvanced.selectedIndex != myIndex)
         {
            this.gd_caracAdvanced.silent = true;
            this.gd_caracAdvanced.selectedIndex = myIndex;
            this.gd_caracAdvanced.silent = false;
         }
         this.gd_caracAdvanced.verticalScrollValue = scrollValue;
         this.sysApi.setData("openedCharsheetCat",this._openedStatCategoryIds);
      }
      
      private function updateFavCatArray(numId:int, delEntry:Boolean) : void
      {
         if(!delEntry)
         {
            this._favStatCategoryIds.push(numId);
         }
         else
         {
            this._favStatCategoryIds.splice(this._favStatCategoryIds.indexOf(numId),1);
         }
         this.sysApi.setData("favCharsheetCat",this._favStatCategoryIds);
         this.displayCategories();
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         switch(tab)
         {
            case STAT_REGULAR_TAB:
               this.ctr_regular.visible = true;
               this.ctr_advanced.visible = false;
               break;
            case STAT_ADVANCED_TAB:
               this.ctr_regular.visible = false;
               this.ctr_advanced.visible = true;
         }
         this.gridsUpdate();
      }
      
      private function initEquipementSlot() : void
      {
         var slot:Slot = null;
         this._delayDoubleClickTimer = new BenchmarkTimer(500,1,"CharacterBuildsUi._delayDoubleClickTimer");
         this._delayDoubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
         this._equipmentSlots = [];
         this._availableEquipmentPositions = [];
         this._characterEquipmentItemsByPos = [];
         this._equipmentSlots[0] = this.slot_0;
         this._equipmentSlots[1] = this.slot_1;
         this._equipmentSlots[2] = this.slot_2;
         this._equipmentSlots[3] = this.slot_3;
         this._equipmentSlots[4] = this.slot_4;
         this._equipmentSlots[5] = this.slot_5;
         this._equipmentSlots[6] = this.slot_6;
         this._equipmentSlots[7] = this.slot_7;
         this._equipmentSlots[8] = this.slot_8;
         this._equipmentSlots[9] = this.slot_9;
         this._equipmentSlots[10] = this.slot_10;
         this._equipmentSlots[11] = this.slot_11;
         this._equipmentSlots[12] = this.slot_12;
         this._equipmentSlots[13] = this.slot_13;
         this._equipmentSlots[14] = this.slot_14;
         this._equipmentSlots[15] = this.slot_15;
         this._equipmentSlots[28] = this.slot_28;
         this._equipmentSlots[30] = this.slot_30;
         for each(slot in this._equipmentSlots)
         {
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
            this._availableEquipmentPositions.push(int(slot.name.split("_")[1]));
         }
      }
      
      private function initBuilds() : void
      {
         var icon:PresetIcon = null;
         (this.gd_builds.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorFunction;
         (this.gd_builds.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
         (this.gd_builds.renderer as SlotGridRenderer).removeDropSourceFunction = this.removeDropSourceFunction;
         this._namingRuleBuildName = this.sysApi.getCurrentServer().community.namingRulePresetName;
         this.inp_buildName.maxChars = this._namingRuleBuildName.maxLength;
         this.ctr_editBuildIcon.handCursor = true;
         var icons:Array = [];
         for each(icon in this.dataApi.getPresetIcons())
         {
            icons.push(icon);
         }
         this.gd_buildIcons.dataProvider = icons;
      }
      
      private function initStats() : void
      {
         this.ctr_advanced.visible = false;
         this._characterCharacteristics = this.playerApi.characteristics();
         this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
         this._textureMinusUri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
         this._texturePlusUri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_regular,this.uiApi.me());
         this.btn_regular.selected = true;
         this._statsCategoriesData = this.dataApi.getCharacteristicCategories();
         this._openedStatCategoryIds = this.sysApi.getData("openedCharsheetCat");
         if(!this._openedStatCategoryIds)
         {
            this._openedStatCategoryIds = [];
         }
         this._favStatCategoryIds = this.sysApi.getData("favCharsheetCat");
         if(!this._favStatCategoryIds)
         {
            this._favStatCategoryIds = [];
         }
         this.createCharacteristicsDataMatrix();
      }
      
      private function initEquipment() : void
      {
         this._currentCharacterDirection = 1;
         var look:TiphonEntityLook = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id,true);
         this.entityDisplayer.clearSubEntities = false;
         this.entityDisplayer.direction = this._currentCharacterDirection;
         this.entityDisplayer.look = look;
      }
      
      private function fillEquipement() : void
      {
         var equipment:Vector.<ItemWrapper> = null;
         var item:ItemWrapper = null;
         var slot:Slot = null;
         var pos:uint = 0;
         var equipmentLogs:String = "Remplissage des equipements";
         var isOnMount:Boolean = false;
         this._characterEquipmentItemsByPos = [];
         if(this._currentUiState == READ_ONLY_STATE)
         {
            equipment = this._currentBuild.equipment;
            isOnMount = this._currentBuild.hasMount;
         }
         else
         {
            equipment = this.storageApi.getViewContent("equipment");
            isOnMount = this.playerApi.isRidding();
            if(this._currentBuild)
            {
               for each(item in this._currentBuild.equipment)
               {
                  if(item && item.objectGID && item.objectUID == 0)
                  {
                     equipmentLogs += "\n  - delink : " + item.name;
                     this._characterEquipmentItemsByPos[item.position] = item;
                  }
               }
            }
         }
         for each(item in equipment)
         {
            if(item)
            {
               equipmentLogs += "\n  - " + item.name;
               this._characterEquipmentItemsByPos[item.position] = item;
            }
         }
         this.log(8,equipmentLogs);
         if(!this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] || this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] == null)
         {
            if(isOnMount)
            {
               this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = this.storageApi.getFakeItemMountOrRedCross();
            }
            else
            {
               this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = null;
            }
         }
         for each(slot in this._equipmentSlots)
         {
            pos = parseInt(slot.name.split("_")[1]);
            slot.data = this._characterEquipmentItemsByPos[pos];
         }
      }
      
      private function filterCustomModeBreedSpells(spellsList:Array) : void
      {
         var index:uint = 0;
         var jndex:uint = 0;
         var currentVariantList:Array = null;
         var currentSpellWrapper:SpellWrapper = null;
         var currentCustomModeBreedSpell:CustomModeBreedSpell = null;
         while(index < spellsList.length)
         {
            jndex = 0;
            currentVariantList = spellsList[index];
            while(jndex < currentVariantList.length)
            {
               currentSpellWrapper = currentVariantList[jndex];
               if(currentSpellWrapper !== null)
               {
                  currentCustomModeBreedSpell = this.playerApi.getCustomModeBreedSpellById(currentSpellWrapper.id);
                  if(currentCustomModeBreedSpell === null || currentCustomModeBreedSpell.isHidden)
                  {
                     currentVariantList.removeAt(jndex);
                  }
                  else
                  {
                     jndex++;
                  }
               }
            }
            if(currentVariantList.length <= 0)
            {
               spellsList.removeAt(index);
            }
            else
            {
               index++;
            }
         }
      }
      
      private function updateSpells() : void
      {
         var spell:Spell = null;
         var spellWrapper:SpellWrapper = null;
         var spellInventory:Array = null;
         var spellsForPreset:Vector.<SpellForPreset> = null;
         var i:uint = 0;
         var spellConversion:SpellConversion = null;
         var j:uint = 0;
         var variantIds:Array = null;
         var breedSpellsIds:Array = null;
         var k:int = 0;
         var lastElement:GraphicContainer = null;
         if(this._currentUiState == -1)
         {
            return;
         }
         this.log(8,"Remplissage des sorts");
         var buildIsInBreedMode:Boolean = true;
         var spellsList:Array = [];
         if(this._currentUiState == MODIFY_STATE)
         {
            if(this.playerApi.isIncarnation())
            {
               spellInventory = this.playerApi.getSpellInventory();
               for each(spellWrapper in spellInventory)
               {
                  if(spellWrapper.spellId != 0)
                  {
                     spellsList.push([spellWrapper]);
                  }
               }
            }
            else
            {
               spellsList = this.playerApi.getSpells(true);
               if(this._isForgettableSpellsUi)
               {
                  this.filterCustomModeBreedSpells(spellsList);
               }
            }
         }
         else if(this._currentBuild.spellsPreset)
         {
            spellsForPreset = this._currentBuild.spellsPreset.spells;
            for(i = 0; i < spellsForPreset.length; i++)
            {
               spell = this.dataApi.getSpell(spellsForPreset[i].spellId);
               if(!spell)
               {
                  spellConversion = this.dataApi.getSpellConversion(spellsForPreset[i].spellId);
                  spell = this.dataApi.getSpell(spellConversion.newSpellId);
               }
               if(spell && spell.typeId == DataEnum.SPELL_TYPE_INCARNATION)
               {
                  buildIsInBreedMode = false;
                  break;
               }
            }
            if(!buildIsInBreedMode)
            {
               for(j = 0; j < spellsForPreset.length; j++)
               {
                  if(spellsForPreset[j].spellId != 0)
                  {
                     spellsList.push([this.dataApi.getSpellWrapper(spellsForPreset[j].spellId,0)]);
                  }
               }
            }
            else if(this.playerApi.isIncarnation())
            {
               variantIds = [];
               breedSpellsIds = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).allSpellsId;
               for(k = 0; k < breedSpellsIds.length; k++)
               {
                  if(variantIds.indexOf(breedSpellsIds[k]) == -1)
                  {
                     spell = this.dataApi.getSpell(breedSpellsIds[k]);
                     spellsList.push([this.dataApi.getSpellWrapper(spell.spellVariant.spellIds[0],0,false,0,k == spell.spellVariant.spellIds[0]),this.dataApi.getSpellWrapper(spell.spellVariant.spellIds[1],0,false,0,k == spell.spellVariant.spellIds[1])]);
                     variantIds.push(spell.spellVariant.spellIds[1]);
                  }
               }
            }
            else
            {
               spellsList = this.playerApi.getSpells(true);
               if(this._isForgettableSpellsUi)
               {
                  this.filterCustomModeBreedSpells(spellsList);
               }
            }
         }
         spellsList.sort(this.sortOnObtentionLevel);
         this.gd_spell.dataProvider = spellsList;
         if(this._isForgettableSpellsUi)
         {
            this.lbl_manageSpellSets.visible = true;
            this.lbl_manageSpellSets.x = this.gd_spell.x + this.gd_spell.width / 2 - this.lbl_manageSpellSets.width / 2;
            if(this.gd_spell.dataProvider.length <= 0 || this.gd_spell.slots.length < this.gd_spell.dataProvider.length)
            {
               this.lbl_manageSpellSets.y = 10;
            }
            else
            {
               lastElement = this.gd_spell.slots[this.gd_spell.dataProvider.length - 1];
               this.lbl_manageSpellSets.y = lastElement.y + lastElement.height + 35;
            }
         }
         else
         {
            this.lbl_manageSpellSets.visible = false;
         }
      }
      
      private function sortOnObtentionLevel(spellsA:Array, spellsB:Array) : Number
      {
         var aObtentionLevel:int = spellsA[0].spell.getSpellLevel(0).minPlayerLevel;
         var bObtentionLevel:int = spellsB[0].spell.getSpellLevel(0).minPlayerLevel;
         var aObtentionLevelVariant1:int = 0;
         if(spellsA.length > 1)
         {
            aObtentionLevelVariant1 = spellsA[1].spell.getSpellLevel(0).minPlayerLevel;
         }
         var bObtentionLevelVariant1:int = 0;
         if(spellsB.length > 1)
         {
            bObtentionLevelVariant1 = spellsB[1].spell.getSpellLevel(0).minPlayerLevel;
         }
         if(aObtentionLevel != bObtentionLevel)
         {
            return aObtentionLevel - bObtentionLevel;
         }
         if(aObtentionLevelVariant1 != bObtentionLevelVariant1)
         {
            return aObtentionLevelVariant1 - bObtentionLevelVariant1;
         }
         if(spellsA[0].id != spellsB[0].id)
         {
            return spellsA[0].id - spellsB[0].id;
         }
         return 0;
      }
      
      private function previewSpellBar() : void
      {
         var spellsList:Array = null;
         var buildSpellShortcuts:Array = null;
         var i:int = 0;
         var spellId:* = undefined;
         if(this._currentUiState == MODIFY_STATE && this._currentBuild)
         {
            spellsList = this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         }
         else if(this._currentBuild)
         {
            spellsList = [];
            buildSpellShortcuts = this._currentBuild.spellShortcutsBySpellId;
            for(i = 0; i < 100; i++)
            {
               for(spellId in buildSpellShortcuts)
               {
                  if(buildSpellShortcuts[spellId].indexOf(i) != -1)
                  {
                     spellsList[i] = this.dataApi.getShortcutWrapper(i,spellId,DataEnum.SHORTCUT_TYPE_SPELL);
                  }
               }
            }
            this.inventoryApi.setBuildId(this._currentBuild.id);
         }
         else
         {
            this.inventoryApi.setBuildId(-1);
            spellsList = this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         }
         this.sysApi.dispatchHook(CustomUiHookList.PreviewBuildSpellBar,spellsList,this._currentUiState == READ_ONLY_STATE);
      }
      
      private function displayBuild(build:BuildWrapper) : void
      {
         var idx:int = 0;
         var icon:PresetIcon = null;
         this.log(2,"Affichage du build " + build.buildName);
         this._currentBuild = build;
         this._currentBuildNameHasChanged = false;
         this.lbl_warningCharacter.text = this.uiApi.getText("ui.build.buildPreview") + " " + this._currentBuild.buildName;
         this.tx_buildIcon.uri = build.iconUri;
         this._currentBuildIconId = build.gfxId;
         for each(icon in this.dataApi.getPresetIcons())
         {
            if(icon.id == this._currentBuildIconId)
            {
               idx = icon.order;
               break;
            }
         }
         this._currentSelectedBuildIconIndex = idx;
         this.gd_buildIcons.selectedIndex = idx;
         this.gd_buildIcons.updateItem(idx);
         this.inp_buildName.text = build.buildName;
         if(this.isCurrentBuildDifferentFromCharacter() || this._currentBuild != this._currentBuildUsed)
         {
            this.switchToUiState(READ_ONLY_STATE);
         }
         else
         {
            this.switchToUiState(MODIFY_STATE);
         }
         this.updateButtons();
         this.fillEquipement();
         this.updateSpells();
         this.previewSpellBar();
         this.updateStats();
         this.updateLook(this._currentBuild.characterLook);
      }
      
      private function displayNewBuild() : void
      {
         this.log(2,"Affichage d\'un build vide");
         if(this._currentBuild == null && this._currentUiState == MODIFY_STATE)
         {
            return;
         }
         this._currentBuild = null;
         this._currentBuildNameHasChanged = false;
         var randomIconIndex:int = Math.floor(Math.random() * this.gd_buildIcons.dataProvider.length);
         this.gd_buildIcons.selectedIndex = randomIconIndex;
         this.inp_buildName.text = this.uiApi.getText("ui.build.build") + " " + (this.gd_builds.selectedIndex + 1);
         this.switchToUiState(MODIFY_STATE);
         this.updateButtons();
         this.fillEquipement();
         this.updateSpells();
         this.previewSpellBar();
         this.updateStats();
         this.updateLook(this.playerApi.getPlayedCharacterInfo().realEntityLook);
      }
      
      private function choseABuildIcon(iconId:int) : void
      {
         this._currentBuildIconId = iconId;
         this._currentSelectedBuildIconIndex = this.gd_buildIcons.selectedIndex;
         this.tx_buildIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("iconsUri") + "icon_" + iconId);
         this.updateSaveButton();
      }
      
      private function updateButtons() : void
      {
         this._currentBuildHasChanged = false;
         if(this._currentBuild == null)
         {
            this.btn_equipBuild.softDisabled = true;
            this.btn_resetBuild.softDisabled = true;
            this.btn_deleteBuild.softDisabled = true;
            this.btn_lbl_btn_saveBuild.text = this.uiApi.getText("ui.charcrea.create");
            this.updateSaveButton();
            return;
         }
         this.btn_lbl_btn_saveBuild.text = this.uiApi.getText("ui.common.save");
         if(this._currentUiState == READ_ONLY_STATE)
         {
            this.btn_equipBuild.softDisabled = false;
            this.btn_resetBuild.softDisabled = true;
            this.btn_deleteBuild.softDisabled = false;
            this.updateSaveButton();
            return;
         }
         if(this.isCurrentBuildDifferentFromCharacter())
         {
            this._currentBuildHasChanged = true;
            this.btn_equipBuild.softDisabled = true;
            this.btn_resetBuild.softDisabled = false;
            this.btn_deleteBuild.softDisabled = false;
         }
         else
         {
            this.btn_equipBuild.softDisabled = true;
            this.btn_resetBuild.softDisabled = true;
            this.btn_deleteBuild.softDisabled = false;
         }
         this.updateSaveButton();
      }
      
      private function updateSaveButton() : void
      {
         var buildChangedOrIsNew:Boolean = this._currentBuild == null || this._currentBuildHasChanged || this._currentBuildNameHasChanged || this._currentBuildIconId != this._currentBuild.gfxId;
         this.btn_saveBuild.softDisabled = !buildChangedOrIsNew;
      }
      
      private function verifyName() : Boolean
      {
         var name:String = this.inp_buildName.text;
         var errorText:String = "";
         if(name.length < this._namingRuleBuildName.minLength)
         {
            this.log(8,name + " trop court");
            errorText = this.uiApi.getText("ui.build.errorNameShort");
         }
         if(name.length > this._namingRuleBuildName.maxLength)
         {
            this.log(8,name + " trop long");
            errorText = this.uiApi.getText("ui.build.errorNameLong");
         }
         var regexp:RegExp = new RegExp(this._namingRuleBuildName.regexp,"g");
         if(!regexp.test(name))
         {
            this.log(8,name + " ne respecte pas les regles : " + this._namingRuleBuildName.regexp);
            errorText = this.uiApi.getText("ui.build.errorName");
         }
         if(errorText != "")
         {
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),errorText,[this.uiApi.getText("ui.common.ok")],null,null,null,null,false,false,true,null,this.uiApi.me().strata);
            return false;
         }
         return true;
      }
      
      private function isCurrentBuildDifferentFromCharacter() : Boolean
      {
         var buildSpellsCount:int = 0;
         var spell:Spell = null;
         var key:* = undefined;
         var buildItemWrapper:ItemWrapper = null;
         var characterItemWrapper:ItemWrapper = null;
         var upgradableStat:CharacteristicGridItem = null;
         var buildSpellShortcuts:Array = null;
         var spellBarShortcuts:Array = null;
         var spellConversion:SpellConversion = null;
         var spellData:Spell = null;
         var shortcutsArray:Vector.<int> = null;
         var sameItemFound:Boolean = false;
         var caracBase:Number = NaN;
         this.log(2,"isCurrentBuildDifferentFromCharacter ?");
         if(this._currentBuild == null)
         {
            return false;
         }
         var i:int = 0;
         var j:int = 0;
         var buildSpellIds:Array = [];
         var characterSpellIds:Array = this.playerApi.getBreedSpellActivatedIds();
         var characterSpellsCount:int = characterSpellIds.length;
         var breedSpellsIds:Array = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).allSpellsId;
         var buildIsInBreedMode:Boolean = true;
         if(this._currentBuild.spellsPreset !== null)
         {
            for(key in this._currentBuild.spellShortcutsBySpellId)
            {
               spell = this.dataApi.getSpell(key);
               if(!spell)
               {
                  spellConversion = this.dataApi.getSpellConversion(key);
                  spell = this.dataApi.getSpell(spellConversion.newSpellId);
               }
               if(spell && spell.typeId == DataEnum.SPELL_TYPE_INCARNATION)
               {
                  buildIsInBreedMode = false;
               }
            }
            for(key in this._currentBuild.spellShortcutsBySpellId)
            {
               if(buildIsInBreedMode && breedSpellsIds.indexOf(key) != -1)
               {
                  buildSpellIds.push(key);
               }
               else if(!buildIsInBreedMode)
               {
                  buildSpellIds.push(key);
               }
            }
            buildSpellsCount = buildSpellIds.length;
            if(buildIsInBreedMode)
            {
               if(buildSpellsCount != characterSpellsCount)
               {
                  this.log(2,"    Nombre de sorts différents : " + buildSpellsCount + " builds,  " + characterSpellsCount + " sorts actuels");
                  return true;
               }
               while(i < buildSpellsCount)
               {
                  if(characterSpellIds.indexOf(buildSpellIds[i]) == -1)
                  {
                     spellData = this.dataApi.getSpell(buildSpellIds[i]);
                     this.log(2,"    Le sort " + spellData.name + " " + buildSpellIds[i] + " du build n\'est pas actif pour le joueur");
                     return true;
                  }
                  i++;
               }
            }
            buildSpellShortcuts = this._currentBuild.spellShortcutsBySpellId;
            spellBarShortcuts = this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR);
            for(i = 0; i < 100; i++)
            {
               if(spellBarShortcuts[i])
               {
                  if(!(buildSpellShortcuts[spellBarShortcuts[i].id] && buildSpellShortcuts[spellBarShortcuts[i].id].indexOf(i) != -1))
                  {
                     return true;
                  }
               }
               else
               {
                  for each(shortcutsArray in buildSpellShortcuts)
                  {
                     if(shortcutsArray.indexOf(i) != -1)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         if(this.playerApi.getMount() && this._currentBuild.hasMount != this.playerApi.isRidding())
         {
            if(this._currentBuild.hasMount)
            {
               this.log(2,"    Le build a une monture et pas l\'inventaire");
            }
            else
            {
               this.log(2,"    Le build n\'a pas de monture alors que l\'inventaire si");
            }
            return true;
         }
         var buildEquipment:Vector.<ItemWrapper> = this._currentBuild.equipment;
         var buildEquipmentCount:int = buildEquipment.length;
         var characterEquipment:Vector.<ItemWrapper> = this.storageApi.getViewContent("equipment");
         var characterEquipmentCount:int = characterEquipment.length;
         var itemUidsFoundInBuild:Array = [];
         for(i = 0; i < buildEquipmentCount; i++)
         {
            buildItemWrapper = buildEquipment[i];
            if(buildItemWrapper)
            {
               sameItemFound = false;
               for(j = 0; j < characterEquipmentCount; j++)
               {
                  characterItemWrapper = characterEquipment[j];
                  if(characterItemWrapper && buildItemWrapper.position == characterItemWrapper.position)
                  {
                     if(buildItemWrapper.objectGID != characterItemWrapper.objectGID)
                     {
                        this.log(2,"    A la position " + buildItemWrapper.position + ", on a " + buildItemWrapper.name + " " + buildItemWrapper.objectGID + " dans le build et " + characterItemWrapper.name + " " + characterItemWrapper.objectGID + " dans l\'inventaire");
                        return true;
                     }
                     if(buildItemWrapper.objectGID != 0 && buildItemWrapper.objectUID == 0)
                     {
                        this.log(2,"    A la position " + buildItemWrapper.position + ", on a " + buildItemWrapper.name + " " + buildItemWrapper.objectGID + " " + buildItemWrapper.objectUID + " dans le build et " + characterItemWrapper.name + " " + characterItemWrapper.objectGID + " " + characterItemWrapper.objectUID + " dans l\'inventaire");
                        return true;
                     }
                     itemUidsFoundInBuild.push(buildItemWrapper.objectUID);
                     this.log(4,"     on met de coté l\'uid " + buildItemWrapper.objectUID);
                     sameItemFound = true;
                  }
               }
               if(!sameItemFound)
               {
                  if(buildItemWrapper.objectUID != 0)
                  {
                     this.log(2,"    A la position " + buildItemWrapper.position + ", on a " + buildItemWrapper.name + " " + buildItemWrapper.objectGID + " " + buildItemWrapper.objectUID + " dans le build et rien dans l\'inventaire");
                     return true;
                  }
               }
            }
         }
         for(j = 0; j < characterEquipmentCount; j++)
         {
            characterItemWrapper = characterEquipment[j];
            if(characterItemWrapper)
            {
               if(this.inventoryApi.getInvisibleEquipmentPositions().indexOf(characterItemWrapper.position) == -1)
               {
                  this.log(4," ° on cherche l\'uid " + characterItemWrapper.objectUID + "  dans  " + itemUidsFoundInBuild);
                  if(itemUidsFoundInBuild.indexOf(characterItemWrapper.objectUID) == -1)
                  {
                     this.log(2,"    A la position " + characterItemWrapper.position + ", on a rien dans le build et " + characterItemWrapper.name + " " + characterItemWrapper.objectGID + " " + characterItemWrapper.objectUID + " dans l\'inventaire");
                  }
               }
            }
            continue;
            continue;
            return true;
         }
         var buildCaracteristicsByKeyword:Dictionary = this._currentBuild.statsByKeyword as Dictionary;
         for each(upgradableStat in this._statsUpgradableList)
         {
            caracBase = this._characterStats.getStatBaseValue(StatIds.getStatIdFromStatName(upgradableStat.keyword));
            if(!buildCaracteristicsByKeyword[upgradableStat.keyword])
            {
               this.log(2,"    La caracteristique " + upgradableStat.keyword + " ne semble pas exister dans ce build");
               return true;
            }
            if(buildCaracteristicsByKeyword[upgradableStat.keyword].base != caracBase)
            {
               this.log(2,"    La valeur de base de la caracteristique " + upgradableStat.keyword + " est " + buildCaracteristicsByKeyword[upgradableStat.keyword].base + " dans le build, " + caracBase + " dans l\'inventaire");
               return true;
            }
         }
         this.log(2,"   Identique !");
         return false;
      }
      
      private function equipBuild(buildId:int = -1) : void
      {
         if(buildId == -1)
         {
            buildId = this._currentBuild.id;
         }
         this.sysApi.sendAction(new PresetUseRequestAction([buildId]));
      }
      
      private function deleteBuild() : void
      {
         this.sysApi.sendAction(new PresetDeleteRequestAction([this._currentBuild.id]));
      }
      
      private function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         return false;
      }
      
      private function processDrop(target:Object, data:Object, source:Object) : void
      {
      }
      
      private function removeDropSourceFunction(target:Object) : void
      {
      }
      
      private function disableUiOnPopup(disable:Boolean) : void
      {
         this.tx_mask.visible = disable;
      }
      
      public function onSelectItem(target:Grid, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != GridItemSelectMethodEnum.MANUAL)
         {
            this.ctr_buildIcons.visible = false;
         }
         if(target == this.gd_caracAdvanced)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO && target.selectedItem.isCategory)
            {
               this.displayCategories(target.selectedItem);
            }
         }
         else if(target == this.gd_buildIcons)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO)
            {
               this.choseABuildIcon(target.selectedItem.id);
            }
         }
         else if(target == this.gd_builds)
         {
            if(selectMethod == GridItemSelectMethodEnum.AUTO)
            {
               return;
            }
            if(target.selectedItem is BuildWrapper)
            {
               if(this._currentUiState == MODIFY_STATE && this._currentBuild && this._currentBuildHasChanged)
               {
                  this._waitingBuild = target.selectedItem;
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.build.warningSaveNew",this._currentBuild.buildName,this._currentBuild.buildName),[this.uiApi.getText("ui.common.save"),this.uiApi.getText("ui.common.new"),this.uiApi.getText("ui.common.ignore")],[this.onPopupSave,this.onPopupNew,this.onPopupDisplay],null,this.onPopupDisplay,null,false,false,true,null,this.uiApi.me().strata);
                  this.disableUiOnPopup(true);
               }
               else
               {
                  this.displayBuild(target.selectedItem);
               }
            }
            else if(selectMethod == GridItemSelectMethodEnum.MANUAL)
            {
               if(this._currentUiState == MODIFY_STATE && this._currentBuild && this._currentBuildHasChanged)
               {
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.build.warningSave",this._currentBuild.buildName),[this.uiApi.getText("ui.common.save"),this.uiApi.getText("ui.common.ignore")],[this.onPopupSave,this.onPopupNew],null,this.onPopupNew,null,false,false,true,null,this.uiApi.me().strata);
                  this.disableUiOnPopup(true);
               }
               else
               {
                  this.displayNewBuild();
               }
            }
            else
            {
               this.gd_builds.selectedIndex = this._firstFreeIndex;
            }
         }
      }
      
      public function onItemRightClick(target:Grid, item:GridItem) : void
      {
         var menu:Array = null;
         if(!item.data.isCategory)
         {
            menu = [];
            if(this._favStatCategoryIds.indexOf(item.data.numId) == -1)
            {
               menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.zaap.addFavoritTooltip"),this.updateFavCatArray,[item.data.numId,false]));
            }
            else
            {
               menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.zaap.deleteFavoritTooltip"),this.updateFavCatArray,[item.data.numId,true]));
            }
            this.modContextMenu.createContextMenu(menu);
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var text:String = null;
         var pos:Object = null;
         if(item.data && target.name.indexOf("gd_builds") != -1)
         {
            pos = {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
            if(item.data is BuildWrapper)
            {
               text = item.data.buildName;
               if(this.sysApi.getPlayerManager().hasRights)
               {
                  text += " (" + item.data.id + ")";
               }
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),item.container,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var forgettableSpellsUiContainer:UiRootContainer = null;
         var isRoleplayOrPrefight:Boolean = false;
         var slotData:* = undefined;
         var id:int = 0;
         var superTypesForThisSlot:Array = null;
         var allItemsOfTheRightSuperType:Vector.<ItemWrapper> = null;
         var i:int = 0;
         var itemsCount:int = 0;
         var superType:int = 0;
         var inventoryItems:Vector.<ItemWrapper> = null;
         var positions:Array = null;
         var spellWrapper:SpellWrapper = null;
         var selectionAllowed:Boolean = false;
         var spellVariants:Array = null;
         var variantAvailableCount:int = 0;
         var itsTheRightVariantsList:Boolean = false;
         var sw:SpellWrapper = null;
         var buildIconVisible:Boolean = this.ctr_buildIcons.visible;
         this.ctr_buildIcons.visible = false;
         switch(target)
         {
            case this.btn_close:
               if(this.uiApi.getUi("statBoost"))
               {
                  this.uiApi.unloadUi("statBoost");
               }
               if(this._currentUiState == MODIFY_STATE && this._currentBuild && this._currentBuildHasChanged)
               {
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.build.warningSave",this._currentBuild.buildName),[this.uiApi.getText("ui.common.save"),this.uiApi.getText("ui.common.ignore")],[this.onPopupSave,this.onPopupCloseUi],null,this.onPopupCloseUi,null,false,false,true,null,this.uiApi.me().strata);
                  this.disableUiOnPopup(true);
               }
               else
               {
                  this.onPopupCloseUi();
               }
               break;
            case this.btn_regular:
               if(this._statCurrentTab != STAT_REGULAR_TAB)
               {
                  this._statCurrentTab = STAT_REGULAR_TAB;
                  this.displaySelectedTab(this._statCurrentTab);
               }
               break;
            case this.btn_advanced:
               if(this._statCurrentTab != STAT_ADVANCED_TAB)
               {
                  this._statCurrentTab = STAT_ADVANCED_TAB;
                  this.displaySelectedTab(this._statCurrentTab);
               }
               break;
            case this.btn_reset:
               if(this._currentUiState == MODIFY_STATE)
               {
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.charaSheet.resetStatsConfirm"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupSendRestat,this.onPopupClose],this.onPopupSendRestat,this.onPopupClose,null,false,false,true,null,this.uiApi.me().strata);
                  this.disableUiOnPopup(true);
               }
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_leftArrow:
               this.wheelChara(-1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(1);
               break;
            case this.ctr_editBuildIcon:
            case this.tx_buildIcon:
               this.gd_buildIcons.selectedIndex = this._currentSelectedBuildIconIndex;
               this.ctr_buildIcons.visible = !buildIconVisible;
               break;
            case this.ctr_plusBuild:
               this.gd_builds.selectedIndex = this._firstFreeIndex;
               break;
            case this.btn_equipBuild:
               this.equipBuild(this._currentBuild.id);
               break;
            case this.btn_resetBuild:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.build.warningReset"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.equipBuild,this.onPopupClose],this.equipBuild,this.onPopupClose,null,false,false,true,null,this.uiApi.me().strata);
               this.disableUiOnPopup(true);
               break;
            case this.btn_deleteBuild:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.build.warningDelete"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.deleteBuild,this.onPopupClose],this.deleteBuild,this.onPopupClose,null,false,false,true,null,this.uiApi.me().strata);
               this.disableUiOnPopup(true);
               break;
            case this.btn_saveBuild:
               this.onPopupSave();
               break;
            case this.lbl_manageSpellSets:
               forgettableSpellsUiContainer = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_UI);
               if(!forgettableSpellsUiContainer)
               {
                  this.sysApi.sendAction(new OpenForgettableSpellsUiAction([true]));
               }
               else if(!this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SETS_UI))
               {
                  forgettableSpellsUiContainer.uiClass.getSpellSets();
               }
               break;
            default:
               if(this._currentUiState == MODIFY_STATE)
               {
                  isRoleplayOrPrefight = !this.playerApi.isInFight() || this.playerApi.isInPreFight();
                  if(target.name.indexOf("btn_plus") != -1 && isRoleplayOrPrefight)
                  {
                     if(!this.uiApi.getUi("statBoost"))
                     {
                        this.uiApi.loadUi("statBoost","statBoost",[this._componentList[target.name].keyword,this._componentList[target.name].numId,this._someStatsMayBeScrolled,true],this.uiApi.me().strata);
                     }
                     else if(this._componentList[target.name] && this.uiApi.getUi("statBoost").uiClass.statId != this._componentList[target.name].numId)
                     {
                        this.uiApi.getUi("statBoost").uiClass.displayUI(this._componentList[target.name].keyword,this._componentList[target.name].numId,this._someStatsMayBeScrolled,true);
                     }
                  }
                  else if(target.name.indexOf("slot_") == 0)
                  {
                     slotData = (target as Slot).data;
                     id = int(target.name.split("slot_")[1]);
                     this._equipmentPositionClicked = id;
                     superTypesForThisSlot = this.storageApi.serverPositionsToItemSuperType(id);
                     allItemsOfTheRightSuperType = new Vector.<ItemWrapper>();
                     this._equippedItemClicked = -1;
                     if(slotData && slotData is ItemWrapper)
                     {
                        this._equippedItemClicked = (slotData as ItemWrapper).objectUID;
                     }
                     i = 0;
                     for each(superType in superTypesForThisSlot)
                     {
                        inventoryItems = this.storageApi.getInventoryItemsForSuperType(superType);
                        itemsCount = inventoryItems.length;
                        for(i = 0; i < itemsCount; i++)
                        {
                           positions = this.storageApi.itemTypeToServerPosition(inventoryItems[i].type.id);
                           if(!(positions && positions.length > 0 && positions.indexOf(id) === -1))
                           {
                              allItemsOfTheRightSuperType.push(inventoryItems[i]);
                           }
                        }
                     }
                     if(allItemsOfTheRightSuperType.length > 0)
                     {
                        this.uiApi.hideTooltip();
                        this.sysApi.dispatchHook(HookList.OpenItemsList,this._equippedItemClicked,allItemsOfTheRightSuperType,this.uiApi.getText("ui.common.equip"),this.equipObject);
                     }
                  }
                  else if(target.name.indexOf("btn_spell") != -1 || target.name.indexOf("slot_icon") != -1)
                  {
                     spellWrapper = this._componentList[target.name];
                     if(spellWrapper == null)
                     {
                        return;
                     }
                     if(spellWrapper.spellLevelInfos.minPlayerLevel > this._characterLevel)
                     {
                        return;
                     }
                     selectionAllowed = false;
                     for each(spellVariants in this.gd_spell.dataProvider)
                     {
                        if(!(!spellVariants || spellVariants.length <= 1))
                        {
                           variantAvailableCount = 0;
                           itsTheRightVariantsList = false;
                           for each(sw in spellVariants)
                           {
                              if(sw.id == spellWrapper.id)
                              {
                                 itsTheRightVariantsList = true;
                              }
                              if(sw.spellLevelInfos.minPlayerLevel <= this._characterLevel)
                              {
                                 variantAvailableCount++;
                              }
                           }
                           if(itsTheRightVariantsList)
                           {
                              if(variantAvailableCount > 1)
                              {
                                 selectionAllowed = true;
                              }
                              break;
                           }
                        }
                     }
                     if(selectionAllowed)
                     {
                        this.sysApi.sendAction(new SpellVariantActivationRequestAction([spellWrapper.id]));
                     }
                  }
               }
               if(target.name.indexOf("slot_") == -1)
               {
                  this.uiApi.unloadUi("itemsList");
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var data:* = undefined;
         var params:* = undefined;
         var settings:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var setting:String = null;
         var objVariables:Vector.<String> = null;
         var globalPosition:* = undefined;
         var spellWrapper:SpellWrapper = null;
         var statPoints:Number = NaN;
         var additionalPoints:Number = NaN;
         var favText:String = null;
         var description:String = null;
         var isRoleplayOrPrefight:Boolean = false;
         if(target is Slot && (target as Slot).data)
         {
            if((target as Slot).data is MountWrapper)
            {
               this.uiApi.showTooltip((target as Slot).data,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,{
                  "noBg":false,
                  "uiName":this.uiApi.me().name
               },"ItemInfo");
               return;
            }
            settings = {};
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(itemTooltipSettings == null)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each(setting in objVariables)
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            globalPosition = target["localToGlobal"](new Point(0,0));
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",globalPosition.x > 500 ? uint(LocationEnum.POINT_TOPRIGHT) : uint(LocationEnum.POINT_TOPLEFT),globalPosition.x > 500 ? uint(LocationEnum.POINT_TOPLEFT) : uint(LocationEnum.POINT_TOPRIGHT),20,null,null,settings);
            return;
         }
         if(target.name.indexOf("btn_spell") != -1 || target.name.indexOf("slot_icon") != -1)
         {
            spellWrapper = this._componentList[target.name];
            if(spellWrapper == null)
            {
               return;
            }
            this.uiApi.showTooltip(spellWrapper,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{
               "footer":true,
               "footerText":this.uiApi.getText("ui.tooltip.pin") + " (Alt)"
            });
            return;
         }
         switch(target)
         {
            case this.ctr_pointsToDivide:
               statPoints = this._characterStats.getStatBaseValue(StatIds.STATS_POINTS);
               additionalPoints = this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS);
               if(this._someStatsMayBeScrolled && additionalPoints > 0)
               {
                  text = this.uiApi.getText("ui.common.base") + " (" + this.uiApi.getText("ui.charaSheet.natural") + " + " + this.uiApi.getText("ui.charaSheet.additionnal") + ")" + this.uiApi.getText("ui.common.colon") + statPoints + "+" + additionalPoints;
               }
               break;
            case this.btn_reset:
               text = this.uiApi.getText("ui.charaSheet.resetStats");
               break;
            case this.tx_lockBuild:
               text = this.uiApi.getText("ui.build.modeReadOnly");
               break;
            case this.tx_unlockBuild:
               text = this.uiApi.getText("ui.build.modeModify");
               break;
            case this.ctr_plusBuild:
               text = this.uiApi.getText("ui.build.showCharacter");
               break;
            case this.btn_deleteBuild:
               text = this.uiApi.getText("ui.popup.delete");
               break;
            case this.btn_resetBuild:
               text = this.uiApi.getText("ui.build.reset");
               break;
            case this.ctr_editBuildIcon:
               text = this.uiApi.getText("ui.build.choseIcon");
               break;
            default:
               if(target.name.indexOf("lbl_name") != -1)
               {
                  favText = "";
                  data = this._componentList[target.name];
                  if(this._favStatCategoryIds.indexOf(data.numId) == -1)
                  {
                     favText = this.uiApi.getText("ui.charaSheet.rightClickToAdd");
                  }
                  else
                  {
                     favText = this.uiApi.getText("ui.charaSheet.rightClickToRemove");
                  }
                  if(this.ctr_advanced.visible)
                  {
                     text = null;
                     description = this.uiApi.getText("ui.help." + this._componentList[target.name].keyword);
                     if(description.indexOf("[UNKNOWN_TEXT_NAME") != -1)
                     {
                        text = favText;
                     }
                     else
                     {
                        params = {
                           "content":this.uiApi.getText("ui.help." + this._componentList[target.name].keyword),
                           "additionalInfo":favText,
                           "maxWidth":400,
                           "addInfoCssClass":"italiclightgrey"
                        };
                        this.uiApi.showTooltip(params,target,false,"standard",5,3,3,"textInfoWithHorizontalSeparator",null,null);
                     }
                  }
               }
               else if(target.name.indexOf("lbl_value") != -1)
               {
                  if(this.ctr_advanced.visible)
                  {
                     text = null;
                     params = {
                        "content":this.getParsedStat(this._componentList[target.name],true),
                        "additionalInfo":this.uiApi.getText("ui.common.total") + this.uiApi.getText("ui.common.colon") + (target as Label).text,
                        "maxWidth":100
                     };
                     this.uiApi.showTooltip(params,target,false,"standard",6,2,3,"textInfoWithHorizontalSeparator",null,null);
                  }
                  else
                  {
                     text = this.getParsedStat(this._componentList[target.name]);
                  }
               }
               else if(target.name.indexOf("lbl_base") != -1)
               {
                  data = this._componentList[target.name];
                  if(data && !data.isCategory && data.hasOwnProperty("upgradable") && data.upgradable && data.hasOwnProperty("base") && (data.base > 0 || data.additionnal > 0))
                  {
                     text = "" + data.base + " + " + data.additionnal;
                  }
               }
               else if(target.name.indexOf("lbl_bonus") != -1)
               {
                  data = this._componentList[target.name];
                  if(data && !data.isCategory && data.hasOwnProperty("boost") && data.boost > 0)
                  {
                     text = "" + data.stuff + " + " + data.boost;
                  }
               }
               else if(target.name.indexOf("btn_plus") != -1)
               {
                  isRoleplayOrPrefight = !this.playerApi.isInFight() || this.playerApi.isInPreFight();
                  if(!isRoleplayOrPrefight)
                  {
                     text = this.uiApi.getText("ui.charaSheet.caracBoostNoFight");
                  }
                  else if(target.softDisabled)
                  {
                     text = this.uiApi.getText("ui.charaSheet.notEnoughtPoints");
                  }
                  else
                  {
                     switch(this._componentList[target.name].numId)
                     {
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_VITALITY:
                           text = this.uiApi.getText("ui.stats.modifyVitalityPoints");
                           break;
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_WISDOM:
                           text = this.uiApi.getText("ui.stats.modifyWisdomPoints");
                           break;
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_STRENGTH:
                           text = this.uiApi.getText("ui.stats.modifyStrengthPoints");
                           break;
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE:
                           text = this.uiApi.getText("ui.stats.modifyIntelligencePoints");
                           break;
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_CHANCE:
                           text = this.uiApi.getText("ui.stats.modifyChancePoints");
                           break;
                        case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_AGILITY:
                           text = this.uiApi.getText("ui.stats.modifyAgilityPoints");
                     }
                  }
               }
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"textWithSeparator");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.hideTooltip("statboostTooltip");
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         var position:uint = 0;
         if(target is Slot && !(target as Slot).softDisabled && (target as Slot).data && !this._delayDoubleClickTimer.running)
         {
            this.uiApi.unloadUi("itemsList");
            this.blockDragDropOnSlot(target as Slot);
            position = parseInt(target.name.split("slot_")[1]);
            if(position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && (target as Slot).data.objectUID == 0 && (target as Slot).data.hasOwnProperty("mountId"))
            {
               this.sysApi.sendAction(new MountToggleRidingRequestAction([]));
            }
            else
            {
               this.sysApi.sendAction(new ObjectSetPositionAction([(target as Slot).data.objectUID,63,1]));
            }
         }
      }
      
      private function blockDragDropOnSlot(slot:Slot) : void
      {
         this._slotClickedNoDragAllowed = slot;
         if(this._slotClickedNoDragAllowed != null)
         {
            this._slotClickedNoDragAllowed.allowDrag = false;
            this._delayDoubleClickTimer.start();
         }
      }
      
      private function onDelayDoubleClickTimer(pEvt:TimerEvent) : void
      {
         this._delayDoubleClickTimer.stop();
         if(this._slotClickedNoDragAllowed != null)
         {
            this._slotClickedNoDragAllowed.allowDrag = true;
            this._slotClickedNoDragAllowed = null;
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target is Slot && (target as Slot).data)
         {
            data = (target as Slot).data;
            if(data is MountWrapper)
            {
               contextMenu = this.menuApi.create(data,"mount");
            }
            else
            {
               contextMenu = this.menuApi.create(data,"item",[{"ownedItem":true}]);
            }
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_buildName.haveFocus && this._currentBuild)
         {
            this._currentBuildNameHasChanged = this.inp_buildName.text != this._currentBuild.buildName;
            this.updateButtons();
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         var text:String = null;
         if(s == "closeUi")
         {
            if(this.uiApi.getUi("statBoost"))
            {
               this.uiApi.unloadUi("statBoost");
            }
            else if(this._currentUiState == MODIFY_STATE && this._currentBuild && this._currentBuildHasChanged)
            {
               text = this.uiApi.getText("ui.build.warningSave",this._currentBuild.buildName);
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.save"),this.uiApi.getText("ui.common.ignore")],[this.onPopupSave,this.onPopupCloseUi],null,this.onPopupCloseUi,null,false,false,true,null,this.uiApi.me().strata);
               this.disableUiOnPopup(true);
            }
            else
            {
               this.onPopupCloseUi();
            }
            return true;
         }
         return false;
      }
      
      public function onPopupClose() : void
      {
         this.disableUiOnPopup(false);
      }
      
      public function onPopupSendRestat() : void
      {
         this.onPopupClose();
         this.sysApi.sendAction(new ResetCharacterStatsRequestAction([]));
      }
      
      public function onPopupSave() : void
      {
         this.inp_buildName.text = this.sysApi.trimString(this.inp_buildName.text);
         if(!this.verifyName())
         {
            return;
         }
         this.onPopupClose();
         var name:String = this.inp_buildName.text;
         var saveCharacterCurrentState:Boolean = false;
         if(!this._currentBuild || this._currentBuildHasChanged)
         {
            saveCharacterCurrentState = true;
         }
         var buildId:int = -1;
         if(this._currentBuild)
         {
            buildId = this._currentBuild.id;
         }
         this.log(2," Demande de sauvegarde " + buildId + ", " + this._currentBuildIconId + ", " + name + ", " + saveCharacterCurrentState);
         this.sysApi.sendAction(new CharacterPresetSaveRequestAction([buildId,this._currentBuildIconId,name,saveCharacterCurrentState,SavablePresetTypeEnum.CHARACTER_BUILD]));
      }
      
      public function onPopupNew() : void
      {
         this.onPopupClose();
         this.displayNewBuild();
         this.gd_builds.selectedIndex = this._firstFreeIndex;
      }
      
      public function onPopupDisplay() : void
      {
         this.onPopupClose();
         this.displayBuild(this._waitingBuild);
         this._waitingBuild = null;
      }
      
      public function onPopupCloseUi() : void
      {
         this.onPopupClose();
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void
      {
         if(oneLifePointRegenOnly)
         {
            return;
         }
         this._characterCharacteristics = this.playerApi.characteristics();
         this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         this.updateStats();
         this.gd_spell.updateItems();
         if(this._currentUiState == MODIFY_STATE)
         {
            this.updateSpells();
         }
         this.updateButtons();
      }
      
      public function onFightEvent(eventName:String, params:Object, targetList:Object = null) : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         var num:int = targetList.length;
         for(var i:int = 0; i < num; i++)
         {
            if(targetList[i] != this.playerApi.id())
            {
               continue;
            }
            switch(eventName)
            {
               case FightEventEnum.FIGHTER_LIFE_GAIN:
               case FightEventEnum.FIGHTER_LIFE_LOSS:
               case FightEventEnum.FIGHTER_TEMPORARY_BOOSTED:
               case FightEventEnum.FIGHTER_AP_USED:
               case FightEventEnum.FIGHTER_AP_LOST:
               case FightEventEnum.FIGHTER_AP_GAINED:
               case FightEventEnum.FIGHTER_MP_USED:
               case FightEventEnum.FIGHTER_MP_LOST:
               case FightEventEnum.FIGHTER_MP_GAINED:
                  this._characterCharacteristics = this.playerApi.characteristics();
                  this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
                  this.updateStats();
                  this.updateButtons();
                  break;
            }
         }
      }
      
      private function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         this.gridsUpdate();
      }
      
      public function onSpellsList(spellList:Object) : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         this.updateSpells();
         this.updateButtons();
      }
      
      private function onSpellVariantActivated(activatedSpellId:uint, deactivatedSpellId:uint) : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         this.log(2,"Activation de " + activatedSpellId + "    (précédent " + deactivatedSpellId + ")");
         this.updateSpells();
         this.updateButtons();
      }
      
      private function updateLook(look:Object) : void
      {
         if(this._currentUiState == -1)
         {
            return;
         }
         if(this._currentUiState == MODIFY_STATE)
         {
            look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id);
         }
         else
         {
            look = this._currentBuild.characterLook;
         }
         this.entityDisplayer.look = look;
      }
      
      private function onCharacterLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array) : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         this._characterLevel = pNewLevel;
         this.onSpellsList(null);
         this.updateButtons();
      }
      
      public function onEquipmentObjectMove(pItemWrapper:ItemWrapper, oldPosition:int) : void
      {
         var isItemDelinked:Boolean = false;
         var item:ItemWrapper = null;
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         if(oldPosition != -1 && (!this._equipmentSlots[oldPosition] || !this._equipmentSlots[oldPosition].data))
         {
            return;
         }
         if(oldPosition != -1 && this._availableEquipmentPositions.indexOf(oldPosition) != -1 && (!pItemWrapper || !this._equipmentSlots[oldPosition].data || pItemWrapper.objectUID == this._equipmentSlots[oldPosition].data.objectUID))
         {
            isItemDelinked = false;
            if(!pItemWrapper && this._currentBuild)
            {
               for each(item in this._currentBuild.equipment)
               {
                  if(item && item.position == oldPosition && item.objectUID == 0)
                  {
                     this._characterEquipmentItemsByPos[item.position] = item;
                     this._equipmentSlots[oldPosition].data = item;
                     isItemDelinked = true;
                  }
               }
            }
            if(!isItemDelinked)
            {
               this._equipmentSlots[oldPosition].data = null;
               this._characterEquipmentItemsByPos[oldPosition] = null;
            }
         }
         if(!pItemWrapper || this._availableEquipmentPositions.indexOf(pItemWrapper.position) == -1)
         {
            return;
         }
         if(pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && this.playerApi.isRidding())
         {
            this._equipmentSlots[pItemWrapper.position].data = this.storageApi.getFakeItemMount();
            this._characterEquipmentItemsByPos[pItemWrapper.position] = this.storageApi.getFakeItemMount();
         }
         else
         {
            this._equipmentSlots[pItemWrapper.position].data = pItemWrapper;
            this._characterEquipmentItemsByPos[pItemWrapper.position] = pItemWrapper;
         }
         if(pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && this.slot_8.data.objectUID == pItemWrapper.objectUID && !pItemWrapper.linked && pItemWrapper.forcedBackGroundIconUri && pItemWrapper.forcedBackGroundIconUri.fileName.indexOf("linkedSlot") != -1)
         {
            pItemWrapper.forcedBackGroundIconUri = null;
            this.slot_8.refresh();
         }
         this.updateSpells();
         this.updateButtons();
      }
      
      public function onObjectModified(item:ItemWrapper) : void
      {
         var slot:Slot = null;
         var pos:uint = 0;
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         if(this._availableEquipmentPositions.indexOf(item.position) != -1)
         {
            this._characterEquipmentItemsByPos[item.position] = item;
            for each(slot in this._equipmentSlots)
            {
               pos = parseInt(slot.name.split("_")[1]);
               slot.data = this._characterEquipmentItemsByPos[pos];
            }
         }
      }
      
      public function onMountRiding(isRidding:Boolean) : void
      {
         var mount:MountWrapper = null;
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         if(isRidding)
         {
            mount = this.storageApi.getFakeItemMount();
            this._equipmentSlots[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
            this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
         }
         else
         {
            this._equipmentSlots[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = null;
            this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = null;
         }
         this.updateButtons();
      }
      
      public function onMountSet() : void
      {
         if(this._currentUiState != MODIFY_STATE)
         {
            return;
         }
         var mount:MountWrapper = this.storageApi.getFakeItemMount();
         this._equipmentSlots[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
         this._characterEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
      }
      
      public function onPresetsUpdate(buildId:int = -1) : void
      {
         var buildOrEmptyTexture:Object = null;
         var currentBuildIndex:int = 0;
         var buildCount:int = 0;
         var buildWrapper:BuildWrapper = null;
         var newBuild:BuildWrapper = null;
         var buildsLogs:* = "Mise à jour de la liste des presets  ou uniquement du preset " + buildId;
         var builds:Array = this.inventoryApi.getBuilds();
         var index:int = 0;
         if(buildId == -1)
         {
            this._builds = [];
            this._firstFreeIndex = -1;
            currentBuildIndex = -1;
            buildCount = 0;
            this._currentBuildHasChanged = false;
            for each(buildOrEmptyTexture in builds)
            {
               this._builds.push(buildOrEmptyTexture);
               if(buildOrEmptyTexture is BuildWrapper)
               {
                  buildWrapper = buildOrEmptyTexture as BuildWrapper;
                  buildCount++;
                  buildsLogs += "\n  - " + buildWrapper.id + " " + buildWrapper.buildName + " " + buildWrapper.gfxId;
                  if(this._currentBuild != null && buildWrapper.id == this._currentBuild.id)
                  {
                     currentBuildIndex = index;
                     buildsLogs += "\n      selection du " + index + " precedemment selectionné ";
                  }
               }
               else
               {
                  buildsLogs += "\n  - (vide)";
                  if(this._firstFreeIndex == -1)
                  {
                     this._firstFreeIndex = index;
                     buildsLogs += "\n      selection du " + index + " premier index vide ";
                  }
               }
               index++;
            }
            this.gd_builds.dataProvider = this._builds;
            if(currentBuildIndex > -1)
            {
               this.gd_builds.selectedIndex = currentBuildIndex;
            }
            else
            {
               this.gd_builds.selectedIndex = this._firstFreeIndex;
            }
            if(buildCount == ProtocolConstantsEnum.MAX_PRESET_COUNT)
            {
               this.ctr_plusBuild.visible = false;
            }
            else
            {
               this.ctr_plusBuild.visible = true;
               this.ctr_plusBuild.xNoCache = this.gd_builds.slots[this._firstFreeIndex].x + this.gd_builds.x;
               this.ctr_plusBuild.yNoCache = this.gd_builds.slots[this._firstFreeIndex].y + this.gd_builds.y;
            }
         }
         else
         {
            for each(buildOrEmptyTexture in builds)
            {
               if(buildOrEmptyTexture && buildOrEmptyTexture.id == buildId)
               {
                  newBuild = buildOrEmptyTexture as BuildWrapper;
                  break;
               }
            }
            for(index = 0; index < this._builds.length; index++)
            {
               if(this._builds[index] && this._builds[index].id == buildId)
               {
                  this._builds[index] = newBuild;
                  this.gd_builds.dataProvider[index] = newBuild;
                  this.gd_builds.updateItem(index);
                  if(this._currentBuild && this._currentBuild.id == newBuild.id)
                  {
                     this.displayBuild(this._currentBuild);
                  }
                  break;
               }
            }
         }
         this.log(2,buildsLogs);
         this.disableUiOnPopup(false);
      }
      
      public function onPresetSelected(selectedBuildId:int) : void
      {
         var buildOrEmptyTexture:Object = null;
         var index:int = 0;
         var selectedBuildIndex:int = -1;
         for each(buildOrEmptyTexture in this._builds)
         {
            if(buildOrEmptyTexture is BuildWrapper)
            {
               if((buildOrEmptyTexture as BuildWrapper).id == selectedBuildId)
               {
                  selectedBuildIndex = index;
                  this.log(2,"      selection du " + index + " sur demande express ");
               }
            }
            index++;
         }
         if(selectedBuildIndex > -1)
         {
            this.gd_builds.selectedIndex = selectedBuildIndex;
         }
      }
      
      public function onPresetUsed(buildId:int) : void
      {
         var buildOrEmptyTexture:Object = null;
         var index:int = 0;
         var usedBuildIndex:int = 0;
         this.log(2,"Preset " + buildId + " équipé");
         this._currentBuildUsed = this._currentBuild;
         if(!this._currentBuild || buildId != this._currentBuild.id)
         {
            index = 0;
            usedBuildIndex = -1;
            for each(buildOrEmptyTexture in this._builds)
            {
               if(buildOrEmptyTexture is BuildWrapper && (buildOrEmptyTexture as BuildWrapper).id == buildId)
               {
                  usedBuildIndex = index;
               }
               index++;
            }
            this.gd_builds.selectedIndex = usedBuildIndex;
         }
         else
         {
            this.switchToUiState(MODIFY_STATE);
            this.updateButtons();
            this.previewSpellBar();
            this.updateStatsResetButton();
         }
         this.disableUiOnPopup(false);
      }
      
      public function onPresetError(reason:String) : void
      {
         var text:String = null;
         switch(reason)
         {
            case "unknownSave":
            case "unknownDelete":
               text = this.uiApi.getText("ui.common.unknownFail");
               break;
            case "badId":
               text = this.uiApi.getText("ui.preset.error.5");
               break;
            case "inactive":
               text = this.uiApi.getText("ui.preset.error.inactive");
               break;
            case "tooMany":
               text = this.uiApi.getText("ui.preset.error.tooMany");
               break;
            case "invalidPlayerState":
               text = this.uiApi.getText("ui.preset.error.invalidPlayerState");
         }
         this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),text,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose],this.onPopupClose,this.onPopupClose,null,false,false,true,null,this.uiApi.me().strata);
         this.disableUiOnPopup(true);
      }
      
      protected function onShortcutBarViewContent(barType:int) : void
      {
         if(barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
         {
            this.updateButtons();
         }
      }
      
      private function onGameFightStart() : void
      {
         this.inventoryApi.setBuildId(-1);
         this.sysApi.dispatchHook(CustomUiHookList.PreviewBuildSpellBar,this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR),false);
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function log(level:uint, message:String) : void
      {
         if(this.sysApi.getBuildType() > BuildTypeEnum.RELEASE)
         {
            this.sysApi.log(level,message);
         }
      }
   }
}

class CharacteristicGridItem
{
    
   
   public var id:int = 0;
   
   public var keyword:String;
   
   public var name:String;
   
   public var gfxId:String;
   
   public var numId:int;
   
   public var upgradable:Boolean;
   
   public var categoryId:int;
   
   public var base:uint = 0;
   
   public var additionnal:uint = 0;
   
   public var stuff:int = 0;
   
   public var boost:int = 0;
   
   public var isCategory:Boolean = false;
   
   function CharacteristicGridItem(id:int, keyword:String, name:String, gfxId:String = "", numId:int = -1, upgradable:Boolean = false, categoryId:int = -1)
   {
      super();
      this.id = id;
      this.keyword = keyword;
      this.name = name;
      this.gfxId = gfxId;
      this.numId = numId;
      this.upgradable = upgradable;
      this.categoryId = categoryId;
   }
   
   public function clone() : CharacteristicGridItem
   {
      var gridItem:CharacteristicGridItem = new CharacteristicGridItem(this.id,this.keyword,this.name,this.gfxId,this.numId,this.upgradable,this.categoryId);
      gridItem.base = this.base;
      gridItem.additionnal = this.additionnal;
      gridItem.stuff = this.stuff;
      gridItem.boost = this.boost;
      gridItem.isCategory = this.isCategory;
      return gridItem;
   }
}
