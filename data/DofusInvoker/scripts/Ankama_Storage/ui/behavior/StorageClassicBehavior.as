package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.EquipmentUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class StorageClassicBehavior implements IStorageBehavior
   {
       
      
      private var _storage:EquipmentUi;
      
      private var _waitingObject:Object;
      
      public function StorageClassicBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         if(data is ItemWrapper && this._storage.categoryFilter != ItemCategoryEnum.QUEST_CATEGORY)
         {
            if(data.position != 63)
            {
               return true;
            }
         }
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         if(data.quantity == 1)
         {
            Api.system.sendAction(new ObjectSetPositionAction([data.objectUID,63,1]));
         }
         else
         {
            this._waitingObject = data;
            Api.common.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQty);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         if(target == this._storage.grid)
         {
            item = this._storage.grid.selectedItem;
            switch(selectMethod)
            {
               case SelectMethodEnum.CLICK:
                  break;
               case SelectMethodEnum.DOUBLE_CLICK:
                  Api.ui.hideTooltip();
                  this.doubleClickGridItem(item);
                  break;
               case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                  this.doubleClickGridItem(item);
            }
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is EquipmentUi))
         {
            throw new Error("Can\'t attach a StorageClassicBehavior to a non EquipmentUi storage");
         }
         this._storage = storageUi as EquipmentUi;
      }
      
      public function detach() : void
      {
      }
      
      public function onUnload() : void
      {
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.EQUIPMENT_UI;
      }
      
      public function getName() : String
      {
         return StorageState.BAG_MOD;
      }
      
      public function get replacable() : Boolean
      {
         return true;
      }
      
      private function onValidQty(qty:Number) : void
      {
         Api.system.sendAction(new ObjectSetPositionAction([this._waitingObject.objectUID,63,qty]));
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
         var freeSlot:int = 0;
         var item:ItemWrapper = pItem as ItemWrapper;
         if(item && item.category == 0)
         {
            freeSlot = Api.storage.getBestEquipablePosition(item);
            if(freeSlot > -1)
            {
               Api.system.sendAction(new ObjectSetPositionAction([item.objectUID,freeSlot,1]));
            }
         }
         else if(item)
         {
            if(item.usable || item.targetable)
            {
               this._storage.useItem(item);
            }
            else if(item.typeId == DataEnum.ITEM_TYPE_IDOLS)
            {
               Api.system.sendAction(new OpenIdolsAction([]));
            }
            else if(item.hasOwnProperty("isCertificate") && item.isCertificate)
            {
               Api.system.sendAction(new MountInfoRequestAction([item]));
            }
         }
      }
      
      public function transfertAll() : void
      {
      }
      
      public function transfertList() : void
      {
      }
      
      public function transfertExisting() : void
      {
      }
   }
}
