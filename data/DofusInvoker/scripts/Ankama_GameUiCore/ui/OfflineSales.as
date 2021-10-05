package Ankama_GameUiCore.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.sales.OfflineSaleWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class OfflineSales
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var tx_border_footer_gridBlock:TextureBitmap;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var gd_sales:Grid;
      
      public var gd_unsoldItems:Grid;
      
      public var grid_background:TextureBitmap;
      
      public var btn_sortItemIndex:ButtonContainer;
      
      public var lbl_sortItemIndex:Label;
      
      public var btn_sortItemName:ButtonContainer;
      
      public var btn_sortUnsoldItemName:ButtonContainer;
      
      public var lbl_sortItemName:Label;
      
      public var btn_sortItemQuantity:ButtonContainer;
      
      public var lbl_sortItemQuantity:Label;
      
      public var btn_sortItemKamas:ButtonContainer;
      
      public var lbl_sortItemKamas:Label;
      
      public var btn_sortSaleType:ButtonContainer;
      
      public var lbl_sortSaleType:Label;
      
      public var btn_sortSaleDate:ButtonContainer;
      
      public var lbl_sortSaleDate:Label;
      
      public var ctr_totals:GraphicContainer;
      
      public var lbl_total_quantity:Label;
      
      public var lbl_total_sales:Label;
      
      public var lbl_total_kamas:Label;
      
      public var lbl_total_kamas_value:Label;
      
      public var btn_sales:ButtonContainer;
      
      public var btn_unsoldItems:ButtonContainer;
      
      private var _sales:Object;
      
      private var _unsoldItems:Object;
      
      private var _ascendingSort:Boolean;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _lastSortType:String;
      
      private var _salesInit:Boolean;
      
      private var _currentGrid:Grid;
      
      private var _itemsInfo:Dictionary;
      
      public function OfflineSales()
      {
         this._sortFieldAssoc = new Dictionary();
         super();
      }
      
      public function main(pParams:Object) : void
      {
         this.lbl_sortItemIndex.text = this.uiApi.getText("ui.sell.offlineSales.order");
         this.lbl_sortItemName.text = this.uiApi.getText("ui.sell.offlineSales.itemName");
         this.lbl_sortItemQuantity.text = this.uiApi.getText("ui.common.quantity");
         this.lbl_sortItemKamas.text = this.uiApi.getText("ui.common.kamas");
         this.lbl_sortSaleType.text = this.uiApi.getText("ui.sell.offlineSales.saleType");
         this.lbl_sortSaleDate.text = this.uiApi.getText("ui.sell.saleDate");
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this._sortFieldAssoc[this.btn_sortItemIndex] = "index";
         this._sortFieldAssoc[this.btn_sortItemName] = this._sortFieldAssoc[this.btn_sortUnsoldItemName] = "itemName";
         this._sortFieldAssoc[this.btn_sortItemQuantity] = "quantity";
         this._sortFieldAssoc[this.btn_sortItemKamas] = "kamas";
         this._sortFieldAssoc[this.btn_sortSaleType] = "type";
         this._ascendingSort = true;
         this._itemsInfo = new Dictionary();
         this._sales = pParams.sales;
         this._unsoldItems = pParams.unsoldItems;
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onCloseUi);
         if(pParams.tab == 0)
         {
            this.openOfflineSalesTab();
         }
         else if(pParams.tab == 1)
         {
            this.openUnsoldItemsTab();
         }
      }
      
      public function openOfflineSalesTab() : void
      {
         var totalQuantity:uint = 0;
         var totalSales:uint = 0;
         var totalKamas:Number = NaN;
         var offlineSale:Object = null;
         this.btn_sales.selected = true;
         this.gd_unsoldItems.visible = this.btn_sortUnsoldItemName.visible = false;
         this.lbl_sortItemName.width = 275;
         this.lbl_sortItemQuantity.x = this.btn_sortItemQuantity.x = 350;
         this._currentGrid = this.gd_sales;
         this._currentGrid.dataProvider = this._sales;
         this._currentGrid.visible = true;
         this.lbl_sortItemKamas.visible = this.btn_sortItemKamas.visible = this.btn_sortItemName.visible = true;
         this.tx_border_footer_gridBlock.visible = true;
         this.grid_background.height = 314;
         if(!this._salesInit)
         {
            totalSales = this._sales.length;
            totalKamas = 0;
            for each(offlineSale in this._sales)
            {
               totalQuantity += offlineSale.quantity;
               totalKamas += offlineSale.kamas;
            }
            this.lbl_total_quantity.text = this.uiApi.getText("ui.sell.offlineSales.nbSoldItems",totalQuantity);
            this.lbl_total_sales.text = this.uiApi.getText("ui.sell.offlineSales.nbSoldLots",totalSales);
            this.lbl_total_kamas.text = this.uiApi.getText("ui.sell.offlineSales.nbTotalKamas") + this.uiApi.getText("ui.common.colon") + this.utilApi.kamasToString(totalKamas,"");
            this._salesInit = true;
         }
         this.ctr_totals.visible = true;
      }
      
      public function openUnsoldItemsTab() : void
      {
         this.btn_unsoldItems.selected = true;
         this.gd_sales.visible = this.btn_sortItemName.visible = false;
         this.btn_sortUnsoldItemName.visible = true;
         this.lbl_sortItemName.width = 420;
         this.lbl_sortItemQuantity.x = this.btn_sortItemQuantity.x = 495;
         this._currentGrid = this.gd_unsoldItems;
         this._currentGrid.dataProvider = this._unsoldItems;
         this._currentGrid.visible = true;
         this.lbl_sortItemKamas.visible = this.btn_sortItemKamas.visible = false;
         this.ctr_totals.visible = false;
         this.tx_border_footer_gridBlock.visible = false;
         this.grid_background.height = 384;
      }
      
      public function updateSaleLine(offlineSale:OfflineSaleWrapper, components:*, selected:Boolean) : void
      {
         if(offlineSale)
         {
            components.lbl_item_index.text = offlineSale.index;
            if(!offlineSale.effects)
            {
               components.lbl_item_name.text = "{item," + offlineSale.itemId + "::" + offlineSale.itemName + "}";
            }
            else
            {
               components.lbl_item_name.text = offlineSale.itemName;
               this.uiApi.addComponentHook(components.lbl_item_name,"onRelease");
            }
            components.lbl_item_quantity.text = offlineSale.quantity;
            if(this.btn_sales.selected)
            {
               components.lbl_kamas.text = this.utilApi.kamasToString(offlineSale.kamas,"");
               components.tx_kamas.visible = true;
            }
            components.lbl_sale_type.text = offlineSale.type == 1 || offlineSale.type == 3 ? this.uiApi.getText("ui.sell.offlineSales.bidHouse") : this.uiApi.getText("ui.common.shop");
            if(components.lbl_sale_date)
            {
               components.lbl_sale_date.text = this.sysApi.getTimeManager().formatDateIRL(offlineSale.date * 1000);
            }
            this._itemsInfo[components.lbl_item_name.name] = offlineSale;
         }
         else
         {
            components.lbl_item_index.text = "";
            components.lbl_item_name.text = "";
            components.lbl_item_quantity.text = "";
            if(this.btn_sales.selected)
            {
               components.lbl_kamas.text = "";
               components.tx_kamas.visible = false;
            }
            components.lbl_sale_type.text = "";
            if(components.lbl_sale_date)
            {
               components.lbl_sale_date.text = "";
            }
         }
      }
      
      public function onRelease(pTarget:GraphicContainer) : void
      {
         var data:OfflineSaleWrapper = null;
         var itemWrapper:ItemWrapper = null;
         var settings:Object = null;
         var sortType:String = null;
         if(pTarget.name.indexOf("lbl_item_name") > -1 && this._itemsInfo[pTarget.name])
         {
            data = this._itemsInfo[pTarget.name];
            itemWrapper = this.dataApi.getItemWrapper(data.itemId);
            this.dataApi.updateItemWrapperEffects(itemWrapper,data.effects.effects);
            settings = {};
            settings.showEffects = true;
            settings.pinnable = true;
            this.uiApi.showTooltip(itemWrapper,pTarget,false,"standard",0,0,0,"item",null,settings,null,true);
         }
         else
         {
            switch(pTarget)
            {
               case this.btn_close:
                  this.onCloseUi(null);
                  break;
               case this.btn_sortItemIndex:
               case this.btn_sortItemName:
               case this.btn_sortUnsoldItemName:
               case this.btn_sortItemQuantity:
               case this.btn_sortItemKamas:
               case this.btn_sortSaleType:
                  sortType = this._sortFieldAssoc[pTarget];
                  if(sortType == "index" && !this._lastSortType)
                  {
                     this._ascendingSort = false;
                  }
                  else
                  {
                     this._ascendingSort = sortType != this._lastSortType ? true : !this._ascendingSort;
                  }
                  this._currentGrid.dataProvider = this.utilApi.sort(this._currentGrid.dataProvider,sortType,this._ascendingSort,sortType != "itemName");
                  this._lastSortType = sortType;
                  break;
               case this.btn_sales:
                  this.openOfflineSalesTab();
                  break;
               case this.btn_unsoldItems:
                  this.openUnsoldItemsTab();
            }
         }
      }
      
      public function onCloseUi(pShortCut:String) : Boolean
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
         return true;
      }
      
      public function unload() : void
      {
      }
   }
}
