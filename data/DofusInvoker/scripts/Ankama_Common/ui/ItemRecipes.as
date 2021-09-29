package Ankama_Common.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class ItemRecipes
   {
      
      private static const MAX_ITEMS_IN_GRID_BEFORE_SCROLL:int = 4;
       
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _item:ItemWrapper;
      
      private var _recipesList:Array;
      
      private var _categoriesFilterType:int = -1;
      
      private var _jobsFilterType:int = -1;
      
      private var _descendingSort:Boolean = true;
      
      private var _lastSortAttribute:String = "name";
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_currentItem:GraphicContainer;
      
      public var lbl_recipesCount:Label;
      
      public var blk_useItem:GraphicContainer;
      
      public var ctr_filters:GraphicContainer;
      
      public var ctr_recipes:GraphicContainer;
      
      public var ctr_search:GraphicContainer;
      
      public var cb_filterCategories:ComboBox;
      
      public var cb_filterJobs:ComboBox;
      
      public var gd_recipes:Grid;
      
      public var btn_sortName:ButtonContainer;
      
      public var btn_sortLevel:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_closeSearch:ButtonContainer;
      
      public var lbl_input:Input;
      
      public function ItemRecipes()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._item = param.item;
         var recipe:Recipe = this.jobsApi.getRecipe(this._item.objectGID);
         this.uiApi.loadUiInside("recipeItem",this.ctr_currentItem,"currentItemUi",{
            "data":recipe,
            "item":this._item
         });
         this.getRecipes();
         var recipes:Array = this.filteredRecipes();
         if(recipes.length == 0)
         {
            this.blk_useItem.visible = false;
         }
         else
         {
            this.lbl_recipesCount.text = this.uiApi.processText(this.uiApi.getText("ui.craft.associateRecipesCount",recipes.length),"n",recipes.length == 1,recipes.length == 0);
            this.sortItemList(recipes,this._lastSortAttribute);
            this._descendingSort = !this._descendingSort;
            this.gd_recipes.dataProvider = recipes;
            this.blk_useItem.visible = true;
         }
         this.updateWindowHeight();
         this.uiApi.addComponentHook(this.btn_closeSearch,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.cb_filterCategories,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_filterJobs,"onSelectItem");
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi("currentItemUi");
      }
      
      private function getRecipes() : void
      {
         var recipe:Recipe = null;
         var item:ItemWrapper = null;
         var k:* = undefined;
         this._recipesList = [];
         var typeList:Dictionary = new Dictionary(true);
         var jobList:Dictionary = new Dictionary(true);
         var recipeList:Array = this.jobsApi.getRecipesList(this._item.objectGID);
         var nb:int = recipeList.length;
         for(var i:int = 0; i < nb; i++)
         {
            recipe = recipeList[i];
            item = recipe.result;
            this._recipesList.push(recipe);
            if(jobList[recipe.jobId] == null)
            {
               jobList[recipe.jobId] = recipe.job.name;
            }
            if(typeList[item.type.id] == null)
            {
               typeList[item.type.id] = item.type.name;
            }
         }
         var cbProvider:Array = [];
         for(k in jobList)
         {
            cbProvider.push({
               "label":jobList[k],
               "filterType":k
            });
         }
         this.utilApi.sortOnString(cbProvider,"label");
         cbProvider.unshift({
            "label":this.uiApi.getText("ui.craft.allJobs"),
            "filterType":-1
         });
         this.cb_filterJobs.dataProvider = cbProvider;
         cbProvider = [];
         for(k in typeList)
         {
            cbProvider.push({
               "label":typeList[k],
               "filterType":k
            });
         }
         this.utilApi.sortOnString(cbProvider,"label");
         cbProvider.unshift({
            "label":this.uiApi.getText("ui.common.allTypesForObject"),
            "filterType":-1
         });
         this.cb_filterCategories.dataProvider = cbProvider;
      }
      
      private function filteredRecipes() : Array
      {
         var recipe:Recipe = null;
         var item:ItemWrapper = null;
         var list:Array = [];
         var filterName:String = this.lbl_input.text.toLowerCase();
         var filter:* = filterName != "";
         var nb:int = this._recipesList.length;
         for(var i:int = 0; i < nb; i++)
         {
            recipe = this._recipesList[i];
            item = recipe.result;
            if(!(filter && item.undiatricalName.indexOf(this.utilApi.noAccent(filterName)) == -1))
            {
               if(!(this._categoriesFilterType != -1 && item.type.id != this._categoriesFilterType))
               {
                  if(!(this._jobsFilterType != -1 && recipe.jobId != this._jobsFilterType))
                  {
                     list.push(recipe);
                  }
               }
            }
         }
         return list;
      }
      
      private function updateWindowHeight() : void
      {
         var recipesCount:int = 0;
         if(this.blk_useItem.visible)
         {
            recipesCount = Math.min(this.gd_recipes.dataProvider.length,MAX_ITEMS_IN_GRID_BEFORE_SCROLL);
            this.gd_recipes.height = recipesCount * this.gd_recipes.slotHeight;
            this.blk_useItem.height = this.gd_recipes.height + parseInt(this.uiApi.me().getConstant("recipesBlockMargin"));
            this.mainCtr.height = this.gd_recipes.height + parseInt(this.uiApi.me().getConstant("windowMargin"));
            if(this.gd_recipes.dataProvider.length > MAX_ITEMS_IN_GRID_BEFORE_SCROLL)
            {
               this.ctr_filters.visible = true;
               this.ctr_recipes.y = this.uiApi.me().getConstant("recipesCtrAnchorY");
            }
            else
            {
               this.ctr_filters.visible = false;
               this.ctr_recipes.y = this.uiApi.me().getConstant("recipesCtrAnchorYLessThan4Recipes");
               this.blk_useItem.height -= this.uiApi.me().getConstant("recipesCtrAnchorY");
               this.mainCtr.height -= this.uiApi.me().getConstant("recipesCtrAnchorY");
            }
         }
         else
         {
            this.mainCtr.height = parseInt(this.uiApi.me().getConstant("windowMarginNoRecipes"));
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var recipes:Array = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_closeSearch:
               this.lbl_input.text = "";
               recipes = this.filteredRecipes();
               this.sortItemList(recipes,this._lastSortAttribute);
               this.gd_recipes.dataProvider = recipes;
               this.blk_useItem.visible = true;
               break;
            case this.btn_sortName:
               this._lastSortAttribute = "name";
               recipes = this.filteredRecipes();
               this.sortItemList(recipes,this._lastSortAttribute);
               this.gd_recipes.dataProvider = recipes;
               this._descendingSort = !this._descendingSort;
               break;
            case this.btn_sortLevel:
               this._lastSortAttribute = "level";
               recipes = this.filteredRecipes();
               this.sortItemList(recipes,this._lastSortAttribute);
               this.gd_recipes.dataProvider = recipes;
               this._descendingSort = !this._descendingSort;
         }
         if(target == this.btn_close)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else if(target == this.btn_closeSearch)
         {
            this.lbl_input.text = "";
            recipes = this.filteredRecipes();
            this.sortItemList(recipes,this._lastSortAttribute);
            this.gd_recipes.dataProvider = recipes;
            this.blk_useItem.visible = true;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var recipes:Array = null;
         if(isNewSelection && selectMethod != 2)
         {
            if(target == this.cb_filterCategories)
            {
               this._categoriesFilterType = this.cb_filterCategories.value.filterType;
               recipes = this.filteredRecipes();
               this.sortItemList(recipes,this._lastSortAttribute);
               this.gd_recipes.dataProvider = recipes;
               this.blk_useItem.visible = true;
            }
            else if(target == this.cb_filterJobs)
            {
               this._jobsFilterType = this.cb_filterJobs.value.filterType;
               recipes = this.filteredRecipes();
               this.sortItemList(recipes,this._lastSortAttribute);
               this.gd_recipes.dataProvider = recipes;
               this.blk_useItem.visible = true;
            }
         }
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var recipes:Array = null;
         if(this.ctr_search.visible && this.lbl_input.haveFocus)
         {
            recipes = this.filteredRecipes();
            this.sortItemList(recipes,this._lastSortAttribute);
            this.gd_recipes.dataProvider = recipes;
            this.blk_useItem.visible = true;
         }
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
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         var data:Object = (target as Slot).data;
         if(data)
         {
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      private function sortItemList(arrayToSort:Array, sortField:String) : Array
      {
         var dataProvider:Array = arrayToSort;
         switch(sortField)
         {
            case "name":
               if(this._descendingSort)
               {
                  dataProvider.sort(this.sortByName);
               }
               else
               {
                  dataProvider.sort(this.sortByName,Array.DESCENDING);
               }
               break;
            case "level":
               if(this._descendingSort)
               {
                  dataProvider.sort(this.sortByLevel);
               }
               else
               {
                  dataProvider.sort(this.sortByLevel,Array.DESCENDING);
               }
         }
         return dataProvider;
      }
      
      private function sortByName(firstItem:Object, secondItem:Object, stopThere:Boolean = false) : int
      {
         var firstValue:String = firstItem.result.nameWithoutAccent;
         var secondValue:String = secondItem.result.nameWithoutAccent;
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         if(stopThere)
         {
            return 0;
         }
         return this.sortByLevel(firstItem,secondItem,true);
      }
      
      private function sortByLevel(firstItem:Object, secondItem:Object, stopThere:Boolean = false) : int
      {
         var firstValue:int = firstItem.resultLevel;
         var secondValue:int = secondItem.resultLevel;
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         if(stopThere)
         {
            return 0;
         }
         return this.sortByName(firstItem,secondItem,true);
      }
   }
}
