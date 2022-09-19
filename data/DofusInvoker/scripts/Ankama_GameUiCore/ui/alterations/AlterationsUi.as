package Ankama_GameUiCore.ui.alterations
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationSourceTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationUtils;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationsDescr;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.UpdateAlterationFavoriteFlagAction;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.AlterationExpirationTypeEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AlterationsUi
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(AlterationsUi));
      
      private static const UI_TOOLTIP_NAME:String = "standard";
      
      private static const MAX_PREVIEWED_ALTERATIONS:uint = 6;
      
      private static const ALTERATION_REFRESH_DELAY:uint = 1000;
      
      private static const ALTERATION_FAVORITES_SORT:uint = 0;
      
      private static const ALTERATION_CREATION_TIMES_SORT:uint = 1;
      
      private static const ALTERATION_IDS_SORT:uint = 2;
      
      private static const ALTERATION_NAMES_SORT:uint = 3;
      
      private static const ALTERATION_CATEGORIES_SORT:uint = 4;
      
      private static const ALTERATION_DESCRIPTIONS_SORT:uint = 5;
      
      private static const ALTERATION_TIMES_LEFT_SORT:uint = 6;
      
      private static const DEFAULT_ALTERATION_SORT_ORDER:Vector.<uint> = new <uint>[ALTERATION_FAVORITES_SORT,ALTERATION_NAMES_SORT,ALTERATION_CATEGORIES_SORT,ALTERATION_DESCRIPTIONS_SORT,ALTERATION_TIMES_LEFT_SORT];
       
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var btn_clearSearchText:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_sortByDescriptions:ButtonContainer;
      
      public var btn_sortByFavorites:ButtonContainer;
      
      public var btn_sortByNamesOrCategories:ButtonContainer;
      
      public var btn_sortByExpirations:ButtonContainer;
      
      public var cb_alterationParentCategory:ComboBox;
      
      public var cb_alterationCategory:ComboBox;
      
      public var ctr_alterationsUi:GraphicContainer;
      
      public var ctr_cb_alterationParentCategory:GraphicContainer;
      
      public var ctr_cb_alterationCategory:GraphicContainer;
      
      public var inp_alterationsSearch:Input;
      
      public var gd_previewedAlterations:Grid;
      
      public var gd_alterations:Grid;
      
      public var lbl_headerDescription:Label;
      
      public var lbl_headerFavorites:Label;
      
      public var lbl_headerNameOrCategory:Label;
      
      public var lbl_headerExpiration:Label;
      
      public var tx_sortByDescriptionsDown:Texture;
      
      public var tx_sortByDescriptionsUp:Texture;
      
      public var tx_sortByFavoritesDown:Texture;
      
      public var tx_sortByFavoritesUp:Texture;
      
      public var tx_sortByNamesOrCategoriesDown:Texture;
      
      public var tx_sortByNamesOrCategoriesUp:Texture;
      
      public var tx_sortByExpirationsDown:Texture;
      
      public var tx_sortByExpirationsUp:Texture;
      
      private var _alterations:Vector.<AlterationWrapper> = null;
      
      private var _filteredAlterations:Vector.<AlterationWrapper> = null;
      
      private var _favoriteCount:uint = 0;
      
      private var _componentsData:Dictionary;
      
      private var _alterationExpirationRefreshMap:Dictionary = null;
      
      private var _previewedAlterationsExpirationRefreshMap:Dictionary = null;
      
      private var _expirationTimer:BenchmarkTimer = null;
      
      private var _currentLowestExpiration:Number = NaN;
      
      private var _alterationParentCategoryFilters:Vector.<String> = null;
      
      private var _alterationCategoryFilters:Vector.<String> = null;
      
      private var _alterationSortProcessors:Dictionary = null;
      
      private var _currentAlterationsSortOrder:Vector.<uint> = null;
      
      private var _isNameSort:Boolean = true;
      
      private var _searchAlterationsPlaceholderText:String = null;
      
      private var _currentSearchText:String = "";
      
      private var _isSearchInputFilled:Boolean = false;
      
      private var _isSearchInputReady:Boolean = false;
      
      private var _isSearchPlaceholderReset:Boolean = false;
      
      private var _allAlterationParentCategoriesFilter:String = null;
      
      private var _allAlterationCategoriesFilter:String = null;
      
      private var _currentAlterationParentCategoryFilter:String = null;
      
      private var _currentAlterationCategoryFilter:String = null;
      
      public function AlterationsUi()
      {
         this._componentsData = new Dictionary();
         super();
      }
      
      public function main(descr:AlterationsDescr = null) : void
      {
         this.sysApi.addHook(RoleplayHookList.Alterations,this.onAlterations);
         this.sysApi.addHook(RoleplayHookList.AlterationAdded,this.onAlterationAdded);
         this.sysApi.addHook(RoleplayHookList.AlterationRemoved,this.onAlterationRemoved);
         this.sysApi.addHook(RoleplayHookList.AlterationsUpdated,this.onAlterationsUpdated);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.ctr_alterationsUi,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByNamesOrCategories,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByDescriptions,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByExpirations,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sortByFavorites,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_alterationsSearch,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_alterationsSearch,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_clearSearchText,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_alterationParentCategory,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_alterationCategory,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.lbl_headerNameOrCategory.fullWidth();
         this.lbl_headerDescription.fullWidth();
         this.lbl_headerExpiration.fullWidth();
         this.lbl_headerFavorites.fullWidth();
         this._currentAlterationsSortOrder = DEFAULT_ALTERATION_SORT_ORDER.concat();
         this._searchAlterationsPlaceholderText = this.uiApi.getText("ui.alteration.searchAlteration");
         this.inp_alterationsSearch.text = this._searchAlterationsPlaceholderText;
         this._allAlterationParentCategoriesFilter = this.uiApi.getText("ui.alteration.allCategories");
         this._allAlterationCategoriesFilter = this.uiApi.getText("ui.alteration.allSubcategories");
         this.setFilters();
         this.setAlterationSortProcessors();
         this.setAlterationData(descr.alterations.concat());
         this.refreshAlterationUiElements();
      }
      
      public function updatePreviewedAlterationSlot(alteration:AlterationWrapper, components:Object, isSelected:Boolean) : void
      {
         var expirationText:String = null;
         var expirationIconUri:Uri = null;
         var filter:GlowFilter = null;
         var me:UiRootContainer = null;
         var isExpirationIconUri:Boolean = false;
         var iconOffsetX:Number = NaN;
         var iconOffsetY:Number = NaN;
         var containerWidth:Number = NaN;
         components.slot_alteration.data = alteration;
         var isExpiration:Boolean = alteration !== null && alteration.isExpiration;
         components.lbl_expiration.visible = isExpiration;
         components.tx_expiration.visible = isExpiration;
         if(isExpiration)
         {
            if(!alteration.hasExpired && alteration.expirationType === AlterationExpirationTypeEnum.ALTERATION_DATE)
            {
               this._previewedAlterationsExpirationRefreshMap[alteration.id] = alteration;
               if(alteration.expiration < this._currentLowestExpiration)
               {
                  this._currentLowestExpiration = alteration.expiration;
               }
            }
            expirationText = AlterationUtils.getAlterationExpirationText(alteration,true);
            expirationIconUri = AlterationUtils.getAlterationExpirationIconUri(alteration);
            filter = new GlowFilter(this.sysApi.getConfigEntry("colors.text.glow.dark"),1,3,3,15,BitmapFilterQuality.HIGH);
            if(expirationText)
            {
               components.lbl_expiration.text = expirationText;
               components.lbl_expiration.filters = [filter];
               components.lbl_expiration.fullWidthAndHeight();
            }
            else
            {
               components.lbl_expiration.visible = false;
            }
            me = this.uiApi.me();
            isExpirationIconUri = Boolean(expirationIconUri);
            if(isExpirationIconUri)
            {
               components.tx_expiration.uri = expirationIconUri;
               components.tx_expiration.filters = [filter];
               components.tx_expiration.finalize();
            }
            else
            {
               components.tx_expiration.visible = false;
            }
            iconOffsetX = Number(me.getConstant("previewedAlterationsGridExpirationIconOffsetX"));
            if(isNaN(iconOffsetX))
            {
               iconOffsetX = 0;
            }
            iconOffsetY = Number(me.getConstant("previewedAlterationsGridExpirationIconOffsetY"));
            if(isNaN(iconOffsetY))
            {
               iconOffsetY = 0;
            }
            containerWidth = 0;
            if(expirationText)
            {
               containerWidth += components.lbl_expiration.width;
            }
            if(isExpirationIconUri)
            {
               containerWidth += iconOffsetX + components.tx_expiration.width;
            }
            if(expirationText)
            {
               components.lbl_expiration.x = components.slot_alteration.x + components.slot_alteration.width / 2 - containerWidth / 2;
            }
            if(isExpirationIconUri)
            {
               components.tx_expiration.y = components.lbl_expiration.y + iconOffsetY;
               if(expirationText)
               {
                  components.tx_expiration.x = components.lbl_expiration.x + components.lbl_expiration.width + iconOffsetX;
               }
               else
               {
                  components.tx_expiration.x = components.slot_alteration.x + components.slot_alteration.width / 2 - containerWidth / 2;
               }
            }
         }
         components.tx_favorite.visible = alteration !== null && alteration.isFavorite;
         if(alteration !== null)
         {
            this.uiApi.addComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OUT);
            this._componentsData[components.slot_alteration.name] = alteration;
            this.uiApi.addComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OUT);
            this._componentsData[components.tx_expiration.name] = alteration;
         }
         else
         {
            this.uiApi.removeComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OUT);
            delete this._componentsData[components.slot_alteration.name];
            this.uiApi.removeComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OUT);
            delete this._componentsData[components.tx_expiration.name];
         }
      }
      
      public function updateAlterationLine(alteration:AlterationWrapper, components:Object, isSelected:Boolean) : void
      {
         var expirationText:String = null;
         var expirationIconUri:Uri = null;
         var me:UiRootContainer = null;
         var isExpirationIconUri:Boolean = false;
         var positionX:Number = NaN;
         var positionY:Number = NaN;
         var iconOffsetX:Number = NaN;
         var iconOffsetY:Number = NaN;
         var containerWidth:Number = NaN;
         if(alteration === null)
         {
            components.ctr_lineContent.visible = false;
            delete this._componentsData[components.btn_favorite.name];
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OUT);
            this._componentsData[components.tx_expiration.name] = alteration;
            delete this._componentsData[components.slot_alteration.name];
            return;
         }
         this.uiApi.addComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.tx_expiration,ComponentHookList.ON_ROLL_OUT);
         this._componentsData[components.tx_expiration.name] = alteration;
         components.ctr_lineContent.visible = true;
         components.slot_alteration.data = alteration;
         this.uiApi.addComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.slot_alteration,ComponentHookList.ON_ROLL_OUT);
         this._componentsData[components.slot_alteration.name] = alteration;
         components.lbl_name.text = alteration.name;
         components.lbl_category.text = alteration.parentCategory;
         if(alteration.category !== null)
         {
            components.lbl_category.text += " - ".concat(alteration.category);
         }
         components.lbl_description.text = alteration.description;
         components.lbl_expiration.visible = alteration.isExpiration;
         components.tx_expiration.visible = alteration.isExpiration;
         components.tx_expiredAlteration.visible = alteration.hasExpired;
         if(alteration.isExpiration)
         {
            if(!alteration.hasExpired && alteration.expirationType === AlterationExpirationTypeEnum.ALTERATION_DATE)
            {
               this._alterationExpirationRefreshMap[alteration.id] = alteration;
               if(alteration.expiration < this._currentLowestExpiration)
               {
                  this._currentLowestExpiration = alteration.expiration;
               }
            }
            expirationText = AlterationUtils.getAlterationExpirationText(alteration);
            expirationIconUri = AlterationUtils.getAlterationExpirationIconUri(alteration);
            if(expirationText)
            {
               components.lbl_expiration.text = expirationText;
               components.lbl_expiration.fullWidthAndHeight();
            }
            else
            {
               components.lbl_expiration.visible = false;
            }
            me = this.uiApi.me();
            isExpirationIconUri = Boolean(expirationIconUri);
            if(isExpirationIconUri)
            {
               components.tx_expiration.uri = expirationIconUri;
               components.tx_expiration.finalize();
            }
            else
            {
               components.tx_expiration.visible = false;
            }
            positionX = Number(me.getConstant("alterationGridExpirationPositionX"));
            positionY = Number(me.getConstant("alterationGridExpirationPositionY"));
            if(isNaN(positionX))
            {
               positionX = 0;
            }
            if(isNaN(positionY))
            {
               positionY = 0;
            }
            iconOffsetX = Number(me.getConstant("alterationGridExpirationIconOffsetX"));
            if(isNaN(iconOffsetX))
            {
               iconOffsetX = 0;
            }
            iconOffsetY = Number(me.getConstant("alterationGridExpirationIconOffsetY"));
            if(isNaN(iconOffsetY))
            {
               iconOffsetY = 0;
            }
            containerWidth = 0;
            if(expirationText)
            {
               containerWidth += components.lbl_expiration.width;
            }
            if(isExpirationIconUri)
            {
               containerWidth += iconOffsetX + components.tx_expiration.width;
            }
            if(expirationText)
            {
               components.lbl_expiration.x = positionX + this.btn_sortByExpirations.width / 2 - containerWidth / 2;
            }
            components.lbl_expiration.y = positionY;
            if(isExpirationIconUri)
            {
               components.tx_expiration.y = components.lbl_expiration.y + iconOffsetY;
               if(expirationText)
               {
                  components.tx_expiration.x = components.lbl_expiration.x + components.lbl_expiration.width + iconOffsetX;
               }
               else
               {
                  components.tx_expiration.x = positionX + this.btn_sortByExpirations.width / 2 - containerWidth / 2;
               }
            }
         }
         var uriPath:String = this.uiApi.me().getConstant("texture").concat("star").concat(int(alteration.isFavorite)).concat(".png");
         components.tx_favorite.uri = this.uiApi.createUri(uriPath);
         components.tx_favorite.finalize();
         this._componentsData[components.btn_favorite.name] = alteration;
         if(alteration.hasExpired)
         {
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OUT);
            components.btn_favorite.softDisabled = true;
            components.btn_favorite.useHandCursor = false;
         }
         else
         {
            this.uiApi.addComponentHook(components.btn_favorite,ComponentHookList.ON_RELEASE);
            components.btn_favorite.softDisabled = false;
            components.btn_favorite.useHandCursor = true;
            if(!alteration.isFavorite && this._favoriteCount >= AlterationWrapper.MAX_FAVORITE_COUNT)
            {
               this.uiApi.addComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(components.btn_favorite,ComponentHookList.ON_ROLL_OUT);
            }
         }
      }
      
      public function unload() : void
      {
         this.destroyExpirationTimer();
      }
      
      private function startExpirationTimer(delay:Number) : void
      {
         if(delay < 0)
         {
            return;
         }
         if(this._expirationTimer !== null)
         {
            this.destroyExpirationTimer();
         }
         this._expirationTimer = new BenchmarkTimer(delay,0,"AlterationsUi._expirationTimer");
         this._expirationTimer.addEventListener(TimerEvent.TIMER,this.onExpirationTimer);
         this._expirationTimer.start();
      }
      
      private function destroyExpirationTimer() : void
      {
         if(this._expirationTimer === null)
         {
            return;
         }
         this._expirationTimer.stop();
         this._expirationTimer.removeEventListener(TimerEvent.TIMER,this.onExpirationTimer);
         this._expirationTimer = null;
      }
      
      private function updatePreviewedAlterationGridData() : void
      {
         var alteration:AlterationWrapper = null;
         var tmp:Vector.<AlterationWrapper> = this._alterations.concat();
         tmp.sort(AlterationUtils.sortAlterationsByFavorites);
         var previewedAlterations:Vector.<AlterationWrapper> = new Vector.<AlterationWrapper>(0);
         var i:uint = 0;
         while(i < tmp.length && previewedAlterations.length < MAX_PREVIEWED_ALTERATIONS)
         {
            alteration = tmp[i++];
            if(!alteration.hasExpired)
            {
               previewedAlterations.push(alteration);
            }
         }
         previewedAlterations.sort(AlterationUtils.sortPreviewedAlterations);
         while(previewedAlterations.length < MAX_PREVIEWED_ALTERATIONS)
         {
            previewedAlterations.insertAt(0,null);
         }
         previewedAlterations.sort(AlterationUtils.sortPreviewedAlterations);
         this._previewedAlterationsExpirationRefreshMap = new Dictionary();
         this.gd_previewedAlterations.dataProvider = previewedAlterations;
      }
      
      private function updateAlterationGridData(data:Vector.<AlterationWrapper>) : void
      {
         this._alterationExpirationRefreshMap = new Dictionary();
         this.gd_alterations.dataProvider = data;
      }
      
      private function setAlterationSortProcessors() : void
      {
         this._alterationSortProcessors = new Dictionary();
         this._alterationSortProcessors[ALTERATION_FAVORITES_SORT] = new AlterationSortProcessor(ALTERATION_FAVORITES_SORT,AlterationUtils.sortAlterationsByFavorites);
         this._alterationSortProcessors[ALTERATION_CREATION_TIMES_SORT] = new AlterationSortProcessor(ALTERATION_CREATION_TIMES_SORT,AlterationUtils.sortAlterationsByCreationTimes);
         this._alterationSortProcessors[ALTERATION_IDS_SORT] = new AlterationSortProcessor(ALTERATION_IDS_SORT,AlterationUtils.sortAlterationsByIds);
         this._alterationSortProcessors[ALTERATION_NAMES_SORT] = new AlterationSortProcessor(ALTERATION_NAMES_SORT,AlterationUtils.sortAlterationsByNames);
         this._alterationSortProcessors[ALTERATION_CATEGORIES_SORT] = new AlterationSortProcessor(ALTERATION_CATEGORIES_SORT,AlterationUtils.sortAlterationsByCategories);
         this._alterationSortProcessors[ALTERATION_DESCRIPTIONS_SORT] = new AlterationSortProcessor(ALTERATION_DESCRIPTIONS_SORT,AlterationUtils.sortAlterationsByDescriptions);
         this._alterationSortProcessors[ALTERATION_TIMES_LEFT_SORT] = new AlterationSortProcessor(ALTERATION_TIMES_LEFT_SORT,AlterationUtils.sortAlterationsByExpirations);
         this._alterationSortProcessors[ALTERATION_FAVORITES_SORT].isAscending = true;
         this._alterationSortProcessors[ALTERATION_NAMES_SORT].isAscending = false;
         this._alterationSortProcessors[ALTERATION_CATEGORIES_SORT].isAscending = false;
         this._isNameSort = false;
      }
      
      private function refreshSort(prioritizedSort:uint = 4.294967295E9) : void
      {
         var index:Number = NaN;
         var isNewPrioritizedSort:* = prioritizedSort !== uint.MAX_VALUE;
         if(isNewPrioritizedSort)
         {
            this._currentAlterationsSortOrder = DEFAULT_ALTERATION_SORT_ORDER.concat();
            index = this._currentAlterationsSortOrder.indexOf(prioritizedSort);
            if(index === -1)
            {
               _log.warn("Trying to apply sort with unknown sort function. Aborting.");
               return;
            }
            this._currentAlterationsSortOrder.removeAt(index);
            this._currentAlterationsSortOrder.insertAt(0,prioritizedSort);
         }
         else
         {
            prioritizedSort = this._currentAlterationsSortOrder[0];
         }
         var processor:AlterationSortProcessor = this._alterationSortProcessors[prioritizedSort];
         if(isNewPrioritizedSort)
         {
            processor.toggleAscendingOrder();
         }
         switch(prioritizedSort)
         {
            case ALTERATION_FAVORITES_SORT:
               this.refreshSortIcons(this.tx_sortByFavoritesDown,this.tx_sortByFavoritesUp,processor.isAscending);
               break;
            case ALTERATION_NAMES_SORT:
               this.refreshSortIcons(this.tx_sortByNamesOrCategoriesDown,this.tx_sortByNamesOrCategoriesUp,processor.isAscending);
               break;
            case ALTERATION_CATEGORIES_SORT:
               this.refreshSortIcons(this.tx_sortByNamesOrCategoriesDown,this.tx_sortByNamesOrCategoriesUp,processor.isAscending);
               break;
            case ALTERATION_DESCRIPTIONS_SORT:
               this.refreshSortIcons(this.tx_sortByDescriptionsDown,this.tx_sortByDescriptionsUp,processor.isAscending);
               break;
            case ALTERATION_TIMES_LEFT_SORT:
               this.refreshSortIcons(this.tx_sortByExpirationsDown,this.tx_sortByExpirationsUp,processor.isAscending);
               break;
            default:
               this.resetSortIcons();
         }
         this.applyAlterationsSort();
      }
      
      private function refreshFavoritesHeader() : void
      {
         this.lbl_headerFavorites.text = this.uiApi.getText("ui.alteration.favoritesLabel",this._favoriteCount,AlterationWrapper.MAX_FAVORITE_COUNT);
         this.lbl_headerFavorites.fullWidth();
      }
      
      private function refreshAlterationUiElements() : void
      {
         var alteration:AlterationWrapper = null;
         this._filteredAlterations = null;
         this._alterationParentCategoryFilters = new <String>[this._allAlterationParentCategoriesFilter];
         this._favoriteCount = 0;
         for each(alteration in this._alterations)
         {
            if(alteration.parentCategory && this._alterationParentCategoryFilters.indexOf(alteration.parentCategory) === -1)
            {
               this._alterationParentCategoryFilters.push(alteration.parentCategory);
            }
            if(alteration.isFavorite)
            {
               ++this._favoriteCount;
            }
         }
         this.refreshFavoritesHeader();
         this.cb_alterationParentCategory.dataProvider = this._alterationParentCategoryFilters;
         this.ctr_cb_alterationParentCategory.visible = this._alterationParentCategoryFilters.length > 1;
         if(this.cb_alterationParentCategory.dataProvider.indexOf(this._currentAlterationParentCategoryFilter) === -1)
         {
            this.cb_alterationParentCategory.selectedIndex = 0;
            this._currentAlterationParentCategoryFilter = this.cb_alterationParentCategory.selectedItem as String;
         }
         this._currentLowestExpiration = Number.MAX_VALUE;
         this.updatePreviewedAlterationGridData();
         this._alterationExpirationRefreshMap = new Dictionary();
         if(this._currentLowestExpiration !== Number.MAX_VALUE)
         {
            this.startExpirationTimer(ALTERATION_REFRESH_DELAY);
         }
         this.applyFilterPipeline();
      }
      
      private function setAlterationData(alterations:Vector.<AlterationWrapper>) : void
      {
         this._alterations = alterations;
         this._filteredAlterations = null;
         this.updatePreviewedAlterationGridData();
      }
      
      protected function applyAlterationsSort() : void
      {
         if(this._filteredAlterations === null)
         {
            this._filteredAlterations = this._alterations.concat();
         }
         this._filteredAlterations.sort(this.sortAlterations);
         this.updateAlterationGridData(this._filteredAlterations);
      }
      
      private function sortAlterations(w1:AlterationWrapper, w2:AlterationWrapper) : Number
      {
         var sortId:uint = 0;
         var processor:AlterationSortProcessor = null;
         var sortResult:Number = NaN;
         for each(sortId in this._currentAlterationsSortOrder)
         {
            processor = this._alterationSortProcessors[sortId];
            sortResult = processor.sort(w1,w2);
            if(sortResult !== 0)
            {
               return sortResult;
            }
         }
         return 0;
      }
      
      private function resetSortIcons() : void
      {
         this.tx_sortByNamesOrCategoriesDown.visible = false;
         this.tx_sortByNamesOrCategoriesUp.visible = false;
         this.tx_sortByDescriptionsDown.visible = false;
         this.tx_sortByDescriptionsUp.visible = false;
         this.tx_sortByExpirationsDown.visible = false;
         this.tx_sortByExpirationsUp.visible = false;
         this.tx_sortByFavoritesDown.visible = false;
         this.tx_sortByFavoritesUp.visible = false;
      }
      
      private function refreshSortIcons(sortAscTex:Texture, sortDescTex:Texture, isAscending:Boolean) : void
      {
         this.resetSortIcons();
         var sortTexture:Texture = !!isAscending ? sortAscTex : sortDescTex;
         sortTexture.visible = true;
      }
      
      private function handleSearchInput() : void
      {
         if(!this._isSearchInputReady || this._isSearchPlaceholderReset)
         {
            this._isSearchPlaceholderReset = false;
            return;
         }
         var searchText:String = this.inp_alterationsSearch.lastTextOnInput;
         if(searchText === this._searchAlterationsPlaceholderText)
         {
            searchText = "";
         }
         this.btn_clearSearchText.visible = Boolean(searchText);
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
            this.applyFilterPipeline(false);
         }
      }
      
      private function setFilters() : void
      {
         this._filteredAlterations = null;
         this._currentSearchText = null;
         this._currentAlterationParentCategoryFilter = this.cb_alterationParentCategory.dataProvider.length > 0 ? this.cb_alterationParentCategory.dataProvider[0] : null;
         this._currentAlterationCategoryFilter = this.cb_alterationCategory.dataProvider.length > 0 ? this.cb_alterationCategory.dataProvider[0] : null;
         this.cb_alterationParentCategory.selectedIndex = 0;
         this.cb_alterationCategory.selectedIndex = 0;
         this.resetSearchBar(false);
         this._alterationCategoryFilters = null;
         this.ctr_cb_alterationCategory.visible = false;
      }
      
      private function applySearchFilter(isUpdateDataProvider:Boolean = false) : void
      {
         if(!this._currentSearchText)
         {
            return;
         }
         this.btn_clearSearchText.visible = true;
         if(this._filteredAlterations === null)
         {
            this._filteredAlterations = this._alterations.concat();
         }
         this._filteredAlterations = this.utilApi.filter(this._filteredAlterations,this._currentSearchText,"name") as Vector.<AlterationWrapper>;
         if(isUpdateDataProvider)
         {
            this.updateAlterationGridData(this._filteredAlterations);
         }
      }
      
      private function updateSearchBar() : void
      {
         this._isSearchInputReady = true;
         if(!this.inp_alterationsSearch.text)
         {
            this._isSearchInputFilled = false;
         }
         if(this._isSearchInputFilled || this.inp_alterationsSearch.text === this._searchAlterationsPlaceholderText)
         {
            return;
         }
         this.updateSearchPlaceholder();
      }
      
      private function updateSearchPlaceholder(isPlaceholder:Boolean = true) : void
      {
         this.inp_alterationsSearch.placeholderText = this._searchAlterationsPlaceholderText;
         this._isSearchPlaceholderReset = true;
         if(isPlaceholder)
         {
            this._currentSearchText = null;
            this.inp_alterationsSearch.text = this._searchAlterationsPlaceholderText;
         }
         else
         {
            this.inp_alterationsSearch.text = "";
         }
      }
      
      private function handleSearchClick() : void
      {
         if(!this._isSearchInputFilled)
         {
            this.updateSearchPlaceholder(false);
         }
      }
      
      private function resetSearchBar(isReapplyFilterPipeline:Boolean = true) : void
      {
         this.btn_clearSearchText.visible = false;
         this._isSearchInputReady = false;
         this._isSearchInputFilled = false;
         this.updateSearchPlaceholder();
         if(isReapplyFilterPipeline)
         {
            this.applyFilterPipeline(false);
         }
      }
      
      private function applyFilterPipeline(isGenerateCategoryFilterCombobox:Boolean = true) : void
      {
         this._filteredAlterations = this._alterations.concat();
         this.applySearchFilter(false);
         this.applyAlterationParentCategoryFilter(isGenerateCategoryFilterCombobox);
         this.applyAlterationCategoryFilter();
         this.refreshSort();
      }
      
      protected function updateParentCategoryFilter(categoryFilter:String) : void
      {
         var oldValue:String = this._currentAlterationParentCategoryFilter;
         this._currentAlterationParentCategoryFilter = categoryFilter;
         if(oldValue === this._currentAlterationParentCategoryFilter)
         {
            return;
         }
         this.applyFilterPipeline();
      }
      
      private function applyAlterationParentCategoryFilter(isGenerateSubFilterCombobox:Boolean = true) : void
      {
         var alteration:AlterationWrapper = null;
         if(isGenerateSubFilterCombobox)
         {
            this._alterationCategoryFilters = new <String>[this._allAlterationCategoriesFilter];
         }
         if(this._currentAlterationParentCategoryFilter === null || this._currentAlterationParentCategoryFilter === this._allAlterationParentCategoriesFilter)
         {
            if(isGenerateSubFilterCombobox)
            {
               this.ctr_cb_alterationCategory.visible = false;
               this._currentAlterationCategoryFilter = this._allAlterationCategoriesFilter;
            }
            return;
         }
         var index:uint = 0;
         while(index < this._filteredAlterations.length)
         {
            alteration = this._filteredAlterations[index];
            if(alteration.parentCategory !== this._currentAlterationParentCategoryFilter)
            {
               this._filteredAlterations.removeAt(index);
            }
            else
            {
               index++;
               if(isGenerateSubFilterCombobox && alteration.category && this._alterationCategoryFilters.indexOf(alteration.category) === -1)
               {
                  this._alterationCategoryFilters.push(alteration.category);
               }
            }
         }
         if(isGenerateSubFilterCombobox)
         {
            this.ctr_cb_alterationCategory.visible = this._alterationCategoryFilters.length > 1;
            this.cb_alterationCategory.dataProvider = this._alterationCategoryFilters;
            this.cb_alterationCategory.selectedIndex = 0;
            this._currentAlterationCategoryFilter = this.cb_alterationCategory.selectedItem as String;
         }
      }
      
      private function applyAlterationCategoryFilter() : void
      {
         var alteration:AlterationWrapper = null;
         if(this._currentAlterationCategoryFilter === null || this._currentAlterationCategoryFilter === this._allAlterationCategoriesFilter)
         {
            return;
         }
         var index:uint = 0;
         while(index < this._filteredAlterations.length)
         {
            alteration = this._filteredAlterations[index];
            if(alteration.category !== this._currentAlterationCategoryFilter)
            {
               this._filteredAlterations.removeAt(index);
            }
            else
            {
               index++;
            }
         }
      }
      
      protected function updateCategoryFilter(categoryFilter:String) : void
      {
         var oldValue:String = this._currentAlterationCategoryFilter;
         this._currentAlterationCategoryFilter = categoryFilter;
         if(oldValue === this._currentAlterationCategoryFilter)
         {
            return;
         }
         this.applyFilterPipeline(false);
      }
      
      private function updateRefreshTable(relatedGrid:Grid, relatedRefreshMap:Dictionary) : void
      {
         var gridItem:GridItem = null;
         var alteration:AlterationWrapper = null;
         for each(gridItem in relatedGrid.items)
         {
            alteration = gridItem.data as AlterationWrapper;
            if(alteration !== null)
            {
               if(alteration.expiration < this._currentLowestExpiration)
               {
                  this._currentLowestExpiration = alteration.expiration;
               }
               if(alteration.id in relatedRefreshMap)
               {
                  (gridItem.container.parent as Grid).updateItem(gridItem.index);
                  if(alteration.hasExpired)
                  {
                     delete relatedRefreshMap[alteration.id];
                  }
               }
            }
         }
      }
      
      private function onAlterations(descr:AlterationsDescr) : void
      {
         this._alterations = descr.alterations.concat();
         this.refreshAlterationUiElements();
      }
      
      private function onAlterationAdded(addedAlteration:AlterationWrapper) : void
      {
         var alteration:AlterationWrapper = null;
         var i:uint = 0;
         var alterationIndex:Number = Number.NaN;
         for each(alteration in this._alterations)
         {
            if(alteration.id === addedAlteration.id)
            {
               alterationIndex = i;
               break;
            }
            i++;
         }
         if(isNaN(alterationIndex))
         {
            this._alterations.push(addedAlteration.clone());
         }
         else
         {
            this._alterations[alterationIndex] = addedAlteration;
         }
         this.refreshAlterationUiElements();
      }
      
      private function onAlterationRemoved(removedAlteration:AlterationWrapper) : void
      {
         var alteration:AlterationWrapper = null;
         var index:Number = -1;
         var isExpiration:Boolean = false;
         var areNonExpiratedAlterationsLeft:Boolean = false;
         for(var i:Number = 0; i < this._alterations.length; i++)
         {
            alteration = this._alterations[i];
            if(alteration.id === removedAlteration.id)
            {
               if(alteration.hasExpired)
               {
                  isExpiration = true;
                  break;
               }
               areNonExpiratedAlterationsLeft = true;
               index = i;
               break;
            }
         }
         if(!areNonExpiratedAlterationsLeft)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         if(index === -1)
         {
            if(isExpiration)
            {
               this.updatePreviewedAlterationGridData();
            }
            return;
         }
         this._alterations.removeAt(index);
         this.refreshAlterationUiElements();
      }
      
      private function onAlterationsUpdated(alterations:Vector.<AlterationWrapper>) : void
      {
         var updatedAlteration:AlterationWrapper = null;
         var isUpdate:Boolean = false;
         var i:Number = 0;
         var alteration:AlterationWrapper = null;
         for each(updatedAlteration in alterations)
         {
            for(i = 0; i < this._alterations.length; i++)
            {
               alteration = this._alterations[i];
               if(alteration !== null)
               {
                  if(alteration.id === updatedAlteration.id)
                  {
                     this._alterations[i] = updatedAlteration.clone();
                     isUpdate = true;
                     break;
                  }
               }
            }
         }
         if(!isUpdate)
         {
            return;
         }
         this.refreshAlterationUiElements();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(!(target is Slot))
         {
            return;
         }
         var slot:Slot = target as Slot;
         if(!(slot.data is AlterationWrapper))
         {
            return;
         }
         var contextMenu:ContextMenuData = this.menuApi.create(slot.data as AlterationWrapper,"alteration",null);
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         if(shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var point:uint = 0;
         var relativePoint:uint = 0;
         var text:String = null;
         var alteration:AlterationWrapper = this._componentsData[target.name];
         if(target.name.indexOf("slot_alteration_m_gd_previewedAlterations") !== -1)
         {
            point = LocationEnum.POINT_TOPLEFT;
            relativePoint = LocationEnum.POINT_TOPRIGHT;
         }
         else
         {
            if(target.name.indexOf("slot_alteration_m_gd_alterations") === -1)
            {
               if(target.name.indexOf("tx_expiration") !== -1)
               {
                  if(alteration === null)
                  {
                     return;
                  }
                  if(alteration.sourceType === AlterationSourceTypeEnum.ITEM && alteration.parentCategoryId === DataEnum.ITEM_TYPE_ROLEPLAY_BUFF)
                  {
                     text = this.uiApi.getText("ui.common.lostWhenFightStarts");
                  }
                  else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHT_COUNT)
                  {
                     text = this.uiApi.processText(this.uiApi.getText("ui.common.fightsLeft"),"m",alteration.expiration == 1);
                  }
                  else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHTS_WON_COUNT)
                  {
                     text = this.uiApi.processText(this.uiApi.getText("ui.common.victoriesLeft"),"m",alteration.expiration == 1);
                  }
                  else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHTS_LOST_COUNT)
                  {
                     text = this.uiApi.processText(this.uiApi.getText("ui.common.lossesLeft"),"m",alteration.expiration == 1);
                  }
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,UI_TOOLTIP_NAME,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,null,"TextInfo");
                  return;
               }
               if(target.name.indexOf("btn_favorite") !== -1)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.alteration.favoriteMaxCountWarning",AlterationWrapper.MAX_FAVORITE_COUNT)),target,false,UI_TOOLTIP_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
                  return;
               }
               return;
            }
            point = LocationEnum.POINT_LEFT;
            relativePoint = LocationEnum.POINT_RIGHT;
         }
         if(alteration === null)
         {
            return;
         }
         this.uiApi.showTooltip(alteration,target,false,UI_TOOLTIP_NAME,point,relativePoint,3,"alteration",null,null);
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var offset:Number = NaN;
         var alteration:AlterationWrapper = null;
         this.updateSearchBar();
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_sortByNamesOrCategories:
               offset = Number(this.uiApi.me().getConstant("sortByNamesOrCategoriesIconOffset"));
               if(isNaN(offset))
               {
                  offset = 0;
               }
               if(this._isNameSort && !this._alterationSortProcessors[ALTERATION_NAMES_SORT].isAscending)
               {
                  this._isNameSort = false;
                  this._alterationSortProcessors[ALTERATION_NAMES_SORT].isAscending = false;
                  this.lbl_headerNameOrCategory.text = this.uiApi.getText("ui.alteration.category");
                  this.lbl_headerNameOrCategory.fullWidth();
                  this.tx_sortByNamesOrCategoriesDown.x = this.lbl_headerNameOrCategory.x + this.lbl_headerNameOrCategory.width + offset;
                  this.tx_sortByNamesOrCategoriesUp.x = this.lbl_headerNameOrCategory.x + this.lbl_headerNameOrCategory.width + offset;
               }
               else if(!this._isNameSort && !this._alterationSortProcessors[ALTERATION_CATEGORIES_SORT].isAscending)
               {
                  this._isNameSort = true;
                  this._alterationSortProcessors[ALTERATION_CATEGORIES_SORT].isAscending = false;
                  this.lbl_headerNameOrCategory.text = this.uiApi.getText("ui.common.name");
                  this.lbl_headerNameOrCategory.fullWidth();
                  this.tx_sortByNamesOrCategoriesDown.x = this.lbl_headerNameOrCategory.x + this.lbl_headerNameOrCategory.width + offset;
                  this.tx_sortByNamesOrCategoriesUp.x = this.lbl_headerNameOrCategory.x + this.lbl_headerNameOrCategory.width + offset;
               }
               if(this._isNameSort)
               {
                  this.refreshSort(ALTERATION_NAMES_SORT);
               }
               else
               {
                  this.refreshSort(ALTERATION_CATEGORIES_SORT);
               }
               return;
            case this.btn_sortByDescriptions:
               this.refreshSort(ALTERATION_DESCRIPTIONS_SORT);
               return;
            case this.btn_sortByExpirations:
               this.refreshSort(ALTERATION_TIMES_LEFT_SORT);
               return;
            case this.btn_sortByFavorites:
               this.refreshSort(ALTERATION_FAVORITES_SORT);
               return;
            case this.inp_alterationsSearch:
               this.handleSearchClick();
               return;
            case this.btn_clearSearchText:
               this.resetSearchBar();
               return;
         }
         if(target.name.indexOf("btn_favorite") !== -1)
         {
            alteration = this._componentsData[target.name];
            if(alteration === null)
            {
               return;
            }
            if(!alteration.isFavorite && this._favoriteCount >= AlterationWrapper.MAX_FAVORITE_COUNT)
            {
               return;
            }
            this.sysApi.sendAction(UpdateAlterationFavoriteFlagAction.create(alteration.id,!alteration.isFavorite));
         }
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.inp_alterationsSearch:
               this.handleSearchInput();
               return;
            default:
               return;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_alterationParentCategory:
               this.updateParentCategoryFilter(this.cb_alterationParentCategory.selectedItem as String);
               break;
            case this.cb_alterationCategory:
               this.updateCategoryFilter(this.cb_alterationCategory.selectedItem as String);
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:GridItem) : void
      {
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
      }
      
      private function onExpirationTimer(event:TimerEvent) : void
      {
         this._currentLowestExpiration = Number.MAX_VALUE;
         this.updateRefreshTable(this.gd_previewedAlterations,this._previewedAlterationsExpirationRefreshMap);
         this.updateRefreshTable(this.gd_alterations,this._alterationExpirationRefreshMap);
         if(this._currentLowestExpiration === Number.MAX_VALUE)
         {
            this.destroyExpirationTimer();
            return;
         }
         this.startExpirationTimer(ALTERATION_REFRESH_DELAY);
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;

class AlterationSortProcessor
{
    
   
   public var isAscending:Boolean = false;
   
   private var _id:uint = 4.294967295E9;
   
   private var _sortFunc:Function = null;
   
   function AlterationSortProcessor(id:uint, sortFunc:Function)
   {
      super();
      this._id = id;
      this._sortFunc = sortFunc;
   }
   
   public function get id() : uint
   {
      return this._id;
   }
   
   public function toggleAscendingOrder() : void
   {
      this.isAscending = !this.isAscending;
   }
   
   public function sort(w1:AlterationWrapper, w2:AlterationWrapper) : Number
   {
      return this._sortFunc(w1,w2) * (!!this.isAscending ? 1 : -1);
   }
}
