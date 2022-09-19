package Ankama_Grimoire.ui.optionalFeatures
{
   import Ankama_Cartography.Cartography;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.Grimoire;
   import Ankama_Grimoire.enum.EnumTab;
   import Ankama_Grimoire.ui.*;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.optionalFeatures.CustomModeBreedSpell;
   import com.ankamagames.dofus.datacenter.optionalFeatures.ForgettableSpell;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.ForgettableSpellClientAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.ForgettableSpellClientActionEnum;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ForgettableSpellItem;
   import com.ankamagames.dofus.network.types.game.presets.SpellForPreset;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import mapTools.Point;
   
   public class ForgettableSpellsUi
   {
      
      public static const MAX_ACTIVE_SPELLS_PAGES:uint = 5;
      
      public static const ACTIVE_SPELLS_BY_PAGE_NUMBER:uint = 20;
      
      public static const TOOLTIP_UI_NAME:String = "ForgettableSpellsUITooltip";
      
      public static const SPELL_TOOLTIP_UI_NAME:String = "spellBanner";
      
      private static const OBTAINING_ICONS_MAP:Object = {
         "spellIsDroppable":"icon_monster",
         "spellIsCraftable":"icon_hammer",
         "spellIsInQuest":"icon_exclamation",
         "spellIsUnknown":"icon_interrogation"
      };
      
      private static const BTN_HELP_OFFSET:int = -30;
      
      private static const STORAGE_MIN_SPELL_LEVEL_FILTER:String = "forgettableSpellsUiMinSpellLevelFilter";
      
      private static const STORAGE_MAX_SPELL_LEVEL_FILTER:String = "forgettableSpellsUiMaxSpellLevelFilter";
      
      private static const STORAGE_LEARNED_SPELLS_LEVEL_FILTER:String = "forgettableSpellsUiLearnedSpellsLevelFilter";
      
      private static const STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE:String = "forgettableSpellsUiIsSpellNameSortAscendingType";
      
      private static const STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE:String = "forgettableSpellsUiIsSpellLevelSortAscendingType";
      
      private static const STORAGE_SPELL_SORT:String = "forgettableSpellsUiSpellSort";
      
      private static const STORAGE_IS_FIRST_TIME:String = "forgettableSpellsUiIsFirstTime";
      
      private static const STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE:String = "forgettableSpellsUiHasCommonSpellsTabBeenOpenedOnce";
      
      private static const FORGETTABLE_SPELLS_TAB_NAME:String = "btn_forgettableSpells";
      
      private static const COMMON_SPELLS_TAB_NAME:String = "btn_commonSpells";
      
      private static const FINISH_MOVES_TAB_NAME:String = "btn_finishMoves";
      
      private static const FINISH_MOVES_UI_NAME:String = "ForgettableSpellsUIFinishMoves";
      
      private static const OBTAINING_ICONS_NUMBER:uint = 4;
      
      private static const STORAGE_CONSUMABLES_VIEW:String = "storageConsumables";
      
      private static const DISABLED_SHARE_FORGETTABLE_SPELLS_CONTAINER_ALPHA:Number = 0.2;
      
      private static const MAX_OBTAINING_LEVELS:int = 6;
      
      private static const SCROLL_MAGIC_WORKSHOP_POSITION:Point = new Point(-4,-24);
      
      private static const DEFAULT_MIN_SPELL_LEVEL_FILTER:uint = 0;
      
      private static const DEFAULT_MAX_SPELL_LEVEL_FILTER:uint = 200;
      
      private static const DEFAULT_SPELL_NAME_SORT_TYPE:Boolean = true;
      
      private static const DEFAULT_SPELL_LEVEL_SORT_TYPE:Boolean = true;
      
      private static const SPELL_NAME_SORT_TYPE:String = "sortSpellsByName";
      
      private static const SPELL_LEVEL_SORT_TYPE:String = "sortSpellsByLevel";
      
      private static const DEFAULT_SPELL_SORT:String = SPELL_LEVEL_SORT_TYPE;
      
      private static const LEARNED_SPELLS_FILTER_ALL:uint = 0;
      
      private static const LEARNED_SPELLS_FILTER_LEARNED:uint = 1;
      
      private static const LEARNED_SPELLS_FILTER_UNLEARNED:uint = 2;
      
      private static const DEFAULT_LEARNED_SPELLS_FILTER:uint = LEARNED_SPELLS_FILTER_ALL;
      
      private static const SPELL_FAMILY_FORGETTABLE:String = "forgettableSpell";
      
      private static const SPELL_FAMILY_COMMON:String = "commonSpell";
      
      private static const PASSIVE_SPELL_PRIORITY:int = 0;
      
      private static const ACTIVE_SPELL_PRIORITY:int = 1;
      
      private static const WEAPON_SPELL_PRIORITY:int = 2;
      
      private static const SPECIAL_SPELL_PRIORITY:int = 3;
      
      private static const FROM_ACTIVE_SPELLS:uint = 0;
      
      private static const FROM_FORGETTABLE_SPELLS:uint = 1;
      
      private static const FROM_COMMON_SPELLS:uint = 2;
      
      private static const UNKNOWN_OBTAINING:uint = 1000;
      
      private static const OBTAINING_SPELL_IS_DROPPABLE:String = "spellIsDroppable";
      
      private static const OBTAINING_SPELL_IS_CRAFTABLE:String = "spellIsCraftable";
      
      private static const OBTAINING_SPELL_IS_IN_QUEST:String = "spellIsInQuest";
      
      private static const OBTAINING_SPELL_IS_UNKNOWN:String = "spellIsUnknown";
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playedCharacterApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="SystemApi")]
      public var systemApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Module(name="Ankama_Cartography")]
      public var ankamaCartography:Cartography;
      
      [Module(name="Ankama_ContextMenu")]
      public var ankamaContextMenu:ContextMenu;
      
      protected var _currentTabName:String = null;
      
      private var _currentActiveSpellsIndex:Number = 0;
      
      private var _finishMovesUi:UiRootContainer = null;
      
      private var _cartographyPopup:String;
      
      private var _isFirstTime:Boolean = true;
      
      private var _hasCommonSpellsTabBeenOpenedOnce:Boolean = false;
      
      private var _playerLevel:int;
      
      private var _activeSpellIds:Array;
      
      private var _activeSpells:Array = null;
      
      protected var _forgettableSpells:Array;
      
      protected var _filteredForgettableSpells:Array = null;
      
      protected var _equippedForgettableSpells:Array = null;
      
      protected var _commonSpells:Array;
      
      protected var _filteredCommonSpells:Array = null;
      
      protected var _commonSpellPriorities:Object = null;
      
      private var _obtainingFiltersDescr:Object;
      
      protected var _currentSearchText:String = "";
      
      private var _currentSpellLevelFilterMinLevel:uint = 0;
      
      private var _currentSpellLevelFilterMaxLevel:uint = 200;
      
      private var _isSpellLevelFilterReady:Boolean = true;
      
      private var _searchSpellText:String = null;
      
      protected var _isSearchInputFilled:Boolean = false;
      
      protected var _isSearchInputReady:Boolean = false;
      
      private var _isSpellNameSortAscendingType:Boolean = true;
      
      private var _isSpellLevelSortAscendingType:Boolean = true;
      
      private var _currentLearnedSpellsFilter:uint = 0;
      
      protected var _currentSort:String = "sortSpellsByLevel";
      
      private var _areActiveSpellsAlterable:Boolean = true;
      
      private var _isAltDown:Boolean = false;
      
      private var _hasProcessedDrop:Boolean = false;
      
      protected var _componentsDictionary:Dictionary;
      
      private var _weaponSpellType:String = null;
      
      private var _specialSpellType:String = null;
      
      private var _passiveSpellType:String = null;
      
      private var _activeSpellType:String = null;
      
      protected var _learnedForgettableSpellsCount:uint = 0;
      
      private var _forgettableSpellsCount:uint = 0;
      
      public var btn_help:ButtonContainer;
      
      public var btn_forgettableSpells:ButtonContainer;
      
      public var btn_commonSpells:ButtonContainer;
      
      public var btn_shareForgettableSpells:ButtonContainer;
      
      public var btn_finishMoves:ButtonContainer;
      
      public var btn_previousActiveSpells:ButtonContainer;
      
      public var btn_nextActiveSpells:ButtonContainer;
      
      public var btn_clearSearchText:ButtonContainer;
      
      public var btn_spellIsDroppable:ButtonContainer;
      
      public var btn_spellIsCraftable:ButtonContainer;
      
      public var btn_spellIsUnknown:ButtonContainer;
      
      public var btn_sortForgettableSpellsByName:ButtonContainer;
      
      public var btn_sortCommonSpellsByName:ButtonContainer;
      
      public var btn_sortForgettableSpellsByLevel:ButtonContainer;
      
      public var btn_saveAsASpellSet:ButtonContainer;
      
      public var btn_seeMySpellSets:ButtonContainer;
      
      public var cbx_learningSpellsFilter:ComboBox;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_activeSpellsButtons:GraphicContainer;
      
      public var ctr_forgettableSpells:GraphicContainer;
      
      public var ctr_commonSpells:GraphicContainer;
      
      public var ctr_finishMoves:GraphicContainer;
      
      public var ctr_spellLevelFilter:GraphicContainer;
      
      public var ctr_obtainingFilters:GraphicContainer;
      
      public var ctr_topFilters:GraphicContainer;
      
      public var ctr_shareForgettableSpells:GraphicContainer;
      
      public var inp_spellLevelSearch:Input;
      
      public var inp_minSpellLevel:Input;
      
      public var inp_maxSpellLevel:Input;
      
      public var gd_activeSpells:Grid;
      
      public var gd_forgettableSpells:Grid;
      
      public var gd_commonSpells:Grid;
      
      public var lbl_currentActiveSpellsIndex:Label;
      
      public var lbl_forgettableSpellsNameHeader:Label;
      
      public var lbl_commonSpellsNameHeader:Label;
      
      public var lbl_forgettableSpellsLevelHeader:Label;
      
      public var lbl_commonSpellsLevelHeader:Label;
      
      public var lbl_shareForgettableSpells:Label;
      
      public var lbl_spellLevelFilter:Label;
      
      public var lbl_spellLevelFilterFrom:Label;
      
      public var lbl_spellLevelFilterTo:Label;
      
      public var lbl_forgettableIsSpellEquippedHeader:Label;
      
      public var lbl_learnedSpells:Label;
      
      public var lbl_seeMySpellSets:Label;
      
      public var btn_lbl_btn_saveAsASpellSet:Label;
      
      public var tx_spellIsDroppable:Texture;
      
      public var tx_spellIsCraftable:Texture;
      
      public var tx_spellIsUnknown:Texture;
      
      public var tx_sortForgettableSpellsByNameAscending:Texture;
      
      public var tx_sortForgettableSpellsByNameDescending:Texture;
      
      public var tx_sortCommonSpellsByNameDescending:Texture;
      
      public var tx_sortCommonSpellsByNameAscending:Texture;
      
      public var tx_sortForgettableSpellsByLevelAscending:Texture;
      
      public var tx_sortForgettableSpellsByLevelDescending:Texture;
      
      public var tx_commonSpellsWarning:Texture;
      
      public var tx_shareForgettableSpells:Texture;
      
      public function ForgettableSpellsUi()
      {
         this._activeSpellIds = [];
         this._obtainingFiltersDescr = {};
         this._componentsDictionary = new Dictionary(true);
         super();
      }
      
      public function set currentTabName(currentTabName:String) : void
      {
         this._currentTabName = currentTabName;
         this.updateCurrentTab();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentActiveSpellsIndex(currentActiveSpellsIndex:Number) : void
      {
         this._currentActiveSpellsIndex = currentActiveSpellsIndex % MAX_ACTIVE_SPELLS_PAGES;
         if(this._currentActiveSpellsIndex < 0)
         {
            this._currentActiveSpellsIndex += MAX_ACTIVE_SPELLS_PAGES;
         }
         this.updateCurrentActiveSpells();
      }
      
      private function canForgettableSpellsBeAdded() : Boolean
      {
         var maxForgettableSpellsNumber:int = this.playedCharacterApi.getPlayerMaxForgettableSpellsNumber();
         return maxForgettableSpellsNumber < 0 || this._equippedForgettableSpells.length < maxForgettableSpellsNumber;
      }
      
      protected function set currentFilteredSpells(filteredSpells:Array) : void
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this._filteredForgettableSpells = filteredSpells;
         }
         else if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            this._filteredCommonSpells = filteredSpells;
         }
      }
      
      protected function get currentFilteredSpells() : Array
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            if(this._filteredForgettableSpells === null)
            {
               this._filteredForgettableSpells = this._forgettableSpells.concat();
            }
            return this._filteredForgettableSpells;
         }
         if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            if(this._filteredCommonSpells === null)
            {
               this._filteredCommonSpells = this._commonSpells.concat();
            }
            return this._filteredCommonSpells;
         }
         return null;
      }
      
      protected function set currentSpells(currentSpells:Array) : void
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this._forgettableSpells = currentSpells;
         }
         else if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            this._commonSpells = currentSpells;
         }
      }
      
      protected function get currentSpells() : Array
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            return this._forgettableSpells;
         }
         if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            return this._commonSpells;
         }
         return null;
      }
      
      private function get currentSpellGrid() : Grid
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            return this.gd_forgettableSpells;
         }
         if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            return this.gd_commonSpells;
         }
         return null;
      }
      
      protected function set currentSpellGridDataProvider(dataProvider:Array) : void
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this.beforeForgettableSpellsDataProvider();
         }
         this.currentSpellGrid.dataProvider = dataProvider;
      }
      
      private function get defaultMinSpellLevelFilter() : uint
      {
         var toReturn:Number = Number(this.systemApi.getData(STORAGE_MIN_SPELL_LEVEL_FILTER));
         if(isNaN(toReturn) || toReturn < uint.MIN_VALUE || toReturn > uint.MAX_VALUE)
         {
            return DEFAULT_MIN_SPELL_LEVEL_FILTER;
         }
         return toReturn;
      }
      
      private function get defaultMaxSpellLevelFilter() : uint
      {
         var toReturn:Number = Number(this.systemApi.getData(STORAGE_MAX_SPELL_LEVEL_FILTER));
         if(isNaN(toReturn) || toReturn < uint.MIN_VALUE || toReturn > uint.MAX_VALUE)
         {
            return DEFAULT_MAX_SPELL_LEVEL_FILTER;
         }
         return toReturn;
      }
      
      private function get defaultIsSpellNameSortAscendingType() : Boolean
      {
         var rawValue:* = this.systemApi.getData(STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE);
         if(rawValue === null || !(rawValue is Boolean))
         {
            return DEFAULT_SPELL_NAME_SORT_TYPE;
         }
         return Boolean(rawValue);
      }
      
      private function get defaultIsSpellLevelSortAscendingType() : Boolean
      {
         var rawValue:* = this.systemApi.getData(STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE);
         if(rawValue === null || !(rawValue is Boolean))
         {
            return DEFAULT_SPELL_LEVEL_SORT_TYPE;
         }
         return Boolean(rawValue);
      }
      
      private function get defaultSpellSort() : String
      {
         var spellSort:String = this.systemApi.getData(STORAGE_SPELL_SORT);
         if(spellSort === null)
         {
            return DEFAULT_SPELL_SORT;
         }
         return spellSort;
      }
      
      protected function get defaultLearnedSpellFilter() : uint
      {
         var toReturn:Number = Number(this.systemApi.getData(STORAGE_LEARNED_SPELLS_LEVEL_FILTER));
         if(isNaN(toReturn) || toReturn !== LEARNED_SPELLS_FILTER_ALL && toReturn !== LEARNED_SPELLS_FILTER_LEARNED && toReturn !== LEARNED_SPELLS_FILTER_UNLEARNED)
         {
            return DEFAULT_LEARNED_SPELLS_FILTER;
         }
         return toReturn;
      }
      
      public function main(paramsObject:Object = null) : void
      {
         this.systemApi.addHook(BeriliaHookList.DropEnd,this.onActiveSpellDropEnd);
         this.systemApi.addHook(BeriliaHookList.DropStart,this.onActiveSpellDropStart);
         this.systemApi.addHook(CustomUiHookList.SpellMovementAllowed,this.onAreActiveSpellsAlterable);
         this.systemApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         this.systemApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.systemApi.addHook(InventoryHookList.ShortcutBarViewContent,this.onShortcutBarViewContent);
         this.systemApi.addHook(HookList.ForgettableSpellListUpdate,this.onForgettableSpells);
         this.systemApi.addHook(HookList.ForgettableSpellDelete,this.onForgettableSpells);
         this.systemApi.addHook(HookList.ForgettableSpellEquipmentSlots,this.onForgettableSpells);
         this.systemApi.addHook(HookList.ForgettableSpellPresetSaved,this.onForgettableSpellPresetSaved);
         this.systemApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.systemApi.addHook(InventoryHookList.PresetsUpdate,this.onPresetsUpdate);
         this.systemApi.addHook(InventoryHookList.PresetError,this.onPresetError);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_activeSpells,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_activeSpells,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_activeSpells,ComponentHookList.ON_WHEEL);
         this.uiApi.addComponentHook(this.gd_activeSpells,ComponentHookList.ON_PRESS);
         this.uiApi.addComponentHook(this.ctr_activeSpellsButtons,ComponentHookList.ON_WHEEL);
         this.uiApi.addComponentHook(this.gd_forgettableSpells,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_spellLevelSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_spellLevelSearch,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_clearSearchText,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_spellIsDroppable,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_spellIsCraftable,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_spellIsDroppable,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_spellIsDroppable,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_spellIsCraftable,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_spellIsCraftable,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_spellIsUnknown,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_spellIsUnknown,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cbx_learningSpellsFilter,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_minSpellLevel,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_maxSpellLevel,ComponentHookList.ON_CHANGE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.btn_forgettableSpells.soundId = SoundEnum.TAB;
         this.btn_commonSpells.soundId = SoundEnum.TAB;
         this.btn_finishMoves.soundId = SoundEnum.TAB;
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
         this._playerLevel = this.playedCharacterApi.getPlayedCharacterInfo().level;
         this._weaponSpellType = this.uiApi.getText("ui.temporis.weaponSpell");
         this._specialSpellType = this.uiApi.getText("ui.temporis.specialSpell");
         this._passiveSpellType = this.uiApi.getText("ui.temporis.passiveSpell");
         this._activeSpellType = this.uiApi.getText("ui.temporis.activeSpell");
         this._commonSpellPriorities = {};
         this._commonSpellPriorities[this._weaponSpellType] = WEAPON_SPELL_PRIORITY;
         this._commonSpellPriorities[this._specialSpellType] = SPECIAL_SPELL_PRIORITY;
         this._commonSpellPriorities[this._passiveSpellType] = PASSIVE_SPELL_PRIORITY;
         this._commonSpellPriorities[this._activeSpellType] = ACTIVE_SPELL_PRIORITY;
         this.lbl_shareForgettableSpells.fullWidth();
         this.lbl_spellLevelFilterFrom.fullWidth();
         this.lbl_spellLevelFilterTo.fullWidth();
         this.fitSortableLabelHeaders();
         this._searchSpellText = this.searchInputPlaceholder;
         this.inp_spellLevelSearch.placeholderText = this._searchSpellText;
         this.gd_activeSpells.autoSelectMode = 0;
         (this.gd_activeSpells.renderer as SlotGridRenderer).processDropFunction = this.processActiveSpellDrop;
         (this.gd_activeSpells.renderer as SlotGridRenderer).dropValidatorFunction = this.activeSpellDropValidator;
         (this.gd_activeSpells.renderer as SlotGridRenderer).allowDrop = this._areActiveSpellsAlterable;
         this.cbx_learningSpellsFilter.dataProvider = [this.uiApi.getText("ui.temporis.displayAllSpells"),this.uiApi.getText("ui.temporis.displayLearnedSpells"),this.uiApi.getText("ui.temporis.displayUnlearnedSpells")];
         this._currentLearnedSpellsFilter = this.defaultLearnedSpellFilter;
         this.cbx_learningSpellsFilter.selectedIndex = this._currentLearnedSpellsFilter;
         (this.gd_activeSpells.renderer as SlotGridRenderer).removeDropSourceFunction = function(target:Object):void
         {
         };
         this._currentSpellLevelFilterMinLevel = this.defaultMinSpellLevelFilter;
         this._currentSpellLevelFilterMaxLevel = this.defaultMaxSpellLevelFilter;
         this._isSpellNameSortAscendingType = this.defaultIsSpellNameSortAscendingType;
         this._isSpellLevelSortAscendingType = this.defaultIsSpellLevelSortAscendingType;
         this._currentSort = this.defaultSpellSort;
         this.currentActiveSpellsIndex = 0;
         this.loadActiveSpells();
         this.resetFilters();
         this.currentTabName = FORGETTABLE_SPELLS_TAB_NAME;
         this.gd_forgettableSpells.mouseClickEnabled = false;
         this.gd_commonSpells.mouseClickEnabled = false;
         this.systemApi.sendAction(new OpenInventoryAction([this.storageStateMod,UIEnum.INVENTORY_UI]));
         var isFirstTimeTmp:* = this.systemApi.getData(STORAGE_IS_FIRST_TIME);
         if(isFirstTimeTmp !== null && isFirstTimeTmp is Boolean)
         {
            this._isFirstTime = Boolean(isFirstTimeTmp);
         }
         else
         {
            this.systemApi.setData(STORAGE_IS_FIRST_TIME,this._isFirstTime);
         }
         if(this._isFirstTime)
         {
            this.uiApi.loadUi(UIEnum.FORGETTABLE_SPELLS_INTRO_POP_UP,UIEnum.FORGETTABLE_SPELLS_INTRO_POP_UP,[this.validateFirstTime,this.spellsIntroPopupTitle,this.spellsIntroPopupDesc]);
         }
         var hasCommonSpellsTabBeenOpenedOnceTmp:* = this.systemApi.getData(this.commonSpellsDataStorageName);
         if(hasCommonSpellsTabBeenOpenedOnceTmp !== null && hasCommonSpellsTabBeenOpenedOnceTmp is Boolean)
         {
            this._hasCommonSpellsTabBeenOpenedOnce = Boolean(hasCommonSpellsTabBeenOpenedOnceTmp);
         }
         else
         {
            this.systemApi.setData(this.commonSpellsDataStorageName,this._hasCommonSpellsTabBeenOpenedOnce);
         }
         this.tx_commonSpellsWarning.visible = !this._hasCommonSpellsTabBeenOpenedOnce;
         var btn_helpGraphicElement:GraphicElement = this.uiApi.me().getElementById(this.btn_help.name);
         if(btn_helpGraphicElement !== null && btn_helpGraphicElement.location !== null)
         {
            btn_helpGraphicElement.location.setOffsetX(BTN_HELP_OFFSET);
         }
         if(paramsObject !== null && paramsObject.hasOwnProperty("isSpellSetsUi"))
         {
            this.getSpellSets();
         }
         this.setSaveSpellSetButton();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.unloadUi(FINISH_MOVES_UI_NAME);
         this.uiApi.unloadUi(UIEnum.FORGETTABLE_SPELLS_INTRO_POP_UP);
         this.uiApi.unloadUi(this._cartographyPopup);
         this.uiApi.unloadUi(UIEnum.FORGETTABLE_SPELL_SETS_UI);
         this.uiApi.unloadUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP);
         this.systemApi.sendAction(new CloseInventoryAction([UIEnum.INVENTORY_UI]));
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateForgettableSpellLine(spellDescr:Object, components:*, isSelected:Boolean) : void
      {
         var currentObtainingIconName:String = null;
         var currentObtainingTexture:Texture = null;
         var currentObtainingIconDescr:Object = null;
         var obtainingKey:* = null;
         this.uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.removeComponentHook(components.tx_obtaining_0,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.tx_obtaining_0,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.tx_obtaining_1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.tx_obtaining_1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.tx_obtaining_2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.tx_obtaining_2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.tx_obtaining_3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.tx_obtaining_3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.tx_findForgettableSpellScroll,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_DOUBLE_CLICK);
         if(spellDescr === null)
         {
            components.slot_forgettableSpell.visible = false;
            components.tx_isSelectedForgettableSpell.visible = false;
            components.ctr_obtaining.visible = false;
            components.lbl_forgettableSpellName.visible = false;
            components.lbl_forgettableSpellLevel.visible = false;
            components.tx_findForgettableSpellScroll.visible = false;
            components.btn_getForgettableSpellScroll.visible = false;
            components.slot_forgettableSpell.allowDrag = false;
            components.tx_findForgettableSpellScroll.visible = false;
            components.btn_forgettableSpellLine.state = StatesEnum.STATE_NORMAL;
            components.btn_forgettableSpellLine.handCursor = false;
            return;
         }
         this.uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OUT);
         this._componentsDictionary[components.slot_forgettableSpell.name] = spellDescr.isSpellActive;
         this._componentsDictionary[components.btn_forgettableSpellLine.name] = spellDescr;
         components.btn_forgettableSpellLine.state = StatesEnum.STATE_NORMAL;
         components.tx_isSelectedForgettableSpell.visible = spellDescr.isSpellActive;
         components.slot_forgettableSpell.visible = true;
         components.slot_forgettableSpell.allowDrag = spellDescr.isKnown;
         components.slot_forgettableSpell.data = spellDescr.spellWrapper;
         components.slot_forgettableSpell.greyedOut = !spellDescr.isKnown;
         this._componentsDictionary[components.slot_forgettableSpell.name] = spellDescr;
         this.uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OUT);
         var obtainingDescr:Object = spellDescr.obtainingDescr;
         var index:uint = 0;
         components.ctr_obtaining.visible = true;
         for(obtainingKey in obtainingDescr)
         {
            if(obtainingDescr.hasOwnProperty(obtainingKey))
            {
               currentObtainingIconDescr = obtainingDescr[obtainingKey];
               currentObtainingIconName = "tx_obtaining_" + index;
               currentObtainingTexture = null;
               if(components.hasOwnProperty(currentObtainingIconName) && components[currentObtainingIconName] is Texture)
               {
                  currentObtainingTexture = components[currentObtainingIconName] as Texture;
               }
               if(!(currentObtainingTexture === null || !currentObtainingIconDescr.hasOwnProperty("iconGreyPath")))
               {
                  currentObtainingTexture.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + currentObtainingIconDescr.iconGreyPath);
                  currentObtainingTexture.visible = true;
                  if(obtainingKey === OBTAINING_SPELL_IS_DROPPABLE || obtainingKey === OBTAINING_SPELL_IS_CRAFTABLE)
                  {
                     this.uiApi.addComponentHook(currentObtainingTexture,ComponentHookList.ON_RELEASE);
                     currentObtainingTexture.handCursor = true;
                  }
                  else
                  {
                     currentObtainingTexture.handCursor = false;
                  }
                  this._componentsDictionary[components[currentObtainingIconName].name] = currentObtainingIconDescr;
                  this.uiApi.addComponentHook(currentObtainingTexture,ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(currentObtainingTexture,ComponentHookList.ON_ROLL_OUT);
                  index++;
               }
            }
         }
         if(index > 0)
         {
            while(index < OBTAINING_ICONS_NUMBER)
            {
               currentObtainingIconName = "tx_obtaining_" + index;
               currentObtainingTexture = null;
               if(components.hasOwnProperty(currentObtainingIconName) && components[currentObtainingIconName] is Texture)
               {
                  currentObtainingTexture = components[currentObtainingIconName] as Texture;
               }
               if(currentObtainingTexture !== null)
               {
                  currentObtainingTexture.visible = false;
                  index++;
               }
            }
         }
         else
         {
            components.ctr_obtaining.visible = false;
         }
         components.lbl_forgettableSpellName.visible = true;
         components.lbl_forgettableSpellName.text = spellDescr.spellName;
         components.lbl_forgettableSpellLevel.visible = true;
         components.lbl_forgettableSpellLevel.text = spellDescr.spellLevel;
         if(spellDescr.isKnown)
         {
            components.btn_getForgettableSpellScroll.visible = true;
            components.tx_findForgettableSpellScroll.visible = false;
            this.uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
            this._componentsDictionary[components.btn_getForgettableSpellScroll.name] = spellDescr;
            this.uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_DOUBLE_CLICK);
            this._componentsDictionary[components.slot_forgettableSpell.name] = spellDescr;
            this.uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
         }
         else
         {
            components.btn_getForgettableSpellScroll.visible = false;
            if(this.isSpellScrollAvailable(spellDescr.scrollId))
            {
               components.tx_findForgettableSpellScroll.visible = true;
               this.uiApi.addComponentHook(components.tx_findForgettableSpellScroll,ComponentHookList.ON_RELEASE);
               this._componentsDictionary[components.tx_findForgettableSpellScroll.name] = spellDescr;
            }
            else
            {
               components.tx_findForgettableSpellScroll.visible = false;
            }
         }
      }
      
      public function updateCommonSpellLine(spellDescr:Object, components:*, isSelected:Boolean) : void
      {
         var currentObtainingLevelDescr:Object = null;
         var index:uint = 0;
         var currentObtainingButtonIndex:uint = 0;
         var minX:uint = 0;
         var currentObtainingButton:ButtonContainer = null;
         var currentObtainingLabel:Label = null;
         var currentObtainingTexture:Texture = null;
         var maxX:uint = 0;
         var containerWidth:int = 0;
         var tooltipTarget:Texture = null;
         this.uiApi.removeComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.removeComponentHook(components.slot_commonSpell,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.slot_commonSpell,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.slot_commonSpell,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_4,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_4,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_5,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_5,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_6,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_obtainingLevel_6,ComponentHookList.ON_ROLL_OUT);
         if(spellDescr === null)
         {
            components.slot_commonSpell.visible = false;
            components.tx_isSelectedCommonSpell.visible = false;
            components.lbl_commonSpellName.visible = false;
            components.slot_commonSpell.allowDrag = false;
            components.tx_commonSpellNotKnown.visible = false;
            components.lbl_commonSpellType.visible = false;
            components.btn_commonSpellLine.state = StatesEnum.STATE_NORMAL;
            components.ctr_obtainingLevels.visible = false;
            components.tx_passiveCommonSpellBackground.visible = false;
            components.btn_commonSpellLine.handCursor = false;
            return;
         }
         this.uiApi.addComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_ROLL_OUT);
         this._componentsDictionary[components.btn_commonSpellLine.name] = spellDescr.isSpellActive;
         components.tx_commonSpellNotKnown.visible = !spellDescr.isKnown;
         if(spellDescr.isKnown)
         {
            this.uiApi.addComponentHook(components.btn_commonSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
            this._componentsDictionary[components.btn_commonSpellLine.name] = spellDescr;
            this.uiApi.addComponentHook(components.slot_commonSpell,ComponentHookList.ON_DOUBLE_CLICK);
            this._componentsDictionary[components.slot_commonSpell.name] = spellDescr;
         }
         if(spellDescr.obtainingLevels !== null && spellDescr.obtainingLevels.length > 0)
         {
            currentObtainingLevelDescr = null;
            currentObtainingButtonIndex = 0;
            minX = components.tx_obtainingLevel_0.x;
            currentObtainingButton = null;
            currentObtainingLabel = null;
            currentObtainingTexture = null;
            for(index = 0; index < spellDescr.obtainingLevels.length; index++)
            {
               currentObtainingLevelDescr = spellDescr.obtainingLevels[index];
               if(currentObtainingLevelDescr !== null)
               {
                  if(currentObtainingLevelDescr !== null)
                  {
                     currentObtainingButton = components["btn_obtainingLevel_" + currentObtainingButtonIndex];
                     currentObtainingLabel = components["lbl_obtainingLevel_" + currentObtainingButtonIndex];
                     currentObtainingTexture = components["tx_obtainingLevel_" + currentObtainingButtonIndex];
                     if(currentObtainingButton !== null && currentObtainingLabel !== null && currentObtainingTexture !== null)
                     {
                        this.uiApi.addComponentHook(currentObtainingButton,ComponentHookList.ON_ROLL_OVER);
                        this.uiApi.addComponentHook(currentObtainingButton,ComponentHookList.ON_ROLL_OUT);
                        this._componentsDictionary[currentObtainingButton.name] = {"data":currentObtainingLevelDescr};
                        currentObtainingButton.visible = true;
                        if(currentObtainingLevelDescr.spellLevel > 0)
                        {
                           currentObtainingLabel.text = currentObtainingLevelDescr.spellLevel;
                        }
                        else
                        {
                           currentObtainingLabel.text = "-";
                        }
                        if(currentObtainingLevelDescr.isKnown)
                        {
                           currentObtainingLabel.cssClass = "orangecenterbold";
                        }
                        else
                        {
                           currentObtainingLabel.cssClass = "center";
                        }
                        currentObtainingButtonIndex++;
                     }
                  }
               }
            }
            maxX = currentObtainingTexture.x + currentObtainingTexture.width;
            containerWidth = maxX - minX;
            components.ctr_obtainingLevels.x = this.lbl_commonSpellsLevelHeader.x + this.lbl_commonSpellsLevelHeader.width / 2 - containerWidth / 2;
            tooltipTarget = currentObtainingTexture;
            for(index = 0; index < MAX_OBTAINING_LEVELS; index++)
            {
               currentObtainingButton = components["btn_obtainingLevel_" + index];
               if(currentObtainingButton !== null)
               {
                  if(index < currentObtainingButtonIndex)
                  {
                     this._componentsDictionary[currentObtainingButton.name].target = tooltipTarget;
                  }
                  else
                  {
                     currentObtainingButton.visible = false;
                  }
               }
            }
         }
         else
         {
            components.ctr_obtainingLevels.visible = false;
         }
         var isCommonSpellPassive:* = spellDescr.spellType === this._passiveSpellType;
         components.btn_commonSpellLine.state = StatesEnum.STATE_NORMAL;
         components.btn_commonSpellLine.handCursor = !isCommonSpellPassive;
         components.slot_commonSpell.handCursor = !isCommonSpellPassive;
         components.tx_isSelectedCommonSpell.visible = spellDescr.isSpellActive;
         components.slot_commonSpell.visible = true;
         components.slot_commonSpell.allowDrag = spellDescr.isKnown && !isCommonSpellPassive;
         components.slot_commonSpell.data = spellDescr.spellWrapper;
         components.slot_commonSpell.greyedOut = !spellDescr.isKnown;
         components.tx_passiveCommonSpellBackground.visible = isCommonSpellPassive;
         this._componentsDictionary[components.slot_commonSpell.name] = spellDescr;
         this.uiApi.addComponentHook(components.slot_commonSpell,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.slot_commonSpell,ComponentHookList.ON_ROLL_OUT);
         components.lbl_commonSpellName.visible = true;
         components.lbl_commonSpellName.text = spellDescr.spellName;
         components.lbl_commonSpellType.visible = true;
         components.lbl_commonSpellType.text = spellDescr.spellType;
      }
      
      protected function setSaveSpellSetButton() : void
      {
         this.btn_saveAsASpellSet.disabled = this.inventoryApi.getBuildNumber(2) >= this.presetLimit;
      }
      
      private function getSpellSetsWithSpell(spellId:int) : Array
      {
         var item:Object = null;
         var index:uint = 0;
         var builds:Array = this.inventoryApi.getBuilds(2);
         var currentBuildWrapper:BuildWrapper = null;
         var currentSpellsForPreset:Vector.<SpellForPreset> = null;
         var spellSets:Array = [];
         for each(item in builds)
         {
            if(item is BuildWrapper)
            {
               currentBuildWrapper = item as BuildWrapper;
               currentSpellsForPreset = currentBuildWrapper.forgettableSpellsPreset.forgettableSpells;
               if(currentSpellsForPreset !== null)
               {
                  for(index = 0; index < currentSpellsForPreset.length; index++)
                  {
                     if(currentSpellsForPreset[index].spellId === spellId)
                     {
                        spellSets.push({
                           "label":currentBuildWrapper.buildName,
                           "icon":currentBuildWrapper.iconUri,
                           "id":currentBuildWrapper.id
                        });
                        break;
                     }
                  }
               }
            }
         }
         return spellSets;
      }
      
      private function removeSpellFromActiveSpells(index:int) : void
      {
         if(index < 0 || index > this._activeSpells.length)
         {
            return;
         }
         var item:Object = this._activeSpells[index];
         var shortcutWrapper:ShortcutWrapper = null;
         var spellWrapper:SpellWrapper = null;
         if(item is ShortcutWrapper)
         {
            shortcutWrapper = item as ShortcutWrapper;
            if(shortcutWrapper.realItem is SpellWrapper)
            {
               spellWrapper = shortcutWrapper.realItem as SpellWrapper;
            }
         }
         else if(item is SpellWrapper)
         {
            spellWrapper = item as SpellWrapper;
         }
         if(spellWrapper === null)
         {
            return;
         }
         var spellId:int = spellWrapper.id;
         var currentIndex:int = 0;
         var currentIndexStr:* = null;
         var currentSpell:Object = null;
         var areDuplicates:Boolean = false;
         var isForgettableSpell:Boolean = this.playedCharacterApi.isForgettableSpell(spellId);
         if(isForgettableSpell)
         {
            for(currentIndexStr in this._activeSpells)
            {
               currentSpell = this._activeSpells[currentIndexStr];
               currentIndex = Number(currentIndexStr);
               if(currentSpell !== null && currentIndex !== index && currentSpell.id === spellId)
               {
                  areDuplicates = true;
                  break;
               }
            }
         }
         if(!isForgettableSpell || areDuplicates)
         {
            this.systemApi.sendAction(new ShortcutBarRemoveRequestAction([ShortcutBarEnum.SPELL_SHORTCUT_BAR,index]));
         }
         else
         {
            this.unequipForgettableSpell(spellId);
         }
      }
      
      private function validateFirstTime() : void
      {
         this._isFirstTime = false;
         this.systemApi.setData(STORAGE_IS_FIRST_TIME,this._isFirstTime);
      }
      
      private function isSpellActive(spellId:uint) : Boolean
      {
         return this._activeSpellIds.indexOf(spellId) !== -1;
      }
      
      private function saveActiveSpell(spellId:uint) : void
      {
         if(!this.isSpellActive(spellId))
         {
            this._activeSpellIds.push(spellId);
         }
      }
      
      private function removeActiveSpell(spellId:uint) : void
      {
         for(var index:uint = 0; index < this._activeSpellIds.length; index++)
         {
            if(spellId === this._activeSpellIds[index])
            {
               this._activeSpellIds.removeAt(index);
               break;
            }
         }
      }
      
      private function isForgettableSpellEquipped(spellId:uint) : Boolean
      {
         return this._equippedForgettableSpells.indexOf(spellId) !== -1;
      }
      
      private function equipForgettableSpell(spellId:uint, isSendAction:Boolean = true) : void
      {
         if(!this.isForgettableSpellEquipped(spellId))
         {
            if(isSendAction)
            {
               this.systemApi.sendAction(new ForgettableSpellClientAction([spellId,ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_EQUIP]));
            }
            else
            {
               this._equippedForgettableSpells.push(spellId);
            }
         }
      }
      
      private function unequipForgettableSpell(spellId:uint) : void
      {
         for(var index:uint = 0; index < this._equippedForgettableSpells.length; index++)
         {
            if(spellId === this._equippedForgettableSpells[index])
            {
               this.systemApi.sendAction(new ForgettableSpellClientAction([spellId,ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_UNEQUIP]));
               return;
            }
         }
      }
      
      private function shareCurrentForgettableSpells() : void
      {
         var sortedActiveForgettableSpells:Array = this._equippedForgettableSpells.sort(Array.NUMERIC);
         this.systemApi.goToUrl(this.uiApi.getText("ui.link.shareTemporisSpells") + sortedActiveForgettableSpells.toString());
      }
      
      protected function handleSearchInput() : void
      {
         if(!this._isSearchInputReady || this.inp_spellLevelSearch.isPlaceholderActive())
         {
            return;
         }
         var searchText:String = this.inp_spellLevelSearch.lastTextOnInput;
         if(this._isSearchInputFilled)
         {
            this.updateSearchFilter(searchText);
         }
         else if(searchText)
         {
            this._isSearchInputFilled = true;
            this.updateSearchFilter(searchText);
         }
      }
      
      protected function fitCenteredSortableLabelHeader(label:Label) : void
      {
         var currentWidth:Number = label.width;
         label.fullWidth();
         label.x += (currentWidth - label.width) / 2;
      }
      
      protected function fitSortableLabelHeaders() : void
      {
         this.lbl_forgettableSpellsNameHeader.fullWidth();
         this.lbl_commonSpellsNameHeader.fullWidth();
         if(this.lbl_forgettableSpellsLevelHeader)
         {
            this.fitCenteredSortableLabelHeader(this.lbl_forgettableSpellsLevelHeader);
         }
         this.fitCenteredSortableLabelHeader(this.lbl_commonSpellsLevelHeader);
      }
      
      private function resetFilters() : void
      {
         this._filteredForgettableSpells = this._filteredCommonSpells = null;
         this.resetSearchBar(false);
         this._currentSpellLevelFilterMinLevel = this.defaultMinSpellLevelFilter;
         this._currentSpellLevelFilterMaxLevel = this.defaultMaxSpellLevelFilter;
         this.updateSpellLevelInputs();
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this.resetObtainingFilters();
         }
      }
      
      protected function sortBySpellName(firstSpell:Object, secondSpell:Object, forceAscending:Boolean = false) : Number
      {
         var firstSpellPriority:int = 0;
         var secondSpellPriority:int = 0;
         if(firstSpell.spellFamily === SPELL_FAMILY_FORGETTABLE && firstSpell.isKnown !== secondSpell.isKnown)
         {
            if(firstSpell.isKnown)
            {
               return -1;
            }
            return 1;
         }
         if(firstSpell.spellFamily === SPELL_FAMILY_COMMON && this._commonSpellPriorities !== null && firstSpell.spellType !== secondSpell.spellType && firstSpell.spellType in this._commonSpellPriorities && secondSpell.spellType in this._commonSpellPriorities)
         {
            firstSpellPriority = this._commonSpellPriorities[firstSpell.spellType];
            secondSpellPriority = this._commonSpellPriorities[secondSpell.spellType];
            if(firstSpellPriority < secondSpellPriority)
            {
               return -1;
            }
            return 1;
         }
         if(firstSpell.spellName > secondSpell.spellName)
         {
            return this._isSpellNameSortAscendingType || forceAscending ? Number(1) : Number(-1);
         }
         if(firstSpell.spellName < secondSpell.spellName)
         {
            return this._isSpellNameSortAscendingType || forceAscending ? Number(-1) : Number(1);
         }
         return 0;
      }
      
      private function sortBySpellLevel(firstSpell:Object, secondSpell:Object) : Number
      {
         var firstSpellPriority:int = 0;
         var secondSpellPriority:int = 0;
         var firstLevel:uint = firstSpell.spellLevel;
         var secondLevel:uint = secondSpell.spellLevel;
         if(firstSpell.spellFamily === SPELL_FAMILY_FORGETTABLE && firstSpell.isKnown !== secondSpell.isKnown)
         {
            if(firstSpell.isKnown)
            {
               return -1;
            }
            return 1;
         }
         if(firstSpell.spellFamily === SPELL_FAMILY_COMMON && this._commonSpellPriorities !== null && firstSpell.spellType !== secondSpell.spellType && firstSpell.spellType in this._commonSpellPriorities && secondSpell.spellType in this._commonSpellPriorities)
         {
            firstSpellPriority = this._commonSpellPriorities[firstSpell.spellType];
            secondSpellPriority = this._commonSpellPriorities[secondSpell.spellType];
            if(firstSpellPriority < secondSpellPriority)
            {
               return -1;
            }
            return 1;
         }
         if(firstLevel > secondLevel)
         {
            return !!this._isSpellLevelSortAscendingType ? Number(1) : Number(-1);
         }
         if(firstLevel < secondLevel)
         {
            return !!this._isSpellLevelSortAscendingType ? Number(-1) : Number(1);
         }
         if(firstSpell.spellName > secondSpell.spellName)
         {
            return 1;
         }
         if(firstSpell.spellName < secondSpell.spellName)
         {
            return -1;
         }
         return 0;
      }
      
      private function resetObtainingFilters() : void
      {
         this._obtainingFiltersDescr = {
            "spellIsDroppable":true,
            "spellIsCraftable":true,
            "spellIsInQuest":true,
            "spellIsUnknown":true
         };
         this.tx_spellIsDroppable.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE] + "_over.png");
         this.tx_spellIsCraftable.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE] + "_over.png");
         this.tx_spellIsUnknown.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN] + "_over.png");
      }
      
      protected function resetSortButtons() : void
      {
         this.tx_sortForgettableSpellsByNameDescending.visible = false;
         this.tx_sortForgettableSpellsByNameAscending.visible = false;
         this.tx_sortCommonSpellsByNameDescending.visible = false;
         this.tx_sortCommonSpellsByNameAscending.visible = false;
         if(this.tx_sortForgettableSpellsByLevelDescending)
         {
            this.tx_sortForgettableSpellsByLevelDescending.visible = false;
         }
         if(this.tx_sortForgettableSpellsByLevelAscending)
         {
            this.tx_sortForgettableSpellsByLevelAscending.visible = false;
         }
      }
      
      private function applySpellNameSort() : void
      {
         this.resetSortButtons();
         var spellsToProvide:Array = null;
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            if(this._isSpellNameSortAscendingType)
            {
               this.tx_sortForgettableSpellsByNameAscending.visible = true;
            }
            else
            {
               this.tx_sortForgettableSpellsByNameDescending.visible = true;
            }
            if(this._filteredForgettableSpells !== null)
            {
               this._filteredForgettableSpells.sort(this.sortBySpellName);
               spellsToProvide = this._filteredForgettableSpells;
            }
            else
            {
               spellsToProvide = this._forgettableSpells;
            }
         }
         else
         {
            if(this._isSpellNameSortAscendingType)
            {
               this.tx_sortCommonSpellsByNameAscending.visible = true;
            }
            else
            {
               this.tx_sortCommonSpellsByNameDescending.visible = true;
            }
            if(this._filteredCommonSpells !== null)
            {
               this._filteredCommonSpells.sort(this.sortBySpellName);
               spellsToProvide = this._filteredCommonSpells;
            }
            else
            {
               spellsToProvide = this._commonSpells;
            }
         }
         this.currentSpells.sort(this.sortBySpellName);
         this.currentSpellGridDataProvider = spellsToProvide;
      }
      
      private function applySpellLevelSort() : void
      {
         if(this._currentTabName !== FORGETTABLE_SPELLS_TAB_NAME)
         {
            return;
         }
         this.resetSortButtons();
         var spellsToProvide:Array = null;
         if(this._isSpellLevelSortAscendingType)
         {
            if(this.tx_sortForgettableSpellsByLevelAscending)
            {
               this.tx_sortForgettableSpellsByLevelAscending.visible = true;
            }
         }
         else if(this.tx_sortForgettableSpellsByLevelDescending)
         {
            this.tx_sortForgettableSpellsByLevelDescending.visible = true;
         }
         if(this._filteredForgettableSpells !== null)
         {
            this._filteredForgettableSpells.sort(this.sortBySpellLevel);
            spellsToProvide = this._filteredForgettableSpells;
         }
         else
         {
            spellsToProvide = this._forgettableSpells;
         }
         this.currentSpells.sort(this.sortBySpellLevel);
         this.currentSpellGridDataProvider = spellsToProvide;
      }
      
      protected function applySort() : void
      {
         if(this._currentTabName === COMMON_SPELLS_TAB_NAME || this._currentSort === SPELL_NAME_SORT_TYPE)
         {
            this.applySpellNameSort();
         }
         else if(this._currentSort === SPELL_LEVEL_SORT_TYPE)
         {
            this.applySpellLevelSort();
         }
      }
      
      private function applyFilterPipeline() : void
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this._filteredForgettableSpells = this._forgettableSpells.concat();
         }
         else
         {
            if(this._currentTabName !== COMMON_SPELLS_TAB_NAME)
            {
               return;
            }
            this._filteredCommonSpells = this._commonSpells.concat();
         }
         this.applySearchFilter(false);
         this.applyLearnedSpellsFilter();
         this.applySpellLevelFilter();
         this.applyObtainingFilter();
         this.currentSpellGridDataProvider = this.currentFilteredSpells;
      }
      
      protected function applyLearnedSpellsFilter(isUpdateDataProvider:Boolean = false) : void
      {
         if(this._currentTabName !== FORGETTABLE_SPELLS_TAB_NAME && this._currentTabName !== COMMON_SPELLS_TAB_NAME || this._currentLearnedSpellsFilter === LEARNED_SPELLS_FILTER_ALL)
         {
            return;
         }
         var filterCondition:* = this._currentLearnedSpellsFilter === LEARNED_SPELLS_FILTER_LEARNED;
         var filteredSpells:Array = this.currentFilteredSpells;
         if(filteredSpells === null)
         {
            return;
         }
         var index:uint = 0;
         while(index < filteredSpells.length)
         {
            if(filteredSpells[index].isKnown !== filterCondition)
            {
               filteredSpells.removeAt(index);
            }
            else
            {
               index++;
            }
         }
         this.currentFilteredSpells = filteredSpells;
         if(isUpdateDataProvider)
         {
            this.currentSpellGridDataProvider = this.currentFilteredSpells;
         }
      }
      
      private function applySpellLevelFilter(isUpdateDataProvider:Boolean = false) : void
      {
         var currentSpellLevel:uint = 0;
         var filteredSpells:Array = this.currentFilteredSpells;
         if(filteredSpells === null)
         {
            return;
         }
         var index:uint = 0;
         while(index < filteredSpells.length)
         {
            currentSpellLevel = filteredSpells[index].spellLevel;
            if(currentSpellLevel < this._currentSpellLevelFilterMinLevel || currentSpellLevel > this._currentSpellLevelFilterMaxLevel)
            {
               filteredSpells.removeAt(index);
            }
            else
            {
               index++;
            }
         }
         if(isUpdateDataProvider)
         {
            this.currentSpellGridDataProvider = filteredSpells;
         }
      }
      
      private function applyObtainingFilter(isUpdateDataProvider:Boolean = false) : void
      {
         var index:uint = 0;
         var obtainingKey:* = null;
         if(this._currentTabName !== FORGETTABLE_SPELLS_TAB_NAME)
         {
            return;
         }
         var filteredSpells:Array = this.currentFilteredSpells;
         if(filteredSpells === null)
         {
            return;
         }
         for(obtainingKey in this._obtainingFiltersDescr)
         {
            if(!(!this._obtainingFiltersDescr.hasOwnProperty(obtainingKey) || this._obtainingFiltersDescr[obtainingKey]))
            {
               index = 0;
               while(index < filteredSpells.length)
               {
                  if(filteredSpells[index].obtainingDescr.hasOwnProperty(obtainingKey))
                  {
                     filteredSpells.removeAt(index);
                  }
                  else
                  {
                     index++;
                  }
               }
            }
         }
         if(isUpdateDataProvider)
         {
            this.currentSpellGridDataProvider = filteredSpells;
         }
      }
      
      private function applySearchFilter(isUpdateDataProvider:Boolean = false) : void
      {
         var filteredSpells:Array = this.currentFilteredSpells;
         if(filteredSpells === null || !this._currentSearchText)
         {
            return;
         }
         if(filteredSpells === null)
         {
            filteredSpells = this._forgettableSpells.concat();
         }
         filteredSpells = this.utilApi.filter(filteredSpells,this._currentSearchText,"spellName");
         this.currentFilteredSpells = filteredSpells;
         if(isUpdateDataProvider)
         {
            this.currentSpellGridDataProvider = this.currentFilteredSpells;
         }
      }
      
      private function updateSpellNameSort() : void
      {
         this._currentSort = SPELL_NAME_SORT_TYPE;
         this.systemApi.setData(STORAGE_SPELL_SORT,this._currentSort);
         this._isSpellNameSortAscendingType = !this._isSpellNameSortAscendingType;
         this.systemApi.setData(STORAGE_IS_SPELL_NAME_SORT_ASCENDING_TYPE,this._isSpellNameSortAscendingType);
         this.applySort();
      }
      
      private function updateSpellLevelSort() : void
      {
         this._isSpellLevelSortAscendingType = !this._isSpellLevelSortAscendingType;
         this.systemApi.setData(STORAGE_IS_SPELL_LEVEL_SORT_ASCENDING_TYPE,this._isSpellLevelSortAscendingType);
         this._currentSort = SPELL_LEVEL_SORT_TYPE;
         this.systemApi.setData(STORAGE_SPELL_SORT,this._currentSort);
         this.applySort();
      }
      
      protected function updateLearnedSpellsFilter(learnedSpellsValue:uint) : void
      {
         var oldValue:uint = this._currentLearnedSpellsFilter;
         this._currentLearnedSpellsFilter = learnedSpellsValue;
         if(oldValue === this._currentLearnedSpellsFilter)
         {
            return;
         }
         this.systemApi.setData(STORAGE_LEARNED_SPELLS_LEVEL_FILTER,this._currentLearnedSpellsFilter);
         if(oldValue === LEARNED_SPELLS_FILTER_ALL && this._currentLearnedSpellsFilter !== LEARNED_SPELLS_FILTER_ALL)
         {
            this.applyLearnedSpellsFilter(true);
         }
         else
         {
            this.applyFilterPipeline();
         }
      }
      
      private function updateSpellLevelFilter() : void
      {
         var newMinLevel:Number = Number(this.inp_minSpellLevel.lastTextOnInput);
         var newMaxLevel:Number = Number(this.inp_maxSpellLevel.lastTextOnInput);
         if(!this._isSpellLevelFilterReady || this._currentSpellLevelFilterMinLevel === newMinLevel && this._currentSpellLevelFilterMaxLevel === newMaxLevel)
         {
            return;
         }
         var oldMinLevel:uint = this._currentSpellLevelFilterMinLevel;
         var oldMaxLevel:uint = this._currentSpellLevelFilterMaxLevel;
         if(isNaN(newMinLevel) || newMinLevel < uint.MIN_VALUE || newMinLevel > uint.MAX_VALUE)
         {
            newMinLevel = this.defaultMinSpellLevelFilter;
         }
         if(isNaN(newMaxLevel) || newMaxLevel < uint.MIN_VALUE || newMaxLevel > uint.MAX_VALUE)
         {
            newMaxLevel = this.defaultMaxSpellLevelFilter;
         }
         if(newMinLevel > newMaxLevel)
         {
            newMinLevel = this.defaultMinSpellLevelFilter;
         }
         this._currentSpellLevelFilterMinLevel = newMinLevel;
         this._currentSpellLevelFilterMaxLevel = newMaxLevel;
         this.systemApi.setData(STORAGE_MIN_SPELL_LEVEL_FILTER,this._currentSpellLevelFilterMinLevel);
         this.systemApi.setData(STORAGE_MAX_SPELL_LEVEL_FILTER,this._currentSpellLevelFilterMaxLevel);
         if(this._currentSpellLevelFilterMinLevel < oldMinLevel || this._currentSpellLevelFilterMaxLevel > oldMaxLevel)
         {
            this.applyFilterPipeline();
         }
         else
         {
            this.applySpellLevelFilter(true);
         }
      }
      
      private function updateObtainingFilter(clickedButton:ButtonContainer) : void
      {
         var obtainingKey:String = clickedButton.name.substr(4);
         if(!this._obtainingFiltersDescr.hasOwnProperty(obtainingKey))
         {
            return;
         }
         var isFilterActive:Boolean = this._obtainingFiltersDescr[obtainingKey] = !this._obtainingFiltersDescr[obtainingKey];
         var iconPrefix:String = OBTAINING_ICONS_MAP[obtainingKey];
         if(isFilterActive)
         {
            this["tx_" + obtainingKey].uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + iconPrefix + "_over.png");
            this.applyFilterPipeline();
         }
         else
         {
            this["tx_" + obtainingKey].uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + iconPrefix + "_grey.png");
            this.applyObtainingFilter(true);
         }
      }
      
      private function updateSearchFilter(searchText:String) : void
      {
         var oldSearchText:String = this._currentSearchText === null ? "" : this._currentSearchText;
         this._currentSearchText = searchText;
         if(oldSearchText === this._currentSearchText)
         {
            return;
         }
         if(this._currentSearchText.indexOf(oldSearchText) >= 0)
         {
            this.applySearchFilter(true);
         }
         else
         {
            this.applyFilterPipeline();
         }
      }
      
      private function updateSpellLevelInputs() : void
      {
         this._isSpellLevelFilterReady = false;
         this.inp_minSpellLevel.text = this._currentSpellLevelFilterMinLevel.toString();
         this.inp_maxSpellLevel.text = this._currentSpellLevelFilterMaxLevel.toString();
         this._isSpellLevelFilterReady = true;
      }
      
      private function updateSearchBar() : void
      {
         this._isSearchInputReady = true;
         if(!this.inp_spellLevelSearch.text)
         {
            this._isSearchInputFilled = false;
         }
         if(this._isSearchInputFilled || this.inp_spellLevelSearch.text === this._searchSpellText)
         {
            return;
         }
         this.resetSearchPlaceholder();
      }
      
      private function resetSearchPlaceholder() : void
      {
         this.inp_spellLevelSearch.text = "";
      }
      
      private function resetSearchBar(isReapplyFilterPipeline:Boolean = true) : void
      {
         this._isSearchInputReady = false;
         this._isSearchInputFilled = false;
         this._currentSearchText = null;
         this.resetSearchPlaceholder();
         if(isReapplyFilterPipeline)
         {
            this.applyFilterPipeline();
         }
      }
      
      private function loadActiveSpells() : void
      {
         this._activeSpellIds = [];
         this._activeSpells = this.storageApi.getShortcutBarContent(ShortcutBarEnum.SPELL_SHORTCUT_BAR);
         this.updateCurrentActiveSpells();
      }
      
      private function createSpellSet() : void
      {
         if(!this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP))
         {
            this.uiApi.loadUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP,UIEnum.FORGETTABLE_SPELL_SET_POP_UP,[ForgettableSpellSetPopUp.ACTION_CREATE_SPELL_SET,null,this.uiApi.me().name]);
         }
      }
      
      public function getSpellSets(presetId:int = -1) : void
      {
         var forgettableSpellSetUi:UiRootContainer = this.uiApi.getUi(this.spellSetUiName);
         if(forgettableSpellSetUi === null)
         {
            this.uiApi.loadUi(this.spellSetUiName,this.spellSetUiName,[presetId]);
         }
         else
         {
            forgettableSpellSetUi.setOnTop();
         }
      }
      
      private function handleActiveSpellsSelect(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var currentSpellWrapper:SpellWrapper = null;
         var spellCastResult:String = null;
         var currentSpellShortcut:ShortcutWrapper = target.selectedItem;
         if(currentSpellShortcut !== null)
         {
            if(this.systemApi.isFightContext() && this._isAltDown && currentSpellShortcut.realItem is SpellWrapper)
            {
               currentSpellWrapper = currentSpellShortcut.realItem as SpellWrapper;
               spellCastResult = this.playedCharacterApi.canCastThisSpellWithResult(currentSpellWrapper.spellId,currentSpellWrapper.spellLevel);
               this.systemApi.sendAction(new ChatTextOutputAction([spellCastResult,ChatActivableChannelsEnum.CHANNEL_TEAM,null,null]));
            }
            else if(target.selectedItem.active)
            {
               this.systemApi.sendAction(GameFightSpellCastAction.create(CurrentPlayedFighterManager.getInstance().currentFighterId,currentSpellShortcut.id,this.gd_activeSpells.selectedIndex + 1));
            }
         }
      }
      
      private function updateCurrentActiveSpells() : void
      {
         var spell:Object = null;
         var index:uint = 0;
         this.lbl_currentActiveSpellsIndex.text = String(this._currentActiveSpellsIndex + 1);
         var activeSpellsDataProvider:Array = [];
         for each(spell in this._activeSpells)
         {
            if(spell !== null)
            {
               activeSpellsDataProvider[spell.slot - this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER] = spell;
               this.saveActiveSpell(spell.id);
            }
         }
         for(index = 0; index < MAX_ACTIVE_SPELLS_PAGES * ACTIVE_SPELLS_BY_PAGE_NUMBER; index++)
         {
            if(!activeSpellsDataProvider[index])
            {
               activeSpellsDataProvider[index] = null;
            }
         }
         this.gd_activeSpells.dataProvider = activeSpellsDataProvider;
      }
      
      private function updateCurrentTab() : void
      {
         this.btn_forgettableSpells.selected = false;
         this.btn_commonSpells.selected = false;
         this.btn_finishMoves.selected = false;
         this.ctr_forgettableSpells.visible = false;
         this.ctr_commonSpells.visible = false;
         this.ctr_finishMoves.visible = false;
         this.ctr_obtainingFilters.visible = false;
         this.ctr_topFilters.visible = false;
         if(this._currentTabName === FINISH_MOVES_TAB_NAME)
         {
            this.openFinishMovesTab();
            return;
         }
         this.resetFilters();
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this.openForgettableSpellsTab();
         }
         else if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            this.openCommonSpellsTab();
         }
         this.applySort();
      }
      
      private function openForgettableSpellsTab() : void
      {
         this.btn_forgettableSpells.selected = true;
         this.ctr_forgettableSpells.visible = true;
         this.ctr_obtainingFilters.visible = true;
         this.ctr_topFilters.visible = true;
         this.refreshForgettableSpellsList();
      }
      
      private function openCommonSpellsTab() : void
      {
         this.btn_commonSpells.selected = true;
         this.ctr_commonSpells.visible = true;
         if(!this._hasCommonSpellsTabBeenOpenedOnce)
         {
            this._hasCommonSpellsTabBeenOpenedOnce = true;
            this.systemApi.setData(this.commonSpellsDataStorageName,this._hasCommonSpellsTabBeenOpenedOnce);
            this.tx_commonSpellsWarning.visible = false;
         }
         this.refreshCommonSpellsList();
      }
      
      private function openFinishMovesTab() : void
      {
         this.btn_finishMoves.selected = true;
         this.ctr_finishMoves.visible = true;
         if(this.uiApi.getUi(FINISH_MOVES_UI_NAME) === null)
         {
            this._finishMovesUi = this.uiApi.loadUiInside(UIEnum.FINISH_MOVES_UI,this.ctr_finishMoves,FINISH_MOVES_UI_NAME,null) as UiRootContainer;
            if(this._finishMovesUi === null)
            {
               return;
            }
            this._finishMovesUi.addEventListener("UIRenderComplete",this.onFinishMovesLoaded);
         }
      }
      
      protected function refreshForgettableSpellsList() : void
      {
         var forgettableSpell:ForgettableSpell = null;
         var forgettableSpellItem:ForgettableSpellItem = null;
         var spellId:int = 0;
         var index:uint = 0;
         var forgettableSpellDictionary:Dictionary = this.playedCharacterApi.getPlayerForgettableSpells() as Dictionary;
         if(forgettableSpellDictionary === null)
         {
            forgettableSpellDictionary = new Dictionary();
         }
         var learnableSpellList:Array = this.playedCharacterApi.getForgettableSpells();
         this._forgettableSpells = [];
         this._filteredForgettableSpells = null;
         this._equippedForgettableSpells = [];
         var processedForgettableSpells:Array = [];
         this._learnedForgettableSpellsCount = 0;
         this._forgettableSpellsCount = 0;
         for each(forgettableSpell in learnableSpellList)
         {
            if(forgettableSpell !== null)
            {
               this.addForgettableSpell(forgettableSpell.id,forgettableSpell.itemId,forgettableSpellDictionary);
               processedForgettableSpells.push(forgettableSpell.id);
            }
         }
         for each(forgettableSpellItem in forgettableSpellDictionary)
         {
            if(processedForgettableSpells.indexOf(forgettableSpellItem.spellId) === -1)
            {
               forgettableSpell = this.playedCharacterApi.getForgettableSpellById(forgettableSpellItem.spellId);
               if(forgettableSpell !== null)
               {
                  this.addForgettableSpell(forgettableSpellItem.spellId,forgettableSpell.itemId,forgettableSpellDictionary);
               }
            }
         }
         spellId = -1;
         for(index = 0; index < this._forgettableSpells.length; index++)
         {
            spellId = this._forgettableSpells[index].spellId;
            if(this.isSpellActive(spellId))
            {
               this.equipForgettableSpell(spellId,false);
            }
         }
         var maxForgettableSpellsCount:int = this.playedCharacterApi.getPlayerMaxForgettableSpellsNumber();
         var isMaxForgettableSpellsCountHeaderVisible:* = maxForgettableSpellsCount >= 0;
         if(isMaxForgettableSpellsCountHeaderVisible && this.lbl_forgettableIsSpellEquippedHeader)
         {
            this.lbl_forgettableIsSpellEquippedHeader.text = this._equippedForgettableSpells.length + "/" + maxForgettableSpellsCount;
         }
         if(this.lbl_forgettableIsSpellEquippedHeader)
         {
            this.lbl_forgettableIsSpellEquippedHeader.visible = isMaxForgettableSpellsCountHeaderVisible;
         }
         if(this.lbl_learnedSpells)
         {
            this.lbl_learnedSpells.text = this.uiApi.getText("ui.temporis.learnedSpellsRatio",this._learnedForgettableSpellsCount,this._forgettableSpellsCount);
         }
         var toMoveIndex:Number = this.gd_forgettableSpells.scrollBarV !== null ? Number(this.gd_forgettableSpells.scrollBarV.value) : Number(-1);
         this.gd_forgettableSpells.dataProvider = this._forgettableSpells;
         this.applyFilterPipeline();
         this.applySort();
         this.updateShareSpellsButton();
         if(toMoveIndex > 0)
         {
            this.gd_forgettableSpells.moveTo(toMoveIndex,true);
         }
      }
      
      private function addForgettableSpell(spellId:uint, itemId:uint, forgettableSpellDictionary:Dictionary) : void
      {
         var spell:Spell = this.dataApi.getSpell(spellId);
         var spellWrapper:SpellWrapper = this.dataApi.getSpellWrapper(spellId);
         var itemWrapper:ItemWrapper = this.dataApi.getItemWrapper(itemId);
         if(spell === null || spellWrapper === null || itemWrapper === null)
         {
            return;
         }
         var obtainingDescr:Object = {};
         var isObtainingAMystery:Boolean = true;
         if(itemWrapper.dropMonsterIds.length > 0 || this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_DROPS) && itemWrapper.dropTemporisMonsterIds && itemWrapper.dropTemporisMonsterIds.length > 0)
         {
            obtainingDescr[OBTAINING_SPELL_IS_DROPPABLE] = {
               "iconGreyPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE] + "_grey.png",
               "iconOverPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_DROPPABLE] + "_over.png",
               "id":2,
               "item":itemWrapper
            };
            isObtainingAMystery = false;
         }
         if(itemWrapper.recipeSlots != 0 && !itemWrapper.secretRecipe)
         {
            obtainingDescr[OBTAINING_SPELL_IS_CRAFTABLE] = {
               "iconGreyPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE] + "_grey.png",
               "iconOverPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_CRAFTABLE] + "_over.png",
               "id":1,
               "item":itemWrapper
            };
            isObtainingAMystery = false;
         }
         if(isObtainingAMystery)
         {
            obtainingDescr[OBTAINING_SPELL_IS_UNKNOWN] = {
               "iconGreyPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN] + "_grey.png",
               "iconOverPath":OBTAINING_ICONS_MAP[OBTAINING_SPELL_IS_UNKNOWN] + "_over.png",
               "id":UNKNOWN_OBTAINING,
               "item":itemWrapper
            };
         }
         var data:* = spellWrapper;
         var spellName:String = data.name !== null ? data.name : spell.name;
         var isSpellKnown:* = spellId in forgettableSpellDictionary;
         var forgettableSpellItem:ForgettableSpellItem = null;
         if(isSpellKnown)
         {
            ++this._learnedForgettableSpellsCount;
            forgettableSpellItem = forgettableSpellDictionary[spellId];
            if(forgettableSpellItem !== null && forgettableSpellItem.available)
            {
               this.equipForgettableSpell(forgettableSpellItem.spellId,false);
            }
         }
         if(this.systemApi.getPlayerManager().hasRights)
         {
            spellName += " (" + data.id + ")";
         }
         this._forgettableSpells.push({
            "spellId":spellId,
            "scrollId":itemId,
            "isKnown":isSpellKnown,
            "spellName":spellName,
            "spellLevel":spell.spellLevelsInfo[spellWrapper.spellLevel - 1].minPlayerLevel,
            "obtainingDescr":obtainingDescr,
            "spellWrapper":spellWrapper,
            "spellFamily":SPELL_FAMILY_FORGETTABLE,
            "isSpellActive":this.isSpellActive(spellId)
         });
         ++this._forgettableSpellsCount;
      }
      
      private function refreshCommonSpellsList() : void
      {
         var obtainingLevels:Array = null;
         var spellLevels:Array = null;
         var jndex:uint = 0;
         var kndex:uint = 0;
         this._commonSpells = [];
         this._filteredCommonSpells = null;
         var spellList:Array = Grimoire.getInstance().currentSpecialSpells.concat(Grimoire.getInstance().currentBreedSpells);
         var spellListSize:uint = spellList.length;
         var currentSpellWrapper:SpellWrapper = null;
         var currentSpellLevelWrapper:SpellWrapper = null;
         var currentSpell:Spell = null;
         var currentSpellName:String = null;
         var currentSpellType:String = null;
         var currentCustomModeBreedSpell:CustomModeBreedSpell = null;
         var data:* = null;
         for(var index:uint = 0; index < spellListSize; index++)
         {
            if(spellList[index] !== null)
            {
               for(jndex = 0; jndex < spellList[index].length; jndex++)
               {
                  currentSpellWrapper = spellList[index][jndex];
                  currentSpell = currentSpellWrapper.spell;
                  currentCustomModeBreedSpell = this.playedCharacterApi.getCustomModeBreedSpellById(currentSpell.id);
                  if(!(currentCustomModeBreedSpell !== null && currentCustomModeBreedSpell.isHidden))
                  {
                     if(currentSpell.id === 0)
                     {
                        currentSpellType = this._weaponSpellType;
                     }
                     else if(currentCustomModeBreedSpell === null)
                     {
                        currentSpellType = this._specialSpellType;
                     }
                     else if(currentCustomModeBreedSpell.isInitialSpell)
                     {
                        currentSpellType = this._passiveSpellType;
                     }
                     else
                     {
                        currentSpellType = this._activeSpellType;
                     }
                     data = currentSpellWrapper;
                     currentSpellName = data.name !== null ? data.name : currentSpell.name;
                     if(this.systemApi.getPlayerManager().hasRights)
                     {
                        currentSpellName += " (" + currentSpellWrapper.id + ")";
                     }
                     spellLevels = currentSpell.spellLevelsInfo;
                     obtainingLevels = [];
                     for(kndex = 0; kndex < spellLevels.length; kndex++)
                     {
                        currentSpellLevelWrapper = this.dataApi.getSpellWrapper(currentSpell.id,spellLevels[kndex].grade);
                        if(currentSpellLevelWrapper !== null)
                        {
                           obtainingLevels.push({
                              "spellLevel":spellLevels[kndex].minPlayerLevel,
                              "isFirstLevel":this._playerLevel < spellLevels[kndex].minPlayerLevel && kndex === 0,
                              "grade":spellLevels[kndex].grade,
                              "spellWrapper":currentSpellLevelWrapper,
                              "isKnown":currentSpellWrapper.variantActivated && currentSpellWrapper.spellLevel === currentSpellLevelWrapper.spellLevel
                           });
                        }
                     }
                     this._commonSpells.push({
                        "spellId":currentSpell.id,
                        "spellName":currentSpellName,
                        "spellLevel":spellLevels[currentSpellWrapper.spellLevel - 1].minPlayerLevel,
                        "obtainingLevels":obtainingLevels,
                        "isKnown":currentSpellWrapper.variantActivated,
                        "spellWrapper":currentSpellWrapper,
                        "spellType":currentSpellType,
                        "spellFamily":SPELL_FAMILY_COMMON,
                        "isSpellActive":this.isSpellActive(currentSpell.id)
                     });
                  }
               }
            }
         }
         var toMoveIndex:Number = this.gd_commonSpells.scrollBarV !== null ? Number(this.gd_commonSpells.scrollBarV.value) : Number(-1);
         this.gd_commonSpells.dataProvider = this._commonSpells;
         this.applySort();
         if(toMoveIndex !== -1)
         {
            this.gd_commonSpells.moveTo(toMoveIndex,true);
         }
      }
      
      private function updateShareSpellsButton() : void
      {
         if(this._equippedForgettableSpells.length > 0)
         {
            this.uiApi.addComponentHook(this.btn_shareForgettableSpells,ComponentHookList.ON_RELEASE);
            this.ctr_shareForgettableSpells.alpha = 1;
            this.btn_shareForgettableSpells.handCursor = true;
            this.uiApi.removeComponentHook(this.ctr_shareForgettableSpells,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.ctr_shareForgettableSpells,ComponentHookList.ON_ROLL_OUT);
            this.btn_shareForgettableSpells.x = this.lbl_shareForgettableSpells.x;
            this.btn_shareForgettableSpells.width = this.tx_shareForgettableSpells.x - this.lbl_shareForgettableSpells.x + this.lbl_shareForgettableSpells.width + this.tx_shareForgettableSpells.width;
         }
         else
         {
            this.uiApi.removeComponentHook(this.btn_shareForgettableSpells,ComponentHookList.ON_RELEASE);
            this.ctr_shareForgettableSpells.alpha = DISABLED_SHARE_FORGETTABLE_SPELLS_CONTAINER_ALPHA;
            this.btn_shareForgettableSpells.handCursor = false;
            this.uiApi.addComponentHook(this.ctr_shareForgettableSpells,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.ctr_shareForgettableSpells,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      protected function showSpellTooltip(data:Object, target:Object, fromUI:uint) : void
      {
         var point:uint = 0;
         var relativePoint:uint = 0;
         var offset:uint = 0;
         if(data === null || target === null)
         {
            return;
         }
         var spellWrapper:SpellWrapper = null;
         if(fromUI === FROM_ACTIVE_SPELLS)
         {
            if(!(data.realItem is SpellWrapper))
            {
               return;
            }
            point = LocationEnum.POINT_TOP;
            relativePoint = LocationEnum.POINT_BOTTOM;
            offset = 3;
            spellWrapper = this.dataApi.getSpellWrapper(data.id,data.realItem.spellLevel,true);
         }
         else
         {
            if(!(fromUI === FROM_FORGETTABLE_SPELLS || fromUI === FROM_COMMON_SPELLS))
            {
               return;
            }
            point = LocationEnum.POINT_LEFT;
            relativePoint = LocationEnum.POINT_RIGHT;
            offset = 3;
            spellWrapper = data is SpellWrapper ? data as SpellWrapper : data.spellWrapper;
         }
         if(spellWrapper === null)
         {
            return;
         }
         this.uiApi.showTooltip(spellWrapper,target,false,TOOLTIP_UI_NAME,point,relativePoint,offset,null,null,{"isTheoretical":this.systemApi.getOption("useTheoreticalValuesInSpellTooltips","dofus")},null,false);
      }
      
      private function showRemoveSpellMenu(data:Object) : void
      {
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         if(data === null)
         {
            return;
         }
         var spellContextMenu:ContextMenuData = this.menuApi.create(data.realItem,"spell",[]);
         spellContextMenu.content.push(this.ankamaContextMenu.createContextMenuSeparatorObject(),this.ankamaContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"),this.removeSpellFromActiveSpells,[data.slot],false));
         this.ankamaContextMenu.createContextMenu(spellContextMenu);
      }
      
      private function addSpellToActiveSpells(spellId:int, index:int) : void
      {
         var isForgettableSpell:Boolean = this.playedCharacterApi.isForgettableSpell(spellId);
         if(isForgettableSpell)
         {
            if(!this.canForgettableSpellsBeAdded() && !this.isForgettableSpellEquipped(spellId))
            {
               this.systemApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.temporis.warningTemporisSpellsLimit",this.playedCharacterApi.getPlayerMaxForgettableSpellsNumber()),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
               return;
            }
            if(!this.isForgettableSpellEquipped(spellId))
            {
               this.equipForgettableSpell(spellId);
            }
         }
         if(this._activeSpellIds.indexOf(spellId) == -1)
         {
            this.systemApi.sendAction(new ShortcutBarAddRequestAction([DataEnum.SHORTCUT_TYPE_SPELL,spellId,index + this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER]));
         }
      }
      
      private function getFirstActiveSpellIndexAvailable() : int
      {
         var shortcutWrapper:ShortcutWrapper = null;
         var firstEntryAvailableIndex:int = -1;
         var currentIndex:uint = 0;
         for each(shortcutWrapper in this.gd_activeSpells.dataProvider)
         {
            if(shortcutWrapper === null)
            {
               firstEntryAvailableIndex = currentIndex;
               break;
            }
            currentIndex++;
         }
         return firstEntryAvailableIndex;
      }
      
      private function showAddSpellMenu(slot:Slot) : void
      {
         var firstEntryAvailableIndex:int = 0;
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         if(slot === null || !(slot.data is SpellWrapper))
         {
            return;
         }
         var spellContextMenu:ContextMenuData = this.menuApi.create(slot.data,"spell",[]);
         var playerForgettableSpellsDictionary:Dictionary = this.playedCharacterApi.getPlayerForgettableSpells() as Dictionary;
         var isSpellKnown:Boolean = !slot.greyedOut && (slot.data.variantActivated || slot.data.id in playerForgettableSpellsDictionary);
         if(isSpellKnown)
         {
            firstEntryAvailableIndex = this.getFirstActiveSpellIndexAvailable();
            if(firstEntryAvailableIndex >= 0)
            {
               spellContextMenu.content.push(this.ankamaContextMenu.createContextMenuSeparatorObject(),this.ankamaContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.add"),function():void
               {
                  addSpellToActiveSpells(slot.data.id,firstEntryAvailableIndex);
               },[slot]));
            }
         }
         this.ankamaContextMenu.createContextMenu(spellContextMenu);
      }
      
      private function handleObtainingClick(data:Object) : void
      {
         var itemData:Object = null;
         var subAreaWithMaxItem:uint = 0;
         var subAreaMaxItemCount:uint = 0;
         var text:String = null;
         var itemSubAreas:Vector.<uint> = null;
         var subArea:SubArea = null;
         var subAreaId:Object = null;
         if(data === null || data.id === UNKNOWN_OBTAINING)
         {
            return;
         }
         if(data.id === EncyclopediaList.ITEM_COMPONENT_CAT_ID || data.id === EncyclopediaList.ITEM_CRAFTABLE_CAT_ID)
         {
            this.systemApi.dispatchHook(HookList.OpenRecipe,data.item);
         }
         else if(data.id === EncyclopediaList.ITEM_DROPABLE_CAT_ID)
         {
            itemData = {};
            itemData.monsterId = 0;
            itemData.monsterSearch = data.item.name;
            if(data.item.dropTemporisMonsterIds)
            {
               itemData.monsterIdsList = data.item.dropMonsterIds.concat(data.item.dropTemporisMonsterIds);
            }
            else
            {
               itemData.monsterIdsList = data.item.dropMonsterIds;
            }
            itemData.forceOpen = true;
            this.systemApi.dispatchHook(HookList.OpenEncyclopedia,EnumTab.BESTIARY_TAB,itemData);
         }
         else if(data.id == EncyclopediaList.ITEM_HARVESTABLE_CAT_ID)
         {
            subAreaWithMaxItem = 0;
            subAreaMaxItemCount = 0;
            text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas",data.item.resourcesBySubarea.length),"m",data.item.resourcesBySubarea.length == 1,data.item.resourcesBySubarea.length == 0);
            itemSubAreas = new Vector.<uint>(0);
            for each(subAreaId in data.item.resourcesBySubarea)
            {
               subArea = this.dataApi.getSubArea(subAreaId[0]);
               if(subArea.hasCustomWorldMap || subArea.area.superArea.hasWorldMap)
               {
                  itemSubAreas.push(subAreaId[0]);
                  if(subAreaId[1] > subAreaMaxItemCount)
                  {
                     subAreaWithMaxItem = subAreaId[0];
                  }
               }
            }
            this._cartographyPopup = this.ankamaCartography.openCartographyPopup(data.item.name,subAreaWithMaxItem,itemSubAreas,text);
         }
      }
      
      private function getScrollFromForgettableSpell(spellDescr:Object, isForce:Boolean = false) : void
      {
         var spellSetsUsed:Array = null;
         var isSpellUsedInPreset:* = false;
         var isSpellUsedInActiveSet:* = false;
         if(!isForce)
         {
            spellSetsUsed = this.getSpellSetsWithSpell(spellDescr.spellId);
            isSpellUsedInPreset = spellSetsUsed.length > 0;
            isSpellUsedInActiveSet = this._activeSpellIds.indexOf(spellDescr.spellId) != -1;
         }
         if((isSpellUsedInPreset || isSpellUsedInActiveSet) && !isForce)
         {
            if(!this.uiApi.getUi(this.getScrollWarningUiName))
            {
               this.uiApi.loadUi(this.getScrollWarningUiName,this.getScrollWarningUiName,[spellDescr,spellSetsUsed,isSpellUsedInActiveSet,this.getScrollFromForgettableSpell,this.selfUiName]);
            }
         }
         else
         {
            this.systemApi.sendAction(new ForgettableSpellClientAction([spellDescr.spellId,ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_FORGET]));
         }
      }
      
      protected function isSpellScrollAvailable(scrollId:int) : Boolean
      {
         var inventoryContent:Vector.<ItemWrapper> = this.dataApi.getInventoryViewContent(STORAGE_CONSUMABLES_VIEW) as Vector.<ItemWrapper>;
         if(inventoryContent === null)
         {
            return false;
         }
         for(var index:uint = 0; index < inventoryContent.length; index++)
         {
            if(inventoryContent[index].id === scrollId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function searchScrollFromForgettableSpell(spellDescr:Object) : void
      {
         var forgettableSpell:ForgettableSpell = this.playedCharacterApi.getForgettableSpellById(spellDescr.spellId);
         if(forgettableSpell === null)
         {
            return;
         }
         var scrollWrapped:ItemWrapper = this.dataApi.getItemWrapper(forgettableSpell.itemId);
         if(scrollWrapped === null)
         {
            return;
         }
         if(this.isSpellScrollAvailable(scrollWrapped.id))
         {
            this.systemApi.dispatchHook(HookList.SearchForgettableSpellScroll,scrollWrapped.name);
         }
      }
      
      private function activeSpellDropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         var isValid:Boolean = false;
         var shortcutWrapper:ShortcutWrapper = null;
         if(data === null || !(source is Slot) || !(target is Slot))
         {
            return false;
         }
         var sourceSlot:Slot = source as Slot;
         var targetSlot:Slot = target as Slot;
         var sourceGrid:Grid = sourceSlot.getParent() as Grid;
         if(sourceGrid !== null && sourceGrid === targetSlot.getParent() as Grid && data is ShortcutWrapper)
         {
            isValid = false;
            for each(shortcutWrapper in this.gd_activeSpells.dataProvider)
            {
               if(shortcutWrapper !== null && shortcutWrapper.id === data.id)
               {
                  isValid = true;
                  break;
               }
            }
            if(!isValid)
            {
               return false;
            }
         }
         var spellWrapper:SpellWrapper = null;
         var targetSpellWrapper:SpellWrapper = null;
         if(data is SpellWrapper)
         {
            spellWrapper = data as SpellWrapper;
         }
         else if(data is ShortcutWrapper && data.realItem is SpellWrapper)
         {
            spellWrapper = data.realItem as SpellWrapper;
         }
         if(target.data is ShortcutWrapper && target.data.realItem is SpellWrapper)
         {
            targetSpellWrapper = target.data.realItem as SpellWrapper;
         }
         else if(target.data is SpellWrapper)
         {
            targetSpellWrapper = target.data;
         }
         if(this._currentTabName == FORGETTABLE_SPELLS_TAB_NAME && this._equippedForgettableSpells.length >= this.playedCharacterApi.getPlayerMaxForgettableSpellsNumber() && !this.isSpellActive(spellWrapper.spellId))
         {
            return targetSpellWrapper != null && this.playedCharacterApi.isForgettableSpell(targetSpellWrapper.id) == this.playedCharacterApi.isForgettableSpell(spellWrapper.id);
         }
         return spellWrapper != null;
      }
      
      private function processActiveSpellDrop(target:Object, data:Object, source:Object) : void
      {
         var isForgettableSpellRemoved:Boolean = false;
         var currentSpell:SpellWrapper = null;
         if(data is ShortcutWrapper)
         {
            if(!(data.realItem is SpellWrapper))
            {
               return;
            }
            this.systemApi.sendAction(new ShortcutBarSwapRequestAction([ShortcutBarEnum.SPELL_SHORTCUT_BAR,data.slot,this.gd_activeSpells.getItemIndex(target) + this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER]));
            this._hasProcessedDrop = true;
         }
         else
         {
            isForgettableSpellRemoved = false;
            if(target.data !== null && target.data is ShortcutWrapper && target.data.realItem is SpellWrapper)
            {
               currentSpell = target.data.realItem as SpellWrapper;
               if(currentSpell.id === data.id)
               {
                  return;
               }
               if(this.playedCharacterApi.isForgettableSpell(currentSpell.id))
               {
                  this.unequipForgettableSpell(currentSpell.id);
                  isForgettableSpellRemoved = true;
               }
            }
            if(this.playedCharacterApi.isForgettableSpell(data.id) && !this.isForgettableSpellEquipped(data.id))
            {
               if(!this.canForgettableSpellsBeAdded() && !isForgettableSpellRemoved)
               {
                  this.systemApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.temporis.warningTemporisSpellsLimit",this.playedCharacterApi.getPlayerMaxForgettableSpellsNumber()),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
                  return;
               }
               this.equipForgettableSpell(data.id);
            }
            this.systemApi.sendAction(new ShortcutBarAddRequestAction([DataEnum.SHORTCUT_TYPE_SPELL,data.id,this.gd_activeSpells.getItemIndex(target) + this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER]));
            this._hasProcessedDrop = true;
         }
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this.refreshForgettableSpellsList();
         }
         else if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            this.refreshCommonSpellsList();
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.gd_activeSpells:
               this.handleActiveSpellsSelect(target,selectMethod,isNewSelection);
               break;
            case this.cbx_learningSpellsFilter:
               this.updateLearnedSpellsFilter(this.cbx_learningSpellsFilter.selectedIndex);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var forgettableSpellSetUi:UiRootContainer = null;
         this.updateSearchBar();
         this.updateSpellLevelInputs();
         switch(target)
         {
            case this.mainCtr:
               forgettableSpellSetUi = this.uiApi.getUi(this.spellSetUiName);
               if(forgettableSpellSetUi !== null)
               {
                  forgettableSpellSetUi.setOnTop();
               }
               return;
            case this.btn_help:
               this.hintsApi.showSubHints(this._currentTabName);
               break;
            case this.btn_previousActiveSpells:
               this.currentActiveSpellsIndex = this._currentActiveSpellsIndex - 1;
               break;
            case this.btn_nextActiveSpells:
               this.currentActiveSpellsIndex = this._currentActiveSpellsIndex + 1;
               break;
            case this.btn_saveAsASpellSet:
               this.createSpellSet();
               break;
            case this.btn_seeMySpellSets:
               this.getSpellSets();
               break;
            case this.btn_forgettableSpells:
               this.currentTabName = FORGETTABLE_SPELLS_TAB_NAME;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_commonSpells:
               this.currentTabName = COMMON_SPELLS_TAB_NAME;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_finishMoves:
               this.currentTabName = FINISH_MOVES_TAB_NAME;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_clearSearchText:
               this.resetSearchBar();
               break;
            case this.btn_spellIsCraftable:
            case this.btn_spellIsDroppable:
            case this.btn_spellIsUnknown:
               this.updateObtainingFilter(target as ButtonContainer);
               break;
            case this.btn_sortForgettableSpellsByName:
            case this.btn_sortCommonSpellsByName:
               this.updateSpellNameSort();
               break;
            case this.btn_sortForgettableSpellsByLevel:
               this.updateSpellLevelSort();
               break;
            case this.btn_shareForgettableSpells:
               this.shareCurrentForgettableSpells();
               break;
            default:
               switch(true)
               {
                  case target.name.indexOf("tx_findForgettableSpellScroll") !== -1:
                     this.searchScrollFromForgettableSpell(this._componentsDictionary[target.name]);
                     break;
                  case target.name.indexOf("btn_getForgettableSpellScroll") !== -1:
                     this.getScrollFromForgettableSpell(this._componentsDictionary[target.name]);
                     break;
                  case target.name.indexOf("tx_obtaining_") !== -1:
                     this.handleObtainingClick(this._componentsDictionary[target.name]);
               }
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         var spellId:uint = 0;
         var shortcutWrapper:ShortcutWrapper = null;
         var wrapper:Object = null;
         var i:uint = 0;
         var firstEntryAvailableIndex:int = 0;
         if(target === this.gd_activeSpells)
         {
            this.removeSpellFromActiveSpells(this.gd_activeSpells.selectedIndex + this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER);
         }
         else if(target.name in this._componentsDictionary && target.name.indexOf("btn_forgettableSpellLine") !== -1 || target.name.indexOf("btn_commonSpellLine") !== -1 || target.name.indexOf("slot_forgettableSpell") !== -1 || target.name.indexOf("slot_commonSpell") !== -1)
         {
            spellId = this._componentsDictionary[target.name].spellId;
            if(this._activeSpellIds.indexOf(spellId) != -1)
            {
               if(this.playedCharacterApi.isForgettableSpell(spellId))
               {
                  this.unequipForgettableSpell(spellId);
               }
               else
               {
                  for(i = 0; i < this._activeSpells.length; i++)
                  {
                     wrapper = this._activeSpells[i];
                     if(wrapper is ShortcutWrapper)
                     {
                        shortcutWrapper = wrapper as ShortcutWrapper;
                        if(shortcutWrapper.realItem is SpellWrapper && (shortcutWrapper.realItem as SpellWrapper).spellId == spellId)
                        {
                           this.systemApi.sendAction(new ShortcutBarRemoveRequestAction([ShortcutBarEnum.SPELL_SHORTCUT_BAR,i]));
                           break;
                        }
                     }
                     else if(wrapper is SpellWrapper)
                     {
                        this.systemApi.sendAction(new ShortcutBarRemoveRequestAction([ShortcutBarEnum.SPELL_SHORTCUT_BAR,i]));
                        break;
                     }
                  }
               }
            }
            else
            {
               firstEntryAvailableIndex = this.getFirstActiveSpellIndexAvailable();
               if(firstEntryAvailableIndex >= 0)
               {
                  this.addSpellToActiveSpells(spellId,firstEntryAvailableIndex);
               }
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var scrollMagicWorkshopPosition:Point = null;
         var data:Object = null;
         if(target.name.indexOf("tx_obtaining_") !== -1 && this._componentsDictionary.hasOwnProperty(target.name))
         {
            data = this._componentsDictionary[target.name];
            if(data === null)
            {
               return;
            }
            tooltipText = null;
            switch(data.id)
            {
               case EncyclopediaList.ITEM_COMPONENT_CAT_ID:
                  (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.iconOverPath);
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterComponent");
                  break;
               case EncyclopediaList.ITEM_CRAFTABLE_CAT_ID:
                  (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.iconOverPath);
                  scrollMagicWorkshopPosition = null;
                  if(SCROLL_MAGIC_WORKSHOP_POSITION !== null)
                  {
                     scrollMagicWorkshopPosition = SCROLL_MAGIC_WORKSHOP_POSITION;
                  }
                  else
                  {
                     scrollMagicWorkshopPosition = new Point(0,0);
                  }
                  tooltipText = this.uiApi.getText("ui.temporis.craftableAt","[" + scrollMagicWorkshopPosition.x + "," + scrollMagicWorkshopPosition.y + "]");
                  break;
               case EncyclopediaList.ITEM_DROPABLE_CAT_ID:
                  (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.iconOverPath);
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterDropable");
                  break;
               case EncyclopediaList.ITEM_HARVESTABLE_CAT_ID:
                  (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.iconOverPath);
                  tooltipText = this.uiApi.getText("ui.encyclopedia.filterHarvestable");
                  break;
               case UNKNOWN_OBTAINING:
                  tooltipText = this.uiApi.getText("ui.temporis.unknownObtaining");
            }
            if(tooltipText === null)
            {
               return;
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target === this.ctr_shareForgettableSpells)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.disabledShareTemporisSpellsButtonHelp")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("slot") !== -1)
         {
            if(!(target.name in this._componentsDictionary))
            {
               return;
            }
            data = this._componentsDictionary[target.name];
            if(target.name.indexOf("slot_commonSpell_m_gd_commonSpells") !== -1)
            {
               this.showSpellTooltip(data,target,FROM_COMMON_SPELLS);
            }
            else if(target.name.indexOf("slot_forgettableSpell_m_gd_forgettableSpells") !== -1)
            {
               this.showSpellTooltip(data,target,FROM_FORGETTABLE_SPELLS);
            }
         }
         else if(target === this.btn_spellIsCraftable)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.encyclopedia.filterCraftable")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target === this.btn_spellIsDroppable)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.encyclopedia.filterDropable")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target === this.btn_spellIsUnknown)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.temporis.unknownObtaining")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("btn_") !== -1 && target.name.indexOf("SpellLine") !== -1)
         {
            (target as ButtonContainer).state = StatesEnum.STATE_SELECTED_OVER;
         }
         else
         {
            switch(data)
            {
               case -1:
                  if(target.name.indexOf("btn_getForgettableSpellScroll") !== -1)
                  {
                     this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText(this.getScrollBtnOverTextKey)),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
                     break;
                  }
                  break;
               default:
                  this.showSpellTooltip(data.data,data.target,FROM_COMMON_SPELLS);
               case null:
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         var data:Object = null;
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         if(target.name.indexOf("tx_obtaining_") !== -1)
         {
            data = this._componentsDictionary[target.name];
            if(data === null)
            {
               return;
            }
            (target as Texture).uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + data.iconGreyPath);
         }
         else if(target.name.indexOf("btn_") !== -1 && target.name.indexOf("SpellLine") !== -1)
         {
            (target as ButtonContainer).state = StatesEnum.STATE_NORMAL;
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(target === this.gd_activeSpells)
         {
            this.showSpellTooltip(item.data,item.container,FROM_ACTIVE_SPELLS);
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         this.showRemoveSpellMenu(item.data);
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         var me:UiRootContainer = null;
         if(shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
         {
            me = this.uiApi.me();
            if(me === null)
            {
               this.systemApi.log(16,"ForgettableSpellsUi: the current UI is null!");
               return false;
            }
            this.uiApi.unloadUi(me.name);
            return true;
         }
         return false;
      }
      
      private function onActiveSpellDropStart(source:Object) : void
      {
         if(source.getUi() === this.uiApi.me())
         {
            this.systemApi.disableWorldInteraction();
         }
      }
      
      private function onActiveSpellDropEnd(source:Object, target:Object) : void
      {
         var targetSlot:Slot = null;
         var parentUi:UiRootContainer = null;
         var currentIndex:uint = 0;
         var currentSpellSlot:Slot = null;
         if(this._hasProcessedDrop)
         {
            this._hasProcessedDrop = false;
            return;
         }
         if(source.getUi() === this.uiApi.me())
         {
            this.systemApi.enableWorldInteraction();
         }
         if(source.parent !== this.gd_activeSpells || (source.data === null || source.data.objectGID === null) || (source === null || source.data === null || !(source.data is ShortcutWrapper)))
         {
            return;
         }
         if(target === source)
         {
            return;
         }
         if(target is Slot)
         {
            targetSlot = target as Slot;
            parentUi = targetSlot.getUi();
            if(parentUi !== null && parentUi.name !== null && (parentUi.name === "bannerActionBar" || parentUi.name.indexOf("externalActionBar") !== -1) && target.parent !== null && target.parent.name === "gd_spellitemotes")
            {
               return;
            }
         }
         var spellSlot:Slot = source as Slot;
         var activeSpellsGrid:Grid = spellSlot.parent as Grid;
         if(activeSpellsGrid !== null)
         {
            currentIndex = 0;
            for each(currentSpellSlot in activeSpellsGrid.slots)
            {
               if(currentSpellSlot === spellSlot)
               {
                  this.removeSpellFromActiveSpells(currentIndex + this._currentActiveSpellsIndex * ACTIVE_SPELLS_BY_PAGE_NUMBER);
                  break;
               }
               currentIndex++;
            }
         }
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.inp_spellLevelSearch:
               this.handleSearchInput();
               break;
            case this.inp_minSpellLevel:
            case this.inp_maxSpellLevel:
               this.updateSpellLevelFilter();
         }
      }
      
      private function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == Keyboard.ALTERNATE)
         {
            this._isAltDown = true;
         }
      }
      
      private function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == Keyboard.ALTERNATE)
         {
            this._isAltDown = false;
         }
      }
      
      private function onAreActiveSpellsAlterable(areActiveSpellsAlterable:Boolean) : void
      {
         this._areActiveSpellsAlterable = areActiveSpellsAlterable;
         if(!areActiveSpellsAlterable)
         {
            this._isAltDown = false;
         }
         (this.gd_activeSpells.renderer as SlotGridRenderer).allowDrop = this._areActiveSpellsAlterable || this._isAltDown;
      }
      
      public function onWheel(target:GraphicContainer, delta:int) : void
      {
         if(target === this.gd_activeSpells || target === this.ctr_activeSpellsButtons)
         {
            if(delta > 0)
            {
               this.currentActiveSpellsIndex = this._currentActiveSpellsIndex - 1;
            }
            else
            {
               this.currentActiveSpellsIndex = this._currentActiveSpellsIndex + 1;
            }
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip(SPELL_TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
      }
      
      private function onShortcutBarViewContent(barType:int) : void
      {
         if(barType === ShortcutBarEnum.SPELL_SHORTCUT_BAR)
         {
            this.loadActiveSpells();
            if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
            {
               this.refreshForgettableSpellsList();
            }
            else if(this._currentTabName === COMMON_SPELLS_TAB_NAME)
            {
               this.refreshCommonSpellsList();
            }
         }
      }
      
      private function onFinishMovesLoaded(event:Event) : void
      {
         if(this._finishMovesUi === null)
         {
            return;
         }
         this._finishMovesUi.removeEventListener("UIRenderComplete",this.onFinishMovesLoaded);
         this._finishMovesUi.uiClass.ctr_finishMoveList.x = 50;
         this._finishMovesUi.uiClass.ctr_finishMoveList.y = 160;
         this._finishMovesUi.uiClass.ctr_illu.height = 360;
         this._finishMovesUi.uiClass.tx_illu.height = 330;
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(target is Slot)
         {
            this.showAddSpellMenu(target as Slot);
         }
      }
      
      private function onForgettableSpells() : void
      {
         if(this._currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            this.refreshForgettableSpellsList();
         }
      }
      
      private function onForgettableSpellPresetSaved(presetId:int) : void
      {
         this.getSpellSets(presetId);
      }
      
      public function onUiLoaded(name:String) : void
      {
         var forgettableSpellSetUi:UiRootContainer = null;
         if(name === UIEnum.INVENTORY_UI)
         {
            forgettableSpellSetUi = this.uiApi.getUi(this.spellSetUiName);
            if(forgettableSpellSetUi !== null)
            {
               forgettableSpellSetUi.setOnTop();
            }
         }
      }
      
      public function onPresetsUpdate(buildId:int = -1) : void
      {
         this.setSaveSpellSetButton();
      }
      
      public function onPresetError(reasonText:String) : void
      {
         this.setSaveSpellSetButton();
      }
      
      protected function get storageStateMod() : String
      {
         return "forgettableSpellsUi";
      }
      
      protected function get searchInputPlaceholder() : String
      {
         return this.uiApi.getText("ui.temporis.searchSpell");
      }
      
      protected function beforeForgettableSpellsDataProvider() : void
      {
      }
      
      protected function get getScrollBtnOverTextKey() : String
      {
         return "ui.temporis.getScrollFromTemporisSpell";
      }
      
      protected function get spellSetUiName() : String
      {
         return UIEnum.FORGETTABLE_SPELL_SETS_UI;
      }
      
      protected function get presetLimit() : int
      {
         return ProtocolConstantsEnum.MAX_FORGETTABLE_SPELLS_PRESET_COUNT;
      }
      
      protected function get spellsIntroPopupDesc() : String
      {
         return this.uiApi.getText("ui.temporis.spellsUiIntroPopupDescription");
      }
      
      protected function get spellsIntroPopupTitle() : String
      {
         return this.uiApi.getText("ui.temporis.spellsUiIntroPopupTitle");
      }
      
      protected function get selfUiName() : String
      {
         return UIEnum.FORGETTABLE_SPELLS_UI;
      }
      
      protected function get getScrollWarningUiName() : String
      {
         return UIEnum.FORGETTABLE_SPELL_GET_SCROLL_WARNING_POP_UP;
      }
      
      protected function get commonSpellsDataStorageName() : String
      {
         return STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE;
      }
   }
}
