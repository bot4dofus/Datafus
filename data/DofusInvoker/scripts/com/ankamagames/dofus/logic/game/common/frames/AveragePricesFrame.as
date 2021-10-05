package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesGetMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AveragePricesFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AveragePricesFrame));
      
      private static var _dataStoreType:DataStoreType;
      
      private static var _instance:AveragePricesFrame;
       
      
      private var _serverName:String;
      
      private var _pricesData:Object;
      
      public function AveragePricesFrame()
      {
         super();
         this._serverName = PlayerManager.getInstance().server.name;
         if(!_dataStoreType)
         {
            _dataStoreType = new DataStoreType("itemAveragePrices",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
      }
      
      public static function getInstance() : AveragePricesFrame
      {
         return _instance;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get dataAvailable() : Boolean
      {
         return this._pricesData;
      }
      
      public function get pricesData() : Object
      {
         return this._pricesData;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._pricesData = StoreDataManager.getInstance().getData(_dataStoreType,this._serverName);
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         return true;
      }
      
      public function process(pMsg:Message) : Boolean
      {
         var gccm:GameContextCreateMessage = null;
         var oapm:ObjectAveragePricesMessage = null;
         var oapem:ObjectAveragePricesErrorMessage = null;
         switch(true)
         {
            case pMsg is GameContextCreateMessage:
               gccm = pMsg as GameContextCreateMessage;
               if(gccm.context == GameContextEnum.ROLE_PLAY && this.updateAllowed())
               {
                  this.askPricesData();
               }
               return false;
            case pMsg is ObjectAveragePricesMessage:
               oapm = pMsg as ObjectAveragePricesMessage;
               this.updatePricesData(oapm.ids,oapm.avgPrices);
               return true;
            case pMsg is ObjectAveragePricesErrorMessage:
               oapem = pMsg as ObjectAveragePricesErrorMessage;
               return true;
            default:
               return false;
         }
      }
      
      private function updatePricesData(pItemsIds:Vector.<uint>, pItemsAvgPrices:Vector.<Number>) : void
      {
         var nbItems:int = pItemsIds.length;
         this._pricesData = {
            "lastUpdate":new Date(),
            "items":new Dictionary(true)
         };
         for(var i:int = 0; i < nbItems; i++)
         {
            this._pricesData.items[pItemsIds[i]] = pItemsAvgPrices[i];
         }
         StoreDataManager.getInstance().setData(_dataStoreType,this._serverName,this._pricesData);
      }
      
      private function updateAllowed() : Boolean
      {
         var now:Date = null;
         var lastUpdateHour:String = null;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(!featureManager || !featureManager.isFeatureWithKeywordEnabled("trade.averagePricesAutoUpdate"))
         {
            return false;
         }
         if(this.dataAvailable)
         {
            now = new Date();
            lastUpdateHour = TimeManager.getInstance().formatClock(this._pricesData.lastUpdate.getTime());
            if(now.getFullYear() == this._pricesData.lastUpdate.getFullYear() && now.getMonth() == this._pricesData.lastUpdate.getMonth() && now.getDate() == this._pricesData.lastUpdate.getDate())
            {
               return false;
            }
         }
         return true;
      }
      
      private function askPricesData() : void
      {
         var oapgm:ObjectAveragePricesGetMessage = new ObjectAveragePricesGetMessage();
         oapgm.initObjectAveragePricesGetMessage();
         ConnectionsHandler.getConnection().send(oapgm);
      }
   }
}
