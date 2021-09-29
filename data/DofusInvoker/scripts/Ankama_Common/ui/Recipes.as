package Ankama_Common.ui
{
   import Ankama_Common.Common;
   import Ankama_Common.ui.items.RecipesFilterWrapper;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ServerSeasonTemporisCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ServerTypeItemCriterion;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.Version;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class Recipes
   {
      
      private static var _uriMissingIngredients:Uri;
      
      private static var _uriNoIngredients:Uri;
      
      private static var _uriBagIngredients:Uri;
      
      private static var _uriMissingIngredientsSlot:Uri;
      
      private static var _uriNoIngredientsSlot:Uri;
      
      private static var _uriBagIngredientsSlot:Uri;
      
      private static var _uriConditionalSlot:Uri;
      
      public static const MAX_JOB_LEVEL_GAP:int = 100;
       
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="JobsApi")]
      public var jobApi:JobsApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var inp_search:Input;
      
      public var inp_minLevelSearch:Input;
      
      public var inp_maxLevelSearch:Input;
      
      public var cb_type:ComboBox;
      
      public var gd_recipes:Grid;
      
      public var lbl_noRecipe:Label;
      
      public var chk_possibleRecipes:ButtonContainer;
      
      public var chk_showConditionnalRecipes:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      private var _currentJob:KnownJobWrapper;
      
      private var _currentSkillId:int = 0;
      
      private var _recipeTypes:Array;
      
      private var _jobsLevel:Array;
      
      private var _useJobLevelInsteadOfMaxFilter:Boolean = false;
      
      private var _currentRecipesFilter:RecipesFilterWrapper;
      
      private var _searchCriteria:String;
      
      private var _lockSearchTimer:BenchmarkTimer;
      
      private var _sortCriteria:String = "level";
      
      private var _ingredientsToleranceFilter:int = 8;
      
      private var _inventoryDataByGID:Dictionary;
      
      private var _recipes:Vector.<Recipe>;
      
      private var _gridComponentsList:Dictionary;
      
      private var _matsCountModeActivated:Boolean = false;
      
      private var _currentRecipe:Recipe;
      
      private var _canTransfertItems:Boolean;
      
      private var _storageType:String;
      
      public function Recipes()
      {
         this._recipeTypes = [];
         this._jobsLevel = [];
         this._inventoryDataByGID = new Dictionary(true);
         this._gridComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(params:Object) : void
      {
         var index:* = null;
         var uriBase:String = null;
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(CraftHookList.JobSelected,this.onJobSelected);
         this.sysApi.addHook(InventoryHookList.InventoryContent,this.onInventoryUpdate);
         this.sysApi.addHook(CraftHookList.JobLevelUp,this.onJobLevelUp);
         this.sysApi.addHook(CraftHookList.JobsExpOtherPlayerUpdated,this.onJobsExpOtherPlayerUpdated);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_minLevelSearch,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.inp_minLevelSearch,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_maxLevelSearch,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.inp_maxLevelSearch,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cb_type,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_recipes,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.chk_possibleRecipes,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this._lockSearchTimer = new BenchmarkTimer(1000,1,"Recipes._lockSearchTimer");
         this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this.inp_minLevelSearch.restrictChars = "0-9";
         this.inp_maxLevelSearch.restrictChars = "0-9";
         if(!_uriMissingIngredientsSlot)
         {
            uriBase = this.uiApi.me().getConstant("slot");
            _uriMissingIngredients = this.uiApi.createUri(uriBase + "iconInterrogation.png");
            _uriNoIngredients = this.uiApi.createUri(uriBase + "iconFailure.png");
            _uriBagIngredients = this.uiApi.createUri(uriBase + "iconValid.png");
            _uriMissingIngredientsSlot = this.uiApi.createUri(uriBase + "slotYellow.png");
            _uriNoIngredientsSlot = this.uiApi.createUri(uriBase + "slotRed.png");
            _uriBagIngredientsSlot = this.uiApi.createUri(uriBase + "slotGreen.png");
            _uriConditionalSlot = this.uiApi.createUri(uriBase + "specialSlot.png");
         }
         this._storageType = params.storage;
         this._canTransfertItems = this._storageType == "bankUi";
         if(params.jobId != 0)
         {
            this._jobsLevel[params.jobId] = params.jobLevel;
            if(params.jobLevel != this.jobApi.getKnownJob(params.jobId).jobLevel && this.uiApi.me().name == "recipesCraft")
            {
               this._useJobLevelInsteadOfMaxFilter = true;
            }
         }
         if(params.hasOwnProperty("ingredientsToleranceFilter"))
         {
            this._ingredientsToleranceFilter = params.ingredientsToleranceFilter;
         }
         var invData:Array = this.jobApi.getInventoryData(this._canTransfertItems);
         for(index in invData)
         {
            this._inventoryDataByGID[int(index)] = invData[index];
         }
         if(params.hasOwnProperty("matsCountMode"))
         {
            this._matsCountModeActivated = params.matsCountMode;
         }
         this.onJobSelected(params.jobId,params.skillId,this.uiApi.me().name);
      }
      
      public function selectWhichTabHintsToDisplay() : void
      {
         if(this.hintsApi.canDisplayHelp() && this.hintsApi.guidedActivated())
         {
            this.hintsApi.showSubHints();
         }
      }
      
      public function unload() : void
      {
         this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOut);
         this._lockSearchTimer.stop();
         this._lockSearchTimer = null;
         this._inventoryDataByGID = null;
         this._recipes = null;
         this._currentJob = null;
         this._currentRecipe = null;
         this._storageType = null;
         if(this.uiApi.getUi("quantityPopup"))
         {
            this.uiApi.unloadUi("quantityPopup");
         }
         this.uiApi.hideTooltip();
      }
      
      public function set disabled(disable:Boolean) : void
      {
         this.gd_recipes.disabled = disable;
      }
      
      public function get disabled() : Boolean
      {
         return this.gd_recipes.disabled;
      }
      
      public function getJobLevel(jobId:int = 0) : int
      {
         if(jobId == 0)
         {
            if(!this._currentJob)
            {
               this.sysApi.log(16,"Something\'s wrong here, no jobId and no currentJob.");
               return 1;
            }
            jobId = this._currentJob.id;
         }
         if(this._jobsLevel[jobId] > 0)
         {
            return this._jobsLevel[jobId];
         }
         if(this._currentJob)
         {
            return this._currentJob.jobLevel;
         }
         this._jobsLevel[jobId] = this.jobApi.getKnownJob(jobId).jobLevel;
         return this._jobsLevel[jobId];
      }
      
      public function updateRecipeLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var i:uint = 0;
         var job:KnownJobWrapper = null;
         var ingredients:Object = null;
         var levelForCraftXp:int = 0;
         var xp:int = 0;
         var item:Item = null;
         var showConditionalSlot:* = false;
         var maxOccurence:int = 0;
         var ii:int = 0;
         var l:int = 0;
         var ingredientQty:int = 0;
         var hasItemsToTransfert:Boolean = false;
         var itemInBag:Boolean = false;
         var dataSlot:Object = null;
         var currentVersion:Version = null;
         var majorMinorVersion:String = null;
         if(data)
         {
            for(i = 1; i < 9; i++)
            {
               if(!this._gridComponentsList[componentsRef["slot" + i].name])
               {
                  this.uiApi.addComponentHook(componentsRef["slot" + i],ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(componentsRef["slot" + i],ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef["slot" + i],ComponentHookList.ON_RELEASE);
                  this.uiApi.addComponentHook(componentsRef["slot" + i],ComponentHookList.ON_RIGHT_CLICK);
                  this.uiApi.addComponentHook(componentsRef["tx_ingredientStateIcon" + i],ComponentHookList.ON_ROLL_OVER);
                  this.uiApi.addComponentHook(componentsRef["tx_ingredientStateIcon" + i],ComponentHookList.ON_ROLL_OUT);
               }
               if(data && data.ingredients && data.ingredients.length >= i)
               {
                  dataSlot = data.ingredients[i - 1];
               }
               this._gridComponentsList[componentsRef["slot" + i].name] = dataSlot;
            }
            if(!this._gridComponentsList[componentsRef.slot_craftedItem.name])
            {
               this.uiApi.addComponentHook(componentsRef.slot_craftedItem,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.slot_craftedItem,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.slot_craftedItem,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.slot_craftedItem,ComponentHookList.ON_RIGHT_CLICK);
            }
            this._gridComponentsList[componentsRef.slot_craftedItem.name] = data.result;
            if(!this._gridComponentsList[componentsRef.tx_background.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_background,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_background,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.tx_background.name] = data;
            if(!this._gridComponentsList[componentsRef.btn_getItems.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_getItems,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_getItems,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_getItems,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.btn_getItems.name] = data;
            componentsRef.lbl_name.text = data.result.name;
            if(!this._currentJob)
            {
               job = this.jobApi.getKnownJob(data.jobId);
               componentsRef.lbl_job.text = job.name + " " + this.uiApi.getText("ui.common.short.level").toLocaleLowerCase() + " " + data.result.level;
            }
            else
            {
               componentsRef.lbl_job.text = this.uiApi.getText("ui.common.short.level") + " " + data.result.level;
            }
            ingredients = data.ingredients;
            levelForCraftXp = this.getJobLevel(data.jobId);
            componentsRef.ctr_main.greyedOut = this._currentJob && data.result.level > levelForCraftXp || !this.jobApi.checkCraftConditions(data.resultId);
            componentsRef.ctr_main.softDisabled = componentsRef.btn_recipe.softDisabled = componentsRef.ctr_main.greyedOut && this.uiApi.getUi("checkCraft") == null;
            componentsRef.slot_craftedItem.isButton = componentsRef.btn_recipe.useHandCursor = !componentsRef.btn_recipe.softDisabled || this.uiApi.getUi("checkCraft") != null;
            if(componentsRef.btn_recipe.softDisabled)
            {
               for(i = 1; i < 9; i++)
               {
                  componentsRef["slot" + i].isButton = false;
               }
            }
            if(levelForCraftXp < data.result.level)
            {
               levelForCraftXp = data.result.level;
            }
            xp = this.jobApi.getCraftXp(data.result,levelForCraftXp);
            componentsRef.lbl_xp.text = this.uiApi.getText("ui.tooltip.monsterXpAlone",xp);
            componentsRef.slot_craftedItem.data = data.result;
            item = this.dataApi.getItem(data.resultId);
            showConditionalSlot = !this.hasOnlyServerCriterions(item);
            componentsRef.slot_craftedItem.forcedBackGroundIconUri = item && showConditionalSlot ? _uriConditionalSlot : null;
            componentsRef.slot_craftedItem.visible = componentsRef.tx_slot_background.visible = true;
            if(!data.changeVersion || isNaN(data.tooltipExpirationDate) || data.tooltipExpirationDate <= 0 || data.tooltipExpirationDate <= this.timeApi.getTimestamp())
            {
               componentsRef.tx_historyIcon.visible = false;
               this.uiApi.removeComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OUT);
               delete this._gridComponentsList[componentsRef.tx_historyIcon.name];
            }
            else
            {
               componentsRef.tx_historyIcon.visible = true;
               this.uiApi.addComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OUT);
               this._gridComponentsList[componentsRef.tx_historyIcon.name] = data.changeVersion;
               currentVersion = this.sysApi.getCurrentVersion();
               majorMinorVersion = null;
               if(currentVersion !== null)
               {
                  majorMinorVersion = currentVersion.major.toString() + "." + currentVersion.minor.toString();
               }
               if(majorMinorVersion !== null && majorMinorVersion.indexOf(data.changeVersion) === 0)
               {
                  componentsRef.tx_historyIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "clock_arrow_yellow.png");
               }
               else
               {
                  componentsRef.tx_historyIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "clock_arrow.png");
               }
            }
            if(!this._matsCountModeActivated)
            {
               for(i = 1; i <= ingredients.length; i++)
               {
                  componentsRef["slot" + i].data = ingredients[i - 1];
                  componentsRef["slot" + i].mouseEnabled = true;
                  componentsRef["slot" + i].visible = true;
               }
               while(i < 9)
               {
                  componentsRef["slot" + i].data = null;
                  componentsRef["slot" + i].mouseEnabled = false;
                  componentsRef["slot" + i].visible = false;
                  i++;
               }
               return;
            }
            maxOccurence = this.getActualMaxOccurence(data.resultId);
            componentsRef.lbl_maxCraftQuantity.text = "x" + maxOccurence;
            i = 1;
            l = ingredients.length + 1;
            for(hasItemsToTransfert = false; i < l; )
            {
               ii = i - 1;
               itemInBag = this.itemIsInBag(data.ingredientIds[ii]);
               ingredientQty = this.getItemTotalQty(ingredients[ii].objectGID);
               componentsRef["slot" + i].data = ingredients[ii];
               componentsRef["slot" + i].mouseEnabled = true;
               componentsRef["slot" + i].visible = true;
               if(!ingredientQty)
               {
                  componentsRef["tx_ingredientStateIcon" + i].uri = _uriNoIngredients;
                  componentsRef["slot" + i].customTexture = _uriNoIngredientsSlot;
                  componentsRef["slot" + i].selectedTexture = _uriNoIngredientsSlot;
                  componentsRef["slot" + i].highlightTexture = _uriNoIngredientsSlot;
               }
               else if(ingredientQty < data.quantities[ii])
               {
                  componentsRef["tx_ingredientStateIcon" + i].uri = _uriMissingIngredients;
                  componentsRef["slot" + i].customTexture = _uriMissingIngredientsSlot;
                  componentsRef["slot" + i].selectedTexture = _uriMissingIngredientsSlot;
                  componentsRef["slot" + i].highlightTexture = _uriMissingIngredientsSlot;
                  if(!itemInBag)
                  {
                     hasItemsToTransfert = true;
                  }
               }
               else if(itemInBag)
               {
                  componentsRef["tx_ingredientStateIcon" + i].uri = _uriBagIngredients;
                  componentsRef["slot" + i].customTexture = _uriBagIngredientsSlot;
                  componentsRef["slot" + i].selectedTexture = _uriBagIngredientsSlot;
                  componentsRef["slot" + i].highlightTexture = _uriBagIngredientsSlot;
               }
               else
               {
                  componentsRef["tx_ingredientStateIcon" + i].uri = null;
                  componentsRef["slot" + i].customTexture = null;
                  componentsRef["slot" + i].selectedTexture = null;
                  componentsRef["slot" + i].highlightTexture = null;
                  hasItemsToTransfert = true;
               }
               i++;
            }
            for(i = l; i < 9; i++)
            {
               componentsRef["tx_ingredientStateIcon" + i].uri = null;
               componentsRef["slot" + i].customTexture = null;
               componentsRef["slot" + i].selectedTexture = null;
               componentsRef["slot" + i].highlightTexture = null;
               componentsRef["slot" + i].data = null;
               componentsRef["slot" + i].mouseEnabled = false;
               componentsRef["slot" + i].visible = false;
            }
            componentsRef.btn_getItems.visible = this._canTransfertItems && hasItemsToTransfert;
         }
         else
         {
            componentsRef.slot_craftedItem.data = null;
            componentsRef.slot_craftedItem.visible = componentsRef.tx_slot_background.visible = false;
            for(i = 1; i < 9; i++)
            {
               componentsRef["tx_ingredientStateIcon" + i].uri = null;
               componentsRef["slot" + i].customTexture = null;
               componentsRef["slot" + i].selectedTexture = null;
               componentsRef["slot" + i].highlightTexture = null;
               componentsRef["slot" + i].mouseEnabled = false;
               componentsRef["slot" + i].visible = false;
               componentsRef["slot" + i].data = null;
               this._gridComponentsList[componentsRef["slot" + i].name] = null;
            }
            componentsRef.lbl_xp.text = "";
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_job.text = "";
            componentsRef.lbl_maxCraftQuantity.text = "";
            componentsRef.ctr_main.softDisabled = false;
            componentsRef.ctr_main.greyedOut = false;
            componentsRef.btn_getItems.visible = false;
            componentsRef.tx_historyIcon.visible = false;
            this.uiApi.removeComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(componentsRef.tx_historyIcon,ComponentHookList.ON_ROLL_OUT);
            delete this._gridComponentsList[componentsRef.tx_historyIcon.name];
         }
      }
      
      public function set ingredientsToleranceFilter(tolerance:int) : void
      {
         this._ingredientsToleranceFilter = tolerance;
         this.updateRecipes(true);
      }
      
      public function switchSort(sortCriteria:String = "level") : void
      {
         this._sortCriteria = sortCriteria;
         this.gd_recipes.dataProvider = this.jobApi.sortRecipesByCriteria(this.gd_recipes.dataProvider,this._sortCriteria,false);
      }
      
      public function itemIsInBag(itemGID:int) : Boolean
      {
         var itemDetails:Object = this._inventoryDataByGID[itemGID];
         if(!itemDetails || !itemDetails.fromBag)
         {
            return false;
         }
         for(var i:int = 0; i < itemDetails.fromBag.length; )
         {
            if(!itemDetails.fromBag[i])
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function getActualMaxOccurence(resultId:int) : uint
      {
         var maxOccurence:int = 0;
         if(this._inventoryDataByGID[resultId])
         {
            maxOccurence = this._inventoryDataByGID[resultId].actualMaxOccurence;
         }
         return maxOccurence;
      }
      
      public function getPotentialMaxOccurence(resultId:int) : uint
      {
         var maxOccurence:int = 0;
         if(this._inventoryDataByGID[resultId])
         {
            maxOccurence = this._inventoryDataByGID[resultId].potentialMaxOccurence;
         }
         return maxOccurence;
      }
      
      public function getPossibleMaxOccurence(resultId:int) : uint
      {
         var recipe:Recipe = null;
         var occurences:Array = null;
         var stackTotalQty:int = 0;
         var ingredientDetails:Object = null;
         var i:int = 0;
         var j:int = 0;
         var maxOccurence:int = 0;
         if(this._inventoryDataByGID[resultId])
         {
            recipe = this.jobApi.getRecipe(resultId);
            occurences = [];
            stackTotalQty = 0;
            for(i = 0; i < recipe.ingredientIds.length; i++)
            {
               ingredientDetails = this._inventoryDataByGID[recipe.ingredientIds[i]];
               stackTotalQty = 0;
               if(ingredientDetails && ingredientDetails.stackQtyList)
               {
                  for(j = 0; j < ingredientDetails.stackQtyList.length; j++)
                  {
                     if(!ingredientDetails.fromBag[j])
                     {
                        stackTotalQty += ingredientDetails.stackQtyList[j];
                     }
                  }
                  occurences.push(int(stackTotalQty / recipe.quantities[i]));
               }
               else
               {
                  occurences.push(0);
               }
            }
            occurences.sort(Array.NUMERIC);
            maxOccurence = occurences[occurences.length - 1];
         }
         if(maxOccurence == 0)
         {
            maxOccurence = 1;
         }
         return maxOccurence;
      }
      
      public function getItemTotalQty(itemGID:int) : int
      {
         var totalQty:int = 0;
         if(this._inventoryDataByGID[itemGID])
         {
            totalQty = this._inventoryDataByGID[itemGID].totalQuantity;
         }
         return totalQty;
      }
      
      public function requestIngredientsTransfert(recipe:Recipe) : void
      {
         this._currentRecipe = recipe;
         var maxValue:uint = this.getPossibleMaxOccurence(recipe.resultId);
         var defaultValue:uint = this.getPotentialMaxOccurence(recipe.resultId);
         this.modCommon.openQuantityPopup(1,maxValue,defaultValue,this.onValidRecipeMax);
      }
      
      private function updateRecipes(newSearch:Boolean = true) : void
      {
         var r:Recipe = null;
         var typeNames:Array = null;
         var listedTypeIds:Array = null;
         var selectionIndex:int = 0;
         var i:int = 0;
         var recipeType:Object = null;
         var recipeOk:Boolean = false;
         if(newSearch)
         {
            this._recipes = this.jobApi.getRecipesByJob(this._inventoryDataByGID,this._currentSkillId,!!this._currentJob ? int(this._currentJob.id) : 0,this._canTransfertItems,this._ingredientsToleranceFilter);
            this._recipeTypes = [];
            this._recipes = this.jobApi.getJobFilteredRecipes(this._recipes,this._recipeTypes,this._currentRecipesFilter.minLevel,this._currentRecipesFilter.maxLevel,this._searchCriteria,this._currentRecipesFilter.typeId);
            this.jobApi.sortRecipesByCriteria(this._recipes,this._sortCriteria,false);
            typeNames = [];
            listedTypeIds = [];
            selectionIndex = 0;
            i = 1;
            typeNames.push({
               "label":this.uiApi.getText("ui.common.allTypesForObject"),
               "id":0
            });
            this._recipeTypes.sortOn("name",Array.CASEINSENSITIVE);
            for each(recipeType in this._recipeTypes)
            {
               if(listedTypeIds.indexOf(recipeType.id) == -1)
               {
                  typeNames.push({
                     "label":recipeType.name,
                     "id":recipeType.id
                  });
                  listedTypeIds.push(recipeType.id);
                  if(recipeType.id == this._currentRecipesFilter.typeId)
                  {
                     selectionIndex = i;
                  }
                  i++;
               }
            }
            this.cb_type.dataProvider = typeNames;
            this.cb_type.selectedIndex = selectionIndex;
         }
         var visibleRecipes:Array = [];
         var okRecipes:Array = [];
         if(this.chk_showConditionnalRecipes.selected)
         {
            for each(r in this._recipes)
            {
               if(this.jobApi.checkCraftVisible(r.resultId) && r.result.visible)
               {
                  visibleRecipes.push(r);
               }
            }
         }
         else
         {
            for each(r in this._recipes)
            {
               if(this.jobApi.checkCraftVisible(r.resultId) && this.jobApi.checkCraftConditions(r.resultId) && r.result.visible)
               {
                  visibleRecipes.push(r);
               }
            }
         }
         if(this.chk_possibleRecipes.selected)
         {
            for each(r in visibleRecipes)
            {
               if((this._currentJob && r.jobId == this._currentJob.id || !this._currentJob) && r.resultLevel <= this.getJobLevel(r.jobId))
               {
                  recipeOk = true;
                  for(i = 0; i < r.ingredientIds.length; i++)
                  {
                     if(!this._inventoryDataByGID[r.ingredientIds[i]] || !this._inventoryDataByGID[r.ingredientIds[i]].totalQuantity || this._inventoryDataByGID[r.ingredientIds[i]].totalQuantity < r.quantities[i])
                     {
                        recipeOk = false;
                        break;
                     }
                  }
                  if(recipeOk && this.jobApi.checkCraftFeasible(r.resultId))
                  {
                     okRecipes.push(r);
                  }
               }
            }
            this.fillRecipesGrid(okRecipes);
         }
         else
         {
            this.fillRecipesGrid(visibleRecipes);
         }
      }
      
      private function fillRecipesGrid(recipes:Array) : void
      {
         this.gd_recipes.dataProvider = recipes;
         if(!recipes || recipes.length == 0)
         {
            this.lbl_noRecipe.visible = true;
            this.gd_recipes.alpha = 0.2;
         }
         else
         {
            this.lbl_noRecipe.visible = false;
            this.gd_recipes.alpha = 1;
         }
         this.sysApi.dispatchHook(CraftHookList.RecipesListRefreshed,recipes.length);
      }
      
      private function onValidRecipeMax(qty:Number) : void
      {
         var ingredientDetails:Object = null;
         var foundQty:int = 0;
         var ingredientQty:int = 0;
         var ll:int = 0;
         var j:int = 0;
         var ingredients:Vector.<uint> = new Vector.<uint>();
         var quantities:Vector.<uint> = new Vector.<uint>();
         var requiredQuantities:Vector.<uint> = new Vector.<uint>();
         var l:int = this._currentRecipe.ingredientIds.length;
         for(var i:int = 0; i < l; i++)
         {
            requiredQuantities.push(this._currentRecipe.quantities[i] * qty);
            ingredientDetails = this._inventoryDataByGID[this._currentRecipe.ingredientIds[i]];
            if(!(!ingredientDetails || !ingredientDetails.totalQuantity))
            {
               foundQty = 0;
               ingredientQty = 0;
               ll = ingredientDetails.stackUidList.length;
               for(j = 0; j < ll; j++)
               {
                  if(!ingredientDetails.fromBag[j])
                  {
                     ingredients.push(ingredientDetails.stackUidList[j]);
                     ingredientQty = ingredientDetails.stackQtyList[j];
                     if(!foundQty && ingredientQty >= requiredQuantities[i])
                     {
                        quantities.push(requiredQuantities[i]);
                        break;
                     }
                     if(foundQty < requiredQuantities[i])
                     {
                        if(foundQty + ingredientQty == requiredQuantities[i])
                        {
                           quantities.push(ingredientQty);
                           foundQty += ingredientQty;
                           break;
                        }
                        if(foundQty + ingredientQty > requiredQuantities[i])
                        {
                           quantities.push(requiredQuantities[i] - foundQty);
                           foundQty = requiredQuantities[i];
                           break;
                        }
                        quantities.push(ingredientQty);
                        foundQty += ingredientQty;
                     }
                  }
               }
            }
         }
         this.sysApi.sendAction(new ExchangeObjectTransfertListWithQuantityToInvAction([ingredients,quantities]));
      }
      
      private function hasOnlyServerCriterions(item:Item) : Boolean
      {
         var criteria:IItemCriterion = null;
         if(!item)
         {
            return false;
         }
         if(item.craftFeasibleConditions && item.craftFeasibleConditions.criteria.length != 0)
         {
            for each(criteria in item.craftFeasibleConditions.criteria)
            {
               if(!(criteria is ServerTypeItemCriterion) && !(criteria is ServerSeasonTemporisCriterion))
               {
                  return false;
               }
            }
         }
         if(item.craftConditions && item.craftConditions.criteria.length != 0)
         {
            for each(criteria in item.craftConditions.criteria)
            {
               if(!(criteria is ServerTypeItemCriterion) && !(criteria is ServerSeasonTemporisCriterion))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Recipe = null;
         switch(target)
         {
            case this.inp_search:
               if(this.inp_search.text == this.uiApi.getText("ui.common.search.input"))
               {
                  this.inp_search.text = "";
               }
               break;
            case this.chk_showConditionnalRecipes:
            case this.chk_possibleRecipes:
               this.updateRecipes(false);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
         }
         if(target.name.indexOf("btn_getItems") != -1)
         {
            data = this._gridComponentsList[target.name];
            if(data)
            {
               this.requestIngredientsTransfert(data);
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var ttData:* = undefined;
         var data:Object = null;
         switch(target)
         {
            case this.inp_search:
               ttData = this.uiApi.getText("ui.common.searchFilterTooltip");
               break;
            case this.inp_minLevelSearch:
               ttData = this.uiApi.getText("ui.craft.minRecipeLevel");
               break;
            case this.inp_maxLevelSearch:
               ttData = this.uiApi.getText("ui.craft.maxRecipeLevel");
         }
         if(target.name.indexOf("tx_background") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data)
            {
               if(this.getJobLevel(data.jobId) < data.result.level)
               {
                  ttData = this.uiApi.getText("ui.jobs.difficulty3");
               }
               else if(this.getJobLevel(data.jobId) > data.result.level + MAX_JOB_LEVEL_GAP)
               {
                  ttData = this.uiApi.getText("ui.jobs.difficulty1");
               }
            }
         }
         else
         {
            if(target.name.indexOf("slot") == 0)
            {
               data = this._gridComponentsList[target.name];
               if(data)
               {
                  this.uiApi.showTooltip(data,target,false,"standard",6,2,3,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               return;
            }
            if(target.name.indexOf("btn_getItems") == 0)
            {
               data = this._gridComponentsList[target.name];
               if(data)
               {
                  ttData = this.uiApi.getText("ui.craft.transfertIngredients",this.getPotentialMaxOccurence(data.resultId));
               }
            }
            else if(target.name.indexOf("tx_ingredientStateIcon") == 0)
            {
               if((target as Texture).uri)
               {
                  if((target as Texture).uri.fileName == _uriNoIngredients.fileName)
                  {
                     ttData = this.uiApi.getText("ui.craft.noIngredient");
                  }
                  else if((target as Texture).uri.fileName == _uriMissingIngredients.fileName)
                  {
                     ttData = this.uiApi.getText("ui.craft.ingredientNotEnough");
                  }
                  else if((target as Texture).uri.fileName == _uriBagIngredients.fileName)
                  {
                     ttData = this.uiApi.getText("ui.craft.ingredientInBag");
                  }
               }
            }
            else if(target.name.indexOf("tx_historyIcon") == 0)
            {
               data = this._gridComponentsList[target.name];
               if(data)
               {
                  ttData = this.uiApi.getText("ui.jobs.versionNotice",data);
               }
            }
         }
         if(ttData)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         switch(target)
         {
            case this.gd_recipes:
               if(selectMethod != SelectMethodEnum.AUTO && this._currentJob)
               {
                  item = this.gd_recipes.selectedItem;
                  this.sysApi.dispatchHook(CraftHookList.RecipeSelected,item,this._currentJob.id);
               }
               break;
            case this.cb_type:
               if(!isNewSelection || this._currentRecipesFilter.typeId == this.cb_type.selectedItem.id)
               {
                  return;
               }
               this._currentRecipesFilter.typeId = this.cb_type.selectedItem.id;
               Common.getInstance().setJobSearchOptionsByJobId(this._currentRecipesFilter);
               this.updateRecipes();
               break;
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         var data:Object = this._gridComponentsList[target.name];
         if(data)
         {
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(this.inp_search.haveFocus)
         {
            this._searchCriteria = this.inp_search.text.toLowerCase();
            if(!this._searchCriteria.length)
            {
               this._searchCriteria = null;
            }
            this.updateRecipes();
            return true;
         }
         return false;
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_search.haveFocus || this.inp_minLevelSearch.haveFocus || this.inp_maxLevelSearch.haveFocus)
         {
            this._lockSearchTimer.reset();
            this._lockSearchTimer.start();
         }
      }
      
      public function onTimeOut(e:TimerEvent) : void
      {
         var inpText:String = null;
         var searchMinLevel:int = 0;
         var searchMaxLevel:int = 0;
         var updateRecipesNeeded:Boolean = false;
         if(this.inp_search.text != this.uiApi.getText("ui.common.search.input"))
         {
            if(this.inp_search.text.length > 2)
            {
               inpText = this.inp_search.text.toLowerCase();
               if(this._searchCriteria != inpText)
               {
                  this._searchCriteria = this.inp_search.text.toLowerCase();
                  updateRecipesNeeded = true;
               }
            }
            else
            {
               if(this._searchCriteria)
               {
                  this._searchCriteria = null;
               }
               if(this.inp_search.text == "")
               {
                  updateRecipesNeeded = true;
               }
               else
               {
                  this.fillRecipesGrid([]);
               }
            }
         }
         var min:int = int(this.inp_minLevelSearch.text);
         if(this._currentRecipesFilter.minLevel != min)
         {
            searchMinLevel = 1;
            if(!min || min == 0)
            {
               this.inp_minLevelSearch.text = "1";
               searchMinLevel = 1;
            }
            else if(min > ProtocolConstantsEnum.MAX_JOB_LEVEL)
            {
               this.inp_minLevelSearch.text = "" + ProtocolConstantsEnum.MAX_JOB_LEVEL;
               searchMinLevel = ProtocolConstantsEnum.MAX_JOB_LEVEL;
            }
            else
            {
               searchMinLevel = min;
            }
            if(searchMinLevel > this._currentRecipesFilter.maxLevel)
            {
               this.inp_minLevelSearch.text = "" + this._currentRecipesFilter.maxLevel;
               searchMinLevel = this._currentRecipesFilter.maxLevel;
            }
            this._currentRecipesFilter.minLevel = searchMinLevel;
            Common.getInstance().setJobSearchOptionsByJobId(this._currentRecipesFilter);
            updateRecipesNeeded = true;
         }
         var max:int = int(this.inp_maxLevelSearch.text);
         if(this._currentRecipesFilter.maxLevel != max)
         {
            searchMaxLevel = 1;
            if(!max || max == 0)
            {
               this.inp_maxLevelSearch.text = "1";
               searchMaxLevel = 1;
            }
            else if(max > ProtocolConstantsEnum.MAX_JOB_LEVEL)
            {
               this.inp_maxLevelSearch.text = "" + ProtocolConstantsEnum.MAX_JOB_LEVEL;
               searchMaxLevel = ProtocolConstantsEnum.MAX_JOB_LEVEL;
            }
            else
            {
               searchMaxLevel = max;
            }
            if(searchMaxLevel < this._currentRecipesFilter.minLevel)
            {
               this.inp_maxLevelSearch.text = "" + this._currentRecipesFilter.minLevel;
               searchMaxLevel = this._currentRecipesFilter.minLevel;
            }
            this._currentRecipesFilter.maxLevel = searchMaxLevel;
            Common.getInstance().setJobSearchOptionsByJobId(this._currentRecipesFilter);
            updateRecipesNeeded = true;
         }
         if(updateRecipesNeeded)
         {
            this.updateRecipes();
         }
      }
      
      private function onInventoryUpdate(items:Vector.<ItemWrapper>, kama:Number) : void
      {
         var index:* = null;
         this._inventoryDataByGID = new Dictionary(true);
         var invData:Array = this.jobApi.getInventoryData(this._canTransfertItems);
         for(index in invData)
         {
            this._inventoryDataByGID[int(index)] = invData[index];
         }
         this.updateRecipes(true);
      }
      
      private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint) : void
      {
         if(this._jobsLevel[jobId])
         {
            this._jobsLevel[jobId] = newLevel;
         }
         if(this._currentJob)
         {
            if(this._currentJob.id == jobId)
            {
               this._currentJob = this.jobApi.getKnownJob(jobId);
               this._currentRecipesFilter.maxLevel = newLevel;
               this.inp_maxLevelSearch.text = "" + this._currentRecipesFilter.maxLevel;
               this.updateRecipes(false);
            }
         }
      }
      
      protected function onJobsExpOtherPlayerUpdated(playerId:Number, jobExperience:Object) : void
      {
         if(this.uiApi.me().name != "recipesCraft")
         {
            return;
         }
         var jobXp:JobExperience = jobExperience as JobExperience;
         this._jobsLevel[jobXp.jobId] = jobXp.jobLevel;
         if(this.inp_maxLevelSearch.text == (jobXp.jobLevel - 1).toString())
         {
            this._currentRecipesFilter.maxLevel = jobXp.jobLevel;
            this.inp_maxLevelSearch.text = "" + this._currentRecipesFilter.maxLevel;
         }
         this.updateRecipes(false);
      }
      
      private function onJobSelected(jobId:int, skillId:int, uiName:String) : void
      {
         if(uiName != this.uiApi.me().name)
         {
            return;
         }
         if(jobId == 0 && skillId == 0)
         {
            this._currentJob = null;
            this._currentSkillId = 0;
            this._currentRecipesFilter = new RecipesFilterWrapper(0,1,ProtocolConstantsEnum.MAX_JOB_LEVEL);
         }
         else
         {
            this._currentJob = this.jobApi.getKnownJob(jobId);
            this._currentSkillId = skillId;
            this._currentRecipesFilter = Common.getInstance().getJobSearchOptionsByJobId(this._currentJob.id);
            if(!this._currentRecipesFilter)
            {
               this._currentRecipesFilter = new RecipesFilterWrapper(this._currentJob.id,1,this.getJobLevel());
            }
         }
         this._searchCriteria = null;
         this.inp_minLevelSearch.text = "" + this._currentRecipesFilter.minLevel;
         if(this._useJobLevelInsteadOfMaxFilter)
         {
            this._currentRecipesFilter.maxLevel = this.getJobLevel();
         }
         this.inp_maxLevelSearch.text = "" + this._currentRecipesFilter.maxLevel;
         this.updateRecipes(true);
      }
   }
}
