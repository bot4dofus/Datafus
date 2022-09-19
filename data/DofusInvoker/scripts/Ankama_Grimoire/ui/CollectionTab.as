package Ankama_Grimoire.ui
{
   import Ankama_Cartography.Cartography;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.collection.Collectable;
   import com.ankamagames.dofus.datacenter.collection.Collection;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.optionalFeatures.Modster;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailedListRequestAction;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class CollectionTab
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Cartography")]
      public var modCartography:Cartography;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private const CACHE_LAST_COLLECTABLE_SELECTED:String = "lastCollectableSelected";
      
      private const CACHE_SHOW_MODSTERS_AREA:String = "showModstersInArea";
      
      private const ACHIEVEMENT_CAT_MODSTER:uint = 129;
      
      private const ACHIEVEMENT_CAT_MODSTER_COLLECTION:uint = 130;
      
      private const HIDDEN_MODSTER:uint = 7137;
      
      private const COLOR_SELECTED:int = 10006804;
      
      private const COLOR_HIDDEN:int = 0;
      
      private const COLOR_DISCOVERED:int = 1118481;
      
      private const COLOR_OVER:int = 5789784;
      
      private const SORT_BY_ORDER:uint = 0;
      
      private const SORT_BY_NAME:uint = 1;
      
      private const FILTER_ALL:uint = 0;
      
      private const FILTER_DISCOVERED:uint = 1;
      
      private const FILTER_FINISHED:uint = 2;
      
      private var _componentsList:Dictionary;
      
      private var _collection:Collection;
      
      private var _collectables:Vector.<Collectable>;
      
      private var _collectablesDiscovered:Vector.<Collectable>;
      
      private var _collectablesFinished:Vector.<Collectable>;
      
      private var _filteredCollectables:Vector.<Collectable>;
      
      private var _modstersInSubArea:Vector.<Collectable>;
      
      private var _currentModster:Modster;
      
      private var _realMonster:Monster;
      
      private var _parentMonster:Monster;
      
      private var _hiddenSuccessFinished:Vector.<uint>;
      
      private var _hiddenSuccessStarted:Vector.<uint>;
      
      private var _successFinished:Vector.<uint>;
      
      private var _successStarted:Vector.<uint>;
      
      private var _currentModsterSubAreas:Vector.<uint>;
      
      private var _mapPopup:String;
      
      private var _modsters:Vector.<Modster>;
      
      private var _modstersDiscovered:Vector.<Modster>;
      
      private var _cbFilters:Array;
      
      private var _sortType:uint = 0;
      
      private var _ascending:Boolean = true;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _currentSearchText:String;
      
      private var _lastSearchText:String;
      
      public var gd_modsters:Grid;
      
      public var ctr_details:GraphicContainer;
      
      public var ctr_noDetails:GraphicContainer;
      
      public var slot_modsterPassiveSpell:Slot;
      
      public var ctr_separator:GraphicContainer;
      
      public var gd_modsterActiveSpells:Grid;
      
      public var tx_modsterIllu:Texture;
      
      public var lbl_modsterName:Label;
      
      public var lbl_bigModsterId:Label;
      
      public var lbl_bigModsterIdNotDiscovered:Label;
      
      public var lbl_modsterCategory:Label;
      
      public var hint_category:Texture;
      
      public var lbl_modsterSuccess:Label;
      
      public var gd_modsterSuccess:Grid;
      
      public var lbl_modsterObtentionTitle:Label;
      
      public var lbl_modsterArea:Label;
      
      public var btn_loc:ButtonContainer;
      
      public var cb_filterModsters:ComboBox;
      
      public var btn_sort:ButtonContainer;
      
      public var lbl_modstersCount:Label;
      
      public var lbl_noModsterFound:Label;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_showModstersInArea:ButtonContainer;
      
      public function CollectionTab()
      {
         this._componentsList = new Dictionary(true);
         this._collectables = new Vector.<Collectable>();
         this._collectablesDiscovered = new Vector.<Collectable>();
         this._collectablesFinished = new Vector.<Collectable>();
         this._filteredCollectables = new Vector.<Collectable>();
         this._modstersInSubArea = new Vector.<Collectable>();
         this._hiddenSuccessFinished = new Vector.<uint>();
         this._hiddenSuccessStarted = new Vector.<uint>();
         this._successFinished = new Vector.<uint>();
         this._successStarted = new Vector.<uint>();
         this._currentModsterSubAreas = new Vector.<uint>();
         this._cbFilters = [];
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var collectable:Collectable = null;
         var _collection:Collection = Collection.getCollectionById(DataEnum.COLLECTION_MOBEDEX);
         if(!_collection || !_collection.isRespected)
         {
            return;
         }
         this.sysApi.addHook(QuestHookList.AchievementDetailedList,this.onAchievementDetailed);
         this.uiApi.addComponentHook(this.hint_category,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.hint_category,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_loc,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sort,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_filterModsters,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.collection.searchModster");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.restrict = "^[&\"~!@#$£%*\\_+=[]|;<>./?{},]()";
         this.btn_resetSearch.visible = false;
         this._cbFilters = [{
            "label":this.uiApi.getText("ui.collection.filterAllModster"),
            "filterType":this.FILTER_ALL
         },{
            "label":this.uiApi.getText("ui.collection.filterSuccessMissing"),
            "filterType":this.FILTER_DISCOVERED
         },{
            "label":this.uiApi.getText("ui.collection.filterSuccessFinished"),
            "filterType":this.FILTER_FINISHED
         }];
         this.cb_filterModsters.dataProvider = this._cbFilters;
         this.cb_filterModsters.value = this._cbFilters[0];
         this.tx_modsterIllu.useCache = false;
         this.gd_modsterSuccess.x = this.lbl_modsterSuccess.x + this.lbl_modsterSuccess.textWidth + 10;
         this.btn_showModstersInArea.selected = this.sysApi.getSetData(this.CACHE_SHOW_MODSTERS_AREA + this.playerApi.id(),false,DataStoreEnum.BIND_CHARACTER);
         this._collectables = _collection.collectables;
         this._collectables = this.utilApi.sort(this._collectables,"order",this._ascending,true);
         this._filteredCollectables = this._collectables.concat();
         var modstersInCurrentSubArea:Vector.<uint> = this.getModstersIdsInCurrentSubArea();
         for each(collectable in this._filteredCollectables)
         {
            if(modstersInCurrentSubArea.indexOf(collectable.entityId) != -1)
            {
               this._modstersInSubArea.push(collectable);
            }
         }
         this.sysApi.sendAction(AchievementDetailedListRequestAction.create(this.ACHIEVEMENT_CAT_MODSTER_COLLECTION));
         this.sysApi.sendAction(AchievementDetailedListRequestAction.create(this.ACHIEVEMENT_CAT_MODSTER));
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi(this._mapPopup);
      }
      
      public function updateModsters(data:Collectable, components:*, selected:Boolean) : void
      {
         var isDiscovered:Boolean = false;
         components.tx_modster.visible = false;
         if(data)
         {
            if(!this._componentsList[components.ctr_modster.name])
            {
               this.uiApi.addComponentHook(components.ctr_modster,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.ctr_modster,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.ctr_modster,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentsList[components.ctr_modster.name] = data;
            isDiscovered = this.collectableIsdiscovered(data);
            selected = this._currentModster && data.entityId == this._currentModster.modsterId;
            components.ctr_modster.visible = true;
            if(selected)
            {
               components.ctr_modster.bgColor = this.COLOR_SELECTED;
            }
            else
            {
               components.ctr_modster.bgColor = !!isDiscovered ? this.COLOR_DISCOVERED : this.COLOR_HIDDEN;
            }
            components.tx_modster.useCache = false;
            components.tx_modster.visible = components.ctr_modsterId.visible = isDiscovered;
            components.tx_modsterCompleted.visible = components.tx_modster.visible && this.allSuccessValidated(data);
            components.tx_modster.uri = this.uiApi.createUri(this.uiApi.me().getConstant("modster_uri") + data.entityId + ".swf");
            components.lbl_modsterId.text = data.order;
            components.lbl_bigModsterId.visible = !components.ctr_modsterId.visible;
            components.lbl_bigModsterId.text = data.order;
         }
         else
         {
            components.ctr_modster.visible = false;
            components.ctr_modsterId.visible = false;
            components.lbl_modsterId.text = "";
            components.lbl_bigModsterId.visible = false;
            components.lbl_bigModsterId.text = "";
            components.tx_modster.uri = null;
         }
      }
      
      public function updateSuccess(data:Object, components:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!this._componentsList[components.btn_success.name])
            {
               this.uiApi.addComponentHook(components.btn_success,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_success,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_success,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentsList[components.btn_success.name] = data;
            components.ctr_success.visible = true;
            components.tx_validSuccess.visible = this.successIsValidated(uint(data));
         }
         else
         {
            components.ctr_success.visible = false;
            components.tx_validSuccess.visible = false;
         }
      }
      
      private function initModsters(collectables:Vector.<Collectable>) : void
      {
         var modster:Modster = null;
         var collectable:Collectable = null;
         this._modsters = new Vector.<Modster>(this._collectables.length);
         this._modstersDiscovered = new Vector.<Modster>();
         this._collectablesDiscovered = new Vector.<Collectable>();
         for each(collectable in this._collectables)
         {
            modster = Modster.getModsterByModsterId(collectable.entityId);
            this._modsters[collectable.order - 1] = modster;
            if(this.collectableIsdiscovered(collectable))
            {
               if(this._modstersDiscovered.indexOf(modster) == -1)
               {
                  this._modstersDiscovered.push(modster);
               }
               if(this._collectablesDiscovered.indexOf(collectable) == -1)
               {
                  this._collectablesDiscovered.push(collectable);
               }
            }
         }
         this.lbl_modstersCount.text = this.uiApi.getText("ui.collection.modstersCount",this._collectablesDiscovered.length,this._collectables.length);
      }
      
      private function selectModster(modsterCollectable:Collectable) : void
      {
         var spellId:int = 0;
         if(!this.collectableIsdiscovered(modsterCollectable))
         {
            this.lbl_bigModsterIdNotDiscovered.text = modsterCollectable.order.toString();
            this.ctr_details.visible = false;
            this.ctr_noDetails.visible = true;
         }
         else
         {
            this.ctr_details.visible = true;
            this.ctr_noDetails.visible = false;
         }
         this._currentModster = this._modsters[modsterCollectable.order - 1];
         if(this._currentModster == null)
         {
            return;
         }
         this.sysApi.setData(this.CACHE_LAST_COLLECTABLE_SELECTED + this.playerApi.id(),modsterCollectable,DataStoreEnum.BIND_CHARACTER);
         if(this.gd_modsters.indexIsInvisibleSlot(this._filteredCollectables.indexOf(modsterCollectable)))
         {
            this.gd_modsters.moveTo(this._filteredCollectables.indexOf(modsterCollectable),true);
         }
         var scrollValue:int = this.gd_modsters.verticalScrollValue;
         this.gd_modsters.updateItems();
         this._realMonster = this.dataApi.getMonsterFromId(this._currentModster.modsterId);
         if(this._currentModster.parentsModsterId.length)
         {
            this._parentMonster = this.dataApi.getMonsterFromId(this._currentModster.parentsModsterId[0]);
         }
         this.btn_loc.visible = this._currentModster.parentsModsterId.length > 0;
         var activeSpells:Array = [];
         for each(spellId in this._currentModster.modsterActiveSpells)
         {
            activeSpells.push(SpellWrapper.create(spellId,1));
         }
         this.gd_modsterActiveSpells.height = activeSpells.length * this.gd_modsterActiveSpells.slotHeight + activeSpells.length * 10;
         this.gd_modsterActiveSpells.visible = activeSpells.length > 0;
         this.gd_modsterActiveSpells.dataProvider = activeSpells;
         this.slot_modsterPassiveSpell.visible = this._currentModster.modsterPassiveSpells.length > 0;
         this.slot_modsterPassiveSpell.y = this.gd_modsterActiveSpells.height + 10;
         this.ctr_separator.visible = this.slot_modsterPassiveSpell.visible;
         this.ctr_separator.y = this.gd_modsterActiveSpells.height;
         if(this._currentModster.modsterPassiveSpells.length > 0)
         {
            this.slot_modsterPassiveSpell.data = SpellWrapper.create(this._currentModster.modsterPassiveSpells[0],1);
         }
         this.tx_modsterIllu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("modster_uri") + this._currentModster.modsterId + ".swf");
         this.lbl_modsterName.text = this.dataApi.getItemName(this._currentModster.itemId);
         this.lbl_bigModsterId.text = modsterCollectable.order.toString();
         this.lbl_modsterCategory.htmlText = this.modsterCategory(modsterCollectable.rarity);
         if(this._currentModster.modsterAchievements.length)
         {
            this.gd_modsterSuccess.dataProvider = this._currentModster.modsterAchievements;
         }
         this.lbl_modsterArea.text = this.getModsterObtention(this._currentModster);
         this.gd_modsters.verticalScrollValue = scrollValue;
         this.lbl_modsterObtentionTitle.visible = true;
         this.lbl_modsterArea.visible = true;
      }
      
      private function onAchievementDetailed(finishedAchievements:Vector.<com.ankamagames.dofus.network.types.game.achievement.Achievement>, startedAchievements:Vector.<com.ankamagames.dofus.network.types.game.achievement.Achievement>) : void
      {
         var currentAchievementCategory:uint = 0;
         var achievement:com.ankamagames.dofus.network.types.game.achievement.Achievement = null;
         var lastCollectableSelected:Collectable = null;
         if(finishedAchievements.length)
         {
            currentAchievementCategory = this.getAchievementCategory(finishedAchievements[0]);
         }
         else if(startedAchievements.length)
         {
            currentAchievementCategory = this.getAchievementCategory(startedAchievements[0]);
         }
         if(currentAchievementCategory == this.ACHIEVEMENT_CAT_MODSTER_COLLECTION)
         {
            this._hiddenSuccessFinished = new Vector.<uint>();
            for each(achievement in finishedAchievements)
            {
               this._hiddenSuccessFinished.push(achievement.id);
            }
            this._hiddenSuccessStarted = new Vector.<uint>();
            for each(achievement in startedAchievements)
            {
               this._hiddenSuccessStarted.push(achievement.id);
            }
         }
         else if(currentAchievementCategory == this.ACHIEVEMENT_CAT_MODSTER)
         {
            this._successFinished = new Vector.<uint>();
            for each(achievement in finishedAchievements)
            {
               this._successFinished.push(achievement.id);
            }
            this._successStarted = new Vector.<uint>();
            for each(achievement in startedAchievements)
            {
               this._successStarted.push(achievement.id);
            }
            this.initModsters(this._filteredCollectables);
            this.sort(this._sortType,this._ascending);
            lastCollectableSelected = this.sysApi.getData(this.CACHE_LAST_COLLECTABLE_SELECTED + this.playerApi.id(),DataStoreEnum.BIND_CHARACTER);
            if(lastCollectableSelected && this._filteredCollectables.indexOf(lastCollectableSelected) != -1)
            {
               this.selectModster(lastCollectableSelected);
            }
            else if(this._filteredCollectables.length)
            {
               this.selectModster(this._filteredCollectables[0]);
            }
            else
            {
               this.lbl_modsterObtentionTitle.visible = false;
               this.lbl_modsterArea.visible = false;
               this.btn_loc.visible = false;
            }
         }
      }
      
      private function getAchievementCategory(achievement:com.ankamagames.dofus.network.types.game.achievement.Achievement) : uint
      {
         var ach:com.ankamagames.dofus.datacenter.quest.Achievement = this.dataApi.getAchievementById(achievement.id);
         if(ach)
         {
            return ach.categoryId;
         }
         return 0;
      }
      
      private function collectableIsdiscovered(collectable:Collectable) : Boolean
      {
         var achievementId:uint = 0;
         if(this._collectablesDiscovered.indexOf(collectable) != -1)
         {
            return true;
         }
         if(!this._modsters)
         {
            return false;
         }
         var modster:Modster = this._modsters[collectable.order - 1];
         for each(achievementId in modster.modsterHiddenAchievements)
         {
            if(this._hiddenSuccessFinished.indexOf(achievementId) == -1)
            {
               return false;
            }
         }
         if(this._collectablesDiscovered.indexOf(collectable) == -1)
         {
            this._collectablesDiscovered.push(collectable);
         }
         return true;
      }
      
      private function successIsValidated(successId:uint) : Boolean
      {
         return this._successFinished.indexOf(successId) != -1;
      }
      
      private function allSuccessValidated(collectable:Collectable) : Boolean
      {
         var successId:uint = 0;
         if(this._collectablesFinished.indexOf(collectable) != -1)
         {
            return true;
         }
         var modster:Modster = this._modsters[collectable.order - 1];
         for each(successId in modster.modsterAchievements)
         {
            if(this._successFinished.indexOf(successId) == -1)
            {
               return false;
            }
         }
         for each(successId in modster.modsterHiddenAchievements)
         {
            if(this._hiddenSuccessFinished.indexOf(successId) == -1)
            {
               return false;
            }
         }
         if(this._collectablesFinished.indexOf(collectable) == -1)
         {
            this._collectablesFinished.push(collectable);
         }
         return true;
      }
      
      private function modsterCategory(category:uint) : String
      {
         var categoryText:String = null;
         switch(category)
         {
            case DataEnum.COLLECTABLE_CATEGORY_COMMON:
               categoryText = this.uiApi.getText("ui.collection.collectableCategoryText","<font color=\'#4ea53c\'>" + this.uiApi.getText("ui.collection.collectableCategoryCommon") + "</font>");
               break;
            case DataEnum.COLLECTABLE_CATEGORY_RARE:
               categoryText = this.uiApi.getText("ui.collection.collectableCategoryText","<font color=\'#459fa6\'>" + this.uiApi.getText("ui.collection.collectableCategoryRare") + "</font>");
               break;
            case DataEnum.COLLECTABLE_CATEGORY_EVOLUTION:
               categoryText = this.uiApi.getText("ui.collection.collectableCategoryText","<font color=\'#ffffff\'>" + this.uiApi.getText("ui.collection.collectableCategoryEvolution") + "</font>");
               break;
            case DataEnum.COLLECTABLE_CATEGORY_EPIC:
               categoryText = this.uiApi.getText("ui.collection.collectableCategoryText","<font color=\'#ae70dc\'>" + this.uiApi.getText("ui.collection.collectableCategoryEpic") + "</font>");
               break;
            case DataEnum.COLLECTABLE_CATEGORY_LEGENDARY:
               categoryText = this.uiApi.getText("ui.collection.collectableCategoryText","<font color=\'#e8cf01\'>" + this.uiApi.getText("ui.collection.collectableCategoryLegendary") + "</font>");
         }
         return categoryText;
      }
      
      private function getModsterObtention(modster:Modster) : String
      {
         var parentId:uint = 0;
         var monster:Monster = null;
         var subArea:SubArea = null;
         var i:uint = 0;
         var textObtention:* = "";
         this._currentModsterSubAreas = new Vector.<uint>();
         if(modster.parentsModsterId.length)
         {
            for each(parentId in modster.parentsModsterId)
            {
               monster = this.dataApi.getMonsterFromId(parentId);
               for(i = 0; i < monster.subareas.length; i++)
               {
                  subArea = this.dataApi.getSubArea(monster.subareas[i]);
                  if(this._currentModsterSubAreas.indexOf(subArea.id) == -1)
                  {
                     this._currentModsterSubAreas.push(subArea.id);
                     textObtention += textObtention != "" ? ", " + subArea.name : subArea.name;
                  }
               }
            }
         }
         else if(modster.modsterId == this.HIDDEN_MODSTER)
         {
            textObtention += "???";
         }
         else
         {
            textObtention = "{openBook,jobTab,78::" + this.uiApi.getText("ui.collection.modstersJob") + "} (" + this.uiApi.getText("ui.craft.job").toLowerCase() + ")";
         }
         return textObtention;
      }
      
      private function sort(sortType:uint, ascending:Boolean) : void
      {
         switch(sortType)
         {
            case this.SORT_BY_ORDER:
               this._sortType = this.SORT_BY_ORDER;
               this.sortByOrder(ascending);
               break;
            case this.SORT_BY_NAME:
               this._sortType = this.SORT_BY_NAME;
               this._ascending = ascending;
               this._filteredCollectables = this._filteredCollectables.sort(this.sortByName);
               this.gd_modsters.dataProvider = this._filteredCollectables;
         }
      }
      
      private function sortByName(collectable1:Collectable, collectable2:Collectable) : Number
      {
         var collectable1Name:String = this.utilApi.noAccent(collectable1.entityName.toLowerCase());
         var collectable2Name:String = this.utilApi.noAccent(collectable2.entityName.toLowerCase());
         if(collectable1Name < collectable2Name)
         {
            return !!this._ascending ? Number(-1) : Number(1);
         }
         if(collectable1Name > collectable2Name)
         {
            return !!this._ascending ? Number(1) : Number(-1);
         }
         return 0;
      }
      
      private function sortByOrder(ascending:Boolean) : void
      {
         this._ascending = ascending;
         this._filteredCollectables = this.utilApi.sort(this._filteredCollectables,"order",this._ascending,true);
         this.gd_modsters.dataProvider = this._filteredCollectables;
      }
      
      private function searchCollectable() : void
      {
         var collectables:Vector.<Collectable> = null;
         var entityName:String = null;
         var collectable:Collectable = null;
         var result:Vector.<Collectable> = new Vector.<Collectable>();
         if(this._currentSearchText.indexOf(this._lastSearchText) != -1)
         {
            collectables = this.gd_modsters.dataProvider.concat();
         }
         else
         {
            collectables = this._filteredCollectables.concat();
         }
         for each(collectable in collectables)
         {
            if(this._collectablesDiscovered.indexOf(collectable) != -1)
            {
               entityName = this.utilApi.noAccent(collectable.entityName.toLowerCase());
               if(entityName.indexOf(this.utilApi.noAccent(this._currentSearchText.toLowerCase())) != -1)
               {
                  result.push(collectable);
               }
            }
         }
         this.gd_modsters.dataProvider = result;
         this._lastSearchText = this._currentSearchText;
      }
      
      private function resetSearch() : void
      {
         this._currentSearchText = null;
         this._lastSearchText = null;
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this.sort(this._sortType,this._ascending);
      }
      
      private function getModstersIdsInCurrentSubArea() : Vector.<uint>
      {
         var parent:Monster = null;
         var modster:Modster = null;
         var parentId:uint = 0;
         var subAreaId:uint = 0;
         var modstersInCurrentSubArea:Vector.<uint> = new Vector.<uint>();
         for each(modster in Modster.getModsters())
         {
            for each(parentId in modster.parentsModsterId)
            {
               parent = this.dataApi.getMonsterFromId(parentId);
               if(parent)
               {
                  for each(subAreaId in parent.subareas)
                  {
                     if(subAreaId == this.playerApi.currentSubArea().id && modstersInCurrentSubArea.indexOf(modster.modsterId) == -1)
                     {
                        modstersInCurrentSubArea.push(modster.modsterId);
                     }
                  }
               }
            }
         }
         return modstersInCurrentSubArea;
      }
      
      private function filteringCollectables(filterType:uint) : void
      {
         var collectable:Collectable = null;
         var collectablesWithSuccessMissing:Vector.<Collectable> = null;
         var collectablesWithAllSuccess:Vector.<Collectable> = null;
         if(filterType == this.FILTER_DISCOVERED)
         {
            collectablesWithSuccessMissing = new Vector.<Collectable>();
            for each(collectable in this._collectablesDiscovered)
            {
               if(!this.allSuccessValidated(collectable))
               {
                  if(!this.btn_showModstersInArea.selected || this.btn_showModstersInArea.selected && this._modstersInSubArea.indexOf(collectable) != -1)
                  {
                     collectablesWithSuccessMissing.push(collectable);
                  }
               }
            }
            this._filteredCollectables = collectablesWithSuccessMissing;
         }
         else if(filterType == this.FILTER_FINISHED)
         {
            collectablesWithAllSuccess = new Vector.<Collectable>();
            for each(collectable in this._collectablesDiscovered)
            {
               if(this.allSuccessValidated(collectable))
               {
                  if(!this.btn_showModstersInArea.selected || this.btn_showModstersInArea.selected && this._modstersInSubArea.indexOf(collectable) != -1)
                  {
                     collectablesWithAllSuccess.push(collectable);
                  }
               }
            }
            this._filteredCollectables = collectablesWithAllSuccess;
         }
         else
         {
            this._filteredCollectables = !!this.btn_showModstersInArea.selected ? this._modstersInSubArea.concat() : this._collectables.concat();
         }
         this.sort(this._sortType,this._ascending);
         this.lbl_noModsterFound.visible = this._filteredCollectables.length == 0;
         if(this._currentSearchText != null)
         {
            this.searchCollectable();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var text:String = null;
         var contextMenu:Array = null;
         var lastCollectableSelected:Collectable = null;
         var modsterCollectable:Collectable = null;
         switch(target)
         {
            case this.btn_loc:
               text = this.uiApi.processText(this.uiApi.getText("ui.monster.presentInAreas",this._parentMonster.subareas.length),"m",this._parentMonster.subareas.length == 1,this._parentMonster.subareas.length == 0);
               this._mapPopup = this.modCartography.openCartographyPopup(this._modstersDiscovered.indexOf(this._realMonster) != -1 ? this._realMonster.name : this.uiApi.getText("ui.temporis.modsterNotDiscovered"),this._parentMonster.favoriteSubareaId,this._currentModsterSubAreas,text);
               break;
            case this.btn_sort:
               contextMenu = [];
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.collection.ascendingNumericOrder"),this.sort,[this.SORT_BY_ORDER,true],false,null,this._sortType == this.SORT_BY_ORDER && this._ascending));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.collection.descendingNumericOrder"),this.sort,[this.SORT_BY_ORDER,false],false,null,this._sortType == this.SORT_BY_ORDER && !this._ascending));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.collection.ascendingAlphabeticalOrder"),this.sort,[this.SORT_BY_NAME,true],false,null,this._sortType == this.SORT_BY_NAME && this._ascending));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.collection.descendingAlphabeticalOrder"),this.sort,[this.SORT_BY_NAME,false],false,null,this._sortType == this.SORT_BY_NAME && !this._ascending));
               contextMenu.unshift(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.common.sorting")));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_resetSearch:
               this.resetSearch();
               break;
            case this.btn_showModstersInArea:
               this.filteringCollectables(this.cb_filterModsters.value.filterType);
               lastCollectableSelected = this.sysApi.getData("lastCollectableSelected" + this.playerApi.id(),DataStoreEnum.BIND_CHARACTER);
               if(lastCollectableSelected && this._filteredCollectables.indexOf(lastCollectableSelected) != -1)
               {
                  this.selectModster(lastCollectableSelected);
               }
               else if(this._filteredCollectables.length)
               {
                  this.selectModster(this._filteredCollectables[0]);
               }
               else
               {
                  this.lbl_modsterObtentionTitle.visible = false;
                  this.lbl_modsterArea.visible = false;
                  this.btn_loc.visible = false;
               }
               this.sysApi.setData(this.CACHE_SHOW_MODSTERS_AREA + this.playerApi.id(),this.btn_showModstersInArea.selected,DataStoreEnum.BIND_CHARACTER);
               break;
            default:
               if(target.name.indexOf("ctr_modster") != -1)
               {
                  modsterCollectable = this._componentsList[target.name];
                  this.selectModster(modsterCollectable);
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var achievement:com.ankamagames.dofus.datacenter.quest.Achievement = null;
         var data:Collectable = null;
         var isSelected:Boolean = false;
         switch(target)
         {
            case this.slot_modsterPassiveSpell:
               this.uiApi.showTooltip(this.slot_modsterPassiveSpell.data,target,false,"modsterSpell",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{"isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus")},null,false);
               break;
            case this.hint_category:
               tooltipText = this.uiApi.getText("ui.collection.categoryInfo");
               break;
            default:
               if(target.name.indexOf("btn_success") != -1)
               {
                  achievement = this.dataApi.getAchievementById(this._componentsList[target.name]);
                  this.uiApi.showTooltip(achievement,target,false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,"achievementModster");
               }
               else if(target.name.indexOf("ctr_modster") != -1)
               {
                  data = this._componentsList[target.name];
                  isSelected = this._currentModster && data.entityId == this._currentModster.modsterId;
                  target.bgColor = !!isSelected ? this.COLOR_SELECTED : this.COLOR_OVER;
               }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         var data:Collectable = null;
         var isSelected:Boolean = false;
         var isDiscovered:Boolean = false;
         if(target.name.indexOf("ctr_modster") != -1)
         {
            data = this._componentsList[target.name];
            isSelected = this._currentModster && data.entityId == this._currentModster.modsterId;
            isDiscovered = this.collectableIsdiscovered(data);
            target.bgColor = !!isSelected ? this.COLOR_SELECTED : (!!isDiscovered ? this.COLOR_DISCOVERED : this.COLOR_HIDDEN);
         }
         this.uiApi.hideTooltip();
         this.uiApi.hideTooltip("modsterSpell");
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var _loc3_:* = target;
         switch(0)
         {
         }
         if(target.name.indexOf("gd_modsterActiveSpells") != -1)
         {
            this.uiApi.showTooltip(item.data,target,false,"modsterSpell",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{"isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus")},null,false);
         }
         else if(target.name.indexOf("gd_modsterActiveSpells") != -1)
         {
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.hideTooltip("modsterSpell");
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_filterModsters:
               this.filteringCollectables(this.cb_filterModsters.value.filterType);
         }
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_search:
               if(this.inp_search.text.length && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this._currentSearchText = this.inp_search.text;
                  this.btn_resetSearch.visible = true;
                  this.searchCollectable();
               }
               else if(this._currentSearchText)
               {
                  this.resetSearch();
               }
         }
      }
   }
}
