package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
   import com.ankamagames.dofus.network.messages.game.actions.sequence.SequenceEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnFinishMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnStartMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapFightCountMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
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
   
   public class FightBotFrame implements Frame
   {
      
      private static var _self:FightBotFrame;
       
      
      private var _frameFightListRequest:Boolean;
      
      private var _fightCount:uint;
      
      private var _mapPos:Array;
      
      private var _enabled:Boolean;
      
      private var _rollOverTimer:BenchmarkTimer;
      
      private var _actionTimer:BenchmarkTimer;
      
      private var _inFight:Boolean;
      
      private var _lastElemOver:Sprite;
      
      private var _lastEntityOver:IInteractive;
      
      private var _wait:Boolean;
      
      private var _turnPlayed:uint;
      
      private var _myTurn:Boolean;
      
      private var _turnAction:Array;
      
      public function FightBotFrame()
      {
         this._rollOverTimer = new BenchmarkTimer(2000,0,"FightBotFrame._rollOverTimer");
         this._actionTimer = new BenchmarkTimer(5000,0,"FightBotFrame._actionTimer");
         this._turnAction = [];
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this.initRight();
      }
      
      public static function getInstance() : FightBotFrame
      {
         if(!_self)
         {
            _self = new FightBotFrame();
         }
         return _self;
      }
      
      public function pushed() : Boolean
      {
         this._enabled = true;
         this.fakeActivity();
         this._myTurn = false;
         this._actionTimer.start();
         this._actionTimer.addEventListener(TimerEvent.TIMER,this.onAction);
         this._rollOverTimer.start();
         this._rollOverTimer.addEventListener(TimerEvent.TIMER,this.randomOver);
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
         this._enabled = false;
         return true;
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function get fightCount() : uint
      {
         return this._fightCount;
      }
      
      public function process(msg:Message) : Boolean
      {
         var startFightMsg:GameFightReadyMessage = null;
         var turnStartMsg:GameFightTurnStartMessage = null;
         switch(true)
         {
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
            case msg is GameFightShowFighterMessage:
               this.sendAdminCmd("givelife *");
               this.sendAdminCmd("giveenergy *");
               this._turnPlayed = 0;
               this._myTurn = false;
               startFightMsg = new GameFightReadyMessage();
               startFightMsg.initGameFightReadyMessage(true);
               ConnectionsHandler.getConnection().send(startFightMsg);
               break;
            case msg is GameFightTurnStartMessage:
               turnStartMsg = msg as GameFightTurnStartMessage;
               this._turnAction = [];
               if(turnStartMsg.id == PlayedCharacterManager.getInstance().id)
               {
                  this._myTurn = true;
                  ++this._turnPlayed;
                  if(this._turnPlayed > 2)
                  {
                     this.castSpell(411,true);
                  }
                  else
                  {
                     this.addTurnAction(this.fightRandomMove,[]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.castSpell,[173,false]);
                     this.addTurnAction(this.turnEnd,[]);
                     this.nextTurnAction();
                  }
               }
               else
               {
                  this._myTurn = false;
               }
               break;
            case msg is SequenceEndMessage:
               this.nextTurnAction();
         }
         return false;
      }
      
      private function initRight() : void
      {
         this.sendAdminCmd("adminaway");
         this.sendAdminCmd("givelevel * 200");
         this.sendAdminCmd("givespell * 173 6");
         this.sendAdminCmd("givespell * 411 6");
         this.sendAdminCmd("dring po=63,vita=8000,pa=100,agi=150 true");
      }
      
      private function sendAdminCmd(cmd:String) : void
      {
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage(cmd);
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
      
      private function nextTurnAction() : void
      {
         var action:Object = null;
         if(this._turnAction.length)
         {
            action = this._turnAction.shift();
            action.fct.apply(this,action.args);
         }
      }
      
      private function addTurnAction(fct:Function, args:Array) : void
      {
         this._turnAction.push({
            "fct":fct,
            "args":args
         });
      }
      
      private function turnEnd() : void
      {
         var finDeTourMsg:GameFightTurnFinishMessage = new GameFightTurnFinishMessage();
         finDeTourMsg.initGameFightTurnFinishMessage();
         ConnectionsHandler.getConnection().send(finDeTourMsg);
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
         if(this._inFight || this._wait)
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
         var entity:* = undefined;
         var groupEntity:IEntity = null;
         if(this._inFight || this._wait)
         {
            return;
         }
         var rpEF:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!rpEF)
         {
            return;
         }
         var avaibleCells:Array = [];
         for each(entity in rpEF.getEntitiesDictionnary())
         {
            if(entity is GameRolePlayGroupMonsterInformations)
            {
               groupEntity = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(entity).contextualId);
               avaibleCells.push(MapPoint.fromCellId(groupEntity.position.cellId));
            }
         }
         if(!avaibleCells || !avaibleCells.length)
         {
            return;
         }
         var ccmsg:CellClickMessage = new CellClickMessage();
         ccmsg.cell = avaibleCells[Math.floor(avaibleCells.length * Math.random())];
         ccmsg.cellId = ccmsg.cell.cellId;
         ccmsg.id = MapDisplayManager.getInstance().currentMapPoint.mapId;
         Kernel.getWorker().process(ccmsg);
      }
      
      private function fightRandomMove() : void
      {
         var reachableCells:FightReachableCellsMaker = new FightReachableCellsMaker(FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations);
         if(!reachableCells.reachableCells.length)
         {
            this.nextTurnAction();
            return;
         }
         var ccmsg:CellClickMessage = new CellClickMessage();
         ccmsg.cell = MapPoint.fromCellId(reachableCells.reachableCells[Math.floor(reachableCells.reachableCells.length * Math.random())]);
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
      
      private function castSpell(spellId:uint, onMySelf:Boolean) : void
      {
         var cellId:uint = 0;
         var avaibleCells:Array = null;
         var entity:* = undefined;
         var monster:GameFightMonsterInformations = null;
         var gafcrmsg:GameActionFightCastRequestMessage = new GameActionFightCastRequestMessage();
         if(onMySelf)
         {
            cellId = FightEntitiesFrame.getCurrentInstance().getEntityInfos(PlayedCharacterManager.getInstance().id).disposition.cellId;
         }
         else
         {
            avaibleCells = [];
            for each(entity in FightEntitiesFrame.getCurrentInstance().getEntitiesDictionnary())
            {
               if(entity.contextualId < 0 && entity is GameFightMonsterInformations)
               {
                  monster = entity as GameFightMonsterInformations;
                  if(monster.spawnInfo.alive)
                  {
                     avaibleCells.push(entity.disposition.cellId);
                  }
               }
            }
            cellId = avaibleCells[Math.floor(avaibleCells.length * Math.random())];
         }
         gafcrmsg.initGameActionFightCastRequestMessage(spellId,cellId);
         ConnectionsHandler.getConnection().send(gafcrmsg);
      }
   }
}
