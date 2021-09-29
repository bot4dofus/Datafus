package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentAddAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class AuctionBetaStats implements IUiStats, IHookStats
   {
       
      
      private var _action:StatsAction;
      
      private var _switchBetaSell:uint = 0;
      
      private var _switchBetaBuy:uint = 0;
      
      private var _switchStandardSell:uint = 0;
      
      private var _switchStandardBuy:uint = 0;
      
      private var _betaSell:uint = 0;
      
      private var _betaBuy:uint = 0;
      
      private var _standardSell:uint = 0;
      
      private var _standardBuy:uint = 0;
      
      private var _beta:Boolean;
      
      private var _sell:Boolean;
      
      public function AuctionBetaStats(args:Array)
      {
         super();
         this._beta = args[0];
         this._sell = args[1];
         this._action = new StatsAction(InternalStatisticTypeEnum.AUCTION_BETA);
         this._action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._action.setParam("account_id",PlayerManager.getInstance().accountId);
         this._action.setParam("server_id",PlayerManager.getInstance().server.id);
         this._action.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._action.setParam("map_id",PlayedCharacterManager.getInstance().currentMap.mapId);
         this._action.setParam("open_mode",!!this._beta ? 1 : 0);
         this._action.setParam("hdv_id",args[2]);
      }
      
      public function switchToSell() : void
      {
         if(this._sell)
         {
            this._beta = !this._beta;
            if(this._beta)
            {
               ++this._switchBetaSell;
            }
            else
            {
               ++this._switchStandardSell;
            }
         }
         else
         {
            this._sell = true;
         }
      }
      
      public function switchToBuy() : void
      {
         if(!this._sell)
         {
            this._beta = !this._beta;
            if(this._beta)
            {
               ++this._switchBetaBuy;
            }
            else
            {
               ++this._switchStandardBuy;
            }
         }
         else
         {
            this._sell = false;
         }
      }
      
      public function addSell() : void
      {
         if(this._beta)
         {
            ++this._betaSell;
         }
         else
         {
            ++this._standardSell;
         }
      }
      
      public function addBuy() : void
      {
         if(this._beta)
         {
            ++this._betaBuy;
         }
         else
         {
            ++this._standardBuy;
         }
      }
      
      public function remove() : void
      {
         this._action.setParam("switch_beta_sell",this._switchBetaSell);
         this._action.setParam("switch_beta_buy",this._switchBetaBuy);
         this._action.setParam("switch_standard_sell",this._switchStandardSell);
         this._action.setParam("switch_standard_buy",this._switchStandardBuy);
         this._action.setParam("sell_beta",this._betaSell);
         this._action.setParam("buy_beta",this._betaBuy);
         this._action.setParam("sell_standard",this._standardSell);
         this._action.setParam("buy_standard",this._standardBuy);
         this._action.setParam("close_mode",!!this._beta ? 1 : 0);
         this._action.send();
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         if(pMessage is BidSwitchToBuyerModeAction)
         {
            this.switchToBuy();
         }
         else if(pMessage is BidSwitchToSellerModeAction)
         {
            this.switchToSell();
         }
         else if(pMessage is ExchangeShopStockMouvmentAddAction)
         {
            this.addSell();
         }
         else if(pMessage is ExchangeBidHouseBuyAction)
         {
            this.addBuy();
         }
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         if(pHook == ExchangeHookList.ExchangeLeave)
         {
            this.remove();
         }
      }
   }
}
