package Ankama_Common.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class FeedUi
   {
      
      private static const EXCEPTION_FEED_ITEM:Array = [2239,12007,12008];
      
      private static const TYPE_TO_FEED_LIVING_OBJECT:int = 1;
      
      private static const TYPE_TO_FEED_MOUNT:int = 2;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _foodList:Object;
      
      private var _typeToFeed:int = 0;
      
      private var _item:ItemWrapper;
      
      private var _mountId:int;
      
      private var _mountFamilyId:int;
      
      private var _mountLocation:int;
      
      private var _feeding:int;
      
      public var btn_closeFeed:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_feedOk:ButtonContainer;
      
      public var grid_food:Grid;
      
      public var lbl_selectItem:Label;
      
      public var ctr_quantity:GraphicContainer;
      
      public var inp_quantity:Input;
      
      public var btn_min:ButtonContainer;
      
      public var btn_max:ButtonContainer;
      
      public var lbl_quantity:Label;
      
      public var icon_quantity:Texture;
      
      public var tx_icon_ctr_window:Texture;
      
      public function FeedUi()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.btn_closeFeed.soundId = SoundEnum.WINDOW_CLOSE;
         this.sysApi.addHook(InventoryHookList.ObjectQuantity,this.onObjectQuantity);
         this.sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         this.uiApi.addComponentHook(this.btn_feedOk,"onRelease");
         this.uiApi.addComponentHook(this.btn_feedOk,"onRollOver");
         this.uiApi.addComponentHook(this.btn_feedOk,"onRollOut");
         this.uiApi.addComponentHook(this.grid_food,"onSelectItem");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onValidUi);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.ctr_quantity.visible = false;
         this.inp_quantity.text = "" + Common.getInstance().lastFoodQuantity;
         this._typeToFeed = param.type;
         if(this._typeToFeed == TYPE_TO_FEED_MOUNT)
         {
            this._mountId = param.mountId;
            this._mountFamilyId = param.mountFamilyId;
            this._mountLocation = param.mountLocation;
            this._foodList = param.foodList;
            if(this.storageApi.getFakeItemMount())
            {
               this.tx_icon_ctr_window.uri = this.storageApi.getFakeItemMount().iconUri;
            }
            else
            {
               this.tx_icon_ctr_window.visible = false;
            }
         }
         else
         {
            this._item = param.item;
            this.tx_icon_ctr_window.uri = this._item.iconUri;
            this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
            this.inp_quantity.text = "1";
         }
         if(this._foodList && this._foodList.length)
         {
            this.grid_food.dataProvider = this._foodList;
            this.btn_feedOk.softDisabled = true;
            this.grid_food.selectedIndex = -1;
         }
         else
         {
            this.grid_food.dataProvider = new Array();
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.item.errorNoFoodLivingItem",this._item.name),[this.uiApi.getText("ui.common.ok")],[this.uiApi.unloadUi(this.uiApi.me().name)]);
         }
         if(this.icon_quantity && this.lbl_quantity)
         {
            this.icon_quantity.x = this.lbl_quantity.x + this.lbl_quantity.textWidth + 8;
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi("itemBoxFood");
      }
      
      private function onConfirmFeed(qty:Number = 1) : void
      {
         if(this._typeToFeed == TYPE_TO_FEED_MOUNT)
         {
            qty = this.utilApi.stringToKamas(this.inp_quantity.text,"");
            this.sysApi.sendAction(new MountFeedRequestAction([this._mountId,this._mountLocation,this.grid_food.selectedItem.objectUID,qty]));
         }
         else
         {
            this.sysApi.sendAction(new LivingObjectFeedAction([this._item.objectUID,new <Object>[{
               "objectUID":this.grid_food.selectedItem.objectUID,
               "quantity":qty
            }]]));
         }
         Common.getInstance().lastFoodQuantity = qty;
      }
      
      public function onValidUi(pShortcut:String) : Boolean
      {
         if(this.grid_food.selectedItem && !this.btn_feedOk.softDisabled && (!this.inp_quantity.haveFocus || !this._feeding))
         {
            this._feeding = 1;
            this.onRelease(this.btn_feedOk);
            return true;
         }
         this._feeding = Math.max(0,--this._feeding);
         return false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var qty:int = 0;
         switch(target)
         {
            case this.btn_closeFeed:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_feedOk:
               qty = this.utilApi.stringToKamas(this.inp_quantity.text,"");
               if(this._typeToFeed == TYPE_TO_FEED_LIVING_OBJECT)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.item.confirmFoodLivingItem"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmFeed,null],this.onConfirmFeed);
               }
               else if(this.grid_food.selectedItem.quantity < qty)
               {
                  this.onConfirmFeed(this.grid_food.selectedItem.quantity);
               }
               else
               {
                  this.onConfirmFeed(qty);
               }
               break;
            case this.btn_max:
               if(this.grid_food.selectedIndex > -1)
               {
                  this.inp_quantity.text = this.utilApi.kamasToString(this.grid_food.dataProvider[this.grid_food.selectedIndex].quantity,"");
               }
               break;
            case this.btn_min:
               this.inp_quantity.text = "1";
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target == this.btn_feedOk)
         {
            if(this.grid_food.selectedItem && this.btn_feedOk.softDisabled)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.canNotFeedAnymore")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
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
      
      public function onSelectItem(target:Grid, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.grid_food)
         {
            if(this.grid_food.selectedItem)
            {
               this.lbl_selectItem.visible = false;
               this.btn_feedOk.softDisabled = false;
               this.ctr_quantity.visible = true;
               if(this._typeToFeed == TYPE_TO_FEED_LIVING_OBJECT)
               {
                  this.ctr_quantity.disabled = true;
                  this.btn_min.visible = this.btn_max.visible = false;
                  this.icon_quantity.uri = this.grid_food.selectedItem.iconUri;
                  this.inp_quantity.numberMax = 1;
                  this.inp_quantity.text = "1";
               }
               else
               {
                  this.btn_min.visible = this.btn_max.visible = true;
                  this.icon_quantity.uri = this.grid_food.selectedItem.iconUri;
                  this.inp_quantity.numberMax = this.grid_food.selectedItem.quantity;
                  this.inp_quantity.text = this.utilApi.kamasToString(this.grid_food.selectedItem.quantity,"");
                  this.inp_quantity.focus();
               }
               if(selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
               {
                  this.onConfirmFeed(1);
               }
            }
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:Object = null;
         if(item.data)
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            tooltipData = item.data;
            if(!itemTooltipSettings.header && !itemTooltipSettings.conditions && !itemTooltipSettings.effects && !itemTooltipSettings.description && !itemTooltipSettings.averagePrice)
            {
               tooltipData = item.data;
            }
            this.uiApi.showTooltip(tooltipData,item.container,false,"standard",8,0,0,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int) : void
      {
         if(item && this._foodList)
         {
            if(this._typeToFeed == TYPE_TO_FEED_MOUNT)
            {
               this._foodList = this.storageApi.getRideFoodsFor(this._mountFamilyId);
            }
            else
            {
               this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
            }
            this.inp_quantity.text = this.utilApi.kamasToString(quantity,"");
            this.grid_food.dataProvider = this._foodList;
            if(quantity <= 0)
            {
               this.btn_feedOk.softDisabled = true;
            }
         }
      }
      
      private function onObjectDeleted(item:Object) : void
      {
         if(item && this._foodList)
         {
            if(this._typeToFeed == TYPE_TO_FEED_MOUNT)
            {
               this._foodList = this.storageApi.getRideFoodsFor(this._mountFamilyId);
            }
            else
            {
               this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
            }
            this.grid_food.dataProvider = this._foodList;
            this.btn_feedOk.softDisabled = true;
            if(this._foodList && this._foodList.length)
            {
               this.grid_food.selectedIndex = 0;
               this.inp_quantity.text = "1";
            }
            else
            {
               this.ctr_quantity.visible = false;
               this.uiApi.unloadUi("itemBoxFood");
            }
         }
      }
   }
}
