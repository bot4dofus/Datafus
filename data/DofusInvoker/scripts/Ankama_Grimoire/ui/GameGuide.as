package Ankama_Grimoire.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.progression.FeatureDescription;
   import com.ankamagames.dofus.internalDatacenter.tutorial.FeatureDescriptionWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.StatsHookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class GameGuide
   {
      
      private static var _lastDescriptionViewedId:uint;
      
      private static var _openedCategories:Array = [];
      
      private static const MINUS_URI:String = "minusUri";
      
      private static const PLUS_URI:String = "plusUri";
      
      private static const CTR_CAT:String = "ctr_cat";
      
      private static const CTR_SUB_CAT:String = "ctr_subCat";
      
      private static const CTR_SUB_SUB_CAT:String = "ctr_subSubCat";
      
      private static const CTR_DESCRIPTION:String = "ctr_mainDescription";
      
      private static const CTR_SUB_DESCRIPTION:String = "ctr_subDescription";
      
      private static var _descriptionWrappers:Array = [];
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      public var uiCtr:GraphicContainer;
      
      public var gd_categories:Grid;
      
      public var gd_descriptions:Grid;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var ctr_searchResult:GraphicContainer;
      
      public var tx_nextSearchResult:Texture;
      
      public var tx_prevSearchResult:Texture;
      
      public var lbl_searchResult:Label;
      
      private var _log:Logger;
      
      private var _componentList:Dictionary;
      
      private var _categories:Array;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _searchTimer:BenchmarkTimer;
      
      private var _searchCriteria:String;
      
      private var _lastSearchCriteria:String;
      
      private var _lastDescriptionWithSearchCriteria:Vector.<uint>;
      
      private var _totalSearchResult:uint;
      
      private var _searchedFeatures:Array;
      
      private var _currentResultIndex:int;
      
      private var _indexOfResultInCurrentDescription:int;
      
      private var _currentDescriptionIndex:int;
      
      private var _lastSearchResult:Object;
      
      private var _currentPosY:int;
      
      private var _shiftIsDown:Boolean;
      
      private var _hookTimer:BenchmarkTimer;
      
      private var _hookFeatureId:uint;
      
      private var _hookFeatureAccessType:String;
      
      public function GameGuide()
      {
         this._log = Log.getLogger(getQualifiedClassName(GameGuide));
         this._componentList = new Dictionary(true);
         this._categories = [];
         this._searchTimer = new BenchmarkTimer(500,1,"GameGuide._searchTimer");
         this._lastDescriptionWithSearchCriteria = new Vector.<uint>();
         this._hookTimer = new BenchmarkTimer(2000,1,"GameGuide._hookTimer");
         super();
      }
      
      public static function resetDescriptionWrappers() : void
      {
         _descriptionWrappers = [];
      }
      
      public function main(params:Object) : void
      {
         var featureWrapper:FeatureDescriptionWrapper = null;
         var featureDescription:FeatureDescription = null;
         var featureId:uint = 0;
         this.sysApi.addHook(HookList.MoveToFeatureDescription,this.onMoveToFeatureDescription);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_nextSearchResult,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_nextSearchResult,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_nextSearchResult,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_prevSearchResult,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_prevSearchResult,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_prevSearchResult,ComponentHookList.ON_ROLL_OUT);
         this._searchTimer.addEventListener(TimerEvent.TIMER,this.onSearchTimer);
         this._hookTimer.addEventListener(TimerEvent.TIMER,this.onHookTimer);
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.guidebook.search");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.restrict = "^[&\"~!@#$%*\\_+=[]|;<>./?{},]";
         this.btn_resetSearch.visible = false;
         this.ctr_searchResult.visible = false;
         var allFeatureDescriptionId:Vector.<uint> = this.getAllFeatureDescription();
         var firstInit:* = _descriptionWrappers.length == 0;
         for each(featureId in allFeatureDescriptionId)
         {
            featureDescription = this.dataApi.getFeatureDescriptionById(featureId);
            if(featureDescription.canBeDisplayed)
            {
               if(featureDescription.parentId == 0)
               {
                  this._categories.push(featureDescription);
               }
               if(firstInit)
               {
                  featureWrapper = FeatureDescriptionWrapper.create(featureDescription);
                  _descriptionWrappers.push(featureWrapper);
                  if(featureWrapper.parentId == 0)
                  {
                     this.addEmptyLine(_descriptionWrappers,featureWrapper.totalHeight + 40);
                  }
                  else
                  {
                     this.addEmptyLine(_descriptionWrappers,featureWrapper.totalHeight);
                  }
               }
            }
         }
         this._categories = this._categories.sort(this.sortByPriority);
         for each(featureDescription in this._categories)
         {
            if(_openedCategories.indexOf(featureDescription.id) != -1)
            {
               this.addSubCategories(featureDescription);
            }
         }
         this.gd_categories.dataProvider = this._categories;
         this.gd_descriptions.dataProvider = _descriptionWrappers;
         if(params != null && params is Array)
         {
            if(params.length > 1 && params[1] != "")
            {
               this.dispatchStatsHook(params[0],params[1]);
            }
            featureDescription = this.dataApi.getFeatureDescriptionById(int(params[0]));
            this.moveToDescription(featureDescription);
         }
         else if(_lastDescriptionViewedId > 0)
         {
            featureDescription = this.dataApi.getFeatureDescriptionById(_lastDescriptionViewedId);
            this.selectCategory(featureDescription.id);
            this.moveToDescription(featureDescription);
         }
         else
         {
            this.gd_categories.setSelectedIndex(0,GridItemSelectMethodEnum.AUTO);
         }
         this.gd_descriptions.scrollBarV.addEventListener(Event.CHANGE,this.onScroll);
         this.sysApi.startStats("gameGuide");
      }
      
      public function unload() : void
      {
         var data:* = undefined;
         for each(data in _descriptionWrappers)
         {
            if(data && data.parentGC.parent)
            {
               data.parentGC.parent.removeChild(data.parentGC);
            }
         }
         this._searchTimer.removeEventListener(TimerEvent.TIMER,this.onSearchTimer);
         this._hookTimer.removeEventListener(TimerEvent.TIMER,this.onHookTimer);
         if(this.gd_descriptions.scrollBarV)
         {
            this.gd_descriptions.scrollBarV.removeEventListener(Event.CHANGE,this.onScroll);
         }
      }
      
      public function updateCategories(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT:
               if(!this._componentList[componentsRef.btn_cat])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_cat,ComponentHookList.ON_RELEASE);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_cat.addEventListener(KEY_DOWN) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_cat.addEventListener(KEY_UP) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  componentsRef.btn_cat.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyUp);
                  componentsRef.btn_cat.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               }
               this._componentList[componentsRef.btn_cat] = data;
               if(!this._componentList[componentsRef.btn_deployCat])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_deployCat,ComponentHookList.ON_RELEASE);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_deployCat.addEventListener(KEY_DOWN) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_deployCat.addEventListener(KEY_UP) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  componentsRef.btn_deployCat.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyUp);
                  componentsRef.btn_deployCat.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               }
               this._componentList[componentsRef.btn_deployCat] = data;
               componentsRef.tx_catplusminus.visible = data.children.length > 0;
               if(_openedCategories.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(MINUS_URI));
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(PLUS_URI));
               }
               componentsRef.btn_cat.selected = selected;
               componentsRef.btn_deployCat.selected = false;
               componentsRef.tx_catImage.visible = true;
               componentsRef.tx_catImage.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path").concat("guideBook/menu_icons/").concat("feature_" + data.id + ".png"));
               componentsRef.lbl_catName.text = data.name;
               break;
            case CTR_SUB_CAT:
               if(!this._componentList[componentsRef.btn_subCat])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_subCat,ComponentHookList.ON_RELEASE);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_subCat.addEventListener(KEY_DOWN) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_subCat.addEventListener(KEY_UP) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  componentsRef.btn_subCat.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyUp);
                  componentsRef.btn_subCat.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               }
               this._componentList[componentsRef.btn_subCat] = data;
               if(!this._componentList[componentsRef.btn_deploySubCat])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_deploySubCat,ComponentHookList.ON_RELEASE);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_deploySubCat.addEventListener(KEY_DOWN) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_deploySubCat.addEventListener(KEY_UP) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  componentsRef.btn_deploySubCat.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyUp);
                  componentsRef.btn_deploySubCat.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               }
               this._componentList[componentsRef.btn_deploySubCat] = data;
               componentsRef.tx_subCatplusminus.visible = data.children.length > 0;
               if(_openedCategories.indexOf(data.id) != -1)
               {
                  componentsRef.tx_subCatplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(MINUS_URI));
               }
               else
               {
                  componentsRef.tx_subCatplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(PLUS_URI));
               }
               componentsRef.btn_subCat.selected = selected;
               componentsRef.btn_deploySubCat.selected = false;
               componentsRef.lbl_subCatName.text = data.name;
               break;
            case CTR_SUB_SUB_CAT:
               if(!this._componentList[componentsRef.btn_subSubCat])
               {
                  this.uiApi.addComponentHook(componentsRef.btn_subSubCat,ComponentHookList.ON_RELEASE);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_subSubCat.addEventListener(KEY_DOWN) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  LogInFile.getInstance().logLine("GameGuide componentsRef.btn_subSubCat.addEventListener(KEY_UP) onKeyUp",FileLoggerEnum.EVENTLISTENERS);
                  componentsRef.btn_subSubCat.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyUp);
                  componentsRef.btn_subSubCat.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
               }
               this._componentList[componentsRef.btn_subSubCat] = data;
               componentsRef.tx_subSubCatplusminus.visible = data.children.length > 0;
               if(_openedCategories.indexOf(data.id) != -1)
               {
                  componentsRef.tx_subSubCatplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(MINUS_URI));
               }
               else
               {
                  componentsRef.tx_subSubCatplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant(PLUS_URI));
               }
               componentsRef.btn_subSubCat.selected = selected;
               componentsRef.lbl_subSubCatName.text = data.name;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         var parentData:FeatureDescription = null;
         if(!data)
         {
            return "";
         }
         if(data && data.parentId <= 0)
         {
            return CTR_CAT;
         }
         if(data && data.parentId > 0)
         {
            parentData = this.dataApi.getFeatureDescriptionById(data.parentId);
            if(parentData && parentData.parentId > 0)
            {
               return CTR_SUB_SUB_CAT;
            }
            return CTR_SUB_CAT;
         }
         return "";
      }
      
      public function updateCategoryDescription(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getDescriptionLineType(data,line))
         {
            case CTR_DESCRIPTION:
               componentsRef.lbl_categoryName.text = data.categoryName;
               componentsRef.ctr_categoryDescription.getStrata(0).removeChildren();
               componentsRef.ctr_categoryDescription.addContent(data.parentGC);
               break;
            case CTR_SUB_DESCRIPTION:
               componentsRef.ctr_subCategoryDescription.getStrata(0).removeChildren();
               componentsRef.ctr_subCategoryDescription.addContent(data.parentGC);
               break;
            default:
               componentsRef.ctr_categoryDescription.getStrata(0).removeChildren();
               componentsRef.ctr_subCategoryDescription.getStrata(0).removeChildren();
         }
      }
      
      public function getDescriptionLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data && data.parentId == 0)
         {
            return CTR_DESCRIPTION;
         }
         if(data && data.parentId != 0)
         {
            return CTR_SUB_DESCRIPTION;
         }
         return "";
      }
      
      private function getAllFeatureDescription() : Vector.<uint>
      {
         var allFeatureDescriptionId:Vector.<uint> = this.dataApi.queryEquals(FeatureDescription,"parentId",0);
         allFeatureDescriptionId = this.dataApi.querySort(FeatureDescription,allFeatureDescriptionId,["priority","name"],[true,true]);
         for(var i:uint = 0; i < allFeatureDescriptionId.length; i++)
         {
            this.addSecondaryFeatureDescription(allFeatureDescriptionId[i],allFeatureDescriptionId,i);
         }
         return allFeatureDescriptionId;
      }
      
      private function addSecondaryFeatureDescription(parentId:uint, allIds:Vector.<uint>, parentIndex:uint) : int
      {
         var totIndex:int = 0;
         var featuresIds:Vector.<uint> = this.dataApi.queryEquals(FeatureDescription,"parentId",parentId);
         featuresIds = this.dataApi.querySort(FeatureDescription,featuresIds,["priority","name"],[true,true]);
         for(var i:uint = 0; i < featuresIds.length; i++)
         {
            if(allIds.indexOf(featuresIds[i]) == -1)
            {
               allIds.insertAt(parentIndex + 1 + totIndex,featuresIds[i]);
               totIndex += this.addSecondaryFeatureDescription(featuresIds[i],allIds,parentIndex + 1 + totIndex);
               totIndex++;
            }
         }
         return totIndex;
      }
      
      private function displayCategories(featureDescription:FeatureDescription) : void
      {
         var index:int = _openedCategories.indexOf(featureDescription.id);
         if(index == -1)
         {
            _openedCategories.push(featureDescription.id);
            this.addSubCategories(featureDescription);
         }
         else
         {
            _openedCategories.splice(index,1);
            this.removeSubCategories(featureDescription);
         }
         var scrollValue:uint = this.gd_categories.verticalScrollValue;
         this.gd_categories.dataProvider = this._categories;
         if(this.gd_categories.selectedItem != null)
         {
            this.selectCategory(this.gd_categories.selectedItem.id);
         }
         this.gd_categories.verticalScrollValue = scrollValue;
      }
      
      private function addSubCategories(featureDescription:FeatureDescription) : void
      {
         var subFeatureDescription:FeatureDescription = null;
         var subId:uint = 0;
         var parentIndex:int = 0;
         var i:uint = 0;
         if(featureDescription.children.length <= 0)
         {
            return;
         }
         var subCatId:Vector.<int> = featureDescription.children;
         var subCats:Vector.<FeatureDescription> = new Vector.<FeatureDescription>();
         for each(subId in subCatId)
         {
            subFeatureDescription = this.dataApi.getFeatureDescriptionById(subId);
            if(subFeatureDescription.canBeDisplayed)
            {
               subCats.push(subFeatureDescription);
            }
         }
         subCats = subCats.sort(this.sortByPriority);
         parentIndex = this._categories.indexOf(featureDescription);
         for(i = 0; i < subCats.length; i++)
         {
            if(this._categories.indexOf(subCats[i]) == -1)
            {
               this._categories.insertAt(parentIndex + 1 + i,subCats[i]);
            }
         }
      }
      
      private function removeSubCategories(featureDescription:FeatureDescription) : void
      {
         var id:uint = 0;
         var parentIndex:int = 0;
         var subCatId:Vector.<int> = featureDescription.children;
         for each(id in subCatId)
         {
            if(_openedCategories.indexOf(id) != -1)
            {
               _openedCategories.splice(_openedCategories.indexOf(id),1);
               this.removeSubCategories(this.dataApi.getFeatureDescriptionById(id));
            }
         }
         parentIndex = this._categories.indexOf(featureDescription);
         this._categories.splice(parentIndex + 1,subCatId.length);
      }
      
      private function addEmptyLine(array:Array, contentHeight:uint) : void
      {
         var nbOfLine:uint = Math.ceil(contentHeight / 20);
         for(var i:uint = 0; i < nbOfLine; i++)
         {
            array.push(null);
         }
      }
      
      private function findDescriptionIndex(descriptionId:uint) : int
      {
         for(var i:uint = 0; i < _descriptionWrappers.length; i++)
         {
            if(_descriptionWrappers[i] != null && _descriptionWrappers[i].id == descriptionId)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function moveToDescription(featureDescription:FeatureDescription) : void
      {
         var index:int = this.findDescriptionIndex(featureDescription.id);
         if(index > -1)
         {
            _lastDescriptionViewedId = featureDescription.id;
            this.selectCategory(featureDescription.id);
            this.gd_descriptions.moveTo(index,true);
         }
      }
      
      private function onKeyDown(target:Object, keyCode:uint) : void
      {
         if(keyCode == Keyboard.SHIFT)
         {
            this._shiftIsDown = true;
         }
      }
      
      private function onKeyUp(target:Object, keyCode:uint) : void
      {
         var nextIndex:uint = 0;
         var prevIndex:uint = 0;
         if(target is Event)
         {
            LogInFile.getInstance().logLine("GameGuide onKeyUp (" + (target as Event).currentTarget.name + ")",FileLoggerEnum.EVENTLISTENERS);
         }
         var shortcut:Shortcut = this.bindsApi.getShortcutsFromKeyCode(keyCode);
         if(shortcut)
         {
            switch(shortcut.name)
            {
               case ShortcutHookListEnum.PREVIOUS_SEARCH_RESULT:
                  this.gd_descriptions.focus();
                  this.goToPrevResult();
                  return;
               case ShortcutHookListEnum.NEXT_SEARCH_RESULT:
                  this.gd_descriptions.focus();
                  this.goToNextResult();
                  return;
               case ShortcutHookListEnum.HISTORY_DOWN:
                  nextIndex = Math.min(this.gd_categories.selectedIndex + 1,this.gd_categories.dataProvider.length - 1);
                  this.moveToDescription(this.gd_categories.dataProvider[nextIndex]);
                  this.dispatchStatsHook(this.gd_categories.dataProvider[nextIndex].id,"keyboard");
                  return;
               case ShortcutHookListEnum.HISTORY_UP:
                  prevIndex = Math.max(0,this.gd_categories.selectedIndex - 1);
                  this.moveToDescription(this.gd_categories.dataProvider[prevIndex]);
                  this.dispatchStatsHook(this.gd_categories.dataProvider[prevIndex].id,"keyboard");
                  return;
            }
         }
         switch(keyCode)
         {
            case Keyboard.ENTER:
               this.displayCategories(this.gd_categories.selectedItem);
               return;
            case Keyboard.END:
               this.gd_descriptions.verticalScrollValue = this.gd_descriptions.dataProvider.length - 1;
               return;
            case Keyboard.HOME:
               this.gd_descriptions.verticalScrollValue = 0;
               return;
            case Keyboard.SHIFT:
               this._shiftIsDown = false;
         }
         if(this.inp_search.haveFocus && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT && this._searchCriteria != this.inp_search.text.toLowerCase())
         {
            if(this.inp_search.text.length)
            {
               this._searchCriteria = this.inp_search.text.toLowerCase();
               this._searchTimer.start();
               this.btn_resetSearch.visible = true;
            }
            else if(this._searchCriteria)
            {
               this.resetSearch();
            }
         }
      }
      
      private function onSearchTimer(r:TimerEvent = null) : void
      {
         var featureWrapper:FeatureDescriptionWrapper = null;
         this._searchTimer.reset();
         this._totalSearchResult = 0;
         var featureDescriptionWithSearchCriteria:Vector.<uint> = this.dataApi.queryString(FeatureDescription,"name",this._searchCriteria);
         featureDescriptionWithSearchCriteria = this.dataApi.queryUnion(featureDescriptionWithSearchCriteria,this.dataApi.queryString(FeatureDescription,"description",this._searchCriteria));
         featureDescriptionWithSearchCriteria = this.dataApi.querySort(FeatureDescription,featureDescriptionWithSearchCriteria,["priority","name"],[true,true]);
         this._searchedFeatures = [];
         this._currentResultIndex = 0;
         for each(featureWrapper in _descriptionWrappers)
         {
            if(featureWrapper && this._lastDescriptionWithSearchCriteria.indexOf(featureWrapper.id) != -1)
            {
               featureWrapper.cleanSearch(this._lastSearchCriteria);
            }
            if(featureWrapper && featureDescriptionWithSearchCriteria.indexOf(featureWrapper.id) != -1)
            {
               featureWrapper.searchWord(this._searchCriteria);
               this._totalSearchResult += featureWrapper.searchResult.length;
               if(featureWrapper.searchResult.length > 0)
               {
                  this._searchedFeatures.push(featureWrapper);
               }
            }
         }
         this.ctr_searchResult.visible = true;
         if(this._totalSearchResult > 0)
         {
            this.lbl_searchResult.text = this._currentResultIndex + 1 + "/" + this._totalSearchResult;
         }
         else
         {
            this.lbl_searchResult.text = this._totalSearchResult + "/" + this._totalSearchResult;
         }
         this.tx_nextSearchResult.disabled = this.tx_prevSearchResult.disabled = this._totalSearchResult <= 0;
         this._lastDescriptionWithSearchCriteria = featureDescriptionWithSearchCriteria.concat();
         this._lastSearchCriteria = this._searchCriteria;
         if(this._searchedFeatures.length > 0)
         {
            this.moveToResult(this._searchedFeatures[0],0);
         }
      }
      
      private function resetSearch() : void
      {
         var featureWrapper:FeatureDescriptionWrapper = null;
         this._searchCriteria = null;
         this._searchTimer.reset();
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this.ctr_searchResult.visible = false;
         this._searchedFeatures = [];
         this._totalSearchResult = 0;
         this._currentResultIndex = 0;
         this._indexOfResultInCurrentDescription = 0;
         this._currentDescriptionIndex = 0;
         this._lastSearchResult = null;
         for each(featureWrapper in _descriptionWrappers)
         {
            if(featureWrapper && this._lastDescriptionWithSearchCriteria.indexOf(featureWrapper.id) != -1)
            {
               featureWrapper.cleanSearch(this._lastSearchCriteria);
            }
         }
      }
      
      private function sortByPriority(feature1:FeatureDescription, feature2:FeatureDescription) : int
      {
         var firstValue:uint = feature1.priority;
         var secondValue:uint = feature2.priority;
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return this.sortByName(feature1,feature2);
      }
      
      private function sortByName(feature1:FeatureDescription, feature2:FeatureDescription) : int
      {
         var firstValue:String = StringUtils.noAccent(feature1.name);
         var secondValue:String = StringUtils.noAccent(feature2.name);
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return 0;
      }
      
      private function goToNextResult() : void
      {
         ++this._currentResultIndex;
         ++this._indexOfResultInCurrentDescription;
         if(this._currentResultIndex > this._totalSearchResult - 1)
         {
            this._currentResultIndex = 0;
            this._currentDescriptionIndex = 0;
            this._indexOfResultInCurrentDescription = 0;
         }
         if(this._indexOfResultInCurrentDescription > this._searchedFeatures[this._currentDescriptionIndex].searchResult.length - 1)
         {
            this._indexOfResultInCurrentDescription = 0;
            ++this._currentDescriptionIndex;
         }
         this.moveToResult(this._searchedFeatures[this._currentDescriptionIndex],this._indexOfResultInCurrentDescription);
         this.lbl_searchResult.text = this._currentResultIndex + 1 + "/" + this._totalSearchResult;
      }
      
      private function goToPrevResult() : void
      {
         --this._currentResultIndex;
         --this._indexOfResultInCurrentDescription;
         if(this._currentResultIndex < 0)
         {
            this._currentResultIndex = this._totalSearchResult - 1;
            this._currentDescriptionIndex = this._searchedFeatures.length - 1;
            this._indexOfResultInCurrentDescription = this._searchedFeatures[this._currentDescriptionIndex].searchResult.length - 1;
         }
         if(this._indexOfResultInCurrentDescription < 0)
         {
            --this._currentDescriptionIndex;
            this._indexOfResultInCurrentDescription = this._searchedFeatures[this._currentDescriptionIndex].searchResult.length - 1;
         }
         var currentFeature:FeatureDescriptionWrapper = this._searchedFeatures[this._currentDescriptionIndex];
         this.moveToResult(currentFeature,this._indexOfResultInCurrentDescription);
         this.lbl_searchResult.text = this._currentResultIndex + 1 + "/" + this._totalSearchResult;
      }
      
      private function moveToResult(featureWrapper:FeatureDescriptionWrapper, currentIndex:int) : void
      {
         var searchResult:Object = featureWrapper.searchResult[currentIndex];
         if(!searchResult)
         {
            return;
         }
         if(this._lastSearchResult)
         {
            this._lastSearchResult.clearHighlight();
         }
         searchResult.highlight();
         this._lastSearchResult = searchResult;
         var slotHeight:int = this.uiApi.me().getConstant("descriptionSlotHeight");
         var descriptionPos:int = this.gd_descriptions.dataProvider.indexOf(featureWrapper) * slotHeight;
         var resultPos:int = descriptionPos + searchResult.bounds.y + searchResult.parentLabel.y;
         if(resultPos - this._currentPosY > this.gd_descriptions.height - slotHeight * 5 || resultPos < this._currentPosY)
         {
            this.gd_descriptions.verticalScrollValue = (resultPos - slotHeight * 5) / slotHeight;
            this._currentPosY = this.gd_descriptions.verticalScrollValue * slotHeight;
         }
         if(_lastDescriptionViewedId != featureWrapper.id)
         {
            this.dispatchStatsHook(featureWrapper.id,"search");
            this.selectCategory(featureWrapper.id);
         }
      }
      
      private function selectCategory(id:uint) : void
      {
         var cat:FeatureDescription = null;
         var currentDescription:FeatureDescription = this.dataApi.getFeatureDescriptionById(id);
         for each(cat in this.gd_categories.dataProvider)
         {
            if(cat.id == currentDescription.id)
            {
               this.gd_categories.setSelectedIndex(this.gd_categories.dataProvider.indexOf(cat),GridItemSelectMethodEnum.AUTO);
               return;
            }
         }
         if((!this.gd_categories.selectedItem || this.gd_categories.selectedItem.id != currentDescription.id) && currentDescription.parentId > 0)
         {
            this.selectCategory(currentDescription.parentId);
         }
      }
      
      private function dispatchStatsHook(featureId:uint, accessType:String) : void
      {
         this._hookFeatureId = featureId;
         this._hookFeatureAccessType = accessType;
         this._hookTimer.reset();
         this._hookTimer.start();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:FeatureDescription = null;
         switch(target)
         {
            case this.btn_resetSearch:
               this.resetSearch();
               break;
            case this.tx_nextSearchResult:
               this.goToNextResult();
               break;
            case this.tx_prevSearchResult:
               this.goToPrevResult();
               break;
            default:
               if(this._shiftIsDown)
               {
                  if(target.name.indexOf("btn_cat") != -1 || target.name.indexOf("btn_subCat") != -1 || target.name.indexOf("btn_subSubCat") != -1)
                  {
                     data = this._componentList[target];
                     this.sysApi.dispatchHook(BeriliaHookList.MouseShiftClick,{"data":data});
                  }
               }
               else if(target.name.indexOf("btn_cat") != -1 || target.name.indexOf("btn_subCat") != -1 || target.name.indexOf("btn_subSubCat") != -1)
               {
                  data = this._componentList[target];
                  this.moveToDescription(data);
                  this.dispatchStatsHook(data.id,"click");
               }
               else if(target.name.indexOf("btn_deployCat") != -1 || target.name.indexOf("btn_deploySubCat") != -1)
               {
                  data = this._componentList[target];
                  this.displayCategories(data);
               }
         }
      }
      
      public function onScroll(e:Event) : void
      {
         var tempIndex:int = this.gd_descriptions.scrollBarV.value;
         while(this.getDescriptionLineType(this.gd_descriptions.dataProvider[tempIndex],0).indexOf("Description") < 0)
         {
            tempIndex--;
         }
         var tempId:int = this.gd_descriptions.dataProvider[tempIndex].id;
         _lastDescriptionViewedId = tempId;
         this.selectCategory(tempId);
         this.dispatchStatsHook(tempId,"scroll");
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.tx_nextSearchResult:
               text = this.uiApi.getText("ui.guidebook.nextResult");
               break;
            case this.tx_prevSearchResult:
               text = this.uiApi.getText("ui.guidebook.prevResult");
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onMoveToFeatureDescription(params:Array) : void
      {
         if(params.length > 1 && params[1] != "")
         {
            this.dispatchStatsHook(params[0],params[1]);
         }
         var featureDescription:FeatureDescription = this.dataApi.getFeatureDescriptionById(params[0]);
         if(featureDescription)
         {
            this.moveToDescription(featureDescription);
         }
         else
         {
            this._log.warn("feature " + params[0] + " not found !");
         }
      }
      
      private function onHookTimer(t:TimerEvent = null) : void
      {
         this._hookTimer.reset();
         if(this._hookFeatureId != 0 && this._hookFeatureAccessType != "")
         {
            this.sysApi.dispatchHook(StatsHookList.GameGuideArticleSelectionType,this._hookFeatureId,this._hookFeatureAccessType);
         }
      }
   }
}
