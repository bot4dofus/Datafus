package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.internalDatacenter.taxi.TeleportDestinationWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ZaapRespawnSaveRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapDestinationsMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapRespawnSaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapRespawnUpdatedMessage;
   import com.ankamagames.dofus.network.types.game.interactive.zaap.TeleportDestination;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.getQualifiedClassName;
   
   public class ZaapFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
       
      
      private var _priority:int = 0;
      
      private var _spawnMapId:Number;
      
      private var _zaapsList:Array;
      
      public function ZaapFrame()
      {
         super();
      }
      
      public function get spawnMapId() : Number
      {
         return this._spawnMapId;
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(p:int) : void
      {
         this._priority = p;
      }
      
      public function pushed() : Boolean
      {
         this._zaapsList = new Array();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var zdmsg:ZaapDestinationsMessage = null;
         var tdmsg:TeleportDestinationsMessage = null;
         var destinations:Array = null;
         var tra:TeleportRequestAction = null;
         var zrsra:ZaapRespawnSaveRequestAction = null;
         var zrsrmsg:ZaapRespawnSaveRequestMessage = null;
         var zrumsg:ZaapRespawnUpdatedMessage = null;
         var ldm:LeaveDialogMessage = null;
         var dest:TeleportDestination = null;
         var hints:Vector.<Hint> = null;
         var hint:Hint = null;
         var trmsg:TeleportRequestMessage = null;
         var zaap:TeleportDestinationWrapper = null;
         switch(true)
         {
            case msg is ZaapDestinationsMessage:
               zdmsg = msg as ZaapDestinationsMessage;
               this._zaapsList = [];
               for each(dest in zdmsg.destinations)
               {
                  this._zaapsList.push(new TeleportDestinationWrapper(zdmsg.type,dest.mapId,dest.subAreaId,dest.type,dest.level,dest.cost,zdmsg.spawnMapId == dest.mapId));
               }
               this._spawnMapId = zdmsg.spawnMapId;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,this._zaapsList,zdmsg.type == TeleporterTypeEnum.TELEPORTER_HAVENBAG ? TeleporterTypeEnum.TELEPORTER_HAVENBAG : TeleporterTypeEnum.TELEPORTER_ZAAP);
               return true;
            case msg is TeleportDestinationsMessage:
               tdmsg = msg as TeleportDestinationsMessage;
               destinations = [];
               if(tdmsg.type == TeleporterTypeEnum.TELEPORTER_SUBWAY)
               {
                  for each(dest in tdmsg.destinations)
                  {
                     hints = TeleportDestinationWrapper.getHintsFromMapId(dest.mapId);
                     for each(hint in hints)
                     {
                        destinations.push(new TeleportDestinationWrapper(tdmsg.type,dest.mapId,dest.subAreaId,TeleporterTypeEnum.TELEPORTER_SUBWAY,dest.level,dest.cost,false,hint));
                     }
                  }
               }
               else
               {
                  for each(dest in tdmsg.destinations)
                  {
                     destinations.push(new TeleportDestinationWrapper(tdmsg.type,dest.mapId,dest.subAreaId,dest.type,dest.level,dest.cost));
                  }
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,destinations,tdmsg.type);
               return true;
            case msg is TeleportRequestAction:
               tra = msg as TeleportRequestAction;
               if(tra.cost <= PlayedCharacterManager.getInstance().characteristics.kamas)
               {
                  trmsg = new TeleportRequestMessage();
                  trmsg.initTeleportRequestMessage(tra.sourceType,tra.destinationType,tra.mapId);
                  ConnectionsHandler.getConnection().send(trmsg);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.popup.not_enough_rich"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is ZaapRespawnSaveRequestAction:
               zrsra = msg as ZaapRespawnSaveRequestAction;
               zrsrmsg = new ZaapRespawnSaveRequestMessage();
               zrsrmsg.initZaapRespawnSaveRequestMessage();
               ConnectionsHandler.getConnection().send(zrsrmsg);
               return true;
            case msg is ZaapRespawnUpdatedMessage:
               zrumsg = msg as ZaapRespawnUpdatedMessage;
               for each(zaap in this._zaapsList)
               {
                  zaap.spawn = zaap.mapId == zrumsg.mapId;
               }
               this._spawnMapId = zrumsg.mapId;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,this._zaapsList,TeleporterTypeEnum.TELEPORTER_ZAAP);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_TELEPORTER)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
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
