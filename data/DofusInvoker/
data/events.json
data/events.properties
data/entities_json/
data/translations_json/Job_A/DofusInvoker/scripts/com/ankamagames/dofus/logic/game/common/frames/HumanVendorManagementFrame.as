package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.TradeStockItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectModifyPricedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockMovementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeShopStockStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkHumanVendorMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class HumanVendorManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanVendorManagementFrame));
       
      
      private var _success:Boolean = false;
      
      private var _shopStock:Array;
      
      public function HumanVendorManagementFrame()
      {
         super();
         this._shopStock = new Array();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get commonExchangeManagementFrame() : CommonExchangeManagementFrame
      {
         return Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
      }
      
      public function pushed() : Boolean
      {
         this._success = false;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var stockItem:TradeStockItemWrapper = null;
         var esohvmsg:ExchangeStartOkHumanVendorMessage = null;
         var player:* = undefined;
         var playerName:String = null;
         var esostmsg:ExchangeShopStockStartedMessage = null;
         var eompa:ExchangeObjectModifyPricedAction = null;
         var eomfpmsg:ExchangeObjectModifyPricedMessage = null;
         var essmamsg:ExchangeShopStockMovementUpdatedMessage = null;
         var itemWrapper:ItemWrapper = null;
         var newPrice:Number = NaN;
         var newItem:Boolean = false;
         var essmrmsg:ExchangeShopStockMovementRemovedMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var objectToSell:ObjectItemToSellInHumanVendorShop = null;
         var object:ObjectItemToSell = null;
         var i:int = 0;
         switch(true)
         {
            case msg is ExchangeStartOkHumanVendorMessage:
               esohvmsg = msg as ExchangeStartOkHumanVendorMessage;
               player = this.roleplayContextFrame.entitiesFrame.getEntityInfos(esohvmsg.sellerId);
               PlayedCharacterManager.getInstance().isInExchange = true;
               if(player == null)
               {
                  _log.error("Impossible de trouver le personnage vendeur dans l\'entitiesFrame");
                  return true;
               }
               playerName = (player as GameRolePlayMerchantInformations).name;
               this._shopStock = new Array();
               for each(objectToSell in esohvmsg.objectsInfos)
               {
                  stockItem = TradeStockItemWrapper.createFromObjectItemToSell(objectToSell);
                  this._shopStock.push(stockItem);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeStartOkHumanVendor,playerName,this._shopStock,EntitiesLooksManager.getInstance().getTiphonEntityLook(esohvmsg.sellerId));
               return true;
               break;
            case msg is ExchangeShopStockStartedMessage:
               esostmsg = msg as ExchangeShopStockStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               this._shopStock = new Array();
               for each(object in esostmsg.objectsInfos)
               {
                  stockItem = TradeStockItemWrapper.createFromObjectItemToSell(object);
                  _log.debug(" - " + stockItem.itemWrapper.name);
                  this._shopStock.push(stockItem);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockStarted,this._shopStock);
               return true;
            case msg is ExchangeObjectModifyPricedAction:
               eompa = msg as ExchangeObjectModifyPricedAction;
               eomfpmsg = new ExchangeObjectModifyPricedMessage();
               eomfpmsg.initExchangeObjectModifyPricedMessage(eompa.objectUID,eompa.quantity,eompa.price);
               ConnectionsHandler.getConnection().send(eomfpmsg);
               return true;
            case msg is ExchangeShopStockMovementUpdatedMessage:
               essmamsg = msg as ExchangeShopStockMovementUpdatedMessage;
               itemWrapper = ItemWrapper.create(0,essmamsg.objectInfo.objectUID,essmamsg.objectInfo.objectGID,essmamsg.objectInfo.quantity,essmamsg.objectInfo.effects,false);
               newPrice = essmamsg.objectInfo.objectPrice;
               newItem = true;
               for(i = 0; i < this._shopStock.length; i++)
               {
                  if(this._shopStock[i].itemWrapper.objectUID == itemWrapper.objectUID)
                  {
                     if(itemWrapper.quantity > this._shopStock[i].itemWrapper.quantity)
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockAddQuantity);
                     }
                     else
                     {
                        KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockRemoveQuantity);
                     }
                     stockItem = TradeStockItemWrapper.create(itemWrapper,newPrice);
                     this._shopStock.splice(i,1,stockItem);
                     newItem = false;
                     break;
                  }
               }
               if(newItem)
               {
                  stockItem = TradeStockItemWrapper.create(itemWrapper,essmamsg.objectInfo.objectPrice);
                  this._shopStock.push(stockItem);
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,itemWrapper);
               return true;
            case msg is ExchangeShopStockMovementRemovedMessage:
               essmrmsg = msg as ExchangeShopStockMovementRemovedMessage;
               for(i = 0; i < this._shopStock.length; i++)
               {
                  if(this._shopStock[i].itemWrapper.objectUID == essmrmsg.objectId)
                  {
                     this._shopStock.splice(i,1);
                     break;
                  }
               }
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockUpdate,this._shopStock,null);
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeShopStockMovementRemoved,essmrmsg.objectId);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is ExchangeLeaveMessage:
               elm = msg as ExchangeLeaveMessage;
               if(elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = elm.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this._shopStock = null;
         return true;
      }
   }
}
