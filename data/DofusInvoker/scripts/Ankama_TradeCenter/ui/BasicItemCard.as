package Ankama_TradeCenter.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class BasicItemCard
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      protected var _currentObject:Object;
      
      protected var _currentPrice:Number = 0;
      
      protected const PRICE_LIMIT:Number = 1.0E12;
      
      protected var _isSellingItem:Boolean = false;
      
      public var mainCtr:Object;
      
      public var ctr_inputQty:GraphicContainer;
      
      public var ctr_inputPrice:GraphicContainer;
      
      public var input_quantity:Input;
      
      public var input_price:Input;
      
      public var lbl_price:Label;
      
      public var lbl_totalPrice:Label;
      
      public var btn_lbl_btn_valid:Label;
      
      public var lbl_item_name:Label;
      
      public var lbl_item_level:Label;
      
      public var tx_inputQuantity:TextureBitmap;
      
      public var tx_kama:Texture;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_remove:ButtonContainer;
      
      public var btn_modify:ButtonContainer;
      
      public var tx_item:Texture;
      
      public function BasicItemCard()
      {
         super();
      }
      
      public function main(param:Object = null) : void
      {
         this.btn_valid.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.btn_remove.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.btn_modify.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.uiApi.addComponentHook(this.input_quantity,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_price,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.tx_item,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_item,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_item,ComponentHookList.ON_RIGHT_CLICK);
         this.hideCard();
         this.input_quantity.maxChars = 9;
         this.input_quantity.restrictChars = "0-9";
         this.input_price.numberMax = this.PRICE_LIMIT;
         this.input_price.restrictChars = "0-9  ";
         this.btn_modify.visible = false;
         this.btn_remove.visible = false;
      }
      
      public function get uiVisible() : Boolean
      {
         return this.uiApi.me().visible;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         var value:Number = 0;
         if(target == this.input_price)
         {
            value = this.utilApi.stringToKamas(this.input_price.text,"");
            if(value > ProtocolConstantsEnum.MAX_KAMA)
            {
               value = ProtocolConstantsEnum.MAX_KAMA;
            }
            this.input_price.text = this.utilApi.kamasToString(value,"");
         }
         else if(target == this.input_quantity)
         {
            value = this.utilApi.stringToKamas(this.input_quantity.text,"");
            this.input_quantity.text = this.utilApi.kamasToString(value,"");
         }
      }
      
      protected function checkPlayerFund(quantity:int, token:int = 0) : void
      {
         var inventory:Vector.<ItemWrapper> = null;
         var item:ItemWrapper = null;
         var playerFunds:Number = 0;
         if(token == 0)
         {
            playerFunds = this.playerApi.characteristics().kamas;
         }
         else
         {
            inventory = this.playerApi.getInventory();
            for each(item in inventory)
            {
               if(item.objectGID == token)
               {
                  playerFunds += item.quantity;
               }
            }
         }
         if(this._currentPrice * quantity > playerFunds)
         {
            this.lbl_totalPrice.cssClass = "redright";
            this.btn_valid.disabled = true;
         }
         else
         {
            this.lbl_totalPrice.cssClass = "right";
            this.btn_valid.disabled = false;
         }
         this.btn_valid.disabled = this.btn_valid.disabled || this.playerApi.hasDebt();
      }
      
      public function onObjectSelected(pItem:Object = null) : void
      {
         if(pItem == null)
         {
            this.hideCard();
         }
         else
         {
            this.hideCard(false);
            this._currentObject = pItem;
            this.lbl_item_name.cssClass = "whitebold";
            if(this._currentObject.etheral)
            {
               this.lbl_item_name.cssClass = "itemetheral";
            }
            if(this._currentObject.itemSetId != -1)
            {
               this.lbl_item_name.cssClass = "orangeleft";
            }
            this.lbl_item_name.text = this._currentObject.name;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               this.lbl_item_name.text += " (" + this._currentObject.id + ")";
            }
            this.lbl_item_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._currentObject.level;
            this.tx_item.uri = this._currentObject.fullSizeIconUri;
            this.input_price.text = "0";
            this.input_price.setSelection(0,8388607);
            this.lbl_price.text = "0";
            this.input_quantity.text = "1";
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:Object = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         var makerParams:Object = null;
         switch(target)
         {
            case this.tx_item:
               data = this._currentObject;
               point = LocationEnum.POINT_TOPRIGHT;
               relPoint = LocationEnum.POINT_TOPLEFT;
               makerParams = {"showEffects":false};
         }
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,makerParams);
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void
      {
         var contextMenu:Object = this.menuApi.create(target);
         if(contextMenu && contextMenu.content.length > 0)
         {
            this.modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      protected function hideCard(hide:Boolean = true) : void
      {
         this.mainCtr.visible = !hide;
      }
   }
}
