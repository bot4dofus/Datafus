package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.optionalFeatures.Modster;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Point;
   
   public class ForgettableModstersUi extends ForgettableSpellsUi
   {
      
      private static const LEARNED_SPELLS_FILTER_LEARNED:uint = 1;
      
      private static const FROM_FORGETTABLE_SPELLS:uint = 1;
      
      private static const FORGETTABLE_SPELLS_TAB_NAME:String = "btn_forgettableSpells";
      
      private static const COMMON_SPELLS_TAB_NAME:String = "btn_commonSpells";
      
      private static const SPELL_EQUIPPED_SORT_TYPE:String = "sortSpellsByEquipped";
      
      private static const STORAGE_SPELL_SORT:String = "forgettableSpellsUiSpellSort";
      
      private static const SPELL_FAMILY_COMMON:String = "commonSpell";
      
      private static const STORAGE_IS_SPELL_EQUIPPED_SORT_ASCENDING_TYPE:String = "modstersSpellsUiIsSpellEquippedSortAscendingType";
      
      private static const STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE:String = "forgettableModstersUiHasCommonSpellsTabBeenOpenedOnce";
      
      private static const DEFAULT_SPELL_EQUIPPED_SORT_TYPE:Boolean = true;
      
      private static const MODSTER_ACTIVE_SPELLS_PADDING:int = 4;
      
      private static const MAX_MODSTERS_PRESET_COUNT:int = 50;
      
      private static var _searchOnModsterName:Boolean = true;
      
      private static var _searchOnSpellName:Boolean = true;
       
      
      public var lbl_forgettableSpellsModstersSpells:Label;
      
      public var lbl_forgettableSpellsModstersPassiveSpell:Label;
      
      public var lbl_modsterEquipped:Label;
      
      public var lbl_commonSpellEquippedHeader:Label;
      
      public var lbl_noModsters:Label;
      
      public var lbl_seeCollection:Label;
      
      public var tx_sortMosterByEquippedDescending:Texture;
      
      public var tx_sortMosterByEquippedAscending:Texture;
      
      public var tx_sortCommonSpellByEquippedDescending:Texture;
      
      public var tx_sortCommonSpellByEquippedAscending:Texture;
      
      public var btn_sortModsterbyEquipped:ButtonContainer;
      
      public var btn_sortCommonSpellbyEquipped:ButtonContainer;
      
      public var btn_searchFilter:ButtonContainer;
      
      public var ctr_warning:GraphicContainer;
      
      private var _isSpellEquippedSortAscending:Boolean = true;
      
      private var _isInLockedMode:Boolean;
      
      private var _needTutorial:Boolean = false;
      
      public function ForgettableModstersUi()
      {
         super();
      }
      
      override public function main(paramsObject:Object = null) : void
      {
         systemApi.addHook(HookList.GameFightJoin,this.onFightJoin);
         uiApi.addComponentHook(this.btn_searchFilter,ComponentHookList.ON_RELEASE);
         this._isSpellEquippedSortAscending = this.defaultIsSpellEquippedSortAscendingType;
         super.main(paramsObject);
         ctr_shareForgettableSpells.visible = false;
         lbl_spellLevelFilter.visible = false;
         ctr_spellLevelFilter.visible = false;
         cbx_learningSpellsFilter.visible = false;
         ctr_obtainingFilters.visible = false;
         btn_lbl_btn_saveAsASpellSet.text = uiApi.getText("ui.temporis.modsters.team.save");
         lbl_seeMySpellSets.text = uiApi.getText("ui.temporis.modsters.team.see");
         this._needTutorial = systemApi.getSetData("needModsterTuto" + playedCharacterApi.id(),true,DataStoreEnum.BIND_CHARACTER);
      }
      
      override public function onUiLoaded(name:String) : void
      {
         var introPopup:UiRootContainer = null;
         super.onUiLoaded(name);
         if(name === UIEnum.INVENTORY_UI)
         {
            uiApi.me().setOnTop();
            introPopup = uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_INTRO_POP_UP);
            if(introPopup)
            {
               introPopup.setOnTop();
            }
         }
      }
      
      override public function unload() : void
      {
         bindsApi.setShortcutEnabled(true);
         super.unload();
      }
      
      override protected function get storageStateMod() : String
      {
         return "forgettableModstersUi";
      }
      
      override protected function get spellSetUiName() : String
      {
         return UIEnum.FORGETTABLE_MODSTER_SETS_UI;
      }
      
      override protected function fitSortableLabelHeaders() : void
      {
         super.fitSortableLabelHeaders();
         this.lbl_modsterEquipped.fullWidth();
         this.lbl_commonSpellEquippedHeader.fullWidth();
         this.lbl_forgettableSpellsModstersSpells.fullWidth();
         this.lbl_forgettableSpellsModstersPassiveSpell.fullWidth();
         fitCenteredSortableLabelHeader(this.lbl_modsterEquipped);
         fitCenteredSortableLabelHeader(this.lbl_commonSpellEquippedHeader);
         fitCenteredSortableLabelHeader(this.lbl_forgettableSpellsModstersSpells);
         fitCenteredSortableLabelHeader(this.lbl_forgettableSpellsModstersPassiveSpell);
      }
      
      override protected function get searchInputPlaceholder() : String
      {
         return uiApi.getText("ui.temporis.modsters.search");
      }
      
      override protected function get defaultLearnedSpellFilter() : uint
      {
         return LEARNED_SPELLS_FILTER_LEARNED;
      }
      
      override protected function get getScrollBtnOverTextKey() : String
      {
         return "ui.temporis.modsters.transferToInventory";
      }
      
      private function updateSpellEquippedSort() : void
      {
         _currentSort = SPELL_EQUIPPED_SORT_TYPE;
         systemApi.setData(STORAGE_SPELL_SORT,_currentSort);
         this._isSpellEquippedSortAscending = !this._isSpellEquippedSortAscending;
         systemApi.setData(STORAGE_IS_SPELL_EQUIPPED_SORT_ASCENDING_TYPE,this._isSpellEquippedSortAscending);
         this.applySort();
      }
      
      private function applySpellEquippedSort() : void
      {
         this.resetSortButtons();
         var spellsToProvide:Array = null;
         if(_currentTabName === FORGETTABLE_SPELLS_TAB_NAME)
         {
            if(this._isSpellEquippedSortAscending)
            {
               this.tx_sortMosterByEquippedAscending.visible = true;
            }
            else
            {
               this.tx_sortMosterByEquippedDescending.visible = true;
            }
            if(_filteredForgettableSpells !== null)
            {
               _filteredForgettableSpells.sort(this.sortSpellByEquipped);
               spellsToProvide = _filteredForgettableSpells;
            }
            else
            {
               spellsToProvide = _forgettableSpells;
            }
         }
         else if(_currentTabName === COMMON_SPELLS_TAB_NAME)
         {
            if(this._isSpellEquippedSortAscending)
            {
               this.tx_sortCommonSpellByEquippedAscending.visible = true;
            }
            else
            {
               this.tx_sortCommonSpellByEquippedDescending.visible = true;
            }
            if(_filteredCommonSpells !== null)
            {
               _filteredCommonSpells.sort(this.sortSpellByEquipped);
               spellsToProvide = _filteredCommonSpells;
            }
            else
            {
               spellsToProvide = _commonSpells;
            }
         }
         currentSpells.sort(this.sortSpellByEquipped);
         currentSpellGridDataProvider = spellsToProvide;
      }
      
      override protected function applySort() : void
      {
         if(_currentSort === SPELL_EQUIPPED_SORT_TYPE)
         {
            this.applySpellEquippedSort();
         }
         else
         {
            super.applySort();
         }
      }
      
      override protected function resetSortButtons() : void
      {
         super.resetSortButtons();
         this.tx_sortMosterByEquippedAscending.visible = false;
         this.tx_sortMosterByEquippedDescending.visible = false;
         this.tx_sortCommonSpellByEquippedAscending.visible = false;
         this.tx_sortCommonSpellByEquippedDescending.visible = false;
      }
      
      private function sortSpellByEquipped(firstSpell:Object, secondSpell:Object) : Number
      {
         var firstSpellPriority:int = 0;
         var secondSpellPriority:int = 0;
         if(firstSpell.spellFamily === SPELL_FAMILY_COMMON && _commonSpellPriorities !== null && firstSpell.spellType !== secondSpell.spellType && firstSpell.spellType in _commonSpellPriorities && secondSpell.spellType in _commonSpellPriorities)
         {
            firstSpellPriority = _commonSpellPriorities[firstSpell.spellType];
            secondSpellPriority = _commonSpellPriorities[secondSpell.spellType];
            if(firstSpellPriority < secondSpellPriority)
            {
               return -1;
            }
            return 1;
         }
         if(firstSpell.isSpellActive && !secondSpell.isSpellActive)
         {
            return !!this._isSpellEquippedSortAscending ? Number(-1) : Number(1);
         }
         if(!firstSpell.isSpellActive && secondSpell.isSpellActive)
         {
            return !!this._isSpellEquippedSortAscending ? Number(1) : Number(-1);
         }
         return sortBySpellName(firstSpell,secondSpell,true);
      }
      
      private function get defaultIsSpellEquippedSortAscendingType() : Boolean
      {
         var rawValue:* = systemApi.getData(STORAGE_IS_SPELL_EQUIPPED_SORT_ASCENDING_TYPE);
         return rawValue is Boolean ? Boolean(rawValue as Boolean) : Boolean(DEFAULT_SPELL_EQUIPPED_SORT_TYPE);
      }
      
      override public function updateForgettableSpellLine(spellDescr:Object, components:*, isSelected:Boolean) : void
      {
         var spellId:int = 0;
         uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OVER);
         uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OUT);
         uiApi.removeComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
         uiApi.removeComponentHook(components.tx_findForgettableSpellScroll,ComponentHookList.ON_RELEASE);
         uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
         uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OVER);
         uiApi.removeComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OUT);
         uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OVER);
         uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OUT);
         uiApi.removeComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_DOUBLE_CLICK);
         if(spellDescr === null)
         {
            components.slot_forgettableSpell.visible = false;
            components.tx_isSelectedForgettableSpell.visible = false;
            components.lbl_forgettableSpellName.visible = false;
            components.tx_findForgettableSpellScroll.visible = false;
            components.btn_getForgettableSpellScroll.visible = false;
            components.slot_forgettableSpell.allowDrag = false;
            components.tx_findForgettableSpellScroll.visible = false;
            components.btn_forgettableSpellLine.state = StatesEnum.STATE_NORMAL;
            components.btn_forgettableSpellLine.handCursor = false;
            components.gd_modsterActiveSpells.visible = false;
            components.slot_modsterPassiveSpell.visible = false;
            return;
         }
         uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_ROLL_OUT);
         _componentsDictionary[components.slot_forgettableSpell.name] = spellDescr.isSpellActive;
         _componentsDictionary[components.btn_forgettableSpellLine.name] = spellDescr;
         components.btn_forgettableSpellLine.state = StatesEnum.STATE_NORMAL;
         components.tx_isSelectedForgettableSpell.visible = spellDescr.isSpellActive;
         components.slot_forgettableSpell.visible = true;
         components.slot_forgettableSpell.allowDrag = spellDescr.isKnown;
         components.slot_forgettableSpell.data = spellDescr.spellWrapper;
         components.slot_forgettableSpell.greyedOut = !spellDescr.isKnown;
         _componentsDictionary[components.slot_forgettableSpell.name] = spellDescr;
         uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_ROLL_OUT);
         components.lbl_forgettableSpellName.visible = true;
         components.lbl_forgettableSpellName.text = spellDescr.spellName;
         var modster:Modster = Modster.getModsterByScrollId(spellDescr.scrollId);
         var activeSpells:Array = [];
         for each(spellId in modster.modsterActiveSpells)
         {
            activeSpells.push(SpellWrapper.create(spellId,1));
         }
         components.gd_modsterActiveSpells.visible = true;
         components.gd_modsterActiveSpells.dataProvider = activeSpells;
         components.gd_modsterActiveSpells.width = activeSpells.length * (components.gd_modsterActiveSpells.slotWidth + MODSTER_ACTIVE_SPELLS_PADDING);
         if(modster.modsterPassiveSpells.length > 0)
         {
            _componentsDictionary[components.slot_modsterPassiveSpell.name] = SpellWrapper.create(modster.modsterPassiveSpells[0],1);
         }
         uiApi.addComponentHook(components.slot_modsterPassiveSpell,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(components.slot_modsterPassiveSpell,ComponentHookList.ON_ROLL_OUT);
         components.slot_modsterPassiveSpell.visible = modster.modsterPassiveSpells.length > 0;
         components.slot_modsterPassiveSpell.data = _componentsDictionary[components.slot_modsterPassiveSpell.name];
         components.slot_modsterPassiveSpell.greyedOut = false;
         this.lbl_noModsters.visible = false;
         if(spellDescr.isKnown)
         {
            components.btn_getForgettableSpellScroll.visible = true;
            components.btn_getForgettableSpellScroll.softDisabled = this._isInLockedMode || playedCharacterApi.isInFight();
            components.tx_findForgettableSpellScroll.visible = false;
            uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(components.btn_getForgettableSpellScroll,ComponentHookList.ON_RELEASE);
            _componentsDictionary[components.btn_getForgettableSpellScroll.name] = spellDescr;
            uiApi.addComponentHook(components.slot_forgettableSpell,ComponentHookList.ON_DOUBLE_CLICK);
            _componentsDictionary[components.slot_forgettableSpell.name] = spellDescr;
            uiApi.addComponentHook(components.btn_forgettableSpellLine,ComponentHookList.ON_DOUBLE_CLICK);
         }
      }
      
      override public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(target.name.indexOf("gd_modsterActiveSpells") != -1)
         {
            showSpellTooltip(item.data,item.container,FROM_FORGETTABLE_SPELLS);
         }
         else
         {
            super.onItemRollOver(target,item);
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         if(target.name.indexOf("slot_modsterPassiveSpell") != -1)
         {
            showSpellTooltip(_componentsDictionary[target.name],target,FROM_FORGETTABLE_SPELLS);
         }
         else if(target == btn_lbl_btn_saveAsASpellSet && btn_lbl_btn_saveAsASpellSet.disabled)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.temporis.modsters.team.limit")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         var pos:Point = null;
         if(target == this.btn_sortModsterbyEquipped || target == this.btn_sortCommonSpellbyEquipped)
         {
            this.updateSpellEquippedSort();
         }
         else if(target == this.btn_searchFilter)
         {
            contextMenu = [];
            contextMenu.push(ankamaContextMenu.createContextMenuTitleObject(uiApi.getText("ui.search.criteria")));
            contextMenu.push(ankamaContextMenu.createContextMenuItemObject(uiApi.getText("ui.temporis.modster"),this.changeSearchOnModsterName,null,false,null,_searchOnModsterName,false));
            contextMenu.push(ankamaContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.spellTitle"),this.changeSearchOnSpellName,null,false,null,_searchOnSpellName,false));
            pos = this.btn_searchFilter.localToGlobal(new Point(this.btn_searchFilter.x + this.btn_searchFilter.width,this.btn_searchFilter.y + this.btn_searchFilter.height));
            ankamaContextMenu.createContextMenu(contextMenu,pos);
         }
         else
         {
            super.onRelease(target);
         }
      }
      
      private function changeSearchOnModsterName() : void
      {
         _searchOnModsterName = !_searchOnModsterName;
         this.handleSearchInput();
      }
      
      private function changeSearchOnSpellName() : void
      {
         _searchOnSpellName = !_searchOnSpellName;
         this.handleSearchInput();
      }
      
      override protected function handleSearchInput() : void
      {
         var filteredSpells:Array = null;
         var forgettableSpell:Object = null;
         if(!_isSearchInputReady || inp_spellLevelSearch.isPlaceholderActive())
         {
            applyLearnedSpellsFilter(true);
            return;
         }
         currentFilteredSpells = _forgettableSpells.concat();
         var searchText:String = inp_spellLevelSearch.lastTextOnInput == this.searchInputPlaceholder ? "" : inp_spellLevelSearch.lastTextOnInput;
         _currentSearchText = searchText;
         if(!_searchOnModsterName && !_searchOnSpellName && _currentSearchText != "")
         {
            currentSpellGridDataProvider = [];
            return;
         }
         if(!_isSearchInputFilled)
         {
            if(searchText)
            {
               _isSearchInputFilled = true;
            }
         }
         applyLearnedSpellsFilter();
         var filteredSpellsByModsterName:Array = currentFilteredSpells.concat();
         var filteredSpellsSpellName:Array = currentFilteredSpells.concat();
         if(_searchOnModsterName && !_searchOnSpellName)
         {
            filteredSpellsByModsterName = this.searchOnModsterName();
            currentFilteredSpells = filteredSpellsByModsterName;
         }
         else if(!_searchOnModsterName && _searchOnSpellName)
         {
            filteredSpellsSpellName = this.searchOnSpellName();
            currentFilteredSpells = filteredSpellsSpellName;
         }
         else if(_searchOnModsterName && _searchOnSpellName)
         {
            filteredSpellsByModsterName = this.searchOnModsterName();
            filteredSpellsSpellName = this.searchOnSpellName();
            filteredSpells = filteredSpellsByModsterName.concat();
            for each(forgettableSpell in filteredSpellsSpellName)
            {
               if(filteredSpellsByModsterName.indexOf(forgettableSpell) == -1)
               {
                  filteredSpells.push(forgettableSpell);
               }
            }
            currentFilteredSpells = filteredSpells;
         }
         applyLearnedSpellsFilter(true);
      }
      
      private function searchOnModsterName() : Array
      {
         var filteredSpells:Array = currentFilteredSpells.concat();
         if(!_currentSearchText)
         {
            return filteredSpells;
         }
         return utilApi.filter(filteredSpells,_currentSearchText,"spellName");
      }
      
      private function searchOnSpellName() : Array
      {
         var modster:Modster = null;
         var spell:Spell = null;
         var isPushed:Boolean = false;
         var forgettableSpell:Object = null;
         var passiveSpellId:uint = 0;
         var activeSpellId:uint = 0;
         if(!_currentSearchText)
         {
            return currentFilteredSpells.concat();
         }
         var filteredSpells:Array = [];
         var searchText:String = utilApi.noAccent(_currentSearchText.toLowerCase());
         for each(forgettableSpell in _forgettableSpells)
         {
            modster = Modster.getModsterById(forgettableSpell.spellId);
            if(!(modster == null || filteredSpells.indexOf(forgettableSpell) != -1))
            {
               isPushed = false;
               for each(passiveSpellId in modster.modsterPassiveSpells)
               {
                  spell = Spell.getSpellById(passiveSpellId);
                  if(spell && utilApi.noAccent(spell.name.toLowerCase()).indexOf(searchText) != -1)
                  {
                     isPushed = true;
                     filteredSpells.push(forgettableSpell);
                     break;
                  }
               }
               if(!isPushed)
               {
                  for each(activeSpellId in modster.modsterActiveSpells)
                  {
                     spell = Spell.getSpellById(activeSpellId);
                     if(spell && utilApi.noAccent(spell.name.toLowerCase()).indexOf(searchText) != -1)
                     {
                        isPushed = true;
                        filteredSpells.push(forgettableSpell);
                        break;
                     }
                  }
               }
            }
         }
         return filteredSpells;
      }
      
      private function onFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean) : void
      {
         if(currentTabName == FORGETTABLE_SPELLS_TAB_NAME)
         {
            gd_forgettableSpells.updateItems();
         }
      }
      
      override protected function beforeForgettableSpellsDataProvider() : void
      {
         this.lbl_noModsters.visible = true;
         if(_isSearchInputFilled)
         {
            this.lbl_noModsters.text = uiApi.getText("ui.common.noSearchResult");
         }
         else
         {
            this.lbl_noModsters.text = uiApi.getText("ui.temporis.modsters.emptyList");
         }
      }
      
      override protected function get spellsIntroPopupTitle() : String
      {
         return uiApi.getText("ui.temporis.modstersUiIntroPopupTitle");
      }
      
      override protected function get spellsIntroPopupDesc() : String
      {
         return uiApi.getText("ui.temporis.modstersUiIntroPopupDescription");
      }
      
      override protected function get selfUiName() : String
      {
         return UIEnum.FORGETTABLE_MODSTERS_UI;
      }
      
      override protected function get getScrollWarningUiName() : String
      {
         return UIEnum.MODSTER_GET_SCROLL_WARNING_POP_UP;
      }
      
      override protected function get commonSpellsDataStorageName() : String
      {
         return STORAGE_HAS_COMMON_SPELLS_TAB_BEEN_OPENED_ONCE;
      }
      
      private function switchToLockedMode(modal:Boolean) : void
      {
         var introPopup:UiRootContainer = null;
         var inventoryUi:UiRootContainer = null;
         if(modal && !this._needTutorial)
         {
            return;
         }
         this._isInLockedMode = modal;
         bindsApi.setShortcutEnabled(!modal);
         uiApi.me().showModalContainer = modal;
         this.ctr_warning.visible = modal;
         btn_commonSpells.disabled = modal;
         btn_finishMoves.disabled = modal;
         btn_saveAsASpellSet.disabled = modal;
         btn_seeMySpellSets.disabled = lbl_seeMySpellSets.disabled = modal;
         this.lbl_seeCollection.disabled = modal;
         if(modal)
         {
            uiApi.me().setOnTop();
            introPopup = uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_INTRO_POP_UP);
            if(introPopup)
            {
               introPopup.setOnTop();
            }
         }
         else
         {
            inventoryUi = uiApi.getUi(UIEnum.INVENTORY_UI);
            if(inventoryUi)
            {
               Berilia.getInstance().setUiOnTop(inventoryUi);
            }
         }
         gd_forgettableSpells.updateItems();
         this._needTutorial = systemApi.setData("needModsterTuto" + playedCharacterApi.id(),false,DataStoreEnum.BIND_CHARACTER);
      }
      
      override protected function refreshForgettableSpellsList() : void
      {
         super.refreshForgettableSpellsList();
         this.switchToLockedMode(_learnedForgettableSpellsCount >= 1 && _equippedForgettableSpells.length == 0);
      }
      
      override protected function setSaveSpellSetButton() : void
      {
         btn_saveAsASpellSet.disabled = this._isInLockedMode || inventoryApi.getBuildNumber(2) >= presetLimit;
      }
      
      override public function onShortcut(s:String) : Boolean
      {
         if(this._isInLockedMode)
         {
            return false;
         }
         return super.onShortcut(s);
      }
   }
}
