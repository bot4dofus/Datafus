package Ankama_GameUiCore.ui.alterations
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
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
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.OpenAlterationUiAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.AlterationExpirationTypeEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   
   public class PreviewedAlterationsUi
   {
      
      private static const UI_TOOLTIP_NAME:String = "standard";
      
      private static const MAX_PREVIEWED_ALTERATIONS:uint = 6;
      
      private static const ALTERATION_REFRESH_DELAY:uint = 1000;
       
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var btn_minimArrow:ButtonContainer;
      
      public var ctr_alterations:GraphicContainer;
      
      public var ctr_root:GraphicContainer;
      
      public var gd_previewedAlterations:Grid;
      
      public var tx_background:TextureBitmap;
      
      public var tx_openAlterationsUi:TextureBitmap;
      
      private var _isVisible:Boolean = false;
      
      private var _alterations:Vector.<AlterationWrapper> = null;
      
      private var _previewedAlterations:Vector.<AlterationWrapper> = null;
      
      private var _expirationTimer:BenchmarkTimer = null;
      
      private var _currentLowestExpiration:Number = NaN;
      
      private var _previewedAlterationExpirationRefreshMap:Dictionary = null;
      
      private var _componentsData:Dictionary;
      
      public function PreviewedAlterationsUi()
      {
         this._componentsData = new Dictionary();
         super();
      }
      
      public function main(descr:AlterationsDescr = null) : void
      {
         this.uiApi.addComponentHook(this.tx_openAlterationsUi,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(RoleplayHookList.Alterations,this.onAlterations);
         this.sysApi.addHook(RoleplayHookList.AlterationAdded,this.onAlterationAdded);
         this.sysApi.addHook(RoleplayHookList.AlterationRemoved,this.onAlterationRemoved);
         this.sysApi.addHook(RoleplayHookList.AlterationsUpdated,this.onAlterationsUpdated);
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.setAlterationData(descr.alterations.concat());
      }
      
      public function unload() : void
      {
         this.destroyExpirationTimer();
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
               this._previewedAlterationExpirationRefreshMap[alteration.id] = alteration;
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
            iconOffsetX = Number(me.getConstant("previewedAlterationGridExpirationIconOffsetX"));
            if(isNaN(iconOffsetX))
            {
               iconOffsetX = 0;
            }
            iconOffsetY = Number(me.getConstant("previewedAlterationGridExpirationIconOffsetY"));
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
         var favoriteFilter:GlowFilter = new GlowFilter(this.sysApi.getConfigEntry("colors.text.glow.dark"),1,2,2,4,BitmapFilterQuality.HIGH);
         components.tx_favorite.filters = [favoriteFilter];
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
      
      private function refreshAlterationUiElements() : void
      {
         this.initializeAlterationUiElements();
         this.setAlterationsVisibility(true);
      }
      
      private function setAlterationData(alterations:Vector.<AlterationWrapper>) : void
      {
         this._alterations = alterations;
         this._alterations.sort(AlterationUtils.sortAlterationsByFavorites);
         this._previewedAlterations = this._alterations.slice(0,MAX_PREVIEWED_ALTERATIONS);
         this._previewedAlterations.sort(AlterationUtils.sortPreviewedAlterations);
         this.refreshAlterationUiElements();
      }
      
      private function initializeAlterationUiElements() : void
      {
         this._currentLowestExpiration = Number.MAX_VALUE;
         this._previewedAlterationExpirationRefreshMap = new Dictionary();
         this.gd_previewedAlterations.dataProvider = this._previewedAlterations;
         var me:UiRootContainer = this.uiApi.me();
         this.gd_previewedAlterations.width = this.gd_previewedAlterations.slotWidth * this.gd_previewedAlterations.dataProvider.length + Number(me.getConstant("alterationsIconSizeOffset")) * (this.gd_previewedAlterations.dataProvider.length - 1);
         this.tx_background.width = this.gd_previewedAlterations.width + Number(me.getConstant("backgroundLengthOffset"));
         this.tx_background.x = -this.tx_background.width + Number(me.getConstant("backgroundXOffset"));
         this.gd_previewedAlterations.x = this.tx_background.x + Number(me.getConstant("GdPreviewedAlterationsXOffset"));
         this.gd_previewedAlterations.y = Number(me.getConstant("GdPreviewedAlterationsYOffset"));
         if(this._currentLowestExpiration !== Number.MAX_VALUE)
         {
            this.startExpirationTimer(ALTERATION_REFRESH_DELAY);
         }
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
         if(descr.alterations.length === 0)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         this.setAlterationData(descr.alterations.concat());
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
         this.setAlterationData(this._alterations);
      }
      
      private function onAlterationRemoved(removedAlteration:AlterationWrapper) : void
      {
         var index:Number = -1;
         for(var i:Number = 0; i < this._alterations.length; i++)
         {
            if(this._alterations[i].id === removedAlteration.id)
            {
               index = i;
               break;
            }
         }
         if(index === -1)
         {
            return;
         }
         this._alterations.removeAt(index);
         if(this._alterations.length <= 0)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         this.setAlterationData(this._alterations);
      }
      
      private function onAlterationsUpdated(alterations:Vector.<AlterationWrapper>) : void
      {
         var updatedAlteration:AlterationWrapper = null;
         var i:Number = NaN;
         var isUpdate:Boolean = false;
         for each(updatedAlteration in alterations)
         {
            for(i = 0; i < this._alterations.length; i++)
            {
               if(this._alterations[i].id === updatedAlteration.id)
               {
                  this._alterations[i] = updatedAlteration.clone();
                  isUpdate = true;
                  break;
               }
            }
         }
         if(!isUpdate)
         {
            return;
         }
         this.setAlterationData(this._alterations);
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
      
      public function onRelease(target:Object) : void
      {
         switch(target)
         {
            case this.btn_minimArrow:
               this.setAlterationsVisibility(!this._isVisible);
               break;
            case this.tx_openAlterationsUi:
               if(this.uiApi.getUiByName(UIEnum.ALTERATIONS_UI))
               {
                  return;
               }
               this.sysApi.sendAction(OpenAlterationUiAction.create());
               break;
         }
      }
      
      private function setAlterationsVisibility(isVisible:Boolean) : void
      {
         this._isVisible = isVisible;
         this.ctr_alterations.visible = this._isVisible;
         this.btn_minimArrow.selected = !this._isVisible;
         this.tx_background.visible = this._isVisible;
      }
      
      private function onFoldAll(mustFold:Boolean) : void
      {
         this.setAlterationsVisibility(!mustFold);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target.name.indexOf("slot_alteration") === -1)
         {
            return;
         }
         var alteration:AlterationWrapper = this._componentsData[target.name];
         if(alteration === null)
         {
            return;
         }
         if(target.name.indexOf("tx_expiration") !== -1)
         {
            if(alteration.sourceType === AlterationSourceTypeEnum.ITEM && alteration.parentCategoryId === DataEnum.ITEM_TYPE_ROLEPLAY_BUFF)
            {
               text = this.uiApi.getText("ui.common.lostWhenFightStarts");
            }
            else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHT_COUNT)
            {
               text = this.uiApi.processText(this.uiApi.getText("ui.common.fightsLeft"),"m",alteration.expiration > 1);
            }
            else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHTS_WON_COUNT)
            {
               text = this.uiApi.processText(this.uiApi.getText("ui.common.victoriesLeft"),"m",alteration.expiration > 1);
            }
            else if(alteration.expirationType == AlterationExpirationTypeEnum.ALTERATION_FIGHTS_LOST_COUNT)
            {
               text = this.uiApi.processText(this.uiApi.getText("ui.common.lossesLeft"),"m",alteration.expiration > 1);
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,UI_TOOLTIP_NAME,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,3,null,null,null,"TextInfo");
            return;
         }
         this.uiApi.showTooltip(alteration,target,false,UI_TOOLTIP_NAME,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,3,"alteration",null,null);
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onExpirationTimer(event:TimerEvent) : void
      {
         this._currentLowestExpiration = Number.MAX_VALUE;
         this.updateRefreshTable(this.gd_previewedAlterations,this._previewedAlterationExpirationRefreshMap);
         if(this._currentLowestExpiration === Number.MAX_VALUE)
         {
            this.destroyExpirationTimer();
            return;
         }
         this.startExpirationTimer(ALTERATION_REFRESH_DELAY);
      }
   }
}
