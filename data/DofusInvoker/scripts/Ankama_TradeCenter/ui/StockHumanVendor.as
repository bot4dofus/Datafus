package Ankama_TradeCenter.ui
{
   import Ankama_TradeCenter.TradeCenter;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMerchantInformations;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   
   public class StockHumanVendor extends StockMyselfVendor
   {
       
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      private var _previousMerchant:GameRolePlayMerchantInformations;
      
      private var _nextMerchant:GameRolePlayMerchantInformations;
      
      private var _currentMerchantIndex:int;
      
      private var _merchantCount:int;
      
      private var _currentName:String;
      
      public var btn_previousStock:ButtonContainer;
      
      public var btn_nextStock:ButtonContainer;
      
      public var ctr_previousStock:GraphicContainer;
      
      public var ctr_nextStock:GraphicContainer;
      
      public function StockHumanVendor()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         sysApi.addHook(RoleplayHookList.MerchantListUpdated,this.onMerchantListUpdated);
         uiApi.addComponentHook(this.btn_previousStock,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_previousStock,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_nextStock,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_nextStock,ComponentHookList.ON_ROLL_OUT);
         ctr_center.visible = false;
         this._currentName = params.playerName;
         lbl_title.text = this._currentName;
         ed_merchant.look = params.look;
         tx_bgEntity.visible = true;
         this.onMerchantListUpdated();
      }
      
      override public function unload() : void
      {
         uiApi.unloadUi(UIEnum.HUMAN_VENDOR);
         super.unload();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_previousStock || target == this.btn_nextStock)
         {
            if(target == this.btn_previousStock)
            {
               if(!this._previousMerchant)
               {
                  return;
               }
               this.btn_previousStock.disabled = true;
               TradeCenter.getInstance().exchangeOnHumanVendorRequestWithDelay(this._previousMerchant.contextualId,this._previousMerchant.disposition.cellId);
               this.unload();
            }
            else if(target == this.btn_nextStock)
            {
               if(!this._nextMerchant)
               {
                  return;
               }
               this.btn_nextStock.disabled = true;
               TradeCenter.getInstance().exchangeOnHumanVendorRequestWithDelay(this._nextMerchant.contextualId,this._nextMerchant.disposition.cellId);
               this.unload();
            }
         }
         else
         {
            super.onRelease(target);
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var info:String = null;
         var merchantNumber:int = 0;
         var offset:int = 9;
         switch(target)
         {
            case this.btn_previousStock:
               if(!this._previousMerchant)
               {
                  return;
               }
               merchantNumber = this._currentMerchantIndex;
               if(merchantNumber == 0)
               {
                  merchantNumber = this._merchantCount;
               }
               info = uiApi.getText("ui.humanVendor.vendorNumber",merchantNumber,this._previousMerchant.name,this._merchantCount);
               break;
            case this.btn_nextStock:
               if(!this._nextMerchant)
               {
                  return;
               }
               merchantNumber = this._currentMerchantIndex + 2;
               if(merchantNumber > this._merchantCount)
               {
                  merchantNumber = 1;
               }
               info = uiApi.getText("ui.humanVendor.vendorNumber",merchantNumber,this._nextMerchant.name,this._merchantCount);
               break;
         }
         if(info)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(info),target,false,"standard",LocationEnum.POINT_RIGHT,LocationEnum.POINT_RIGHT,offset,null,null,null,"TextInfo");
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      public function onMerchantListUpdated() : void
      {
         var merchants:Array = this.rpApi.getMerchants();
         this._merchantCount = merchants.length;
         for(var i:int = 0; i < this._merchantCount; i++)
         {
            if(this._currentName == merchants[i].name)
            {
               this._currentMerchantIndex = i;
               break;
            }
         }
         if(this._currentMerchantIndex > 0)
         {
            this._previousMerchant = merchants[this._currentMerchantIndex - 1];
         }
         else
         {
            this._previousMerchant = merchants[this._merchantCount - 1];
         }
         if(this._currentMerchantIndex < this._merchantCount - 1)
         {
            this._nextMerchant = merchants[this._currentMerchantIndex + 1];
         }
         else
         {
            this._nextMerchant = merchants[0];
         }
         if(this._previousMerchant && this._merchantCount > 1)
         {
            this.ctr_previousStock.visible = true;
         }
         else
         {
            this.ctr_previousStock.visible = false;
         }
         if(this._nextMerchant && this._merchantCount > 1)
         {
            this.ctr_nextStock.visible = true;
         }
         else
         {
            this.ctr_nextStock.visible = false;
         }
      }
   }
}
