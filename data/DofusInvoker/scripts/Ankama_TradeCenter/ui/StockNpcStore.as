package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class StockNpcStore extends Stock
   {
       
      
      public function StockNpcStore()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         uiApi.loadUi(UIEnum.NPC_ITEM,UIEnum.NPC_ITEM);
         sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         sysApi.addHook(InventoryHookList.ObjectQuantity,this.onObjectQuantity);
         sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         uiApi.addComponentHook(btn_itemsFilter,ComponentHookList.ON_RELEASE);
         lbl_title.text = uiApi.getText("ui.common.shop");
         ed_merchant.look = params.look;
         tx_bgEntity.visible = true;
         replaceCategoryButtons();
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(name == UIEnum.NPC_ITEM)
         {
            replaceCategoryButtons();
         }
      }
      
      override public function unload() : void
      {
         uiApi.unloadUi(UIEnum.NPC_ITEM);
         super.unload();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btn_close:
               sysApi.dispatchHook(ExchangeHookList.CloseStore);
         }
         super.onRelease(target);
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var sellItem:Object = null;
         super.onRollOver(target);
         var pos:Object = {
            "point":LocationEnum.POINT_RIGHT,
            "relativePoint":LocationEnum.POINT_RIGHT
         };
         var offset:int = 9;
         var _loc5_:* = target;
         switch(0)
         {
         }
         if(target.name.indexOf("btn_item") != -1)
         {
            sellItem = _componentsList[target.name];
            if(sellItem && sellItem.criterion && sellItem.criterion.inlineCriteria.length > 0)
            {
               uiApi.showTooltip(sellItem.criterion,target,false,"standard",pos.point,pos.relativePoint,offset,"sellCriterion");
            }
         }
      }
      
      override public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         super.onSelectItem(target,selectMethod,isNewSelection);
      }
      
      private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int) : void
      {
         if(item.objectGID == _tokenType && btn_itemsFilter.selected)
         {
            updateStockInventory();
         }
      }
      
      private function onObjectDeleted(item:ItemWrapper) : void
      {
         if(item.objectGID == _tokenType && btn_itemsFilter.selected)
         {
            updateStockInventory();
         }
      }
   }
}
