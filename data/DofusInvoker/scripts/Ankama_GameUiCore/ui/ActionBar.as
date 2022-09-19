package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import Ankama_GameUiCore.ui.params.ActionBarParameters;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.ForgettableSpellClientAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenForgettableSpellsUiAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.ForgettableSpellClientActionEnum;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import damageCalculation.tools.StatIds;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   
   public class ActionBar extends ContextAwareUi
   {
      
      protected static var externalActionBars:Vector.<ActionBar> = new Vector.<ActionBar>(4,true);
      
      protected static var mainBar:ActionBar;
      
      private static const TYPE_ITEM_WRAPPER:int = 0;
      
      private static const TYPE_BUILD_WRAPPER:int = 1;
      
      private static const TYPE_SMILEY_WRAPPER:int = 3;
      
      private static const TYPE_EMOTE_WRAPPER:int = 4;
      
      private static const TYPE_IDOLS_PRESET_WRAPPER:int = 5;
      
      protected static const NUM_PAGES:uint = 5;
      
      private static const NUM_ITEMS_PER_PAGE:uint = 20;
      
      protected static const EXTERNAL_UI_BASE_NAME:String = "externalActionBar";
      
      private static const EXTERNAL_UI_VERTICAL_NAME:String = "externalActionBarVertical";
      
      private static var _shortcutColor:String;
      
      protected static var ITEMS_TAB:String = "items";
      
      protected static var SPELLS_TAB:String = "spells";
       
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var gd_spellitemotes:Grid;
      
      public var btn_tabSpells:ButtonContainer;
      
      public var btn_tabItems:ButtonContainer;
      
      public var ctr_changeNumber:GraphicContainer;
      
      public var btn_upArrow:ButtonContainer;
      
      public var btn_downArrow:ButtonContainer;
      
      public var btn_addActionBar:ButtonContainer;
      
      public var lbl_itemsNumber:Label;
      
      protected var _nPageItems:uint = 0;
      
      protected var _nPageSpells:uint = 0;
      
      protected var _sTabGrid:String;
      
      protected var _aSpells;
      
      private var _aItems;
      
      private var _itemToUseId:uint;
      
      private var _waitingObjectUID:uint;
      
      private var _waitingObjectPosition:uint;
      
      private var _buildSpellPreview:Boolean;
      
      private var _spellMovementAllowed:Boolean = false;
      
      private var _shortcutsMovementAllowed:Boolean = false;
      
      private var _altDown:Boolean = false;
      
      private var _isDragging:Boolean = false;
      
      protected var isMainBar:Boolean = true;
      
      protected var isForgettableSpellsUi:Boolean = false;
      
      protected var isModsterUi:Boolean = false;
      
      public function ActionBar()
      {
         super();
      }
      
      public function get nPageItems() : uint
      {
         return this._nPageItems;
      }
      
      public function get nPageSpells() : uint
      {
         return this._nPageSpells;
      }
      
      public function get sTabGrid() : String
      {
         return this._sTabGrid;
      }
      
      override public function main(args:Array) : void
      {
         var i:int = 0;
         super.main(args);
         this.isForgettableSpellsUi = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.FORGETTABLE_SPELLS);
         this.isModsterUi = this.isForgettableSpellsUi && this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.MODSTERS);
         if(args && args.length && (args[0] as ActionBarParameters).context)
         {
            currentContext = (args[0] as ActionBarParameters).context;
         }
         sysApi.addHook(HookList.OpenInventory,this.onOpenInventory);
         sysApi.addHook(CustomUiHookList.SwitchBannerTab,this.onSwitchBannerTab);
         sysApi.addHook(InventoryHookList.WeaponUpdate,this.onWeaponUpdate);
         sysApi.addHook(CustomUiHookList.SpellMovementAllowed,this.onSpellMovementAllowed);
         sysApi.addHook(CustomUiHookList.ShortcutsMovementAllowed,this.onShortcutsMovementAllowed);
         sysApi.addHook(InventoryHookList.PresetsUpdate,this.onPresetsUpdate);
         sysApi.addHook(CustomUiHookList.PreviewBuildSpellBar,this.previewBuildShortcuts);
         sysApi.addHook(HookList.IdolsPresetDelete,this.onIdolsPresetDelete);
         sysApi.addHook(FightHookList.SlaveStatsList,this.onSlaveStatsList);
         sysApi.addHook(InventoryHookList.ShortcutBarViewContent,this.onShortcutBarViewContent);
         sysApi.addHook(BeriliaHookList.DropStart,this.onDropStart);
         sysApi.addHook(BeriliaHookList.DropEnd,this.onDropEnd);
         sysApi.addHook(HookList.CancelCastSpell,this.onCancelCastSpell);
         sysApi.addHook(HookList.CastSpellMode,this.onCastSpellMode);
         sysApi.addHook(HookList.SpellUpdate,this.onSpellUpdate);
         sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.btn_upArrow.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_downArrow.soundId = SoundEnum.SCROLL_UP;
         this.btn_tabSpells.soundId = SoundEnum.BANNER_SPELL_TAB;
         this.btn_tabItems.soundId = SoundEnum.BANNER_OBJECT_TAB;
         this.uiApi.addShortcutHook("cac",this.onShortcut);
         this.uiApi.addShortcutHook("s1",this.onShortcut);
         this.uiApi.addShortcutHook("s2",this.onShortcut);
         this.uiApi.addShortcutHook("s3",this.onShortcut);
         this.uiApi.addShortcutHook("s4",this.onShortcut);
         this.uiApi.addShortcutHook("s5",this.onShortcut);
         this.uiApi.addShortcutHook("s6",this.onShortcut);
         this.uiApi.addShortcutHook("s7",this.onShortcut);
         this.uiApi.addShortcutHook("s8",this.onShortcut);
         this.uiApi.addShortcutHook("s9",this.onShortcut);
         this.uiApi.addShortcutHook("s10",this.onShortcut);
         this.uiApi.addShortcutHook("s11",this.onShortcut);
         this.uiApi.addShortcutHook("s12",this.onShortcut);
         this.uiApi.addShortcutHook("s13",this.onShortcut);
         this.uiApi.addShortcutHook("s14",this.onShortcut);
         this.uiApi.addShortcutHook("s15",this.onShortcut);
         this.uiApi.addShortcutHook("s16",this.onShortcut);
         this.uiApi.addShortcutHook("s17",this.onShortcut);
         this.uiApi.addShortcutHook("s18",this.onShortcut);
         this.uiApi.addShortcutHook("s19",this.onShortcut);
         this.uiApi.addShortcutHook("s20",this.onShortcut);
         this.uiApi.addShortcutHook("bannerSpellsTab",this.onShortcut);
         this.uiApi.addShortcutHook("bannerItemsTab",this.onShortcut);
         this.uiApi.addShortcutHook("bannerPreviousTab",this.onShortcut);
         this.uiApi.addShortcutHook("bannerNextTab",this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_1,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_2,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_3,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_4,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_5,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_DOWN,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PAGE_ITEM_UP,this.onShortcut);
         this.uiApi.addComponentHook(this.gd_spellitemotes,"onWheel");
         this.uiApi.addComponentHook(this.gd_spellitemotes,"onPress");
         this.uiApi.addComponentHook(this.btn_downArrow,"onRollOver");
         this.uiApi.addComponentHook(this.btn_downArrow,"onRollOut");
         this.uiApi.addComponentHook(this.btn_upArrow,"onRollOver");
         this.uiApi.addComponentHook(this.btn_upArrow,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabItems,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabItems,"onRollOut");
         this.uiApi.addComponentHook(this.btn_tabSpells,"onRollOver");
         this.uiApi.addComponentHook(this.btn_tabSpells,"onRollOut");
         this.uiApi.addComponentHook(this.btn_addActionBar,"onRollOver");
         this.uiApi.addComponentHook(this.btn_addActionBar,"onRollOut");
         this.uiApi.addComponentHook(this.ctr_changeNumber,"onWheel");
         StatsManager.getInstance().addListenerToStat(StatIds.ACTION_POINTS,this.onUpdateActionPoints);
         this._aSpells = [];
         this._aItems = [];
         this.btn_upArrow.disabled = true;
         this.gd_spellitemotes.autoSelectMode = 0;
         (this.gd_spellitemotes.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidator;
         (this.gd_spellitemotes.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
         (this.gd_spellitemotes.renderer as SlotGridRenderer).removeDropSourceFunction = this.emptyFct;
         this.gd_spellitemotes.keyboardIndexHandler = this.onGridKeyDown;
         if(this.isMainBar)
         {
            mainBar = this;
            for(i = 0; i < externalActionBars.length; i++)
            {
               this.loadExternalActionBar(i);
            }
            sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
            sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
            this._nPageItems = sysApi.getData("bannerItemsPageIndex");
            if(this.getPlayerId() >= 0)
            {
               this._nPageSpells = sysApi.getData("bannerSpellsPageIndex" + this.getPlayerId());
            }
            else
            {
               this._nPageSpells = 0;
            }
            this.onShortcutBarViewContent(0);
            this.onShortcutBarViewContent(1);
            this.onContextChanged(currentContext);
         }
      }
      
      override protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         switch(context)
         {
            case ContextEnum.SPECTATOR:
               this.gd_spellitemotes.disabled = true;
               break;
            case ContextEnum.PREFIGHT:
               this.gridDisplay(ITEMS_TAB,true);
               break;
            case ContextEnum.FIGHT:
               this.gridDisplay(SPELLS_TAB,true);
               break;
            case ContextEnum.ROLEPLAY:
               this.gridDisplay(ITEMS_TAB,true);
               this.gd_spellitemotes.disabled = false;
         }
      }
      
      private function loadExternalActionBar(pActionBarId:uint, pOrientationChanged:Boolean = false, pContext:String = null) : void
      {
         var uiName:String = EXTERNAL_UI_BASE_NAME;
         var orientation:uint = ExternalActionBar.ORIENTATION_HORIZONTAL;
         var externalActionBarsState:* = sysApi.getData(this.dataKey,DataStoreEnum.BIND_CHARACTER);
         if(externalActionBarsState && externalActionBarsState[pActionBarId] && externalActionBarsState[pActionBarId].orientation == ExternalActionBar.ORIENTATION_VERTICAL)
         {
            uiName = EXTERNAL_UI_VERTICAL_NAME;
            orientation = ExternalActionBar.ORIENTATION_VERTICAL;
         }
         this.uiApi.loadUi(uiName,EXTERNAL_UI_BASE_NAME + "_" + pActionBarId,[new ActionBarParameters(pActionBarId,orientation,pOrientationChanged,pContext)],StrataEnum.STRATA_TOP,null,true);
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         if(uiName && uiName.indexOf(EXTERNAL_UI_BASE_NAME) == 0)
         {
            this.btn_addActionBar.disabled = !this.canAddExternalActionBar();
         }
      }
      
      private function onUiUnloaded(uiName:String) : void
      {
         if(uiName && uiName.indexOf(EXTERNAL_UI_BASE_NAME) == 0)
         {
            this.btn_addActionBar.disabled = !this.canAddExternalActionBar();
         }
      }
      
      public function reloadExternalActionBar(pActionBarId:uint, pContext:String) : void
      {
         this.loadExternalActionBar(pActionBarId,true,pContext);
      }
      
      public function gridDisplay(tabStyle:String, forceRefresh:Boolean = false) : void
      {
         var index:int = 0;
         var dropAllEnabled:Boolean = false;
         if(currentContext == ContextEnum.ROLEPLAY)
         {
            dropAllEnabled = true;
         }
         if(tabStyle == this._sTabGrid && !forceRefresh)
         {
            return;
         }
         var autoselect:* = tabStyle == this._sTabGrid;
         this._sTabGrid = tabStyle;
         switch(tabStyle)
         {
            case SPELLS_TAB:
               this.btn_tabSpells.visible = false;
               this.btn_tabItems.visible = true;
               (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = this._spellMovementAllowed;
               this.updateGrid(this._aSpells,this._nPageSpells,autoselect);
               this.lbl_itemsNumber.text = (this._nPageSpells + 1).toString();
               index = this._nPageSpells;
               break;
            case ITEMS_TAB:
               this.btn_tabSpells.visible = true;
               this.btn_tabItems.visible = false;
               (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = !!dropAllEnabled ? Boolean(dropAllEnabled) : Boolean(this._shortcutsMovementAllowed);
               this.updateGrid(this._aItems,this._nPageItems,autoselect);
               this.lbl_itemsNumber.text = (this._nPageItems + 1).toString();
               index = this._nPageItems;
         }
         this.btn_upArrow.disabled = index == 0;
         this.btn_downArrow.disabled = index == NUM_PAGES - 1;
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var data:Object = null;
         var tooltipMaker:String = null;
         var settings:Object = null;
         var setting:String = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var cacheName:String = null;
         var text:* = null;
         var itemWrapper:ItemWrapper = null;
         var spellWrapper:SpellWrapper = null;
         var isWeapon:Boolean = false;
         var build:BuildWrapper = null;
         var iw:ItemWrapper = null;
         var ref:GraphicContainer = this.uiApi.getUi(UIEnum.BANNER).getElement(!!sysApi.isFightContext() ? "tooltipFightPlacer" : "tooltipRoleplayPlacer");
         var cte:String = "bannerActionBar::gd_spellitemotes::item";
         var nSlot:int = int(item.container.name.substr(cte.length)) + 1;
         var shortcutKey:String = this.bindsApi.getShortcutBindStr("s" + nSlot);
         if(!item.data)
         {
            return;
         }
         if(!_shortcutColor)
         {
            _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
            _shortcutColor = _shortcutColor.replace("0x","#");
         }
         if(target == this.gd_spellitemotes)
         {
            if(this._sTabGrid == ITEMS_TAB)
            {
               cacheName = "TextInfo";
               switch(item.data.type)
               {
                  case TYPE_ITEM_WRAPPER:
                     itemWrapper = this.inventoryApi.getItem(item.data.id);
                     if(!itemWrapper)
                     {
                        itemWrapper = this.dataApi.getItemWrapper(item.data.gid);
                     }
                     data = this.tooltipApi.getItemTooltipInfo(itemWrapper,shortcutKey);
                     tooltipMaker = "itemName";
                     settings = {};
                     itemTooltipSettings = this.getItemTooltipSettings();
                     for each(setting in sysApi.getObjectVariables(itemTooltipSettings))
                     {
                        settings[setting] = itemTooltipSettings[setting];
                     }
                     settings.ref = ref;
                     cacheName = "ItemInfo";
                     break;
                  case TYPE_BUILD_WRAPPER:
                     if(!item.data.realItem)
                     {
                        return;
                     }
                     text = item.data.realItem.buildName;
                     if(shortcutKey && shortcutKey != "")
                     {
                        text += " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
                     }
                     data = this.uiApi.textTooltipInfo(text);
                     break;
                  case TYPE_SMILEY_WRAPPER:
                     text = this.uiApi.getText("ui.banner.emote.tooltip");
                     if(shortcutKey && shortcutKey != "")
                     {
                        text += " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
                     }
                     data = this.uiApi.textTooltipInfo(text);
                     break;
                  case TYPE_EMOTE_WRAPPER:
                     text = item.data.name;
                     if(shortcutKey && shortcutKey != "")
                     {
                        text += " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
                     }
                     data = this.uiApi.textTooltipInfo(text);
                     tooltipMaker = "emoteName";
                     break;
                  case TYPE_IDOLS_PRESET_WRAPPER:
                     text = this.uiApi.getText("ui.idol.preset.tooltip",item.data.id + 1);
                     if(shortcutKey && shortcutKey != "")
                     {
                        text += " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
                     }
                     data = this.uiApi.textTooltipInfo(text);
                     break;
                  default:
                     if(shortcutKey && shortcutKey != "")
                     {
                        text = " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>";
                        data = this.uiApi.textTooltipInfo(text);
                        break;
                     }
                     return;
               }
               this.uiApi.showTooltip(data,item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,tooltipMaker,null,settings,cacheName);
            }
            else if(this._sTabGrid == SPELLS_TAB)
            {
               if(!item.data.realItem)
               {
                  return;
               }
               spellWrapper = this.dataApi.getSpellWrapper(item.data.id,item.data.realItem.spellLevel,true);
               if(spellWrapper == null)
               {
                  return;
               }
               if(this._buildSpellPreview)
               {
                  for each(build in this.inventoryApi.getBuilds())
                  {
                     if(build.id == this.inventoryApi.getBuildId())
                     {
                        break;
                     }
                  }
                  for each(iw in build.equipment)
                  {
                     if(iw is WeaponWrapper)
                     {
                        break;
                     }
                  }
                  if((item.data.realItem is WeaponWrapper || item.data.realItem is SpellWrapper && item.data.realItem.isSpellWeapon) && iw is WeaponWrapper)
                  {
                     settings = {};
                     itemTooltipSettings = this.getItemTooltipSettings();
                     for each(setting in sysApi.getObjectVariables(itemTooltipSettings))
                     {
                        settings[setting] = itemTooltipSettings[setting];
                     }
                     settings.ref = ref;
                     data = this.tooltipApi.getWeaponTooltipInfo(spellWrapper,shortcutKey,settings,iw as WeaponWrapper);
                     cacheName = "ItemInfo";
                  }
                  else
                  {
                     data = this.tooltipApi.getSpellTooltipInfo(spellWrapper,shortcutKey);
                     cacheName = "SpellBanner";
                  }
               }
               else
               {
                  isWeapon = (item.data.realItem is WeaponWrapper || item.data.realItem is SpellWrapper && item.data.realItem.isSpellWeapon) && this.inventoryApi.getCurrentWeapon();
                  if(isWeapon)
                  {
                     settings = {};
                     itemTooltipSettings = this.getItemTooltipSettings();
                     for each(setting in sysApi.getObjectVariables(itemTooltipSettings))
                     {
                        settings[setting] = itemTooltipSettings[setting];
                     }
                     settings.ref = ref;
                     data = this.tooltipApi.getWeaponTooltipInfo(spellWrapper,shortcutKey,settings);
                     cacheName = "ItemInfo";
                  }
                  else
                  {
                     data = this.tooltipApi.getSpellTooltipInfo(spellWrapper,shortcutKey);
                     cacheName = "SpellBanner";
                  }
               }
               this.uiApi.showTooltip(data,item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,3,null,null,null,cacheName);
            }
         }
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         var trueData:Object = null;
         var makercontentLength:uint = 0;
         var disabled:Boolean = false;
         var spellContextMenu:ContextMenuData = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         switch(this._sTabGrid)
         {
            case ITEMS_TAB:
               data = item.data;
               if(data == null || data.realItem == null)
               {
                  return;
               }
               trueData = data.realItem;
               contextMenu = this.menuApi.create(trueData,"item",[{"ownedItem":true}]);
               makercontentLength = contextMenu.content.length;
               disabled = false;
               if(contextMenu && contextMenu.content && contextMenu.content[0])
               {
                  disabled = contextMenu.content[0].disabled;
               }
               if(data.type == TYPE_ITEM_WRAPPER && data.targetable && !data.nonUsableOnAnother)
               {
                  contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.target"),this.onItemUseOnCell,[data.id],disabled));
               }
               if(data.usable || data.type == TYPE_BUILD_WRAPPER || data.type == TYPE_SMILEY_WRAPPER || data.type == TYPE_EMOTE_WRAPPER)
               {
                  if(data.quantity > 1 && data.isOkForMultiUse)
                  {
                     contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.multipleUse"),this.useItemQuantity,[data.id,data.quantity,item.container],disabled));
                  }
                  contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.use"),this.useItem,[data.id,data.type],!disabled ? !data.active : Boolean(disabled)));
               }
               if(data.type == TYPE_ITEM_WRAPPER && data.category == 0)
               {
                  contextMenu.content.unshift(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.equip"),this.equipItem,[trueData],!disabled ? !data.active : Boolean(disabled)));
               }
               contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"),this.onRemoveItem,[data.slot],false));
               if(contextMenu.content.length && makercontentLength > 0)
               {
                  contextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject());
               }
               if(data.type != TYPE_BUILD_WRAPPER && data.type != TYPE_IDOLS_PRESET_WRAPPER)
               {
                  itemTooltipSettings = this.getItemTooltipSettings();
                  contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"),null,null,false,[this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.name"),this.onItemTooltipDisplayOption,["header"],disabled,null,itemTooltipSettings.header,false),this.modContextMenu.createContextMenuItemObject(this.uiApi.processText(this.uiApi.getText("ui.common.effects"),"",false),this.onItemTooltipDisplayOption,["effects"],disabled,null,itemTooltipSettings.effects,false),this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.conditions"),this.onItemTooltipDisplayOption,["conditions"],disabled,null,itemTooltipSettings.conditions,false),this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.description"),this.onItemTooltipDisplayOption,["description"],disabled,null,itemTooltipSettings.description,false),this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.item.averageprice"),this.onItemTooltipDisplayOption,["averagePrice"],disabled,null,itemTooltipSettings.averagePrice,false)],disabled));
               }
               if(contextMenu.content.length > 0)
               {
                  this.modContextMenu.createContextMenu(contextMenu);
               }
               break;
            case SPELLS_TAB:
               this.uiApi.hideTooltip();
               this.uiApi.hideTooltip("spellBanner");
               data = item.data;
               if(data == null)
               {
                  return;
               }
               spellContextMenu = this.menuApi.create(data.realItem,"spell",[{"replaceByOtherSpell":true}]);
               spellContextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject(),this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.remove"),this.onRemoveSpell,[data.slot],false));
               this.modContextMenu.createContextMenu(spellContextMenu);
               break;
         }
      }
      
      public function onItemUseOnCell(id:uint) : void
      {
         if(id)
         {
            sysApi.sendAction(new ObjectUseAction([id,1,true]));
         }
      }
      
      public function useItem(id:uint, shortcutType:uint = 0) : void
      {
         if(shortcutType == TYPE_BUILD_WRAPPER)
         {
            sysApi.sendAction(new PresetUseRequestAction([id]));
         }
         else if(shortcutType == TYPE_SMILEY_WRAPPER)
         {
            sysApi.sendAction(new ChatSmileyRequestAction([id]));
         }
         else if(shortcutType == TYPE_EMOTE_WRAPPER)
         {
            sysApi.sendAction(new EmotePlayRequestAction([id]));
         }
         else if(shortcutType == TYPE_IDOLS_PRESET_WRAPPER)
         {
            sysApi.sendAction(new PresetUseRequestAction([id]));
         }
         else
         {
            sysApi.sendAction(new ObjectUseAction([id,1,false]));
         }
      }
      
      public function useItemQuantity(id:uint, qtyMax:uint = 1, target:GraphicContainer = null) : void
      {
         this._itemToUseId = id;
         this.modCommon.openQuantityPopup(1,qtyMax,1,this.onValidItemQuantityUse,null,false,target);
      }
      
      public function onValidItemQuantityUse(qty:Number) : void
      {
         sysApi.sendAction(new ObjectUseAction([this._itemToUseId,qty,false]));
         this._itemToUseId = 0;
      }
      
      public function onItemRollOut(target:Object, item:Object) : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.hideTooltip("spellBanner");
      }
      
      public function onWheel(target:GraphicContainer, delta:int) : void
      {
         if(delta > 0)
         {
            this.pageItemUp();
         }
         else
         {
            this.pageItemDown();
         }
      }
      
      protected function getPlayerId() : Number
      {
         if(this.playerApi.isInFight())
         {
            return this.fightApi.getCurrentPlayedFighterId();
         }
         return this.playerApi.id();
      }
      
      private function onGridKeyDown(oldIndex:int, newIndex:int) : int
      {
         var numPage:uint = this._sTabGrid == ITEMS_TAB ? uint(this._nPageItems) : uint(this._nPageSpells);
         var index:int = newIndex;
         if(newIndex < 0)
         {
            if(numPage > 0)
            {
               this.pageItemUp();
               index = newIndex == -1 ? int(NUM_ITEMS_PER_PAGE - 1) : int(oldIndex + this.gd_spellitemotes.slotByRow);
            }
         }
         else if(newIndex > NUM_ITEMS_PER_PAGE - 1)
         {
            this.pageItemDown();
            if(numPage < NUM_PAGES - 1)
            {
               index = newIndex == NUM_ITEMS_PER_PAGE ? 0 : int(oldIndex - this.gd_spellitemotes.slotByRow);
            }
            else
            {
               index = oldIndex;
            }
         }
         return index;
      }
      
      private function getItemTooltipSettings() : ItemTooltipSettings
      {
         var itemTooltipSettings:ItemTooltipSettings = sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.setItemTooltipSettings(itemTooltipSettings);
         }
         return itemTooltipSettings;
      }
      
      private function setItemTooltipSettings(val:ItemTooltipSettings) : Boolean
      {
         return sysApi.setData("itemTooltipSettings",val,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onIdolsPresetDelete(pPresetId:uint) : void
      {
         var shortcut:Object = null;
         for each(shortcut in this._aItems)
         {
            if(shortcut && shortcut.type == TYPE_IDOLS_PRESET_WRAPPER && shortcut.id == pPresetId)
            {
               this.onRemoveItem(shortcut.slot);
               break;
            }
         }
      }
      
      public function unselectSpell() : void
      {
         if(this.fightApi.isCastingSpell())
         {
            this.fightApi.cancelSpell();
         }
      }
      
      protected function displayPage() : void
      {
         var index:int = 0;
         if(this._sTabGrid == ITEMS_TAB)
         {
            index = this._nPageItems;
            sysApi.setData("bannerItemsPageIndex",this._nPageItems);
         }
         else if(this._sTabGrid == SPELLS_TAB)
         {
            index = this._nPageSpells;
            if(this.getPlayerId() >= 0 && !this.fightApi.isSlaveContext())
            {
               sysApi.setData("bannerSpellsPageIndex" + this.getPlayerId(),this._nPageSpells);
            }
         }
         this.lbl_itemsNumber.text = (index + 1).toString();
         this.btn_upArrow.disabled = index == 0;
         this.btn_downArrow.disabled = index == NUM_PAGES - 1;
      }
      
      private function pageItem(page:int) : void
      {
         if(page < NUM_PAGES && page >= 0)
         {
            switch(this._sTabGrid)
            {
               case ITEMS_TAB:
                  this._nPageItems = page;
                  this.updateGrid(this._aItems,this._nPageItems,false);
                  break;
               case SPELLS_TAB:
                  this._nPageSpells = page;
                  this.updateGrid(this._aSpells,this._nPageSpells,false);
            }
            this.displayPage();
         }
      }
      
      private function pageItemDown() : void
      {
         switch(this._sTabGrid)
         {
            case ITEMS_TAB:
               if(this._nPageItems < NUM_PAGES - 1)
               {
                  ++this._nPageItems;
                  this.updateGrid(this._aItems,this._nPageItems,false);
                  this.displayPage();
               }
               break;
            case SPELLS_TAB:
               if(this._nPageSpells < NUM_PAGES - 1)
               {
                  ++this._nPageSpells;
                  this.updateGrid(this._aSpells,this._nPageSpells,false);
                  this.displayPage();
               }
         }
      }
      
      private function pageItemUp() : void
      {
         switch(this._sTabGrid)
         {
            case ITEMS_TAB:
               if(this._nPageItems > 0)
               {
                  --this._nPageItems;
                  this.updateGrid(this._aItems,this._nPageItems,false);
                  this.displayPage();
               }
               break;
            case SPELLS_TAB:
               if(this._nPageSpells > 0)
               {
                  --this._nPageSpells;
                  this.updateGrid(this._aSpells,this._nPageSpells,false);
                  this.displayPage();
               }
         }
      }
      
      protected function removeForgettableSpell(spellId:int, index:int) : void
      {
         var currentIndex:uint = 0;
         var areDuplicates:Boolean = false;
         var currentShortcutWrapper:ShortcutWrapper = null;
         var currentSpellWrapper:SpellWrapper = null;
         for(currentIndex = 0; currentIndex < this._aSpells.length; currentIndex++)
         {
            currentShortcutWrapper = this._aSpells[currentIndex];
            if(currentShortcutWrapper !== null)
            {
               currentSpellWrapper = currentShortcutWrapper.realItem as SpellWrapper;
               if(currentSpellWrapper !== null)
               {
                  if(currentIndex !== index && currentSpellWrapper.spellId === spellId)
                  {
                     areDuplicates = true;
                     break;
                  }
               }
            }
         }
         if(areDuplicates)
         {
            sysApi.sendAction(new ShortcutBarRemoveRequestAction([ShortcutBarEnum.SPELL_SHORTCUT_BAR,index]));
         }
         else
         {
            sysApi.sendAction(new ForgettableSpellClientAction([spellId,ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_UNEQUIP]));
         }
      }
      
      private function onRemoveSpell(index:int) : void
      {
         var spellId:int = 0;
         var isForgettableSpell:Boolean = false;
         if(this.isForgettableSpellsUi && this._sTabGrid === SPELLS_TAB)
         {
            spellId = this._aSpells[index].realItem.spellId;
            isForgettableSpell = this.playerApi.isForgettableSpell(spellId);
            if(isForgettableSpell)
            {
               this.removeForgettableSpell(spellId,index);
               return;
            }
         }
         sysApi.sendAction(new ShortcutBarRemoveRequestAction([1,index]));
      }
      
      private function onRemoveItem(index:int) : void
      {
         var shortcutWrapper:ShortcutWrapper = null;
         var spellWrapper:SpellWrapper = null;
         var spellId:int = 0;
         var isForgettableSpell:Boolean = false;
         if(this.isForgettableSpellsUi && this._aSpells[index] is ShortcutWrapper && this._sTabGrid === SPELLS_TAB)
         {
            shortcutWrapper = this._aSpells[index];
            if(shortcutWrapper.realItem is SpellWrapper)
            {
               spellWrapper = shortcutWrapper.realItem as SpellWrapper;
               spellId = spellWrapper.spellId;
               isForgettableSpell = this.playerApi.isForgettableSpell(spellId);
               if(isForgettableSpell)
               {
                  this.removeForgettableSpell(spellId,index);
                  return;
               }
            }
         }
         sysApi.sendAction(new ShortcutBarRemoveRequestAction([0,index]));
      }
      
      private function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == Keyboard.ALTERNATE)
         {
            this._altDown = true;
         }
         if(!this._isDragging && keyCode == Keyboard.ALTERNATE && (!sysApi.isFightContext() || this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))
         {
            if(this._sTabGrid == SPELLS_TAB)
            {
               this._isDragging = true;
               (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = this._spellMovementAllowed || this._altDown;
               if(!this._buildSpellPreview)
               {
                  this.updateGrid(this._aSpells,this._nPageSpells);
               }
            }
         }
      }
      
      private function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(keyCode == Keyboard.ALTERNATE)
         {
            this._altDown = false;
         }
         if(keyCode == Keyboard.ALTERNATE && (!sysApi.isFightContext() || this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))
         {
            if(this._sTabGrid == SPELLS_TAB)
            {
               this._isDragging = false;
               (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = this._spellMovementAllowed || this._altDown;
               if(!this._buildSpellPreview)
               {
                  this.updateGrid(this._aSpells,this._nPageSpells);
               }
            }
         }
      }
      
      private function onSpellMovementAllowed(state:Boolean) : void
      {
         this._spellMovementAllowed = state;
         if(!state)
         {
            this._altDown = false;
         }
         if(this._sTabGrid == SPELLS_TAB)
         {
            (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = this._spellMovementAllowed || this._altDown;
            if(!this._buildSpellPreview)
            {
               this.updateGrid(this._aSpells,this._nPageSpells);
            }
         }
      }
      
      private function onShortcutsMovementAllowed(state:Boolean) : void
      {
         this._shortcutsMovementAllowed = state;
         if(this._sTabGrid == ITEMS_TAB)
         {
            (this.gd_spellitemotes.renderer as SlotGridRenderer).allowDrop = state;
            this.updateGrid(this._aItems,this._nPageItems);
         }
      }
      
      private function onPresetsUpdate(buildId:int = -1) : void
      {
         if(this._sTabGrid == ITEMS_TAB)
         {
            this._aItems = this.storageApi.getShortcutBarContent(0);
            this.updateGrid(this._aItems,this._nPageItems);
         }
      }
      
      private function onWeaponUpdate() : void
      {
         if(this._sTabGrid == SPELLS_TAB)
         {
            this.gridDisplay(this._sTabGrid,true);
         }
      }
      
      protected function onSwitchBannerTab(tabName:String) : void
      {
         this.gridDisplay(tabName);
      }
      
      public function onOpenSpellBook() : void
      {
         this.gridDisplay(SPELLS_TAB);
      }
      
      public function onOpenInventory(... args) : void
      {
         if(!this.playerApi.isInFight())
         {
            this.gridDisplay(ITEMS_TAB);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var spellIndex:uint = 0;
         switch(s)
         {
            case "cac":
               if(sysApi.isFightContext() && this.playerApi.canCastThisSpell(0,1))
               {
                  sysApi.sendAction(GameFightSpellCastAction.create(CurrentPlayedFighterManager.getInstance().currentFighterId,0,-1));
               }
               return true;
            case "s1":
            case "s2":
            case "s3":
            case "s4":
            case "s5":
            case "s6":
            case "s7":
            case "s8":
            case "s9":
            case "s10":
            case "s11":
            case "s12":
            case "s13":
            case "s14":
            case "s15":
            case "s16":
            case "s17":
            case "s18":
            case "s19":
            case "s20":
               if(!this.uiApi.getUi("passwordMenu") && !this.inventoryApi.removeSelectedItem())
               {
                  spellIndex = parseInt(s.substr(1)) - 1;
                  this.gd_spellitemotes.selectedIndex = spellIndex;
               }
               return true;
            case "bannerSpellsTab":
               this.gridDisplay(SPELLS_TAB);
               return true;
            case "bannerItemsTab":
               this.gridDisplay(ITEMS_TAB);
               return true;
            case "bannerNextTab":
               this.pageItemDown();
               return true;
            case "bannerPreviousTab":
               this.pageItemUp();
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_1:
               this.pageItem(0);
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_2:
               this.pageItem(1);
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_3:
               this.pageItem(2);
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_4:
               this.pageItem(3);
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_5:
               this.pageItem(4);
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_DOWN:
               this.pageItemDown();
               return true;
            case ShortcutHookListEnum.PAGE_ITEM_UP:
               this.pageItemUp();
               return true;
            default:
               return false;
         }
      }
      
      private function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         var isValid:Boolean = false;
         var shortcutWrapper:ShortcutWrapper = null;
         if(!data)
         {
            return false;
         }
         var sourceSlot:Slot = source as Slot;
         var targetSlot:Slot = target as Slot;
         var sourceGrid:Grid = sourceSlot.getParent() as Grid;
         if(sourceSlot.getUi().name.indexOf(UIEnum.CHINQ_UI) != -1 || sourceSlot.getUi().name.indexOf(UIEnum.ITEM_EFFECTS_MODIFIER) != -1)
         {
            return false;
         }
         if(sourceGrid && sourceGrid === targetSlot.getParent() as Grid)
         {
            if(data is ShortcutWrapper)
            {
               isValid = false;
               for each(shortcutWrapper in this.gd_spellitemotes.dataProvider)
               {
                  if(shortcutWrapper && shortcutWrapper.id === data.id)
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
         }
         switch(this._sTabGrid)
         {
            case SPELLS_TAB:
               return data is SpellWrapper || data is ShortcutWrapper;
            case ITEMS_TAB:
               return data is ItemWrapper || data is BuildWrapper || data is IdolsPresetWrapper || data is EmoteWrapper || data is SmileyWrapper || data is ShortcutWrapper;
            default:
               return false;
         }
      }
      
      private function processDrop(target:GraphicContainer, data:Object, source:Object) : void
      {
         var currentSpell:SpellWrapper = null;
         if(this.dropValidator(target,data,source))
         {
            switch(this._sTabGrid)
            {
               case SPELLS_TAB:
                  if(data is ShortcutWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarSwapRequestAction([1,data.slot,this.gd_spellitemotes.getItemIndex(target) + this._nPageSpells * NUM_ITEMS_PER_PAGE]));
                  }
                  else
                  {
                     if((target as Slot).data && (target as Slot).data is ShortcutWrapper && (target as Slot).data.realItem is SpellWrapper)
                     {
                        currentSpell = (target as Slot).data.realItem as SpellWrapper;
                        if(currentSpell.id == data.id)
                        {
                           break;
                        }
                     }
                     if(!this.playerApi.isForgettableSpellAvailable(data.id))
                     {
                        sysApi.sendAction(new ForgettableSpellClientAction([data.id,ForgettableSpellClientActionEnum.FORGETTABLE_SPELL_EQUIP]));
                     }
                     sysApi.sendAction(new ShortcutBarAddRequestAction([2,data.id,this.gd_spellitemotes.getItemIndex(target) + this._nPageSpells * NUM_ITEMS_PER_PAGE]));
                  }
                  break;
               case ITEMS_TAB:
                  if(data is ShortcutWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarSwapRequestAction([0,data.slot,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
                  else if(data is IdolsPresetWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarAddRequestAction([5,data.id,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
                  else if(data is BuildWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarAddRequestAction([1,data.id,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
                  else if(data is EmoteWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarAddRequestAction([4,data.id,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
                  else if(data is SmileyWrapper)
                  {
                     sysApi.sendAction(new ShortcutBarAddRequestAction([3,data.id,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
                  else
                  {
                     sysApi.sendAction(new ShortcutBarAddRequestAction([0,data.objectUID,this.gd_spellitemotes.getItemIndex(target) + this._nPageItems * NUM_ITEMS_PER_PAGE]));
                  }
            }
         }
      }
      
      private function onValidQty(qty:Number) : void
      {
         if(qty <= 0)
         {
            return;
         }
         sysApi.sendAction(new ObjectSetPositionAction([this._waitingObjectUID,this._waitingObjectPosition,qty]));
      }
      
      protected function updateGrid(items:*, page:uint, autoSelect:Boolean = true) : void
      {
         var item:Object = null;
         var i:uint = 0;
         var dp:Array = [];
         for each(item in items)
         {
            if(item)
            {
               dp[item.slot - page * NUM_ITEMS_PER_PAGE] = item;
            }
         }
         for(i = 0; i < NUM_PAGES * NUM_ITEMS_PER_PAGE; i++)
         {
            if(!dp[i])
            {
               dp[i] = null;
            }
         }
         this.gd_spellitemotes.dataProvider = dp;
         if(!autoSelect)
         {
            this.unselectSpell();
         }
      }
      
      protected function onSpellUpdate(spell:Object) : void
      {
         var dp:Array = null;
         var spel:Object = null;
         if(this._sTabGrid == SPELLS_TAB)
         {
            dp = [];
            for each(spel in this._aSpells)
            {
               if(spel)
               {
                  dp[spel.slot - this._nPageSpells * NUM_ITEMS_PER_PAGE] = spel;
                  if(spel.id == spell.id)
                  {
                     dp[spel.slot - this._nPageSpells * NUM_ITEMS_PER_PAGE].active = spell.active;
                  }
               }
            }
            this.gd_spellitemotes.dataProvider = dp;
         }
      }
      
      private function emptyFct(... args) : void
      {
      }
      
      protected function onShortcutBarViewContent(barType:int) : void
      {
         if(barType == 0)
         {
            this._aItems = this.storageApi.getShortcutBarContent(barType);
            if(this._sTabGrid == ITEMS_TAB)
            {
               this.updateGrid(this._aItems,this._nPageItems);
            }
         }
         else if(barType == 1 && (!this.fightApi.isSlaveContext() || this.isMainBar))
         {
            this.updateSpellShortcuts();
         }
      }
      
      protected function updateSpellShortcuts() : void
      {
         if(this._buildSpellPreview)
         {
            return;
         }
         this._aSpells = this.storageApi.getShortcutBarContent(1);
         var olNPage:int = this._nPageSpells;
         if(this.fightApi.isSlaveContext())
         {
            this._nPageSpells = 0;
         }
         else
         {
            this._nPageSpells = sysApi.getData("bannerSpellsPageIndex" + this.getPlayerId());
         }
         if(olNPage != this._nPageSpells)
         {
            this.displayPage();
         }
         if(this._sTabGrid == SPELLS_TAB)
         {
            this.updateGrid(this._aSpells,this._nPageSpells);
         }
      }
      
      public function previewBuildShortcuts(spells:*, preview:Boolean) : void
      {
         this._buildSpellPreview = preview;
         this._aSpells = spells;
         var olNPage:int = this._nPageSpells;
         if(this.fightApi.isSlaveContext())
         {
            this._nPageSpells = 0;
         }
         else
         {
            this._nPageSpells = sysApi.getData("bannerSpellsPageIndex" + this.getPlayerId());
         }
         if(olNPage != this._nPageSpells)
         {
            this.displayPage();
         }
         this.gridDisplay(SPELLS_TAB,true);
         this.gd_spellitemotes.softDisabled = preview;
      }
      
      public function onSlaveStatsList(charac:Object) : void
      {
         if(this.isMainBar)
         {
            this.gridDisplay(SPELLS_TAB);
            if(!this._buildSpellPreview)
            {
               this.updateGrid(this._aSpells,this._nPageSpells);
            }
         }
      }
      
      public function unload() : void
      {
         StatsManager.getInstance().removeListenerFromStat(StatIds.ACTION_POINTS,this.onUpdateActionPoints);
         sysApi.removeHook(BeriliaHookList.UiUnloaded);
         this.uiApi.setFollowCursorUri(null);
      }
      
      public function onCancelCastSpell(spellWrapper:Object) : void
      {
         this.uiApi.setFollowCursorUri(null);
      }
      
      public function onCastSpellMode(spellWrapper:Object) : void
      {
         this.uiApi.setFollowCursorUri(spellWrapper.iconUri,false,false,15,15,1,this.gd_spellitemotes.slotWidth * 0.75,this.gd_spellitemotes.slotHeight * 0.75);
      }
      
      private function onItemTooltipDisplayOption(field:String) : void
      {
         var itemTooltipSettings:ItemTooltipSettings = this.getItemTooltipSettings();
         itemTooltipSettings[field] = !itemTooltipSettings[field];
         this.setItemTooltipSettings(itemTooltipSettings);
      }
      
      private function onDropStart(src:GraphicContainer) : void
      {
         if(src.getUi() == this.uiApi.me())
         {
            sysApi.disableWorldInteraction();
         }
      }
      
      private function onDropEnd(src:GraphicContainer, target:Object) : void
      {
         if(src.getUi() == this.uiApi.me() && !this.uiApi.getUi(UIEnum.GRIMOIRE))
         {
            sysApi.enableWorldInteraction();
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var _spellShortcut:ShortcutWrapper = null;
         var spellCastResult:String = null;
         var uiName:String = null;
         var item:ItemWrapper = null;
         switch(target)
         {
            case this.gd_spellitemotes:
               switch(this._sTabGrid)
               {
                  case SPELLS_TAB:
                     _spellShortcut = (target as Grid).selectedItem;
                     if(_spellShortcut)
                     {
                        if(sysApi.isFightContext() && this.uiApi.keyIsDown(Keyboard.ALTERNATE) && _spellShortcut.realItem)
                        {
                           spellCastResult = this.playerApi.canCastThisSpellWithResult((_spellShortcut.realItem as SpellWrapper).spellId,(_spellShortcut.realItem as SpellWrapper).spellLevel);
                           sysApi.sendAction(new ChatTextOutputAction([spellCastResult,ChatActivableChannelsEnum.CHANNEL_TEAM,null,null]));
                        }
                        else if(selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                        {
                           if(this.isForgettableSpellsUi)
                           {
                              uiName = !!this.isModsterUi ? UIEnum.FORGETTABLE_MODSTERS_UI : UIEnum.FORGETTABLE_SPELLS_UI;
                              sysApi.sendAction(OpenForgettableSpellsUiAction.create(false,uiName));
                           }
                           else
                           {
                              sysApi.dispatchHook(HookList.OpenSpellInterface,_spellShortcut.id);
                           }
                        }
                        else if((target as Grid).selectedItem.active)
                        {
                           sysApi.sendAction(GameFightSpellCastAction.create(CurrentPlayedFighterManager.getInstance().currentFighterId,_spellShortcut.id,this.gd_spellitemotes.selectedIndex + 1));
                        }
                     }
                     else if(sysApi.isFightContext())
                     {
                        sysApi.sendAction(new BannerEmptySlotClickAction([]));
                     }
                     break;
                  case ITEMS_TAB:
                     if(!(target as Grid).selectedItem || !(target as Grid).selectedItem.active)
                     {
                        break;
                     }
                     if((target as Grid).selectedItem.type == TYPE_BUILD_WRAPPER || (target as Grid).selectedItem.type == TYPE_SMILEY_WRAPPER || (target as Grid).selectedItem.type == TYPE_EMOTE_WRAPPER || (target as Grid).selectedItem.type == TYPE_IDOLS_PRESET_WRAPPER)
                     {
                        if(selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK || selectMethod == GridItemSelectMethodEnum.MANUAL)
                        {
                           this.useItem((target as Grid).selectedItem.id,(target as Grid).selectedItem.type);
                        }
                     }
                     else
                     {
                        item = this.inventoryApi.getItem((target as Grid).selectedItem.id);
                        if(!item)
                        {
                           break;
                        }
                        if(selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                        {
                           if(item.usable)
                           {
                              this.useItem((target as Grid).selectedItem.id);
                           }
                           else if(item.hasOwnProperty("isCertificate") && item.isCertificate)
                           {
                              sysApi.sendAction(new MountInfoRequestAction([item]));
                           }
                        }
                        else if(selectMethod == GridItemSelectMethodEnum.CLICK)
                        {
                           if(item.targetable && !this.uiApi.keyIsDown(Keyboard.SHIFT))
                           {
                              this.onItemUseOnCell((target as Grid).selectedItem.id);
                           }
                        }
                        else if(selectMethod == GridItemSelectMethodEnum.MANUAL)
                        {
                           if(item.targetable)
                           {
                              this.onItemUseOnCell((target as Grid).selectedItem.id);
                           }
                           else if(item.usable)
                           {
                              this.useItem((target as Grid).selectedItem.id);
                           }
                        }
                        if((item.category == ItemCategoryEnum.EQUIPMENT_CATEGORY || item.category == ItemCategoryEnum.COSMETICS_CATEGORY) && (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK || selectMethod == GridItemSelectMethodEnum.MANUAL))
                        {
                           this.equipItem(item);
                        }
                        if(item.category != 0 && !item.usable && !item.targetable && item.typeId == DataEnum.ITEM_TYPE_IDOLS)
                        {
                           sysApi.sendAction(new OpenIdolsAction([]));
                        }
                     }
                     break;
               }
         }
      }
      
      private function onUpdateActionPoints(stat:Stat) : void
      {
         if(sysApi.isFightContext() && this._sTabGrid == SPELLS_TAB && stat.entityId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            this.gd_spellitemotes.updateItems();
         }
      }
      
      public function equipItem(item:ItemWrapper) : void
      {
         var freeSlot:int = 0;
         var equipment:Vector.<ItemWrapper> = null;
         var itemEquiped:Object = null;
         var uid:int = item.objectUID;
         if(item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD || item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY || item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME)
         {
            freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
         }
         else
         {
            freeSlot = this.storageApi.getBestEquipablePosition(item);
            if(item.quantity > 1)
            {
               equipment = this.storageApi.getViewContent("equipment");
               for each(itemEquiped in equipment)
               {
                  if(itemEquiped && itemEquiped.position == freeSlot && itemEquiped.objectGID == item.objectGID)
                  {
                     freeSlot = CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED;
                     uid = itemEquiped.objectUID;
                  }
               }
            }
         }
         if(freeSlot > -1)
         {
            sysApi.sendAction(new ObjectSetPositionAction([uid,freeSlot,1]));
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.gd_spellitemotes:
               this.uiApi.hideTooltip();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_tabItems:
               this.gridDisplay(ITEMS_TAB);
               break;
            case this.btn_tabSpells:
               this.gridDisplay(SPELLS_TAB);
               break;
            case this.btn_upArrow:
               this.pageItemUp();
               break;
            case this.btn_downArrow:
               this.pageItemDown();
               break;
            case this.btn_addActionBar:
               this.addNewActionBar();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var textKey:String = null;
         var data:Object = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         var shortcutKey:String = null;
         switch(target)
         {
            case this.btn_tabSpells:
               tooltipText = this.uiApi.getText("ui.charcrea.spells");
               shortcutKey = this.bindsApi.getShortcutBindStr("bannerSpellsTab");
               break;
            case this.btn_tabItems:
               tooltipText = this.uiApi.getText("ui.common.objects");
               shortcutKey = this.bindsApi.getShortcutBindStr("bannerItemsTab");
               break;
            case this.btn_upArrow:
               tooltipText = this.uiApi.getText("ui.common.prevPage");
               shortcutKey = this.bindsApi.getShortcutBindStr("pageItemUp");
               break;
            case this.btn_downArrow:
               point = 1;
               relPoint = 7;
               tooltipText = this.uiApi.getText("ui.common.nextPage");
               shortcutKey = this.bindsApi.getShortcutBindStr("pageItemDown");
               break;
            case this.btn_addActionBar:
               tooltipText = this.uiApi.getText("ui.banner.addActionBar");
         }
         if(shortcutKey)
         {
            if(!_shortcutColor)
            {
               _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
               _shortcutColor = _shortcutColor.replace("0x","#");
            }
            if(tooltipText)
            {
               data = this.uiApi.textTooltipInfo(tooltipText + " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>");
            }
            else if(textKey)
            {
               data = this.uiApi.textTooltipInfo(this.uiApi.getText(textKey,"<font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>"));
            }
         }
         else
         {
            data = this.uiApi.textTooltipInfo(tooltipText);
         }
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      protected function addNewActionBar(id:int = -1) : void
      {
         var bar:* = undefined;
         var barToDisplay:* = null;
         var totalAvailableBars:uint = 0;
         for each(bar in externalActionBars)
         {
            if(!bar.mainCtr.visible)
            {
               totalAvailableBars++;
               if(!barToDisplay)
               {
                  barToDisplay = bar;
               }
            }
         }
         if(barToDisplay)
         {
            if(barToDisplay.orientation == ExternalActionBar.ORIENTATION_VERTICAL)
            {
               this.reloadExternalActionBar(barToDisplay.actionBarId,currentContext);
               return;
            }
            barToDisplay.show();
         }
         this.btn_addActionBar.disabled = totalAvailableBars < 2;
      }
      
      protected function canAddExternalActionBar() : Boolean
      {
         var bar:* = undefined;
         for each(bar in externalActionBars)
         {
            if(!bar || !bar.mainCtr.visible)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function get dataKey() : String
      {
         var contextKey:String = currentContext == ContextEnum.ROLEPLAY ? "rp" : "fight";
         return EXTERNAL_UI_BASE_NAME + "StateData_" + contextKey + "_" + this.playerApi.id();
      }
   }
}
