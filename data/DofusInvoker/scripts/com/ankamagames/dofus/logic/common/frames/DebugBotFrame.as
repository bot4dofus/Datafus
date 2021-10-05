package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.atouin.types.CellReference;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.ChatChannelsMultiEnum;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListRequestMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IInteractive;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.setTimeout;
   
   public class DebugBotFrame implements Frame
   {
      
      private static var _self:DebugBotFrame;
       
      
      private var _frameFightListRequest:Boolean;
      
      private var _fightCount:uint;
      
      private var _mapPos:Array;
      
      private var _enabled:Boolean;
      
      private var _rollOverTimer:BenchmarkTimer;
      
      private var _actionTimer:BenchmarkTimer;
      
      private var _chatTimer:BenchmarkTimer;
      
      private var _inFight:Boolean;
      
      private var _lastElemOver:Sprite;
      
      private var _lastEntityOver:IInteractive;
      
      private var _wait:Boolean;
      
      private var _changeMap:Boolean = true;
      
      private var ttSentence:int = 0;
      
      private var limit:int = 100;
      
      public function DebugBotFrame()
      {
         this._rollOverTimer = new BenchmarkTimer(2000,0,"DebugBotFrame._rollOverTimer");
         this._actionTimer = new BenchmarkTimer(5000,0,"DebugBotFrame._actionTimer");
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this.initRight();
      }
      
      public static function getInstance() : DebugBotFrame
      {
         if(!_self)
         {
            _self = new DebugBotFrame();
         }
         return _self;
      }
      
      public function enableChatMessagesBot(val:Boolean, time:int = 500) : void
      {
         if(val)
         {
            this._changeMap = false;
            this._chatTimer = new BenchmarkTimer(time,0,"DebugBotFrame._chatTimer");
            this._chatTimer.addEventListener(TimerEvent.TIMER,this.sendChatMessage);
         }
         else if(this._chatTimer)
         {
            this._changeMap = true;
            this._chatTimer.removeEventListener(TimerEvent.TIMER,this.sendChatMessage);
         }
      }
      
      public function pushed() : Boolean
      {
         this._enabled = true;
         this.fakeActivity();
         this._actionTimer.start();
         this._actionTimer.addEventListener(TimerEvent.TIMER,this.onAction);
         this._rollOverTimer.start();
         this._rollOverTimer.addEventListener(TimerEvent.TIMER,this.randomOver);
         if(this._chatTimer)
         {
            this._chatTimer.start();
         }
         this._mapPos = MapPosition.getMapPositions();
         var mfcMsg:MapFightCountMessage = new MapFightCountMessage();
         mfcMsg.initMapFightCountMessage(1);
         this.process(mfcMsg);
         return true;
      }
      
      public function pulled() : Boolean
      {
         this._rollOverTimer.stop();
         this._rollOverTimer.removeEventListener(TimerEvent.TIMER,this.randomOver);
         this._actionTimer.stop();
         this._actionTimer.removeEventListener(TimerEvent.TIMER,this.onAction);
         if(this._chatTimer)
         {
            this._chatTimer.stop();
         }
         this._enabled = false;
         return true;
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get fightCount() : uint
      {
         return this._fightCount;
      }
      
      public function process(msg:Message) : Boolean
      {
         var mfcMsg:MapFightCountMessage = null;
         var mrflMsg:MapRunningFightListMessage = null;
         var maxFightId:int = 0;
         var maxFighter:int = 0;
         var joinRequestMsg:GameFightJoinRequestMessage = null;
         var csmsg:ChatServerMessage = null;
         var requestRunningFightMsg:MapRunningFightListRequestMessage = null;
         var fightInfos:FightExternalInformations = null;
         switch(true)
         {
            case msg is MapFightCountMessage:
               mfcMsg = msg as MapFightCountMessage;
               if(mfcMsg.fightCount)
               {
                  requestRunningFightMsg = new MapRunningFightListRequestMessage();
                  requestRunningFightMsg.initMapRunningFightListRequestMessage();
                  ConnectionsHandler.getConnection().send(requestRunningFightMsg);
                  this._frameFightListRequest = true;
               }
               break;
            case msg is MapRunningFightListMessage:
               if(!this._frameFightListRequest)
               {
                  break;
               }
               this._frameFightListRequest = false;
               mrflMsg = msg as MapRunningFightListMessage;
               maxFighter = 0;
               for each(fightInfos in mrflMsg.fights)
               {
                  if(fightInfos.fightTeams.length > maxFighter)
                  {
                     maxFighter = fightInfos.fightTeams.length;
                     maxFightId = fightInfos.fightId;
                  }
               }
               if(this._wait || Math.random() < 0.6)
               {
                  return true;
               }
               joinRequestMsg = new GameFightJoinRequestMessage();
               joinRequestMsg.initGameFightJoinRequestMessage(0,maxFightId);
               ConnectionsHandler.getConnection().send(joinRequestMsg);
               this._actionTimer.reset();
               this._actionTimer.start();
               return true;
               break;
            case msg is GameFightJoinMessage:
               ++this._fightCount;
               this._inFight = true;
               break;
            case msg is GameFightEndMessage:
               this._inFight = false;
               break;
            case msg is MapComplementaryInformationsDataMessage:
               this._wait = false;
               break;
            case msg is MapsLoadingStartedMessage:
               this._wait = true;
               break;
            case msg is ChatServerMessage:
               csmsg = msg as ChatServerMessage;
               if(csmsg.channel == ChatChannelsMultiEnum.CHANNEL_SALES || csmsg.channel == ChatChannelsMultiEnum.CHANNEL_SEEK && Math.random() > 0.95)
               {
                  this.join(csmsg.senderName);
               }
         }
         return false;
      }
      
      private function initRight() : void
      {
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("adminaway");
         ConnectionsHandler.getConnection().send(aqcmsg);
         aqcmsg.initAdminQuietCommandMessage("god");
         ConnectionsHandler.getConnection().send(aqcmsg);
      }
      
      private function onAction(e:Event) : void
      {
         if(Math.random() < 0.9)
         {
            this.randomWalk();
         }
         else
         {
            this.randomMove();
         }
      }
      
      private function join(name:String) : void
      {
         if(this._inFight || this._wait)
         {
            return;
         }
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("join " + name);
         ConnectionsHandler.getConnection().send(aqcmsg);
         this._actionTimer.reset();
         this._actionTimer.start();
      }
      
      private function randomMove() : void
      {
         if(this._inFight || this._wait || !this._changeMap)
         {
            return;
         }
         var mapPos:MapPosition = this._mapPos[int(Math.random() * this._mapPos.length)];
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("moveto " + mapPos.id);
         ConnectionsHandler.getConnection().send(aqcmsg);
         this._actionTimer.reset();
         this._actionTimer.start();
      }
      
      private function fakeActivity() : void
      {
         if(!this._enabled)
         {
            return;
         }
         setTimeout(this.fakeActivity,1000 * 60 * 5);
         var bpmgs:BasicPingMessage = new BasicPingMessage();
         bpmgs.initBasicPingMessage(false);
         ConnectionsHandler.getConnection().send(bpmgs,ConnectionType.TO_ALL_SERVERS);
      }
      
      private function randomWalk() : void
      {
         var cell:CellReference = null;
         var mp:MapPoint = null;
         if(this._inFight || this._wait)
         {
            return;
         }
         var avaibleCells:Array = [];
         for each(cell in MapDisplayManager.getInstance().getDataMapContainer().getCell())
         {
            mp = MapPoint.fromCellId(cell.id);
            if(DataMapProvider.getInstance().pointMov(mp.x,mp.y))
            {
               avaibleCells.push(mp);
            }
         }
         if(!avaibleCells)
         {
            return;
         }
         var ccmsg:CellClickMessage = new CellClickMessage();
         ccmsg.cell = avaibleCells[Math.floor(avaibleCells.length * Math.random())];
         ccmsg.cellId = ccmsg.cell.cellId;
         ccmsg.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
         Kernel.getWorker().process(ccmsg);
      }
      
      private function randomOver(... foo) : void
      {
         var e:IEntity = null;
         var entity:IInteractive = null;
         var ui:UiRootContainer = null;
         var emomsg2:EntityMouseOutMessage = null;
         var elem:GraphicContainer = null;
         var momsg2:MouseOutMessage = null;
         if(this._wait)
         {
            return;
         }
         var avaibleEntities:Array = [];
         for each(e in EntitiesManager.getInstance().entities)
         {
            if(e is IInteractive)
            {
               avaibleEntities.push(e);
            }
         }
         entity = avaibleEntities[Math.floor(avaibleEntities.length * Math.random())];
         if(!entity)
         {
            return;
         }
         if(this._lastEntityOver)
         {
            emomsg2 = new EntityMouseOutMessage(this._lastEntityOver);
            Kernel.getWorker().process(emomsg2);
         }
         this._lastEntityOver = entity;
         var emomsg:EntityMouseOverMessage = new EntityMouseOverMessage(entity);
         Kernel.getWorker().process(emomsg);
         var avaibleElem:Array = [];
         for each(ui in Berilia.getInstance().uiList)
         {
            for each(elem in ui.getElements())
            {
               if(elem.mouseChildren || elem.mouseEnabled)
               {
                  avaibleElem.push(elem);
               }
            }
         }
         if(!avaibleElem.length)
         {
            return;
         }
         if(this._lastElemOver)
         {
            momsg2 = GenericPool.get(MouseOutMessage,this._lastElemOver,new MouseEvent(MouseEvent.MOUSE_OUT));
            Kernel.getWorker().process(momsg2);
         }
         var target:GraphicContainer = avaibleElem[Math.floor(avaibleElem.length * Math.random())];
         var momsg:MouseOverMessage = GenericPool.get(MouseOverMessage,target,new MouseEvent(MouseEvent.MOUSE_OVER));
         Kernel.getWorker().process(momsg);
         this._lastElemOver = target;
      }
      
      private function sendChatMessage(pEvt:TimerEvent) : void
      {
         var channel:int = 0;
         var removedSentences:int = 0;
         var color:uint = Math.random() * 16777215;
         var SENTENCES:Vector.<String> = new Vector.<String>();
         SENTENCES[0] = "Test html: salut <span style=\"color:#" + (Math.random() * 16777215).toString(8) + "\">je suis la</span> et la";
         SENTENCES[1] = "i\'m batman";
         SENTENCES[2] = HtmlManager.addLink("i\'m a link now, awesome !!","");
         SENTENCES[3] = ":( sd :p :) fdg dfg f";
         SENTENCES[4] = "je suis <u>underlineeeeeee</u> et moi <b>BOLD</b>" + "\nEt un retour a la ligne, un !!";
         SENTENCES[5] = "*test de texte italic via la commande*";
         var sentence:String = SENTENCES[Math.floor(Math.random() * SENTENCES.length)];
         ++this.ttSentence;
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentence,ChatActivableChannelsEnum.CHANNEL_GLOBAL);
         if(this.ttSentence > this.limit + 1)
         {
            --this.ttSentence;
            channel = 0;
            removedSentences = 1;
            KernelEventsManager.getInstance().processCallback(ChatHookList.NewMessage,channel,removedSentences);
         }
      }
   }
}
