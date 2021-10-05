package Ankama_Exchange
{
   import Ankama_Common.Common;
   import Ankama_Exchange.ui.ExchangeNPCUi;
   import Ankama_Exchange.ui.ExchangeUi;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Exchange extends Sprite
   {
       
      
      protected var exchangeUi:ExchangeUi = null;
      
      protected var exchangeNPCUi:ExchangeNPCUi = null;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      private var _playerName:String;
      
      private var _ignoreName:String;
      
      private var _popupName:String;
      
      private var _waitStorageUnloadData:Object;
      
      public function Exchange()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(ExchangeHookList.ExchangeRequestCharacterFromMe,this.onExchangeRequestCharacterFromMe);
         this.sysApi.addHook(ExchangeHookList.ExchangeRequestCharacterToMe,this.onExchangeRequestCharacterToMe);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeStarted,this.onExchangeStarted);
         this.sysApi.addHook(HookList.CloseInventory,this.onCloseInventory);
         this.sysApi.addHook(ExchangeHookList.ExchangeStartOkNpcTrade,this.onExchangeStartOkNpcTrade);
      }
      
      private function onCloseInventory(uiName:String = "storage") : void
      {
         if(uiName === UIEnum.STORAGE_UI && this.uiApi.getUi(UIEnum.EXCHANGE_UI))
         {
            this.uiApi.unloadUi(UIEnum.EXCHANGE_UI);
         }
      }
      
      private function onExchangeStarted(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number) : void
      {
         if(this.uiApi.getUi(UIEnum.STORAGE_UI))
         {
            this._waitStorageUnloadData = {};
            this._waitStorageUnloadData.pSourceName = pSourceName;
            this._waitStorageUnloadData.pTargetName = pTargetName;
            this._waitStorageUnloadData.pSourceLook = pSourceLook;
            this._waitStorageUnloadData.pTargetLook = pTargetLook;
            this._waitStorageUnloadData.pSourceCurrentPods = pSourceCurrentPods;
            this._waitStorageUnloadData.pTargetCurrentPods = pTargetCurrentPods;
            this._waitStorageUnloadData.pSourceMaxPods = pSourceMaxPods;
            this._waitStorageUnloadData.pTargetMaxPods = pTargetMaxPods;
            this._waitStorageUnloadData.otherId = otherId;
            this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
            this.uiApi.unloadUi(UIEnum.STORAGE_UI);
         }
         else
         {
            this.loadExchangeUi(pSourceName,pTargetName,pSourceLook,pTargetLook,pSourceCurrentPods,pTargetCurrentPods,pSourceMaxPods,pTargetMaxPods,otherId);
         }
      }
      
      private function onUiUnloaded(name:String) : void
      {
         if(name == UIEnum.STORAGE_UI)
         {
            if(this._waitStorageUnloadData)
            {
               this.loadExchangeUi(this._waitStorageUnloadData.pSourceName,this._waitStorageUnloadData.pTargetName,this._waitStorageUnloadData.pSourceLook,this._waitStorageUnloadData.pTargetLook,this._waitStorageUnloadData.pSourceCurrentPods,this._waitStorageUnloadData.pTargetCurrentPods,this._waitStorageUnloadData.pSourceMaxPods,this._waitStorageUnloadData.pTargetMaxPods,this._waitStorageUnloadData.otherId);
               this._waitStorageUnloadData = null;
               this.sysApi.removeHook(BeriliaHookList.UiUnloaded);
            }
         }
      }
      
      private function loadExchangeUi(pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object, pSourceCurrentPods:int, pTargetCurrentPods:int, pSourceMaxPods:int, pTargetMaxPods:int, otherId:Number) : void
      {
         if(this._playerName == pSourceName)
         {
            this.uiApi.unloadUi(this._popupName);
         }
         if(this.uiApi.getUi(UIEnum.STORAGE_UI))
         {
            this.sysApi.log(8,"L\'interface de stocage aurait du avoir été préalablement déchargé.");
            return;
         }
         if(this.uiApi.getUi(UIEnum.INVENTORY_UI))
         {
            this.sysApi.sendAction(new CloseInventoryAction([UIEnum.INVENTORY_UI]));
         }
         this.uiApi.loadUi(UIEnum.EXCHANGE_UI,UIEnum.EXCHANGE_UI,{
            "sourceName":pSourceName,
            "targetName":pTargetName,
            "sourceLook":pSourceLook,
            "targetLook":pTargetLook,
            "sourceCurrentPods":pSourceCurrentPods,
            "targetCurrentPods":pTargetCurrentPods,
            "sourceMaxPods":pSourceMaxPods,
            "targetMaxPods":pTargetMaxPods,
            "otherId":otherId
         });
         this.sysApi.dispatchHook(HookList.OpenInventory,"exchange",UIEnum.STORAGE_UI);
      }
      
      protected function onExchangeRequestCharacterFromMe(myName:String, yourName:String) : void
      {
         this._playerName = myName;
         this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.exchange.requestInProgress"),this.uiApi.getText("ui.exchange.requestInProgress"),[this.uiApi.getText("ui.common.cancel")],[this.sendActionExchangeRefuse],null,this.sendActionExchangeRefuse);
      }
      
      protected function onExchangeRequestCharacterToMe(pTargetName:String, pSourceName:String) : void
      {
         this._playerName = pTargetName;
         this._ignoreName = pSourceName;
         this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.exchange.exchangeRequest"),this.uiApi.getText("ui.exchange.resquestMessage",pSourceName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no"),this.uiApi.getText("ui.common.ignore")],[this.sendActionExchangeAccept,this.sendActionExchangeRefuse,this.sendActionIgnore],this.sendActionExchangeAccept,this.sendActionExchangeRefuse);
      }
      
      protected function onExchangeLeave(success:Boolean) : void
      {
         this.sysApi.enableWorldInteraction();
         if(!success && this.uiApi.getUi(this._popupName))
         {
            this.uiApi.unloadUi(this._popupName);
         }
      }
      
      private function onExchangeStartOkNpcTrade(pNPCId:uint, pSourceName:String, pTargetName:String, pSourceLook:Object, pTargetLook:Object) : void
      {
         if(this.uiApi.getUi(UIEnum.INVENTORY_UI))
         {
            this.sysApi.sendAction(new CloseInventoryAction([UIEnum.INVENTORY_UI]));
         }
         this.sysApi.disableWorldInteraction();
         this.uiApi.loadUi(UIEnum.EXCHANGE_NPC_UI,UIEnum.EXCHANGE_NPC_UI,{
            "sourceName":pSourceName,
            "targetName":pTargetName,
            "sourceLook":pSourceLook,
            "targetLook":pTargetLook
         });
         this.sysApi.sendAction(new OpenInventoryAction(["exchangeNpc"]));
      }
      
      private function sendActionExchangeAccept() : void
      {
         this.sysApi.sendAction(new ExchangeAcceptAction([]));
      }
      
      private function sendActionExchangeRefuse() : void
      {
         this.sysApi.sendAction(new ExchangeRefuseAction([]));
      }
      
      private function sendActionIgnore() : void
      {
         this.sysApi.sendAction(new ExchangeRefuseAction([]));
         this.sysApi.sendAction(new AddIgnoredAction([this._ignoreName,""]));
      }
   }
}
