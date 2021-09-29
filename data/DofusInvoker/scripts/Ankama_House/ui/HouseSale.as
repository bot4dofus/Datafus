package Ankama_House.ui
{
   import Ankama_Common.Common;
   import Ankama_House.House;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class HouseSale
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _price:Number = 0;
      
      private var _inside:Boolean;
      
      private var _instanceId:int;
      
      private var _buyMode:Boolean;
      
      private var _houseWrapper:HouseWrapper;
      
      private var _houseName:String;
      
      public var btnClose:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btnValidate:ButtonContainer;
      
      public var btnCancelTheSale:ButtonContainer;
      
      public var inputPrice:Input;
      
      public var lblOwnerName:Label;
      
      public var lblHouseInfo:TextArea;
      
      public var tx_houseIcon:Texture;
      
      public var mask_houseIcon:GraphicContainer;
      
      public var btn_help:ButtonContainer;
      
      public function HouseSale()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var houseInstance:HouseInstanceWrapper = null;
         var instance:HouseInstanceWrapper = null;
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this._price = param.price;
         this._inside = param.inside;
         this._buyMode = param.buyMode;
         this._instanceId = param.instanceId;
         this._houseWrapper = House.currentHouse;
         if(this._buyMode)
         {
            this.lbl_title.text = this.uiApi.getText("ui.common.housePurchase");
         }
         else
         {
            this.lbl_title.text = this.uiApi.getText("ui.common.houseSale");
         }
         this.inputPrice.restrict = "0-9";
         this.inputPrice.numberMax = ProtocolConstantsEnum.MAX_KAMA;
         if(this._price == 0)
         {
            this.btnCancelTheSale.disabled = true;
            this.inputPrice.text = this.utilApi.kamasToString(this._houseWrapper.defaultPrice);
         }
         else
         {
            this.inputPrice.text = this.utilApi.kamasToString(this._price,"");
            if(this._buyMode)
            {
               this.inputPrice.mouseChildren = false;
               this.btnCancelTheSale.disabled = true;
               this.btnValidate.disabled = this._price > this.playerApi.characteristics().kamas;
            }
            else
            {
               this.btnCancelTheSale.disabled = false;
               this.inputPrice.focus();
            }
         }
         for each(instance in this._houseWrapper.houseInstances)
         {
            if(instance.id == this._instanceId)
            {
               houseInstance = instance;
               break;
            }
         }
         if(!houseInstance.hasOwner)
         {
            this._houseName = this.uiApi.getText("ui.common.houseWithNoOwner");
         }
         else if(houseInstance.price > 0)
         {
            this._houseName = this.uiApi.getText("ui.common.houseForSale");
         }
         else
         {
            this._houseName = this.uiApi.getText("ui.common.houseOwnerName",PlayerManager.getInstance().formatTagName(houseInstance.ownerName,houseInstance.ownerTag));
         }
         this.lblOwnerName.setStyleSheet(UiApi.styleForTagName);
         this.lblOwnerName.htmlText = this._houseName;
         this.lblOwnerName.finalize();
         var info:String = this._houseWrapper.name;
         if(this._houseWrapper.description)
         {
            info += "\n\n" + this._houseWrapper.description;
         }
         this.lblHouseInfo.text = info;
         this.lblHouseInfo.wordWrap = true;
         this.tx_houseIcon.uri = this._houseWrapper.iconUri;
         this.tx_houseIcon.mask = this.mask_houseIcon;
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnValidate,"onRelease");
         this.uiApi.addComponentHook(this.btnCancelTheSale,"onRelease");
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.sysApi.disableWorldInteraction();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var price:Number = NaN;
         switch(target)
         {
            case this.btnClose:
               if(!this._inside)
               {
                  this.sysApi.sendAction(new LeaveDialogAction([]));
               }
               this.uiApi.unloadUi("houseSale");
               return;
            case this.btnValidate:
               price = this.utilApi.stringToKamas(this.inputPrice.text,"");
               if(this._buyMode)
               {
                  this._price = price;
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.housePurchase"),this.uiApi.getText("ui.common.doUBuyHouse",this._houseName,this.utilApi.kamasToString(price,"")),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmHouseBuy,null]);
               }
               else if(price == 0)
               {
                  if(this._inside)
                  {
                     this.sysApi.sendAction(new HouseSellFromInsideAction([this._instanceId,price]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new HouseSellAction([this._instanceId,price]));
                  }
                  this.uiApi.unloadUi("houseSale");
               }
               else
               {
                  if(this._inside)
                  {
                     this.sysApi.sendAction(new HouseSellFromInsideAction([this._instanceId,price]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new HouseSellAction([this._instanceId,price]));
                  }
                  this.uiApi.unloadUi("houseSale");
               }
               return;
            case this.btnCancelTheSale:
               if(this._inside)
               {
                  this.sysApi.sendAction(new HouseSellFromInsideAction([this._instanceId,price,false]));
               }
               else
               {
                  this.sysApi.sendAction(new HouseSellAction([this._instanceId,price,false]));
               }
               this.uiApi.unloadUi("houseSale");
               return;
            case this.btn_help:
               this.hintsApi.showSubHints();
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            if(!this._inside)
            {
               this.sysApi.sendAction(new LeaveDialogAction([]));
            }
            this.uiApi.unloadUi("houseSale");
            return true;
         }
         return false;
      }
      
      private function onConfirmHouseBuy() : void
      {
         this.sysApi.sendAction(new HouseBuyAction([this._price]));
         this.uiApi.unloadUi("houseSale");
      }
      
      public function unload() : void
      {
         this.sysApi.enableWorldInteraction();
      }
      
      private function onLeaveDialog() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
