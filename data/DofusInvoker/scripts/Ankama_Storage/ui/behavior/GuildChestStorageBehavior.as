package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.GuildChestUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   
   public class GuildChestStorageBehavior implements IStorageBehavior
   {
       
      
      protected var _storage:AbstractStorageUi;
      
      private var _guildChestUi:GuildChestUi;
      
      protected var _objectToExchange:Object;
      
      public function GuildChestStorageBehavior()
      {
         super();
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         if(data.position != CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED || source.getUi() == target.getUi())
         {
            return false;
         }
         if(!this.hasRightToTakeItem())
         {
            this._storage.dropErrorText = Api.ui.getText("ui.guild.cantTake");
            return false;
         }
         this._storage.dropErrorText = "";
         return true;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         var quantityMax:uint = 0;
         if(this.dropValidator(target,data,source))
         {
            if(data.quantity > 1)
            {
               this._objectToExchange = data;
               quantityMax = data.quantity;
               Api.common.openQuantityPopup(1,quantityMax,quantityMax,this.onValidNegativQty);
            }
            else
            {
               Api.system.sendAction(new ExchangeObjectMoveAction([data.objectUID,-1]));
            }
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         this._storage = storageUi;
         this._guildChestUi = Api.ui.getUi(UIEnum.GUILD_CHEST_UI).uiClass as GuildChestUi;
         Api.system.disableWorldInteraction();
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.questVisible = false;
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         this._storage.btn_moveAllToLeft.visible = true;
         this._storage.questVisible = true;
      }
      
      public function onUnload() : void
      {
         if(Api.ui.getUi(UIEnum.GUILD_CHEST_UI))
         {
            Api.ui.unloadUi(UIEnum.GUILD_CHEST_UI);
         }
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.GUILD_CHEST_STORAGE_MOD;
      }
      
      protected function onValidNegativQty(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,-qty]));
      }
      
      private function onValidQty(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,qty]));
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,item);
                     if(Api.ui.getUiByName(UIEnum.GUILD_CHEST_UI) != null && item is ItemWrapper && item.isEquipment)
                     {
                        if(item.enhanceable)
                        {
                           Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,item,true);
                        }
                        else
                        {
                           Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,null,true);
                        }
                     }
                     else if(Api.ui.getUiByName(UIEnum.GUILD_CHEST_UI) != null && item is ItemWrapper && !item.isEquipment)
                     {
                        Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,null,true);
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     Api.ui.hideTooltip();
                     if(this.isObjectAllowed(item as ItemWrapper))
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,1]));
                     }
                     else
                     {
                        Api.chat.sendErrorOnChat(Api.ui.getText("ui.guild.canDropThisType"));
                     }
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     if(this.isObjectAllowed(item as ItemWrapper))
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,item.quantity]));
                     }
                     else
                     {
                        Api.chat.sendErrorOnChat(Api.ui.getText("ui.guild.canDropThisType"));
                     }
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     if(this.isObjectAllowed(item as ItemWrapper))
                     {
                        this._objectToExchange = (target as Grid).selectedItem;
                        Api.common.openQuantityPopup(1,(target as Grid).selectedItem.quantity,(target as Grid).selectedItem.quantity,this.onValidQty);
                     }
                     else
                     {
                        Api.chat.sendErrorOnChat(Api.ui.getText("ui.guild.canDropThisType"));
                     }
               }
         }
      }
      
      private function hasRightToTakeItem() : Boolean
      {
         return Api.social.playerGuildRank.rights.indexOf(this._guildChestUi.behavior.takeRight) != -1;
      }
      
      private function hasRightToDropItem() : Boolean
      {
         return Api.social.playerGuildRank.rights.indexOf(this._guildChestUi.behavior.dropRight) != -1;
      }
      
      private function isObjectAllowed(item:ItemWrapper) : Boolean
      {
         return Api.inventory.getItem(item.objectUID) && this.hasRightToDropItem() && this._guildChestUi && this._guildChestUi.behavior && this._guildChestUi.behavior.objectTypeAllowed(item.typeId);
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
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
      
      public function get replacable() : Boolean
      {
         return false;
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
   }
}
