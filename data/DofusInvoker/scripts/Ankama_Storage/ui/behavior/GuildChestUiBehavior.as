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
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   
   public class GuildChestUiBehavior implements IStorageBehavior
   {
       
      
      protected var _storage:AbstractStorageUi;
      
      protected var _objectToExchange:Object;
      
      public var objectTypesRestriction:Vector.<uint>;
      
      public var dropRight:uint;
      
      public var takeRight:uint;
      
      public function GuildChestUiBehavior()
      {
         super();
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         if(data.position != CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED || source.getUi() == target.getUi())
         {
            return false;
         }
         if(!this.hasRightToDropItem())
         {
            this._storage.dropErrorText = Api.ui.getText("ui.guild.cantDrop");
            return false;
         }
         if(this._storage.grid.dataProvider.length >= this._storage.slotsMax && !this.chestContainItem(data.objectUID))
         {
            this._storage.dropErrorText = Api.ui.getText("ui.guild.cantDropChestFull");
            return false;
         }
         if(!this.objectTypeAllowed(data.typeId))
         {
            this._storage.dropErrorText = Api.ui.getText("ui.guild.canDropThisType");
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
               Api.common.openQuantityPopup(1,quantityMax,quantityMax,this.onValidQty);
            }
            else
            {
               Api.system.sendAction(new ExchangeObjectMoveAction([data.objectUID,1]));
            }
         }
      }
      
      public function objectTypeAllowed(typeId:uint) : Boolean
      {
         var guildChestTabActivated:Boolean = FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.GUILD_CHEST_TAB);
         return !guildChestTabActivated || this.objectTypesRestriction.indexOf(typeId) != -1;
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         this._storage = storageUi;
         if(this._storage is GuildChestUi)
         {
            (this._storage as GuildChestUi).behavior = this;
         }
         Api.system.disableWorldInteraction();
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.questVisible = false;
      }
      
      public function detach() : void
      {
         if(this._storage is GuildChestUi)
         {
            (this._storage as GuildChestUi).behavior = null;
         }
         Api.system.enableWorldInteraction();
         this._storage.btn_moveAllToLeft.visible = true;
         this._storage.questVisible = true;
      }
      
      public function onUnload() : void
      {
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.GUILD_CHEST_UI;
      }
      
      public function getName() : String
      {
         return StorageState.GUILD_CHEST_UI_MOD;
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
                     if(item is ItemWrapper && item.isEquipment)
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
                     else if(item is ItemWrapper && !item.isEquipment)
                     {
                        Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,null,true);
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     Api.ui.hideTooltip();
                     if(this.chestContainItem(item.objectUID) && this.hasRightToTakeItem())
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,-1]));
                     }
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     if(this.chestContainItem(item.objectUID) && this.hasRightToTakeItem())
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,-item.quantity]));
                     }
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     if(this.chestContainItem(item.objectUID) && this.hasRightToTakeItem())
                     {
                        this._objectToExchange = (target as Grid).selectedItem;
                        Api.common.openQuantityPopup(1,(target as Grid).selectedItem.quantity,(target as Grid).selectedItem.quantity,this.onValidNegativQty);
                     }
               }
         }
      }
      
      private function hasRightToDropItem() : Boolean
      {
         return Api.social.playerGuildRank.rights.indexOf(this.dropRight) != -1;
      }
      
      private function hasRightToTakeItem() : Boolean
      {
         return Api.social.playerGuildRank.rights.indexOf(this.takeRight) != -1;
      }
      
      private function chestContainItem(uid:uint) : Boolean
      {
         var i:int = 0;
         var dataProvider:* = this._storage.grid.dataProvider;
         var len:int = dataProvider.length;
         for(i = 0; i < len; i++)
         {
            if(dataProvider[i].objectUID == uid)
            {
               return true;
            }
         }
         return false;
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
