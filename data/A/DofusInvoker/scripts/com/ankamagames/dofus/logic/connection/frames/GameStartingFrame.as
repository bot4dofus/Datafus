package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
   import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
   import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.misc.utils.mapeditor.MapEditorManager;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.Worker;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class GameStartingFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameStartingFrame));
      
      private static var displayMacOsSupportWarning:Boolean = true;
       
      
      private var _worker:Worker;
      
      private var m:MapEditorManager;
      
      public function GameStartingFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         this._worker = Kernel.getWorker();
         this.m = new MapEditorManager();
         Kernel.getWorker().process(new GameStartingMessage());
         Dofus.getInstance().renameApp("Dofus " + BuildInfos.VERSION.toStringForAppName());
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var dsmdmsg:DelayedSystemMessageDisplayMessage = null;
         var smdmsg:SystemMessageDisplayMessage = null;
         var dsmdmsg2:DelayedSystemMessageDisplayMessage = null;
         switch(true)
         {
            case msg is DelayedSystemMessageDisplayMessage:
               dsmdmsg = msg as DelayedSystemMessageDisplayMessage;
               this.systemMessageDisplay(dsmdmsg);
               return true;
            case msg is SystemMessageDisplayMessage:
               smdmsg = msg as SystemMessageDisplayMessage;
               if(smdmsg.hangUp)
               {
                  ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.DISCONNECTED_BY_POPUP);
                  dsmdmsg2 = new DelayedSystemMessageDisplayMessage();
                  dsmdmsg2.initDelayedSystemMessageDisplayMessage(smdmsg.hangUp,smdmsg.msgId,smdmsg.parameters);
                  DisconnectionHandlerFrame.messagesAfterReset.push(dsmdmsg2);
               }
               this.systemMessageDisplay(smdmsg);
               return true;
            case msg is OpenMainMenuAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function systemMessageDisplay(msg:SystemMessageDisplayMessage) : void
      {
         var i:* = undefined;
         var textId:uint = 0;
         var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         var a:Array = new Array();
         for each(i in msg.parameters)
         {
            a.push(i);
         }
         if(InfoMessage.getInfoMessageById(40000 + msg.msgId) && InfoMessage.getInfoMessageById(40000 + msg.msgId).textId)
         {
            textId = InfoMessage.getInfoMessageById(40000 + msg.msgId).textId;
         }
         else
         {
            _log.error("Information message " + (40000 + msg.msgId) + " cannot be found.");
            textId = InfoMessage.getInfoMessageById(207).textId;
            a = new Array();
            a.push(msg.msgId);
         }
         var msgContent:String = I18n.getText(textId);
         if(msgContent)
         {
            msgContent = ParamsDecoder.applyParams(msgContent,a);
            commonMod.openPopup(I18n.getUiText("ui.popup.warning"),msgContent,[I18n.getUiText("ui.common.ok")],null,null,null,null,false,true);
            SoundManager.getInstance().manager.removeAllSounds();
            return;
         }
      }
   }
}
