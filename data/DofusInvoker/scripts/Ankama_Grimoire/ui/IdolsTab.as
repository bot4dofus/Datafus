package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.actions.CloseIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.IdolSelectRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.IdolsPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import damageCalculation.tools.StatIds;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class IdolsTab
   {
      
      private static const MAX_ACTIVE_IDOLS:int = 6;
      
      private static const IDOLS_LAST_SORT:String = "idolsLastSort";
      
      private static const IDOLS_LAST_SORT_ORDER:String = "idolsLastSortOrder";
      
      private static const IDOLS_SHOW_ALL:String = "idolsShowAll";
      
      private static const IDOLS_SHOW_SYNERGY_SCORE:String = "idolsShowSynergyScore";
      
      private static const ALL_IDOLS_FILTER:uint = 0;
      
      private static const PARTY_IDOLS_FILTER:uint = 1;
      
      private static const SOLO_IDOLS_FILTER:uint = 2;
      
      private static const IDOLS_SCORE_20:uint = 3;
      
      private static const IDOLS_SCORE_40:uint = 4;
      
      private static const IDOLS_SCORE_60:uint = 5;
      
      private static const SEARCH_DELAY:uint = 200;
      
      private static const IDOLS_PRESET_LAST_SORT:String = "idolsPresetLastSort";
      
      private static const IDOLS_PRESET_LAST_SORT_ORDER:String = "idolsPresetLastSortOrder";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _soloIdols:Array;
      
      private var _groupIdols:Array;
      
      private var _presetsIdols:Array;
      
      private var _currentActiveSoloIdols:Vector.<ItemWrapper>;
      
      private var _currentActiveGroupIdols:Vector.<ItemWrapper>;
      
      private var _activeIdolsIds:Vector.<int>;
      
      private var _txMemberIdolAssoc:Dictionary;
      
      private var _playerIdolsIds:Array;
      
      private var _idolsSelections:Vector.<IdolSelection>;
      
      private var _currentTabName:String;
      
      private var _totalScore:uint;
      
      private var _totalExp:uint;
      
      private var _totalLoot:uint;
      
      private var _globalSynergy:Number;
      
      private var _synergyBonusColor:String;
      
      private var _synergyMalusColor:String;
      
      private var _isPartyLeader:Boolean;
      
      private var _isInFight:Boolean;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _ascendingSort:Boolean;
      
      private var _lastSortType:String;
      
      private var _presetAscendingSort:Boolean;
      
      private var _lastPresetSortType:String;
      
      private var _positiveSynergies:Dictionary;
      
      private var _negativeSynergies:Dictionary;
      
      private var _tmpPositiveSynergies:Dictionary;
      
      private var _tmpNegativeSynergies:Dictionary;
      
      private var _filters:Array;
      
      private var _currentFilter:uint;
      
      private var _currentDataProvider:Object;
      
      private var _filteredDataProvider:Object;
      
      private var _searchTimeoutId:uint;
      
      private var _searchText:String = "";
      
      private var _currentIcon:uint;
      
      private var _btnDeleteAssoc:Dictionary;
      
      private var _presetToDelete:Object;
      
      private var _forceLineRollOver:Boolean;
      
      private var _forceLineRollOut:Boolean;
      
      private var _txIncompatibleMonstersAssoc:Dictionary;
      
      private var _hasProcessedDrop:Boolean = false;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_solo:ButtonContainer;
      
      public var btn_showAll:ButtonContainer;
      
      public var btn_showSynergyScore:ButtonContainer;
      
      public var btn_group:ButtonContainer;
      
      public var btn_presets:ButtonContainer;
      
      public var btn_savePreset:ButtonContainer;
      
      public var gd_activeIdols:Grid;
      
      public var ctr_idols:GraphicContainer;
      
      public var gd_idols:Grid;
      
      public var gd_icons:Grid;
      
      public var ctr_presets:GraphicContainer;
      
      public var gd_presets:Grid;
      
      public var btn_label_btn_showAll:Label;
      
      public var btn_label_btn_showSynergyScore:Label;
      
      public var lbl_score:Label;
      
      public var lbl_exp:Label;
      
      public var lbl_loot:Label;
      
      public var btn_sortIdolByName:ButtonContainer;
      
      public var btn_sortIdolByScore:ButtonContainer;
      
      public var btn_sortPresetsByScore:ButtonContainer;
      
      public var tx_synergy:Texture;
      
      public var cb_filter:ComboBox;
      
      public var btn_closeSearch:ButtonContainer;
      
      public var inp_search:Input;
      
      public var tx_allIncompatibleMonsters:Texture;
      
      public var tx_sortNameUp:Texture;
      
      public var tx_sortNameDown:Texture;
      
      public var tx_sortScoreUp:Texture;
      
      public var tx_sortScoreDown:Texture;
      
      public var tx_sortScorePresetUp:Texture;
      
      public var tx_sortScorePresetDown:Texture;
      
      public var lbl_tabName:Label;
      
      public var lbl_tabScore:Label;
      
      public var lbl_tabScorePreset:Label;
      
      public function IdolsTab()
      {
         super();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(oParam:Object = null) : void
      {
         var i:int = 0;
         var itemW:Object = null;
         var idol:Idol = null;
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.IdolSelectError,this.onIdolSelectError);
         this.sysApi.addHook(HookList.IdolSelected,this.onIdolSelected);
         this.sysApi.addHook(HookList.IdolAdded,this.onIdolAdded);
         this.sysApi.addHook(HookList.IdolRemoved,this.onIdolRemoved);
         this.sysApi.addHook(HookList.IdolPartyRefresh,this.onIdolPartyRefresh);
         this.sysApi.addHook(HookList.IdolPartyLost,this.onIdolPartyLost);
         this.sysApi.addHook(HookList.IdolsList,this.onIdolsList);
         this.sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(HookList.PartyLeave,this.onPartyLeave);
         this.sysApi.addHook(HookList.IdolsPresetsUpdate,this.onIdolsPresetsUpdate);
         this.sysApi.addHook(HookList.IdolsPresetDelete,this.onIdolsPresetDelete);
         this.sysApi.addHook(HookList.IdolsPresetEquipped,this.onIdolsPresetEquipped);
         this.sysApi.addHook(HookList.IdolsPresetSaved,this.onIdolsPresetSaved);
         this.sysApi.addHook(BeriliaHookList.DropEnd,this.onIdolsDropEnd);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_allIncompatibleMonsters,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_allIncompatibleMonsters,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_activeIdols,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_activeIdols,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_activeIdols,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_activeIdols,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.tx_synergy,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_synergy,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_loot,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_loot,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_exp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_exp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_idols,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_icons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_filter,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.lbl_tabName.fullWidthAndHeight(0,5);
         this.lbl_tabScore.fullWidthAndHeight(0,5);
         this.lbl_tabScorePreset.fullWidthAndHeight(0,5);
         this.btn_label_btn_showAll.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.btn_label_btn_showSynergyScore.textfield.autoSize = TextFieldAutoSize.LEFT;
         this.btn_showSynergyScore.x = this.btn_showAll.x + this.btn_showAll.width + 30;
         this._searchText = this.uiApi.getText("ui.common.search.input");
         this.inp_search.text = this._searchText;
         this._activeIdolsIds = new Vector.<int>(0);
         this._txMemberIdolAssoc = new Dictionary();
         this._idolsSelections = new Vector.<IdolSelection>(0);
         this._sortFieldAssoc = new Dictionary();
         this._positiveSynergies = new Dictionary();
         this._negativeSynergies = new Dictionary();
         this._txIncompatibleMonstersAssoc = new Dictionary();
         this._synergyBonusColor = this.sysApi.getConfigEntry("colors.tooltip.bonus").toString().replace("0x","#");
         this._synergyMalusColor = this.sysApi.getConfigEntry("colors.tooltip.malus").toString().replace("0x","#");
         this._sortFieldAssoc[this.btn_sortIdolByName] = "name";
         this._sortFieldAssoc[this.btn_sortIdolByScore] = "score";
         this._ascendingSort = this._presetAscendingSort = true;
         this._isInFight = this.playerApi.isInFight() && !this.playerApi.isInPreFight();
         this.initButtonValue(IDOLS_SHOW_ALL,this.btn_showAll,false);
         this.initButtonValue(IDOLS_SHOW_SYNERGY_SCORE,this.btn_showSynergyScore,true);
         var chosenIdols:Object = oParam.chosenIdols;
         this._soloIdols = [];
         var playerIdols:Array = this.inventoryApi.getStorageObjectsByType(DataEnum.ITEM_TYPE_IDOLS);
         var numChosenIdols:uint = chosenIdols.length;
         var numPlayerIdols:uint = playerIdols.length;
         this._playerIdolsIds = [];
         this._currentActiveSoloIdols = new Vector.<ItemWrapper>(0);
         for(i = 0; i < numChosenIdols; i++)
         {
            idol = this.dataApi.getIdol(chosenIdols[i]);
            this._currentActiveSoloIdols.push(this.dataApi.getItemWrapper(idol.itemId));
         }
         for(i = 0; i < numPlayerIdols; i++)
         {
            itemW = playerIdols[i];
            idol = this.dataApi.getIdolByItemId(itemW.objectGID);
            this._playerIdolsIds.push(idol.id);
            this._soloIdols.push(this.getIdolData(idol,null,chosenIdols.indexOf(idol.id) != -1,false));
         }
         this._isPartyLeader = this.playerApi.isPartyLeader();
         this.updateGroupIdols(oParam.partyChosenIdols,oParam.partyIdols);
         if(!this.partyApi.isInParty(this.playerApi.id()))
         {
            this.openSoloTab();
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_solo,this.uiApi.me());
            this.btn_group.softDisabled = true;
         }
         else
         {
            this.openGroupTab();
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_group,this.uiApi.me());
         }
         this._filters = [];
         this._filters.push({
            "label":this.uiApi.getText("ui.common.allTypesForObject"),
            "id":ALL_IDOLS_FILTER
         });
         this._filters.push({
            "label":this.uiApi.getText("ui.idol.partyIdols"),
            "id":PARTY_IDOLS_FILTER
         });
         this._filters.push({
            "label":this.uiApi.getText("ui.idol.soloIdols"),
            "id":SOLO_IDOLS_FILTER
         });
         this._filters.push({
            "label":this.uiApi.getText("ui.common.score") + " > 20",
            "id":IDOLS_SCORE_20
         });
         this._filters.push({
            "label":this.uiApi.getText("ui.common.score") + " > 40",
            "id":IDOLS_SCORE_40
         });
         this._filters.push({
            "label":this.uiApi.getText("ui.common.score") + " > 60",
            "id":IDOLS_SCORE_60
         });
         this.cb_filter.dataProvider = this._filters;
         this.cb_filter.selectedIndex = 0;
         this.gd_icons.dataProvider = this.dataApi.getIdolsPresetIcons();
         this._presetsIdols = [];
         this.onIdolsPresetsUpdate(oParam.presets);
         this.gd_activeIdols.autoSelectMode = 0;
         (this.gd_activeIdols.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
         (this.gd_activeIdols.renderer as SlotGridRenderer).removeDropSourceFunction = function(target:Object):void
         {
         };
      }
      
      private function setActiveIdolsDrag(isActive:Boolean) : void
      {
         var slot:Slot = null;
         for each(slot in this.gd_activeIdols.slots)
         {
            slot.allowDrag = isActive;
         }
         (this.gd_activeIdols.renderer as SlotGridRenderer).allowDrop = isActive;
      }
      
      private function processDrop(target:Object, data:Object, source:Object) : void
      {
         var itemWrapper:ItemWrapper = null;
         var sourceIdol:Idol = null;
         var targetIdol:Idol = null;
         this._hasProcessedDrop = true;
         if(this._isInFight || !source.data)
         {
            return;
         }
         var activeIdols:Vector.<ItemWrapper> = !!this.btn_solo.selected ? this._currentActiveSoloIdols : this._currentActiveGroupIdols;
         var sourceItemWrapper:ItemWrapper = this.dataApi.getItemWrapper(this.dataApi.getIdolByItemId(source.data.objectGID).itemId);
         var sourceIndex:int = -1;
         var targetIndex:int = this.gd_activeIdols.getItemIndex(target);
         var isSwap:Boolean = false;
         for each(itemWrapper in activeIdols)
         {
            sourceIndex++;
            if(itemWrapper.objectGID == sourceItemWrapper.objectGID)
            {
               isSwap = true;
               break;
            }
         }
         sourceIdol = this.dataApi.getIdolByItemId(source.data.objectGID);
         targetIdol = null;
         this.gd_activeIdols.selectedIndex = targetIndex;
         if(target.data)
         {
            targetIdol = this.dataApi.getIdolByItemId(target.data.objectGID);
         }
         if(isSwap)
         {
            this.swapActiveIdols(activeIdols,sourceIdol,sourceIndex,targetIdol,targetIndex);
            return;
         }
         if(sourceIdol)
         {
            if(targetIdol)
            {
               this.selectIdol(targetIdol.id,this._activeIdolsIds.indexOf(targetIdol.id) == -1,this.gd_activeIdols);
            }
            this.dragIdol(sourceIdol.id,this._activeIdolsIds.indexOf(sourceIdol.id) == -1,this.gd_activeIdols);
         }
      }
      
      private function swapActiveIdols(activeIdols:Vector.<ItemWrapper>, sourceIdol:Idol, sourceIndex:int, targetIdol:Idol, targetIndex:int) : void
      {
         if(targetIdol)
         {
            this.disableIdol(sourceIdol.id,!this.btn_solo.selected);
            this.disableIdol(targetIdol.id,!this.btn_solo.selected);
            if(sourceIndex < targetIndex)
            {
               this.enableIdol(targetIdol.id,!this.btn_solo.selected,sourceIndex);
               this.enableIdol(sourceIdol.id,!this.btn_solo.selected,targetIndex);
            }
            else
            {
               this.enableIdol(sourceIdol.id,!this.btn_solo.selected,targetIndex);
               this.enableIdol(targetIdol.id,!this.btn_solo.selected,sourceIndex);
            }
            this.gd_activeIdols.selectedIndex = targetIndex;
         }
         else
         {
            this.disableIdol(sourceIdol.id,!this.btn_solo.selected);
            this.enableIdol(sourceIdol.id,!this.btn_solo.selected,activeIdols.length);
            this.gd_activeIdols.selectedIndex = activeIdols.length;
         }
      }
      
      private function onIdolsDropEnd(source:Object, target:Object) : void
      {
         var itemWrapper:ItemWrapper = null;
         if(!source.data.objectGID)
         {
            return;
         }
         if(this._hasProcessedDrop)
         {
            this._hasProcessedDrop = false;
            return;
         }
         var sourceIdol:Idol = this.dataApi.getIdolByItemId(source.data.objectGID);
         if(!sourceIdol)
         {
            return;
         }
         var itemW:ItemWrapper = this.dataApi.getItemWrapper(sourceIdol.itemId);
         var activeIdols:Vector.<ItemWrapper> = !!this.btn_solo.selected ? this._currentActiveSoloIdols : this._currentActiveGroupIdols;
         for each(itemWrapper in activeIdols)
         {
            if(itemWrapper.objectGID == itemW.objectGID)
            {
               this.selectIdol(sourceIdol.id,this._activeIdolsIds.indexOf(sourceIdol.id) == -1,this.gd_activeIdols);
               return;
            }
         }
      }
      
      public function unload() : void
      {
         clearTimeout(this._searchTimeoutId);
         this.uiApi.hideTooltip("IdolsInfo");
         this.sysApi.sendAction(new CloseIdolsAction([]));
      }
      
      public function updateIdolLine(idolData:Object, components:*, selected:Boolean) : void
      {
         var grayout:Boolean = false;
         var icons:Array = null;
         var idol:Idol = null;
         var numIcons:uint = 0;
         var i:int = 0;
         var incompatibleMonstersNames:Vector.<String> = null;
         var incompatibleMonster:Monster = null;
         var incompatibleMonsterId:int = 0;
         var owners:String = null;
         var id:Number = NaN;
         var partyMember:PartyMemberWrapper = null;
         var partyMembers:Object = null;
         if(this._forceLineRollOver)
         {
            components.btn_line.state = StatesEnum.STATE_NORMAL;
            if(idolData && this._activeIdolsIds.indexOf(idolData.idolId) != -1)
            {
               components.btn_line.state = StatesEnum.STATE_SELECTED_OVER;
            }
            else if(idolData && !idolData.readOnly && (this._activeIdolsIds.length < MAX_ACTIVE_IDOLS || this._activeIdolsIds.indexOf(idolData.idolId) != -1))
            {
               components.btn_line.state = StatesEnum.STATE_OVER;
            }
            this._forceLineRollOver = false;
            return;
         }
         if(this._forceLineRollOut)
         {
            if(idolData && this._activeIdolsIds.indexOf(idolData.idolId) != -1)
            {
               components.btn_line.state = StatesEnum.STATE_SELECTED;
            }
            else
            {
               components.btn_line.state = StatesEnum.STATE_NORMAL;
            }
            this._forceLineRollOut = false;
            return;
         }
         components.btn_line.y = 1;
         components.btn_line.state = StatesEnum.STATE_NORMAL;
         if(idolData)
         {
            if(idolData.readOnly || this._activeIdolsIds.length == MAX_ACTIVE_IDOLS && this._activeIdolsIds.indexOf(idolData.idolId) == -1)
            {
               components.btn_line.mouseEnabled = false;
               grayout = this.btn_solo.selected && this._playerIdolsIds.indexOf(idolData.idolId) == -1;
            }
            else
            {
               components.btn_line.mouseEnabled = true;
               grayout = false;
            }
            if(grayout)
            {
               components.lbl_idol_name.cssClass = "bolddisabled";
               components.lbl_idol_desc.cssClass = "disabled";
               components.lbl_idol_score.cssClass = "disabledboldright";
            }
            else
            {
               components.lbl_idol_name.cssClass = "bold";
               components.lbl_idol_desc.cssClass = "p";
               components.lbl_idol_score.cssClass = "boldright";
            }
            components.slot_idol.data = idolData.item;
            components.slot_idol.allowDrag = this._activeIdolsIds.indexOf(idolData.idolId) == -1;
            components.slot_idol.visible = true;
            components.lbl_idol_name.text = idolData.name;
            components.lbl_idol_desc.text = idolData.description;
            components.lbl_idol_score.text = idolData.score;
            icons = [];
            idol = this.dataApi.getIdol(idolData.idolId);
            if(idol.incompatibleMonsters.length > 0)
            {
               for each(incompatibleMonsterId in idol.incompatibleMonsters)
               {
                  incompatibleMonster = this.dataApi.getMonsterFromId(incompatibleMonsterId);
                  if(incompatibleMonster)
                  {
                     if(!incompatibleMonstersNames)
                     {
                        incompatibleMonstersNames = new Vector.<String>(0);
                     }
                     incompatibleMonstersNames.push(incompatibleMonster.name);
                  }
               }
               this._txIncompatibleMonstersAssoc[components.tx_incompatibleMonsters] = incompatibleMonstersNames;
               components.tx_incompatibleMonsters.visible = incompatibleMonstersNames !== null;
               icons.push(components.tx_incompatibleMonsters);
            }
            else
            {
               this._txIncompatibleMonstersAssoc[components.tx_incompatibleMonsters] = null;
               components.tx_incompatibleMonsters.visible = false;
            }
            components.tx_partyOnly.visible = idolData.partyOnlyIdol;
            if(components.tx_partyOnly.visible)
            {
               icons.push(components.tx_partyOnly);
            }
            if(this.btn_group.selected)
            {
               components.tx_memberIdol.visible = idolData.ownersIds.length > 0 && idolData.ownersIds.indexOf(this.playerApi.id()) == -1;
               if(components.tx_memberIdol.visible)
               {
                  icons.push(components.tx_memberIdol);
               }
               owners = "";
               if(idolData.ownersIds.length > 0)
               {
                  partyMembers = this.partyApi.getPartyMembers();
                  for each(id in idolData.ownersIds)
                  {
                     for each(partyMember in partyMembers)
                     {
                        if(partyMember.id == id)
                        {
                           owners += "\n" + partyMember.name;
                           break;
                        }
                     }
                  }
               }
               this._txMemberIdolAssoc[components.tx_memberIdol] = owners;
            }
            else
            {
               components.tx_memberIdol.visible = false;
            }
            numIcons = icons.length;
            for(i = 0; i < numIcons; i++)
            {
               icons[i].y = (this.gd_idols.slotHeight / numIcons - icons[i].height) / 2 + i * this.gd_idols.slotHeight / numIcons;
            }
            components.btn_line.selected = this._activeIdolsIds.indexOf(idolData.idolId) != -1;
            if(components.btn_line.selected)
            {
               components.btn_line.state = StatesEnum.STATE_SELECTED;
            }
         }
         else
         {
            components.btn_line.mouseEnabled = false;
            components.slot_idol.data = null;
            components.slot_idol.visible = false;
            components.lbl_idol_name.text = "";
            components.lbl_idol_desc.text = "";
            components.lbl_idol_score.text = "";
            components.tx_partyOnly.visible = false;
            components.tx_memberIdol.visible = false;
            components.tx_incompatibleMonsters.visible = false;
         }
      }
      
      public function updateIcon(data:*, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("iconsUri") + "small_" + data.id);
            components.tx_selected.visible = selected;
         }
         else
         {
            components.tx_icon.uri = null;
            components.tx_selected.visible = false;
         }
      }
      
      public function updatePresetLine(data:*, components:*, selected:Boolean) : void
      {
         var incompatibleMonstersIds:Vector.<int> = null;
         var incompatibleMonstersNames:Vector.<String> = null;
         var incompatibleMonsterId:int = 0;
         var idol:Idol = null;
         var idolId:int = 0;
         var incompatibleMonster:Monster = null;
         if(data)
         {
            components.slot_icon.data = data.icon;
            components.gd_presets_idols.dataProvider = data.idols;
            components.gd_presets_idols.visible = true;
            components.lbl_preset_score.text = data.score;
            components.lbl_preset_score.visible = true;
            this._btnDeleteAssoc[components.btn_delete] = data;
            components.btn_delete.visible = true;
            for each(idolId in data.idolsIds)
            {
               idol = this.dataApi.getIdol(idolId);
               if(idol.incompatibleMonsters.length > 0)
               {
                  if(!incompatibleMonstersIds)
                  {
                     incompatibleMonstersIds = new Vector.<int>(0);
                     incompatibleMonstersNames = new Vector.<String>(0);
                  }
                  for each(incompatibleMonsterId in idol.incompatibleMonsters)
                  {
                     if(incompatibleMonstersIds.indexOf(incompatibleMonsterId) == -1)
                     {
                        incompatibleMonstersIds.push(incompatibleMonsterId);
                     }
                  }
               }
            }
            for each(incompatibleMonsterId in incompatibleMonstersIds)
            {
               incompatibleMonster = this.dataApi.getMonsterFromId(incompatibleMonsterId);
               if(incompatibleMonster)
               {
                  incompatibleMonstersNames.push(incompatibleMonster.name);
               }
            }
            this._txIncompatibleMonstersAssoc[components.tx_preset_incompatibleMonsters] = incompatibleMonstersNames;
            components.tx_preset_incompatibleMonsters.visible = !!incompatibleMonstersNames ? true : false;
         }
         else
         {
            components.slot_icon.data = null;
            components.gd_presets_idols.dataProvider = [];
            components.gd_presets_idols.visible = false;
            components.lbl_preset_score.visible = false;
            components.btn_delete.visible = false;
            components.tx_preset_incompatibleMonsters.visible = false;
         }
      }
      
      private function openSoloTab() : void
      {
         var idolW:ItemWrapper = null;
         this.btn_solo.selected = true;
         this.setActiveIdolsDrag(true);
         this.btn_showSynergyScore.x = this.btn_showAll.x + this.btn_showAll.width + 30;
         this.switchTab("btn_solo");
         this._activeIdolsIds.length = 0;
         for each(idolW in this._currentActiveSoloIdols)
         {
            this._activeIdolsIds.push(this.dataApi.getIdolByItemId(idolW.objectGID).id);
         }
         this.gd_activeIdols.dataProvider = this._currentActiveSoloIdols;
         this.updateIdolsScores();
         this.refreshSoloIdolsList();
         this.updateTotals();
         this.updateList();
      }
      
      private function openGroupTab() : void
      {
         var idolW:ItemWrapper = null;
         this.btn_group.selected = true;
         this.setActiveIdolsDrag(true);
         this.btn_showSynergyScore.x = this.btn_showAll.x;
         this.switchTab("btn_group");
         this._activeIdolsIds.length = 0;
         for each(idolW in this._currentActiveGroupIdols)
         {
            this._activeIdolsIds.push(this.dataApi.getIdolByItemId(idolW.objectGID).id);
         }
         this.gd_activeIdols.dataProvider = this._currentActiveGroupIdols;
         this.updateIdolsScores();
         this.gd_idols.dataProvider = this._groupIdols;
         this.updateTotals();
         this.updateList();
      }
      
      private function openPresetsTab() : void
      {
         this.btn_presets.selected = true;
         this.setActiveIdolsDrag(false);
         this.switchTab("btn_presets",true);
         this._btnDeleteAssoc = new Dictionary();
         this.gd_activeIdols.dataProvider = this._currentActiveSoloIdols;
         this.gd_presets.dataProvider = this._presetsIdols;
         this.applyPresetSort();
      }
      
      private function switchTab(tabName:String, pPresetsTab:Boolean = false) : void
      {
         this.lbl_exp.visible = this.lbl_loot.visible = !pPresetsTab;
         this.tx_synergy.visible = !pPresetsTab;
         this.ctr_idols.visible = !pPresetsTab;
         this.btn_showAll.visible = this.btn_solo.selected;
         this.btn_showSynergyScore.visible = this.btn_solo.selected || this.btn_group.selected;
         this.ctr_presets.visible = pPresetsTab;
         this._currentTabName = tabName;
      }
      
      private function updateGroupIdols(pPartyChosenIdols:Object, pPartyIdols:Object) : void
      {
         var i:int = 0;
         var idol:Idol = null;
         var partyIdol:Object = null;
         this._groupIdols = [];
         this._currentActiveGroupIdols = new Vector.<ItemWrapper>(0);
         var numPartyChosenIdols:uint = pPartyChosenIdols.length;
         var numPartyIdols:uint = pPartyIdols.length;
         for(i = 0; i < numPartyChosenIdols; i++)
         {
            idol = this.dataApi.getIdol(pPartyChosenIdols[i]);
            this._currentActiveGroupIdols.push(this.dataApi.getItemWrapper(idol.itemId));
         }
         for(i = 0; i < numPartyIdols; i++)
         {
            partyIdol = pPartyIdols[i];
            idol = this.dataApi.getIdol(partyIdol.id);
            this._groupIdols.push(this.getIdolData(idol,partyIdol.ownersIds,pPartyChosenIdols.indexOf(idol.id) != -1,!this._isPartyLeader));
         }
      }
      
      private function getIdolData(pIdol:Object, pOwnersIds:Object, pActive:Boolean = false, pReadOnly:Boolean = false) : Object
      {
         if(pActive && this._activeIdolsIds.indexOf(pIdol.id) == -1)
         {
            this._activeIdolsIds.push(pIdol.id);
         }
         var item:ItemWrapper = this.dataApi.getItemWrapper(pIdol.itemId);
         return {
            "idol":pIdol,
            "idolId":pIdol.id,
            "item":item,
            "name":item.name,
            "description":pIdol.spellPair.description,
            "score":pIdol.score,
            "bonusXp":pIdol.experienceBonus,
            "bonusDrop":pIdol.dropBonus,
            "ownersIds":pOwnersIds,
            "partyOnlyIdol":pIdol.groupOnly,
            "active":pActive,
            "readOnly":pReadOnly
         };
      }
      
      private function selectIdol(pIdolId:uint, pActivate:Boolean, pGrid:Grid) : void
      {
         if(pActivate && this._activeIdolsIds.length == MAX_ACTIVE_IDOLS)
         {
            return;
         }
         this._idolsSelections.push(new IdolSelection(pIdolId,this.dataApi.getIdol(pIdolId).itemId,pActivate,pGrid,pGrid.selectedIndex));
         this.sysApi.sendAction(new IdolSelectRequestAction([pIdolId,pActivate,!this.btn_solo.selected]));
      }
      
      private function dragIdol(pIdolId:uint, pActivate:Boolean, pGrid:Grid) : void
      {
         this._idolsSelections.push(new IdolSelection(pIdolId,this.dataApi.getIdol(pIdolId).itemId,pActivate,pGrid,pGrid.selectedIndex));
         this.sysApi.sendAction(new IdolSelectRequestAction([pIdolId,pActivate,!this.btn_solo.selected]));
      }
      
      private function enableIdol(pIdolId:uint, pParty:Boolean, index:int = -1) : void
      {
         var itemW:ItemWrapper = null;
         var activeIdols:Vector.<ItemWrapper> = !pParty ? this._currentActiveSoloIdols : this._currentActiveGroupIdols;
         if(activeIdols.length < MAX_ACTIVE_IDOLS)
         {
            itemW = this.dataApi.getItemWrapper(this.dataApi.getIdol(pIdolId).itemId);
            if(index == -1)
            {
               if(this.gd_activeIdols.selectedIndex == -1)
               {
                  activeIdols.push(itemW);
               }
               else
               {
                  activeIdols.insertAt(this.gd_activeIdols.selectedIndex,itemW);
               }
            }
            else
            {
               activeIdols.insertAt(index,itemW);
            }
            if(!pParty && this.btn_solo.selected || pParty && this.btn_group.selected)
            {
               this._activeIdolsIds.push(pIdolId);
               this.gd_activeIdols.dataProvider = activeIdols;
               this.updateTotals();
            }
         }
      }
      
      private function disableIdol(pIdolId:uint, pParty:Boolean) : void
      {
         var itemW:ItemWrapper = null;
         var idolIndex:int = 0;
         var activeIdols:Vector.<ItemWrapper> = !pParty ? this._currentActiveSoloIdols : this._currentActiveGroupIdols;
         var idolItemGID:uint = this.dataApi.getIdol(pIdolId).itemId;
         for each(itemW in activeIdols)
         {
            if(itemW.objectGID == idolItemGID)
            {
               idolIndex = activeIdols.indexOf(itemW);
               if(idolIndex != -1)
               {
                  activeIdols.splice(idolIndex,1);
               }
               break;
            }
         }
         if(!pParty && (this.btn_solo.selected || this.btn_presets.selected) || pParty && this.btn_group.selected)
         {
            idolIndex = this._activeIdolsIds.indexOf(pIdolId);
            if(idolIndex != -1)
            {
               this._activeIdolsIds.splice(idolIndex,1);
            }
            this.gd_activeIdols.dataProvider = activeIdols;
            this.updateTotals();
         }
      }
      
      private function showIdolTooltip(pData:Object, pTarget:Object) : void
      {
         if(pData)
         {
            this.uiApi.showTooltip(pData,pTarget,false,"IdolsInfo",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_BOTTOMRIGHT,3,null,null);
         }
      }
      
      private function showItemMenu(pData:Object) : void
      {
         var contextMenu:Object = this.menuApi.create(pData);
         if(contextMenu && contextMenu.content.length > 0)
         {
            this.uiApi.hideTooltip("IdolsInfo");
            this.modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      private function updateTotals() : void
      {
         var i:int = 0;
         var idol:Idol = null;
         var coeff:Number = NaN;
         var incompatibleMonstersIds:Vector.<int> = null;
         var incompatibleMonstersNames:Vector.<String> = null;
         var incompatibleMonsterId:int = 0;
         var incompatibleMonster:Monster = null;
         var numActiveIdols:uint = this._activeIdolsIds.length;
         var totalScoreWithoutCoeff:uint = 0;
         this._totalScore = this._totalExp = this._totalLoot = 0;
         this._positiveSynergies = new Dictionary();
         this._negativeSynergies = new Dictionary();
         for(i = 0; i < numActiveIdols; i++)
         {
            idol = this.dataApi.getIdol(this._activeIdolsIds[i]);
            coeff = this.getIdolCoeff(idol,this._activeIdolsIds);
            this._totalScore += Math.floor(idol.score * coeff);
            this._totalExp += Math.floor(idol.experienceBonus * coeff);
            this._totalLoot += Math.floor(idol.dropBonus * coeff);
            totalScoreWithoutCoeff += idol.score;
            if(idol.incompatibleMonsters.length > 0)
            {
               if(!incompatibleMonstersIds)
               {
                  incompatibleMonstersIds = new Vector.<int>(0);
                  incompatibleMonstersNames = new Vector.<String>(0);
               }
               for each(incompatibleMonsterId in idol.incompatibleMonsters)
               {
                  if(incompatibleMonstersIds.indexOf(incompatibleMonsterId) == -1)
                  {
                     incompatibleMonstersIds.push(incompatibleMonsterId);
                  }
               }
            }
         }
         this._totalExp = this.computeExpBonusWithWisdom(this._totalExp);
         this._totalLoot = this.computeLootBonusWithProspecting(this._totalLoot);
         this.lbl_score.text = this._totalScore.toString();
         this.lbl_exp.text = this.uiApi.getText("ui.idol.bonusXp",this._totalExp) + " %";
         this.lbl_loot.text = this.uiApi.getText("ui.idol.bonusLoot",this._totalLoot) + " %";
         this._globalSynergy = this._totalScore / totalScoreWithoutCoeff;
         this.tx_synergy.visible = !this.btn_presets.selected ? this.hasSynergies(true) || this.hasSynergies(false) : Boolean(null);
         for each(incompatibleMonsterId in incompatibleMonstersIds)
         {
            incompatibleMonster = this.dataApi.getMonsterFromId(incompatibleMonsterId);
            if(incompatibleMonster)
            {
               incompatibleMonstersNames.push(incompatibleMonster.name);
            }
         }
         this._txIncompatibleMonstersAssoc[this.tx_allIncompatibleMonsters] = incompatibleMonstersNames;
         this.tx_allIncompatibleMonsters.visible = incompatibleMonstersNames && incompatibleMonstersNames.length > 0;
      }
      
      private function getIdolCoeff(pIdol:Idol, pIdolsList:Object, pAddSynergy:Boolean = true) : Number
      {
         var i:int = 0;
         var j:int = 0;
         var coeff:Number = 1;
         var synergiesIds:Vector.<int> = pIdol.synergyIdolsIds;
         var synergiesCoeffs:Vector.<Number> = pIdol.synergyIdolsCoeff;
         var numSynergies:uint = synergiesIds.length;
         var numActiveIdols:uint = pIdolsList.length;
         for(i = 0; i < numActiveIdols; i++)
         {
            for(j = 0; j < numSynergies; j++)
            {
               if(synergiesIds[j] == pIdolsList[i])
               {
                  if(synergiesCoeffs[j] > 1)
                  {
                     this.addSynergy(!!pAddSynergy ? this._positiveSynergies : this._tmpPositiveSynergies,pIdol.id,synergiesIds[j],synergiesCoeffs[j]);
                  }
                  else if(synergiesCoeffs[j] < 1)
                  {
                     this.addSynergy(!!pAddSynergy ? this._negativeSynergies : this._tmpNegativeSynergies,pIdol.id,synergiesIds[j],synergiesCoeffs[j]);
                  }
                  coeff *= synergiesCoeffs[j];
               }
            }
         }
         return coeff;
      }
      
      private function computeExpBonusWithWisdom(pBonus:uint) : uint
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         var wisdom:int = stats !== null ? int(stats.getStatTotalValue(StatIds.WISDOM)) : 0;
         var level:int = this.playerApi.getPlayedCharacterInfo().level;
         if(level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            level = ProtocolConstantsEnum.MAX_LEVEL;
         }
         return Math.max((2.5 * level + 100) * pBonus / (wisdom + 100),0);
      }
      
      private function computeLootBonusWithProspecting(pBonus:uint) : uint
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         var pp:int = stats !== null ? int(stats.getStatTotalValue(StatIds.MAGIC_FIND)) : 0;
         var level:int = this.playerApi.getPlayedCharacterInfo().level;
         if(level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            level = ProtocolConstantsEnum.MAX_LEVEL;
         }
         return Math.max((0.5 * level + 100) * pBonus / (pp + 100),0);
      }
      
      private function addSynergy(pSynergiesList:Dictionary, pSourceIdolId:uint, pOtherIdolId:uint, pOtherIdolCoeff:Number) : void
      {
         var synergy:IdolSynergy = null;
         if(!pSynergiesList[pSourceIdolId])
         {
            pSynergiesList[pSourceIdolId] = new Vector.<IdolSynergy>(0);
         }
         for each(synergy in pSynergiesList[pSourceIdolId])
         {
            if(synergy.idolId == pOtherIdolId)
            {
               return;
            }
         }
         pSynergiesList[pSourceIdolId].push(new IdolSynergy(pOtherIdolId,pOtherIdolCoeff));
      }
      
      private function getSynergiesText(pSynergiesList:Dictionary, pPositiveSynergies:Boolean) : String
      {
         var idolId:* = undefined;
         var idol:Idol = null;
         var synergies:Vector.<IdolSynergy> = null;
         var synergiesText:String = null;
         var text:String = "<ul>";
         var displayedIdols:Vector.<int> = new Vector.<int>(0);
         for(idolId in pSynergiesList)
         {
            idol = this.dataApi.getIdol(idolId);
            synergies = pSynergiesList[idolId];
            synergiesText = this.getSynergyText(idolId,synergies,displayedIdols);
            if(synergiesText.length > 0)
            {
               text += "<li><b>" + idol.item.name + "</b>" + this.uiApi.getText("ui.common.colon") + synergiesText + "</li>";
               displayedIdols.push(idolId);
            }
         }
         return text + "</ul>";
      }
      
      private function getSynergyText(pIdolId:int, pSynergies:Vector.<IdolSynergy>, pDisplayedIdols:Vector.<int> = null, pSelectedIdolsOnly:Boolean = false) : String
      {
         var synergy:IdolSynergy = null;
         var synergyIdol:Idol = null;
         var synergiesText:String = "";
         var firstSynergyIdol:Boolean = true;
         for each(synergy in pSynergies)
         {
            if((!pSelectedIdolsOnly || this._activeIdolsIds.indexOf(synergy.idolId) != -1) && (!pDisplayedIdols || pDisplayedIdols.indexOf(synergy.idolId) == -1))
            {
               synergyIdol = this.dataApi.getIdol(synergy.idolId);
               synergiesText += (!!firstSynergyIdol ? "" : ", ") + synergyIdol.item.name + " (x" + "<font color=\'" + (synergy.synergyCoeff > 1 ? this._synergyBonusColor : this._synergyMalusColor) + "\'>" + synergy.synergyCoeff.toFixed(2) + "</font>" + ")";
               firstSynergyIdol = false;
            }
         }
         return synergiesText;
      }
      
      private function refreshSoloIdolsList() : void
      {
         var allIdols:Array = null;
         var i:int = 0;
         var numIdols:uint = 0;
         var newDp:Array = null;
         var idol:Idol = null;
         if(this.btn_showAll.selected)
         {
            allIdols = this.dataApi.getAllIdols();
            numIdols = allIdols.length;
            newDp = this._soloIdols.concat();
            for(i = 0; i < numIdols; i++)
            {
               idol = allIdols[i];
               if(this._playerIdolsIds.indexOf(idol.id) == -1)
               {
                  newDp.push(this.getIdolData(idol,null,false,true));
               }
            }
            this.gd_idols.dataProvider = newDp;
         }
         else
         {
            this.gd_idols.dataProvider = this._soloIdols;
         }
      }
      
      private function applySort() : void
      {
         var lastSortType:String = this.sysApi.getData(IDOLS_LAST_SORT);
         var lastSortOrder:* = this.sysApi.getData(IDOLS_LAST_SORT_ORDER);
         if(!this._lastSortType && !lastSortType)
         {
            this.onRelease(this.btn_sortIdolByName);
            return;
         }
         var sortType:String = !!this._lastSortType ? this._lastSortType : lastSortType;
         if(sortType)
         {
            this._lastSortType = sortType;
            this._ascendingSort = lastSortOrder != null ? !lastSortOrder : false;
            if(sortType == "name")
            {
               this.displaySortArrows(true,false);
               this.onRelease(this.btn_sortIdolByName);
            }
            else if(sortType == "score")
            {
               this.displaySortArrows(false,true);
               this.onRelease(this.btn_sortIdolByScore);
            }
         }
      }
      
      private function sort(pIdols:Object, pSortType:String, pAscending:Boolean, pIsString:Boolean) : Object
      {
         var sortedIdols:Object = null;
         if(pIsString)
         {
            this.utilApi.sortOnString(pIdols,pSortType,pAscending);
            sortedIdols = pIdols;
         }
         else
         {
            sortedIdols = this.utilApi.sort(pIdols,pSortType,pAscending,true);
         }
         return sortedIdols;
      }
      
      private function applyFilter(pFilterId:uint) : void
      {
         switch(pFilterId)
         {
            case ALL_IDOLS_FILTER:
               this.gd_idols.dataProvider = this._currentDataProvider;
               break;
            case PARTY_IDOLS_FILTER:
               this.filter("partyOnlyIdol",true);
               break;
            case SOLO_IDOLS_FILTER:
               this.filter("partyOnlyIdol",false);
               break;
            case IDOLS_SCORE_20:
               this.filter("score",20,">");
               break;
            case IDOLS_SCORE_40:
               this.filter("score",40,">");
               break;
            case IDOLS_SCORE_60:
               this.filter("score",60,">");
         }
         this._currentFilter = pFilterId;
         this._filteredDataProvider = this.gd_idols.dataProvider;
      }
      
      private function filter(pDataFieldName:String, pDataFieldValue:*, pOperator:String = "==") : void
      {
         var filteredDataProvider:Array = null;
         var i:int = 0;
         var idolData:Object = null;
         this._currentDataProvider = this.gd_idols.dataProvider;
         var numIdols:uint = !!this._currentDataProvider ? uint(this._currentDataProvider.length) : uint(0);
         if(numIdols > 0)
         {
            filteredDataProvider = [];
            for(i = 0; i < numIdols; i++)
            {
               idolData = this._currentDataProvider[i];
               if(pOperator == "==")
               {
                  if(idolData[pDataFieldName] == pDataFieldValue)
                  {
                     filteredDataProvider.push(idolData);
                  }
               }
               else if(pOperator == ">")
               {
                  if(idolData[pDataFieldName] > pDataFieldValue)
                  {
                     filteredDataProvider.push(idolData);
                  }
               }
            }
            this.gd_idols.dataProvider = filteredDataProvider;
         }
      }
      
      private function stopSearch() : void
      {
         clearTimeout(this._searchTimeoutId);
         this.inp_search.text = this._searchText;
         this.gd_idols.dataProvider = this._filteredDataProvider;
      }
      
      private function getSearchText() : String
      {
         if(this.inp_search.text != this._searchText)
         {
            return this.inp_search.text;
         }
         return "";
      }
      
      private function updateList() : void
      {
         this.applySort();
         this.applyFilter(this._currentFilter);
         clearTimeout(this._searchTimeoutId);
         this.onSearch();
      }
      
      private function deletePreset() : void
      {
         if(this._presetToDelete)
         {
            this.sysApi.sendAction(new PresetDeleteRequestAction([this._presetToDelete.presetId]));
         }
      }
      
      private function doNothing() : void
      {
         this._presetToDelete = null;
      }
      
      private function savePreset(pPreset:Object) : void
      {
         var preset:Object = null;
         var presetScore:uint = 0;
         var i:int = 0;
         var idol:Idol = null;
         var coeff:Number = NaN;
         preset = {};
         preset.presetId = pPreset.id;
         preset.iconId = pPreset.gfxId;
         preset.icon = pPreset;
         preset.idolsIds = pPreset.idolsIds;
         preset.idols = [];
         presetScore = 0;
         for(i = 0; i < pPreset.idolsIds.length; i++)
         {
            idol = this.dataApi.getIdol(pPreset.idolsIds[i]);
            coeff = this.getIdolCoeff(idol,pPreset.idolsIds,false);
            presetScore += Math.floor(idol.score * coeff);
            preset.idols.push(this.dataApi.getItemWrapper(idol.itemId));
         }
         preset.score = presetScore;
         this._presetsIdols.push(preset);
      }
      
      private function applyPresetSort() : void
      {
         var lastSortType:String = this.sysApi.getData(IDOLS_PRESET_LAST_SORT);
         var lastSortOrder:* = this.sysApi.getData(IDOLS_PRESET_LAST_SORT_ORDER);
         if(!this._lastPresetSortType && !lastSortType)
         {
            this._lastPresetSortType = "presetId";
            this.gd_presets.dataProvider = this.utilApi.sort(this._presetsIdols,this._lastPresetSortType,this._presetAscendingSort,true);
            this.sysApi.setData(IDOLS_LAST_SORT,this._lastPresetSortType);
            this.sysApi.setData(IDOLS_LAST_SORT_ORDER,this._presetAscendingSort);
            return;
         }
         var sortType:String = !!this._lastPresetSortType ? this._lastPresetSortType : lastSortType;
         if(sortType)
         {
            this._lastPresetSortType = sortType;
            this._presetAscendingSort = lastSortOrder != null ? !lastSortOrder : false;
            if(sortType == "presetId")
            {
               this.gd_presets.dataProvider = this.utilApi.sort(this._presetsIdols,sortType,true,true);
               this.sysApi.setData(IDOLS_PRESET_LAST_SORT,this._lastPresetSortType);
               this.sysApi.setData(IDOLS_PRESET_LAST_SORT_ORDER,this._presetAscendingSort);
            }
            else if(sortType == "score")
            {
               this.onRelease(this.btn_sortPresetsByScore);
            }
         }
      }
      
      private function getFreePresetId() : uint
      {
         var freeId:uint = 0;
         var preset:Object = null;
         var i:int = 0;
         var exists:Boolean = false;
         var maxPresets:uint = this.gd_icons.dataProvider.length;
         for(i = 0; i < maxPresets; i++)
         {
            exists = false;
            for each(preset in this._presetsIdols)
            {
               if(preset.presetId == i)
               {
                  exists = true;
                  break;
               }
            }
            if(!exists)
            {
               freeId = i;
               break;
            }
         }
         return freeId;
      }
      
      private function initButtonValue(pValueName:String, pButton:ButtonContainer, pDefaultValue:Boolean) : void
      {
         var selected:* = this.sysApi.getData(pValueName);
         pButton.selected = selected != null ? Boolean(selected) : Boolean(pDefaultValue);
         this.sysApi.setData(pValueName,pButton.selected);
      }
      
      private function updateIdolsScores(pUpdateList:Boolean = false) : void
      {
         var idolData:Object = null;
         var idolScore:int = 0;
         var currentScore:uint = 0;
         var idolId:* = undefined;
         var idolsData:Array = !!this.btn_solo.selected ? this._soloIdols : this._groupIdols;
         var selectedIdolsScores:Dictionary = new Dictionary();
         var unselectedIdols:Array = [];
         var tmpIdols:Vector.<int> = new Vector.<int>();
         this._tmpPositiveSynergies = new Dictionary();
         this._tmpNegativeSynergies = new Dictionary();
         for each(idolData in idolsData)
         {
            idolScore = idolData.idol.score;
            if(this.btn_showSynergyScore.selected)
            {
               if(this._activeIdolsIds.indexOf(idolData.idolId) != -1)
               {
                  tmpIdols.length = 0;
                  currentScore = 0;
                  for(idolId in selectedIdolsScores)
                  {
                     currentScore += selectedIdolsScores[idolId];
                     tmpIdols.push(idolId);
                  }
                  tmpIdols.push(idolData.idolId);
                  idolScore = this.getTotalScore(tmpIdols) - currentScore;
                  selectedIdolsScores[idolData.idolId] = idolScore;
               }
               else
               {
                  unselectedIdols.push(idolData);
               }
            }
            idolData.score = idolScore;
         }
         for each(idolData in unselectedIdols)
         {
            tmpIdols.length = 0;
            currentScore = 0;
            for(idolId in selectedIdolsScores)
            {
               currentScore += selectedIdolsScores[idolId];
               tmpIdols.push(idolId);
            }
            tmpIdols.push(idolData.idolId);
            idolData.score = this.getTotalScore(tmpIdols) - currentScore;
         }
         if(pUpdateList)
         {
            if(this.btn_solo.selected)
            {
               this.refreshSoloIdolsList();
            }
            else if(this.btn_group.selected)
            {
               this.gd_idols.dataProvider = this._groupIdols;
            }
            this.updateList();
         }
      }
      
      private function getTotalScore(pIdolsList:Vector.<int>) : uint
      {
         var idol:Idol = null;
         var coeff:Number = NaN;
         var i:int = 0;
         var totalScore:uint = 0;
         var numActiveIdols:uint = pIdolsList.length;
         for(i = 0; i < numActiveIdols; i++)
         {
            idol = this.dataApi.getIdol(pIdolsList[i]);
            coeff = this.getIdolCoeff(idol,pIdolsList,false);
            totalScore += Math.floor(idol.score * coeff);
         }
         return totalScore;
      }
      
      private function getIndexFromComponent(pTarget:GraphicContainer) : int
      {
         var slot:GraphicContainer = null;
         for each(slot in this.gd_idols.slots)
         {
            if(slot.contains(pTarget))
            {
               return this.gd_idols.getIndex() + slot.y / this.gd_idols.slotHeight;
            }
         }
         return -1;
      }
      
      private function hasSynergies(pPositiveSynergies:Boolean) : Boolean
      {
         var idolId:* = undefined;
         var synergies:Dictionary = !!pPositiveSynergies ? this._positiveSynergies : this._negativeSynergies;
         return synergies.length > 0;
      }
      
      private function displaySortArrows(name:Boolean, score:Boolean, presetScore:Boolean = false) : void
      {
         this.tx_sortNameDown.visible = name && this._ascendingSort;
         this.tx_sortNameUp.visible = name && !this._ascendingSort;
         this.tx_sortScoreDown.visible = score && this._ascendingSort;
         this.tx_sortScoreUp.visible = score && !this._ascendingSort;
         this.tx_sortScorePresetDown.visible = presetScore && this._presetAscendingSort;
         this.tx_sortScorePresetUp.visible = presetScore && !this._presetAscendingSort;
      }
      
      public function onIdolSelected(pIdolId:uint, pActivate:Boolean, pParty:Boolean) : void
      {
         var idolIndex:int = 0;
         var updateAll:* = false;
         var i:int = 0;
         var numIdols:uint = 0;
         var forceRollOver:* = false;
         var itemId:uint = 0;
         var partyLeaderUpdate:Boolean = pParty && !this.btn_group.softDisabled && (!this._isPartyLeader || this._idolsSelections.length == 0);
         var nextSelection:IdolSelection = !partyLeaderUpdate && this._idolsSelections.length > 0 ? this._idolsSelections.shift() : null;
         if(partyLeaderUpdate || nextSelection && nextSelection.idolId == pIdolId && nextSelection.activate == pActivate)
         {
            if(pActivate)
            {
               this.enableIdol(pIdolId,pParty);
               updateAll = this._activeIdolsIds.length == MAX_ACTIVE_IDOLS;
            }
            else
            {
               this.disableIdol(pIdolId,pParty);
               updateAll = this._activeIdolsIds.length == MAX_ACTIVE_IDOLS - 1;
            }
            numIdols = this.gd_idols.dataProvider.length;
            if(partyLeaderUpdate)
            {
               itemId = this.dataApi.getIdol(pIdolId).itemId;
               for(i = 0; i < numIdols; i++)
               {
                  if(this.gd_idols.dataProvider[i].item.objectGID == itemId)
                  {
                     idolIndex = i;
                     break;
                  }
               }
            }
            else if(nextSelection)
            {
               if(nextSelection.target == this.gd_activeIdols)
               {
                  for(i = 0; i < numIdols; i++)
                  {
                     if(this.gd_idols.dataProvider[i].item.objectGID == nextSelection.itemId)
                     {
                        idolIndex = i;
                        break;
                     }
                  }
                  this.uiApi.hideTooltip("IdolsInfo");
               }
               else if(nextSelection.target == this.gd_idols)
               {
                  forceRollOver = !pActivate;
                  idolIndex = nextSelection.selectedIndex;
               }
            }
            if(!this.btn_showSynergyScore.selected)
            {
               if(!updateAll)
               {
                  this.gd_idols.updateItem(idolIndex);
               }
               else
               {
                  this.gd_idols.dataProvider = this.gd_idols.dataProvider;
               }
            }
            else
            {
               this.updateIdolsScores(true);
            }
            if(forceRollOver)
            {
               idolIndex = this.gd_idols.getIndex() + Math.floor(this.gd_idols.mouseY / this.gd_idols.slotHeight);
               this._forceLineRollOver = true;
               this.gd_idols.updateItem(idolIndex);
            }
         }
      }
      
      public function onIdolSelectError(pReason:uint, pIdolId:uint, pActivate:Boolean, pParty:Boolean) : void
      {
         var nextSelection:IdolSelection = this._idolsSelections.length > 0 ? this._idolsSelections.shift() : null;
      }
      
      public function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void
      {
         if(!oneLifePointRegenOnly)
         {
            this.updateTotals();
         }
      }
      
      public function onPartyLeave(id:int, isArena:Boolean) : void
      {
         if(this.btn_group.selected)
         {
            this.openSoloTab();
         }
         this.btn_group.softDisabled = true;
      }
      
      public function onIdolAdded(pIdolId:uint) : void
      {
         if(this._playerIdolsIds.indexOf(pIdolId) == -1)
         {
            this._playerIdolsIds.push(pIdolId);
            this._soloIdols.unshift(this.getIdolData(this.dataApi.getIdol(pIdolId),null));
            if(this.btn_solo.selected)
            {
               this.updateIdolsScores();
               this.refreshSoloIdolsList();
               this.updateList();
            }
         }
      }
      
      public function onIdolRemoved(pIdolId:uint) : void
      {
         var i:int = 0;
         var numSoloIdols:uint = this._soloIdols.length;
         var removedIdolIndex:int = -1;
         for(i = 0; i < numSoloIdols; i++)
         {
            if(this._soloIdols[i].idolId == pIdolId)
            {
               removedIdolIndex = i;
               break;
            }
         }
         if(removedIdolIndex != -1)
         {
            this._playerIdolsIds.splice(this._playerIdolsIds.indexOf(pIdolId),1);
            this._soloIdols.splice(removedIdolIndex,1);
            if(!this.btn_group.selected)
            {
               this.disableIdol(pIdolId,false);
               this.updateIdolsScores();
               this.refreshSoloIdolsList();
               this.updateList();
            }
         }
      }
      
      public function onIdolsList(pChosenIdols:Object, pPartyChosenIdols:Object, pPartyIdols:Object) : void
      {
         this.updateGroupIdols(pPartyChosenIdols,pPartyIdols);
         if(pPartyIdols.length > 0 && this.btn_group.softDisabled)
         {
            this.btn_group.softDisabled = false;
         }
      }
      
      public function onIdolPartyRefresh(pPartyIdol:Object) : void
      {
         var idolData:Object = null;
         var idolExists:Boolean = false;
         var newIdol:Idol = null;
         for each(idolData in this._groupIdols)
         {
            if(idolData.idolId == pPartyIdol.id)
            {
               idolExists = true;
               break;
            }
         }
         if(!idolExists)
         {
            newIdol = this.dataApi.getIdol(pPartyIdol.id);
            this._groupIdols.unshift(this.getIdolData(newIdol,pPartyIdol.ownersIds,false,!this._isPartyLeader));
         }
         else if(idolData)
         {
            idolData.ownersIds = pPartyIdol.ownersIds;
            idolData.bonusXp = pPartyIdol.xpBonusPercent;
            idolData.bonusDrop = pPartyIdol.dropBonusPercent;
         }
         if(this.btn_group.selected)
         {
            this.updateIdolsScores();
            this.gd_idols.dataProvider = this._groupIdols;
            this.updateList();
         }
      }
      
      public function onIdolPartyLost(pIdolId:uint) : void
      {
         var idolData:Object = null;
         var deletedIdolIndex:int = -1;
         for each(idolData in this._groupIdols)
         {
            if(idolData.idolId == pIdolId)
            {
               deletedIdolIndex = this._groupIdols.indexOf(idolData);
               break;
            }
         }
         if(deletedIdolIndex != -1)
         {
            this._groupIdols.splice(deletedIdolIndex,1);
         }
         if(this.btn_group.selected)
         {
            this.disableIdol(pIdolId,true);
            this.updateIdolsScores();
            this.gd_idols.dataProvider = this._groupIdols;
            this.updateList();
         }
      }
      
      public function onIdolsPresetsUpdate(pPresets:Object) : void
      {
         var idolsPresetWrapper:Object = null;
         this._presetsIdols.length = 0;
         for each(idolsPresetWrapper in pPresets)
         {
            this.savePreset(idolsPresetWrapper);
         }
      }
      
      public function onIdolsPresetDelete(pPresetId:uint) : void
      {
         var preset:Object = null;
         var presetIndex:int = 0;
         for each(preset in this._presetsIdols)
         {
            if(preset.presetId == pPresetId)
            {
               presetIndex = this._presetsIdols.indexOf(preset);
               break;
            }
         }
         this._presetsIdols.splice(presetIndex,1);
         this.gd_presets.dataProvider = this._presetsIdols;
         this.applyPresetSort();
         this._presetToDelete = null;
      }
      
      public function onIdolsPresetEquipped(pPresetId:uint) : void
      {
         var preset:Object = null;
         var idol:Idol = null;
         var idolW:ItemWrapper = null;
         var updateBonuses:Boolean = this.btn_solo.selected || this.btn_presets.selected;
         this._currentActiveSoloIdols.length = 0;
         if(updateBonuses)
         {
            this._activeIdolsIds.length = 0;
         }
         for each(preset in this._presetsIdols)
         {
            if(preset.presetId == pPresetId)
            {
               for each(idolW in preset.idols)
               {
                  idol = this.dataApi.getIdolByItemId(idolW.objectGID);
                  if(this._playerIdolsIds.indexOf(idol.id) != -1)
                  {
                     this._currentActiveSoloIdols.push(this.dataApi.getItemWrapper(idol.itemId));
                     if(updateBonuses)
                     {
                        this._activeIdolsIds.push(idol.id);
                     }
                  }
               }
               break;
            }
         }
         if(updateBonuses)
         {
            this.updateTotals();
         }
         if(!this.btn_group.selected)
         {
            this.gd_activeIdols.dataProvider = this._currentActiveSoloIdols;
            if(this.btn_solo.selected)
            {
               this.gd_idols.dataProvider = this.gd_idols.dataProvider;
            }
         }
      }
      
      public function onIdolsPresetSaved(pPreset:Object) : void
      {
         this.savePreset(pPreset);
         this.gd_presets.dataProvider = this._presetsIdols;
         this.applyPresetSort();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var idolData:Object = null;
         switch(target)
         {
            case this.gd_activeIdols:
               if(!this._isInFight && (!this.btn_group.selected || this._isPartyLeader) && selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  this.selectIdol(this.dataApi.getIdolByItemId((target as Grid).selectedItem.objectGID).id,false,this.gd_activeIdols);
               }
               break;
            case this.gd_idols:
               if(!this._isInFight && selectMethod == SelectMethodEnum.CLICK)
               {
                  idolData = (target as Grid).selectedItem;
                  if(idolData && !idolData.readOnly)
                  {
                     this.selectIdol(idolData.idolId,this._activeIdolsIds.indexOf(idolData.idolId) == -1,this.gd_idols);
                  }
               }
               break;
            case this.cb_filter:
               if(this.btn_solo.selected)
               {
                  this.refreshSoloIdolsList();
               }
               else if(this.btn_group.selected)
               {
                  this.gd_idols.dataProvider = this._groupIdols;
               }
               this._currentFilter = (target as ComboBox).selectedItem.id;
               this.updateList();
               break;
            case this.gd_icons:
               this._currentIcon = (target as Grid).selectedItem.id;
         }
      }
      
      public function onGameFightStart() : void
      {
         this._isInFight = true;
      }
      
      public function onGameFightEnd(resultsKey:String) : void
      {
         this._isInFight = false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var sortType:String = null;
         var preset:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return;
            case this.btn_help:
               this.hintsApi.showSubHints(this.currentTabName);
               break;
            case this.btn_solo:
               this.openSoloTab();
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_group:
               this.openGroupTab();
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_presets:
               this.openPresetsTab();
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_showAll:
               this.refreshSoloIdolsList();
               this.sysApi.setData(IDOLS_SHOW_ALL,this.btn_showAll.selected);
               this.updateList();
               break;
            case this.btn_showSynergyScore:
               this.updateIdolsScores(true);
               this.sysApi.setData(IDOLS_SHOW_SYNERGY_SCORE,this.btn_showSynergyScore.selected);
               break;
            case this.btn_sortIdolByName:
            case this.btn_sortIdolByScore:
               sortType = this._sortFieldAssoc[target];
               this._ascendingSort = sortType != this._lastSortType ? true : !this._ascendingSort;
               this._lastSortType = sortType;
               this.sysApi.setData(IDOLS_LAST_SORT,this._lastSortType);
               this.sysApi.setData(IDOLS_LAST_SORT_ORDER,this._ascendingSort);
               this.gd_idols.dataProvider = this.sort(this.gd_idols.dataProvider,sortType,this._ascendingSort,sortType == "name");
               this._currentDataProvider = this.gd_idols.dataProvider;
               if(this._filteredDataProvider)
               {
                  this._filteredDataProvider = this.sort(this._filteredDataProvider,sortType,this._ascendingSort,sortType == "name");
               }
               this.displaySortArrows(sortType == "name",sortType == "score");
               this.displaySortArrows(sortType == "name",sortType == "score");
               break;
            case this.inp_search:
               if(this.inp_search.text == this._searchText)
               {
                  this.inp_search.text = "";
               }
               break;
            case this.btn_closeSearch:
               this.stopSearch();
               break;
            case this.btn_savePreset:
               for each(preset in this._presetsIdols)
               {
                  if(preset.iconId == this._currentIcon)
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.idol.presets.iconUsed"),[this.uiApi.getText("ui.common.ok")]);
                     return;
                  }
               }
               this.sysApi.sendAction(new IdolsPresetSaveRequestAction([-1,this._currentIcon]));
               break;
            case this.btn_sortPresetsByScore:
               this._presetAscendingSort = !this._presetAscendingSort;
               this.displaySortArrows(false,false,true);
               this.gd_presets.dataProvider = this.utilApi.sort(this._presetsIdols,"score",this._presetAscendingSort,true);
               this._lastPresetSortType = "score";
               this.sysApi.setData(IDOLS_PRESET_LAST_SORT,this._lastPresetSortType);
               this.sysApi.setData(IDOLS_PRESET_LAST_SORT_ORDER,this._presetAscendingSort);
               break;
            default:
               if(target.name.indexOf("btn_delete") != -1 && this._btnDeleteAssoc[target])
               {
                  this._presetToDelete = this._btnDeleteAssoc[target];
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.idol.presets.delete"),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.deletePreset,this.doNothing],this.deletePreset,this.doNothing);
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var txt:* = null;
         var owners:String = null;
         var globalSynergyColor:String = null;
         var globalSynergy:String = null;
         var positiveSynergies:Boolean = false;
         var totalExp:uint = 0;
         var totalLoot:uint = 0;
         var numPresetIdols:uint = 0;
         var idol:Idol = null;
         var coeff:Number = NaN;
         var i:int = 0;
         var idolId:int = 0;
         var selectedOnlyIdols:* = false;
         var positiveSynergiesText:String = null;
         var negativeSynergiesText:String = null;
         var idolIndex:int = this.getIndexFromComponent(target);
         if(target.name.indexOf("gd_idols") != -1)
         {
            if(!this.gd_idols.dataProvider[idolIndex])
            {
               return;
            }
            this._forceLineRollOver = true;
            this.gd_idols.updateItem(idolIndex);
         }
         if(target.name.indexOf("slot_idol") != -1)
         {
            this.showIdolTooltip((target as Slot).data,target);
         }
         else
         {
            if(target.name.indexOf("tx_partyOnly") != -1)
            {
               txt = this.uiApi.getText("ui.idol.partyOnlyIdol");
            }
            else if(target.name.indexOf("tx_memberIdol") != -1)
            {
               owners = this._txMemberIdolAssoc[target];
               txt = this.uiApi.getText("ui.idol.idolOwner",owners);
            }
            else if(target.name.toLowerCase().indexOf("incompatiblemonsters") != -1)
            {
               if(this._txIncompatibleMonstersAssoc[target])
               {
                  txt = this.uiApi.getText("ui.idol.incompatibleMonsters",this._txIncompatibleMonstersAssoc[target].join("\n"));
               }
            }
            else if(target.name.indexOf("lbl_exp") != -1)
            {
               txt = this.uiApi.getText("ui.idol.tooltip.bonusExp");
            }
            else if(target.name.indexOf("lbl_loot") != -1)
            {
               txt = this.uiApi.getText("ui.idol.tooltip.bonusLoot");
            }
            else if(target.name.indexOf("tx_synergy") != -1)
            {
               if(this._globalSynergy < 1)
               {
                  globalSynergyColor = this._synergyMalusColor;
               }
               else if(this._globalSynergy > 1)
               {
                  globalSynergyColor = this._synergyBonusColor;
               }
               globalSynergy = "x" + (!!globalSynergyColor ? "<font color=\'" + globalSynergyColor + "\'>" + this._globalSynergy.toFixed(2) + "</font>" : this._globalSynergy);
               txt = this.uiApi.getText("ui.idol.synergyTooltip",globalSynergy);
               positiveSynergies = this.hasSynergies(true);
               if(positiveSynergies)
               {
                  txt += "\n\n" + this.uiApi.getText("ui.idol.positiveSynergies",this.getSynergiesText(this._positiveSynergies,true));
               }
               if(this.hasSynergies(false))
               {
                  txt += (!!positiveSynergies ? "\n" : "\n\n") + this.uiApi.getText("ui.idol.negativeSynergies",this.getSynergiesText(this._negativeSynergies,false));
               }
            }
            else if(target.name.indexOf("slot_icon_m_gd_presets") != -1)
            {
               totalExp = 0;
               totalLoot = 0;
               numPresetIdols = (target as Slot).data.idolsIds.length;
               for(i = 0; i < numPresetIdols; i++)
               {
                  idol = this.dataApi.getIdol((target as Slot).data.idolsIds[i]);
                  coeff = this.getIdolCoeff(idol,(target as Slot).data.idolsIds);
                  totalExp += Math.floor(idol.experienceBonus * coeff);
                  totalLoot += Math.floor(idol.dropBonus * coeff);
               }
               txt = this.uiApi.getText("ui.idol.bonusXp",this.computeExpBonusWithWisdom(totalExp)) + " %" + "\n" + this.uiApi.getText("ui.idol.bonusLoot",this.computeLootBonusWithProspecting(totalLoot)) + " %" + "\n<i>" + this.uiApi.getText("ui.idol.preset.tip") + "</i>";
            }
            else if(target.name.indexOf("lbl_idol_score") != -1 && this.btn_showSynergyScore.selected)
            {
               idolId = this.gd_idols.dataProvider[idolIndex].idolId;
               selectedOnlyIdols = this._activeIdolsIds.indexOf(idolId) != -1;
               positiveSynergiesText = this.getSynergyText(idolId,this._tmpPositiveSynergies[idolId],null,selectedOnlyIdols);
               if(positiveSynergiesText.length > 0)
               {
                  txt = this.uiApi.getText("ui.idol.positiveSynergies","<li><b>" + this.gd_idols.dataProvider[idolIndex].name + "</b>" + this.uiApi.getText("ui.common.colon") + positiveSynergiesText + "</li>");
               }
               negativeSynergiesText = this.getSynergyText(idolId,this._tmpNegativeSynergies[idolId],null,selectedOnlyIdols);
               if(negativeSynergiesText.length > 0)
               {
                  txt = (!!txt ? txt + "\n" : "") + this.uiApi.getText("ui.idol.negativeSynergies","<li><b>" + this.gd_idols.dataProvider[idolIndex].name + "</b>" + this.uiApi.getText("ui.common.colon") + negativeSynergiesText + "</li>");
               }
            }
            if(txt)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"IdolsInfo",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip("IdolsInfo");
         if(target.name.indexOf("gd_idols") != -1)
         {
            this._forceLineRollOut = true;
            this.gd_idols.updateItem(this.getIndexFromComponent(target));
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(target.name.indexOf("slot_idol") != -1)
         {
            this.showItemMenu((target as Slot).data);
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         this.showIdolTooltip(item.data,item.container);
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip("IdolsInfo");
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         this.showItemMenu(item.data);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_search:
               clearTimeout(this._searchTimeoutId);
               if(this.getSearchText() != "")
               {
                  this._searchTimeoutId = setTimeout(this.onSearch,SEARCH_DELAY);
               }
               else if(this.gd_idols.dataProvider != this._filteredDataProvider)
               {
                  this.gd_idols.dataProvider = this._filteredDataProvider;
               }
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         this.sysApi.sendAction(new PresetUseRequestAction([(target as Slot).data.id]));
      }
      
      private function onSearch() : void
      {
         this.gd_idols.dataProvider = this.utilApi.filter(this._filteredDataProvider,this.getSearchText(),"name");
      }
   }
}

class IdolSelection
{
    
   
   public var idolId:uint;
   
   public var itemId:uint;
   
   public var activate:Boolean;
   
   public var target:Object;
   
   public var selectedIndex:int;
   
   function IdolSelection(pIdolId:uint, pItemId:uint, pActivate:Boolean, pTarget:Object, pSelectedIndex:int)
   {
      super();
      this.idolId = pIdolId;
      this.itemId = pItemId;
      this.activate = pActivate;
      this.target = pTarget;
      this.selectedIndex = pSelectedIndex;
   }
}

class IdolSynergy
{
    
   
   public var idolId:int;
   
   public var synergyCoeff:Number;
   
   function IdolSynergy(pIdolId:uint, pSynergyCoeff:Number)
   {
      super();
      this.idolId = pIdolId;
      this.synergyCoeff = pSynergyCoeff;
   }
}
