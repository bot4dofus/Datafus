package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.types.Estate;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellFilterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellFilterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class EstateFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EstateFrame));
       
      
      private var _estateList:Array;
      
      private var _estateType:uint;
      
      public function EstateFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get estateType() : uint
      {
         return this._estateType;
      }
      
      public function get estateList() : Array
      {
         return this._estateList;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var htslmsg:HouseToSellListMessage = null;
         var ptslmsg:PaddockToSellListMessage = null;
         var htsfa:HouseToSellFilterAction = null;
         var htsfmsg:HouseToSellFilterMessage = null;
         var ptsfa:PaddockToSellFilterAction = null;
         var pfmsg:PaddockToSellFilterMessage = null;
         var htslra:HouseToSellListRequestAction = null;
         var htslrmsg:HouseToSellListRequestMessage = null;
         var ptslra:PaddockToSellListRequestAction = null;
         var ptslrmsg:PaddockToSellListRequestMessage = null;
         var ldrmsg:LeaveDialogRequestMessage = null;
         var house:HouseInformationsForSell = null;
         var estHouse:Estate = null;
         var paddock:PaddockInformationsForSell = null;
         var estPaddock:Estate = null;
         switch(true)
         {
            case msg is HouseToSellListMessage:
               htslmsg = msg as HouseToSellListMessage;
               this._estateType = 0;
               this._estateList = new Array();
               for each(house in htslmsg.houseList)
               {
                  estHouse = new Estate(house);
                  this._estateList.push(estHouse);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList,this._estateList,htslmsg.pageIndex,htslmsg.totalPage,this._estateType);
               return true;
            case msg is PaddockToSellListMessage:
               ptslmsg = msg as PaddockToSellListMessage;
               this._estateType = 1;
               this._estateList = new Array();
               for each(paddock in ptslmsg.paddockList)
               {
                  estPaddock = new Estate(paddock);
                  this._estateList.push(estPaddock);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList,this._estateList,ptslmsg.pageIndex,ptslmsg.totalPage,this._estateType);
               return true;
            case msg is HouseToSellFilterAction:
               htsfa = msg as HouseToSellFilterAction;
               htsfmsg = new HouseToSellFilterMessage();
               htsfmsg.initHouseToSellFilterMessage(htsfa.areaId,htsfa.atLeastNbRoom,htsfa.atLeastNbChest,htsfa.skillRequested,htsfa.maxPrice,htsfa.orderBy);
               ConnectionsHandler.getConnection().send(htsfmsg);
               return true;
            case msg is PaddockToSellFilterAction:
               ptsfa = msg as PaddockToSellFilterAction;
               pfmsg = new PaddockToSellFilterMessage();
               pfmsg.initPaddockToSellFilterMessage(ptsfa.areaId,ptsfa.atLeastNbMount,ptsfa.atLeastNbMachine,ptsfa.maxPrice,ptsfa.orderBy);
               ConnectionsHandler.getConnection().send(pfmsg);
               return true;
            case msg is HouseToSellListRequestAction:
               htslra = msg as HouseToSellListRequestAction;
               htslrmsg = new HouseToSellListRequestMessage();
               htslrmsg.initHouseToSellListRequestMessage(htslra.pageIndex);
               ConnectionsHandler.getConnection().send(htslrmsg);
               return true;
            case msg is PaddockToSellListRequestAction:
               ptslra = msg as PaddockToSellListRequestAction;
               ptslrmsg = new PaddockToSellListRequestMessage();
               ptslrmsg.initPaddockToSellListRequestMessage(ptslra.pageIndex);
               ConnectionsHandler.getConnection().send(ptslrmsg);
               return true;
            case msg is LeaveDialogRequestAction:
               ldrmsg = new LeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(ldrmsg);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
