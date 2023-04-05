package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.OrnamentSelectRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitleSelectRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitlesAndOrnamentsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentGainedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectRequestMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleGainedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleLostMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectRequestMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectedMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListMessage;
   import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListRequestMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class TinselFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TinselFrame));
       
      
      private var _knownTitles:Vector.<uint>;
      
      private var _knownOrnaments:Vector.<uint>;
      
      private var _currentTitle:uint;
      
      private var _currentOrnament:uint;
      
      private var _titlesOrnamentsAskedBefore:Boolean;
      
      public function TinselFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get knownTitles() : Vector.<uint>
      {
         return this._knownTitles;
      }
      
      public function get knownOrnaments() : Vector.<uint>
      {
         return this._knownOrnaments;
      }
      
      public function get currentTitle() : uint
      {
         return this._currentTitle;
      }
      
      public function get currentOrnament() : uint
      {
         return this._currentOrnament;
      }
      
      public function get titlesOrnamentsAskedBefore() : Boolean
      {
         return this._titlesOrnamentsAskedBefore;
      }
      
      public function pushed() : Boolean
      {
         this._knownTitles = new Vector.<uint>();
         this._knownOrnaments = new Vector.<uint>();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var taolrmsg:TitlesAndOrnamentsListRequestMessage = null;
         var taolmsg:TitlesAndOrnamentsListMessage = null;
         var tgmsg:TitleGainedMessage = null;
         var infot:String = null;
         var tlmsg:TitleLostMessage = null;
         var indexToDelete:int = 0;
         var ogmsg:OrnamentGainedMessage = null;
         var infoo:String = null;
         var tsra:TitleSelectRequestAction = null;
         var tsrmsg:TitleSelectRequestMessage = null;
         var tsmsg:TitleSelectedMessage = null;
         var tsemsg:TitleSelectErrorMessage = null;
         var osra:OrnamentSelectRequestAction = null;
         var osrmsg:OrnamentSelectRequestMessage = null;
         var osmsg:OrnamentSelectedMessage = null;
         var osemsg:OrnamentSelectErrorMessage = null;
         var id:int = 0;
         switch(true)
         {
            case msg is TitlesAndOrnamentsListRequestAction:
               taolrmsg = new TitlesAndOrnamentsListRequestMessage();
               taolrmsg.initTitlesAndOrnamentsListRequestMessage();
               ConnectionsHandler.getConnection().send(taolrmsg);
               return true;
            case msg is TitlesAndOrnamentsListMessage:
               taolmsg = msg as TitlesAndOrnamentsListMessage;
               this._titlesOrnamentsAskedBefore = true;
               this._knownTitles = taolmsg.titles;
               this._knownOrnaments = taolmsg.ornaments;
               this._currentTitle = taolmsg.activeTitle;
               this._currentOrnament = taolmsg.activeOrnament;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated,this._knownOrnaments);
               return true;
            case msg is TitleGainedMessage:
               tgmsg = msg as TitleGainedMessage;
               this._knownTitles.push(tgmsg.titleId);
               infot = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.titleUnlockWithLink"),[tgmsg.titleId]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infot,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               return true;
            case msg is TitleLostMessage:
               tlmsg = msg as TitleLostMessage;
               indexToDelete = 0;
               for each(id in this._knownTitles)
               {
                  if(id == tlmsg.titleId)
                  {
                     break;
                  }
                  indexToDelete++;
               }
               this._knownTitles.splice(indexToDelete,1);
               if(this._currentTitle == tlmsg.titleId)
               {
                  this._currentTitle = 0;
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated,this._knownTitles);
               return true;
            case msg is OrnamentGainedMessage:
               ogmsg = msg as OrnamentGainedMessage;
               this._knownOrnaments.push(ogmsg.ornamentId);
               infoo = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.ornamentUnlockWithLink"),[ogmsg.ornamentId]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infoo,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated,this._knownOrnaments);
               return true;
            case msg is TitleSelectRequestAction:
               tsra = msg as TitleSelectRequestAction;
               tsrmsg = new TitleSelectRequestMessage();
               tsrmsg.initTitleSelectRequestMessage(tsra.titleId);
               ConnectionsHandler.getConnection().send(tsrmsg);
               return true;
            case msg is TitleSelectedMessage:
               tsmsg = msg as TitleSelectedMessage;
               this._currentTitle = tsmsg.titleId;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TitleUpdated,this._currentTitle);
               return true;
            case msg is TitleSelectErrorMessage:
               tsemsg = msg as TitleSelectErrorMessage;
               _log.debug("erreur de selection de titre");
               return true;
            case msg is OrnamentSelectRequestAction:
               osra = msg as OrnamentSelectRequestAction;
               osrmsg = new OrnamentSelectRequestMessage();
               osrmsg.initOrnamentSelectRequestMessage(osra.ornamentId);
               ConnectionsHandler.getConnection().send(osrmsg);
               return true;
            case msg is OrnamentSelectedMessage:
               osmsg = msg as OrnamentSelectedMessage;
               this._currentOrnament = osmsg.ornamentId;
               KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentUpdated,this._currentOrnament);
               return true;
            case msg is OrnamentSelectErrorMessage:
               osemsg = msg as OrnamentSelectErrorMessage;
               _log.debug("erreur de selection d\'ornement");
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}
