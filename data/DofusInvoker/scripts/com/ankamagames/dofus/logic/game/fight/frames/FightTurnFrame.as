package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.EntityMovementCompleteMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.atouin.renderers.MovementZoneRenderer;
   import com.ankamagames.atouin.renderers.ZoneClipRenderer;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.managers.EmbedFontManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
   import com.ankamagames.dofus.logic.game.common.managers.AFKFightManager;
   import com.ankamagames.dofus.logic.game.common.managers.MapMovementAdapter;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightReachableCellsMaker;
   import com.ankamagames.dofus.logic.game.fight.miscs.TackleUtil;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientMultiMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapMovementRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameMapNoMovementMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnFinishMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.UserFont;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import damageCalculation.tools.StatIds;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class FightTurnFrame implements Frame
   {
      
      private static var SWF_LIB:String = XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets_tacticmod.swf");
      
      private static const TAKLED_CURSOR_NAME:String = "TackledCursor";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTurnFrame));
      
      public static const SELECTION_PATH:String = "FightMovementPath";
      
      public static const SELECTION_END_PATH:String = "FightMovementEndPath";
      
      public static const SELECTION_PATH_TACKLED:String = "FightMovementPathTackled";
      
      public static const SELECTION_PATH_UNREACHABLE:String = "FightMovementPathUnreachable";
      
      public static const SELECTION_MOVEMENT_AREA:String = "FightMovementArea";
      
      private static const PATH_COLOR:Color = new Color(26112);
      
      private static const PATH_TACKLED_COLOR:Color = new Color(16747520);
      
      private static const PATH_UNREACHABLE_COLOR:Color = new Color(6684672);
      
      private static const REMIND_TURN_DELAY:uint = 15000;
       
      
      private var _movementSelection:Selection;
      
      private var _movementTargetSelection:Selection;
      
      private var _movementSelectionTackled:Selection;
      
      private var _movementSelectionUnreachable:Selection;
      
      private var _movementAreaSelection:Selection;
      
      private var _isRequestingMovement:Boolean;
      
      private var _spellCastFrame:Frame;
      
      private var _finishingTurn:Boolean;
      
      private var _remindTurnTimeoutId:uint;
      
      private var _myTurn:Boolean;
      
      private var _turnDuration:uint;
      
      private var _remainingDurationSeconds:uint;
      
      private var _lastCell:MapPoint;
      
      private var _cursorData:LinkedCursorData = null;
      
      private var _tfAP:TextField;
      
      private var _tfMP:TextField;
      
      private var _cells:Vector.<uint>;
      
      private var _cellsTackled:Vector.<uint>;
      
      private var _cellsUnreachable:Vector.<uint>;
      
      private var _lastPath:MovementPath;
      
      private var _intervalTurn:Number;
      
      private var _playerEntity:IEntity;
      
      private var _currentFighterId:Number;
      
      private var _tackleByCellId:Dictionary;
      
      private var _turnFinishingNoNeedToRedrawMovement:Boolean = false;
      
      private var _lastMP:int = 0;
      
      public function FightTurnFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get myTurn() : Boolean
      {
         return this._myTurn;
      }
      
      public function set myTurn(b:Boolean) : void
      {
         var refreshTarget:* = b != this._myTurn;
         var monsterEndTurn:* = !this._myTurn;
         this._finishingTurn = false;
         this._currentFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
         this._playerEntity = DofusEntities.getEntity(this._currentFighterId);
         this._turnFinishingNoNeedToRedrawMovement = false;
         this._myTurn = b;
         if(b)
         {
            this.startRemindTurn();
            this.drawMovementArea();
         }
         else
         {
            this._isRequestingMovement = false;
            if(this._remindTurnTimeoutId != 0)
            {
               clearTimeout(this._remindTurnTimeoutId);
            }
            this.removePath();
            this.removeMovementArea();
         }
         var fcf:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(fcf)
         {
            fcf.refreshTimelineOverEntityInfos();
         }
         var scf:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(scf)
         {
            if(monsterEndTurn)
            {
               scf.drawRange();
            }
            if(refreshTarget)
            {
               if(scf)
               {
                  scf.refreshTarget(true);
               }
            }
         }
         if(this._myTurn && !scf)
         {
            this.drawPath();
         }
      }
      
      public function set turnDuration(v:uint) : void
      {
         this._turnDuration = v;
         this._remainingDurationSeconds = Math.floor(v / 1000);
         if(this._intervalTurn)
         {
            clearInterval(this._intervalTurn);
         }
         this._intervalTurn = setInterval(this.onSecondTick,1000);
      }
      
      public function get lastPath() : MovementPath
      {
         return this._lastPath;
      }
      
      public function get movementAreaSelection() : Selection
      {
         return this._movementAreaSelection;
      }
      
      public function freePlayer() : void
      {
         this._isRequestingMovement = false;
      }
      
      public function pushed() : Boolean
      {
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         OptionManager.getOptionManager("dofus").addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         StatsManager.getInstance().addListenerToStat(StatIds.MOVEMENT_POINTS,this.onUpdateMovementPoints);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var conmsg:CellOverMessage = null;
         var gfsca:GameFightSpellCastAction = null;
         var bf:FightBattleFrame = null;
         var playerInformation:GameFightFighterInformations = null;
         var ccmsg:CellClickMessage = null;
         var emcmsg:EntityMovementCompleteMessage = null;
         var fcf:FightContextFrame = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var playerInfos:GameFightFighterInformations = null;
         var imE:IMovable = null;
         var scrmsg:ShowCellRequestMessage = null;
         var text:String = null;
         var ccmmsg:ChatClientMultiMessage = null;
         var spellCastFrame:Frame = null;
         var basicTurnDuration:int = 0;
         var secondsToReport:int = 0;
         switch(true)
         {
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               if(this.myTurn)
               {
                  this._lastCell = conmsg.cell;
                  this.drawPath(this._lastCell);
               }
               return false;
            case msg is GameFightSpellCastAction:
               gfsca = msg as GameFightSpellCastAction;
               if(this._spellCastFrame != null)
               {
                  Kernel.getWorker().removeFrame(this._spellCastFrame);
               }
               this.removePath();
               if(this._myTurn)
               {
                  this.startRemindTurn();
               }
               bf = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
               playerInformation = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._currentFighterId) as GameFightFighterInformations;
               if(bf && bf.turnsCount <= 1 || playerInformation && playerInformation.spawnInfo.alive)
               {
                  Kernel.getWorker().addFrame(this._spellCastFrame = new FightSpellCastFrame(gfsca.spellId));
               }
               return true;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               if(KeyPoll.getInstance().isDown(Keyboard.ALTERNATE) && !Kernel.getWorker().contains(FightSpellCastFrame))
               {
                  if(Kernel.getWorker().contains(PointCellFrame))
                  {
                     PointCellFrame.getInstance().cancelShow();
                  }
                  if(DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(ccmsg.cellId).x,MapPoint.fromCellId(ccmsg.cellId).y,true))
                  {
                     scrmsg = new ShowCellRequestMessage();
                     scrmsg.initShowCellRequestMessage(ccmsg.cellId);
                     ConnectionsHandler.getConnection().send(scrmsg);
                     text = I18n.getUiText("ui.fightAutomsg.cell",["{cell," + ccmsg.cellId + "::" + ccmsg.cellId + "}"]);
                     ccmmsg = new ChatClientMultiMessage();
                     ccmmsg.initChatClientMultiMessage(text,ChatActivableChannelsEnum.CHANNEL_TEAM);
                     ConnectionsHandler.getConnection().send(ccmmsg);
                  }
               }
               else
               {
                  if(!this.myTurn)
                  {
                     return false;
                  }
                  this.askMoveTo(ccmsg.cell);
               }
               return true;
            case msg is GameMapNoMovementMessage:
               if(!this.myTurn)
               {
                  return false;
               }
               this._isRequestingMovement = false;
               this.removePath();
               return true;
               break;
            case msg is EntityMovementCompleteMessage:
               emcmsg = msg as EntityMovementCompleteMessage;
               fcf = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fcf)
               {
                  fcf.refreshTimelineOverEntityInfos();
               }
               if(!this.myTurn)
               {
                  return true;
               }
               if(emcmsg.entity.id == this._currentFighterId)
               {
                  this._isRequestingMovement = false;
                  spellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame);
                  if(!spellCastFrame)
                  {
                     this.drawPath();
                  }
                  this.startRemindTurn();
                  if(this._finishingTurn)
                  {
                     this.finishTurn();
                  }
               }
               return true;
               break;
            case msg is GameFightTurnFinishAction:
               if(!this.myTurn)
               {
                  return false;
               }
               this._turnFinishingNoNeedToRedrawMovement = true;
               entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               playerInfos = entitiesFrame.getEntityInfos(this._currentFighterId) as GameFightFighterInformations;
               if(this._remainingDurationSeconds > 0 && !playerInfos.stats.summoned)
               {
                  basicTurnDuration = CurrentPlayedFighterManager.getInstance().getBasicTurnDuration();
                  secondsToReport = Math.floor(this._remainingDurationSeconds / 2);
                  if(basicTurnDuration + secondsToReport > 60)
                  {
                     secondsToReport = 60 - basicTurnDuration;
                  }
                  if(secondsToReport > 0 && !AFKFightManager.getInstance().isAfk)
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,PatternDecoder.combine(I18n.getUiText("ui.fight.secondsAdded",[secondsToReport]),"n",secondsToReport <= 1,secondsToReport == 0),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  this._remainingDurationSeconds = 0;
                  clearInterval(this._intervalTurn);
               }
               imE = DofusEntities.getEntity(this._currentFighterId) as IMovable;
               if(!imE)
               {
                  return true;
               }
               if(imE.isMoving)
               {
                  this._finishingTurn = true;
               }
               else
               {
                  this.finishTurn();
               }
               return true;
               break;
            case msg is MapContainerRollOutMessage:
               this.removePath();
               return true;
            case msg is GameFightTurnReadyRequestMessage:
               this._turnFinishingNoNeedToRedrawMovement = true;
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         OptionManager.getOptionManager("dofus").removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         StatsManager.getInstance().removeListenerFromStat(StatIds.MOVEMENT_POINTS,this.onUpdateMovementPoints);
         if(this._remindTurnTimeoutId != 0)
         {
            clearTimeout(this._remindTurnTimeoutId);
         }
         if(this._intervalTurn)
         {
            clearInterval(this._intervalTurn);
         }
         Atouin.getInstance().cellOverEnabled = false;
         this.removePath();
         this.removeMovementArea();
         Kernel.getWorker().removeFrame(this._spellCastFrame);
         return true;
      }
      
      public function drawMovementArea() : void
      {
         if(this._turnFinishingNoNeedToRedrawMovement || !Dofus.getInstance().options.getOption("showMovementArea"))
         {
            if(this._movementAreaSelection)
            {
               this.removeMovementArea();
            }
            return;
         }
         if(!this._playerEntity || IMovable(this._playerEntity).isMoving)
         {
            this.removeMovementArea();
            return;
         }
         var playerPosition:MapPoint = this._playerEntity.position;
         var stats:EntityStats = CurrentPlayedFighterManager.getInstance().getStats();
         if(!stats)
         {
            return;
         }
         var movementPoints:int = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS);
         this._lastMP = movementPoints;
         var entitiesFrame:FightEntitiesFrame = FightEntitiesFrame.getCurrentInstance();
         var playerInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(this._playerEntity.id) as GameFightFighterInformations;
         var tackle:Number = TackleUtil.getTackle(playerInfos,playerPosition);
         this._tackleByCellId = new Dictionary();
         this._tackleByCellId[playerPosition.cellId] = tackle;
         var mpLost:int = int(movementPoints * (1 - tackle) + 0.5);
         if(mpLost < 0)
         {
            mpLost = 0;
         }
         movementPoints -= mpLost;
         if(movementPoints == 0)
         {
            this.removeMovementArea();
            return;
         }
         var fightReachableCellsMaker:FightReachableCellsMaker = new FightReachableCellsMaker(playerInfos);
         var reachableCells:Vector.<uint> = fightReachableCellsMaker.reachableCells;
         if(reachableCells.length == 0)
         {
            this.removeMovementArea();
            return;
         }
         if(!this._movementAreaSelection)
         {
            this._movementAreaSelection = new Selection();
            this._movementAreaSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,0.4,true);
            this._movementAreaSelection.color = PATH_COLOR;
            SelectionManager.getInstance().addSelection(this._movementAreaSelection,SELECTION_MOVEMENT_AREA);
         }
         this._movementAreaSelection.zone = new Custom(reachableCells);
         SelectionManager.getInstance().update(SELECTION_MOVEMENT_AREA,this._playerEntity.position.cellId);
      }
      
      public function drawPath(cell:MapPoint = null) : void
      {
         var tackle:Number = NaN;
         var firstObstacle:PathElement = null;
         var pe:PathElement = null;
         var i:int = 0;
         var j:int = 0;
         var pathLen:uint = 0;
         var s:Selection = null;
         var cursorSprite:Sprite = null;
         var font:UserFont = null;
         var fontName:String = null;
         var textFormat:TextFormat = null;
         var effect:GlowFilter = null;
         var cellsToUse:Vector.<uint> = null;
         var orientation:uint = 0;
         this._cells = new Vector.<uint>();
         this._cellsTackled = new Vector.<uint>();
         this._cellsUnreachable = new Vector.<uint>();
         if(Kernel.getWorker().contains(FightSpellCastFrame))
         {
            return;
         }
         if(this._isRequestingMovement)
         {
            return;
         }
         if(!cell)
         {
            if(FightContextFrame.currentCell == -1)
            {
               return;
            }
            cell = MapPoint.fromCellId(FightContextFrame.currentCell);
         }
         if(!this._playerEntity)
         {
            this.removePath();
            return;
         }
         var characteristics:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         var stats:EntityStats = CurrentPlayedFighterManager.getInstance().getStats();
         var mpLost:int = 0;
         var apLost:int = 0;
         var movementPoints:int = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS);
         var actionPoints:int = stats.getStatTotalValue(StatIds.ACTION_POINTS);
         if(IMovable(this._playerEntity).isMoving || this._playerEntity.position.distanceToCell(cell) > movementPoints)
         {
            this.removePath();
            return;
         }
         var path:MovementPath = Pathfinding.findPath(DataMapProvider.getInstance(),this._playerEntity.position,cell,false,false,true);
         if(DataMapProvider.getInstance().obstaclesCells.length > 0 && (path.path.length == 0 || path.path.length > movementPoints))
         {
            path = Pathfinding.findPath(DataMapProvider.getInstance(),this._playerEntity.position,cell,false,false,false);
            if(path.path.length > 0)
            {
               pathLen = path.path.length;
               for(i = 0; i < pathLen; i++)
               {
                  if(DataMapProvider.getInstance().obstaclesCells.indexOf(path.path[i].cellId) != -1)
                  {
                     firstObstacle = path.path[i];
                     for(j = i + 1; j < pathLen; j++)
                     {
                        this._cellsUnreachable.push(path.path[j].cellId);
                     }
                     this._cellsUnreachable.push(path.end.cellId);
                     path.end = firstObstacle.step;
                     path.path = path.path.slice(0,i);
                     break;
                  }
               }
            }
         }
         if(path.path.length == 0 || path.path.length > movementPoints)
         {
            this.removePath();
            return;
         }
         this._lastPath = path;
         var isFirst:Boolean = true;
         var mpCount:int = 0;
         var lastPe:PathElement = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var playerInfos:GameFightFighterInformations = entitiesFrame.getEntityInfos(this._playerEntity.id) as GameFightFighterInformations;
         for each(pe in path.path)
         {
            if(isFirst)
            {
               isFirst = false;
            }
            else
            {
               tackle = TackleUtil.getTackle(playerInfos,lastPe.step);
               mpLost += int((movementPoints - mpCount) * (1 - tackle) + 0.5);
               if(mpLost < 0)
               {
                  mpLost = 0;
               }
               apLost += int(actionPoints * (1 - tackle) + 0.5);
               if(apLost < 0)
               {
                  apLost = 0;
               }
               movementPoints = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS) - mpLost;
               actionPoints = stats.getStatTotalValue(StatIds.ACTION_POINTS) - apLost;
               if(mpCount < movementPoints)
               {
                  if(mpLost > 0)
                  {
                     this._cellsTackled.push(pe.step.cellId);
                  }
                  else
                  {
                     this._cells.push(pe.step.cellId);
                  }
                  mpCount++;
               }
               else
               {
                  this._cellsUnreachable.push(pe.step.cellId);
               }
            }
            lastPe = pe;
         }
         tackle = TackleUtil.getTackle(playerInfos,lastPe.step);
         mpLost += int((movementPoints - mpCount) * (1 - tackle) + 0.5);
         if(mpLost < 0)
         {
            mpLost = 0;
         }
         apLost += int(actionPoints * (1 - tackle) + 0.5);
         if(apLost < 0)
         {
            apLost = 0;
         }
         movementPoints = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS) - mpLost;
         if(mpCount < movementPoints)
         {
            if(firstObstacle)
            {
               movementPoints = path.path.length;
            }
            if(mpLost > 0)
            {
               this._cellsTackled.push(path.end.cellId);
            }
            else
            {
               this._cells.push(path.end.cellId);
            }
         }
         else if(firstObstacle)
         {
            this._cellsUnreachable.unshift(path.end.cellId);
            movementPoints = path.path.length - 1;
         }
         else
         {
            this._cellsUnreachable.push(path.end.cellId);
         }
         if(this._movementSelection == null)
         {
            this._movementSelection = new Selection();
            this._movementSelection.renderer = new MovementZoneRenderer(Dofus.getInstance().options.getOption("showMovementDistance"));
            this._movementSelection.color = PATH_COLOR;
            SelectionManager.getInstance().addSelection(this._movementSelection,SELECTION_PATH);
            this._movementTargetSelection = new Selection();
            this._movementTargetSelection.renderer = new ZoneClipRenderer(!!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA),SWF_LIB,[],-1,false,false);
            SelectionManager.getInstance().addSelection(this._movementTargetSelection,SELECTION_END_PATH);
         }
         if(this._cellsTackled.length > 0)
         {
            if(this._movementSelectionTackled == null)
            {
               this._movementSelectionTackled = new Selection();
               this._movementSelectionTackled.renderer = new MovementZoneRenderer(Dofus.getInstance().options.getOption("showMovementDistance"));
               this._movementSelectionTackled.color = PATH_TACKLED_COLOR;
               SelectionManager.getInstance().addSelection(this._movementSelectionTackled,SELECTION_PATH_TACKLED);
            }
            else
            {
               (this._movementSelectionTackled.renderer as MovementZoneRenderer).startAt = movementPoints + 1;
            }
            this._movementSelectionTackled.zone = new Custom(this._cellsTackled);
            SelectionManager.getInstance().update(SELECTION_PATH_TACKLED);
         }
         else
         {
            s = SelectionManager.getInstance().getSelection(SELECTION_PATH_TACKLED);
            if(s)
            {
               s.remove();
               this._movementSelectionTackled = null;
            }
         }
         if(this._cellsUnreachable.length > 0)
         {
            if(this._movementSelectionUnreachable == null)
            {
               this._movementSelectionUnreachable = new Selection();
               this._movementSelectionUnreachable.renderer = new MovementZoneRenderer(Dofus.getInstance().options.getOption("showMovementDistance"),movementPoints + 1);
               this._movementSelectionUnreachable.color = PATH_UNREACHABLE_COLOR;
               SelectionManager.getInstance().addSelection(this._movementSelectionUnreachable,SELECTION_PATH_UNREACHABLE);
            }
            else
            {
               (this._movementSelectionUnreachable.renderer as MovementZoneRenderer).startAt = movementPoints + 1;
            }
            this._movementSelectionUnreachable.zone = new Custom(this._cellsUnreachable);
            SelectionManager.getInstance().update(SELECTION_PATH_UNREACHABLE);
         }
         else
         {
            s = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
            if(s)
            {
               s.remove();
               this._movementSelectionUnreachable = null;
            }
         }
         if(mpLost > 0 || apLost > 0)
         {
            if(!this._cursorData)
            {
               cursorSprite = new Sprite();
               font = FontManager.getInstance().getFontInfo("Verdana");
               if(font)
               {
                  fontName = font.className;
               }
               else
               {
                  fontName = "Verdana";
               }
               this._tfAP = new TextField();
               this._tfAP.selectable = false;
               textFormat = new TextFormat(fontName,16,255,true);
               this._tfAP.defaultTextFormat = textFormat;
               this._tfAP.setTextFormat(textFormat);
               this._tfAP.text = "-" + apLost + " " + I18n.getUiText("ui.common.ap");
               if(EmbedFontManager.getInstance().isEmbed(textFormat.font))
               {
                  this._tfAP.embedFonts = true;
               }
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.height = this._tfAP.textHeight;
               cursorSprite.addChild(this._tfAP);
               this._tfMP = new TextField();
               this._tfMP.selectable = false;
               textFormat = new TextFormat(fontName,16,26112,true);
               this._tfMP.defaultTextFormat = textFormat;
               this._tfMP.setTextFormat(textFormat);
               this._tfMP.text = "-" + mpLost + " " + I18n.getUiText("ui.common.mp");
               if(EmbedFontManager.getInstance().isEmbed(textFormat.font))
               {
                  this._tfMP.embedFonts = true;
               }
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.height = this._tfMP.textHeight;
               this._tfMP.y = this._tfAP.height;
               cursorSprite.addChild(this._tfMP);
               effect = new GlowFilter(16777215,1,4,4,3,1);
               cursorSprite.filters = [effect];
               this._cursorData = new LinkedCursorData();
               this._cursorData.sprite = cursorSprite;
               this._cursorData.sprite.cacheAsBitmap = true;
               this._cursorData.offset = new Point(14,14);
            }
            if(apLost > 0)
            {
               this._tfAP.text = "-" + apLost + " " + I18n.getUiText("ui.common.ap");
               this._tfAP.width = this._tfAP.textWidth + 5;
               this._tfAP.visible = true;
               this._tfMP.y = this._tfAP.height;
            }
            else
            {
               this._tfAP.visible = false;
               this._tfMP.y = 0;
            }
            if(mpLost > 0)
            {
               this._tfMP.text = "-" + mpLost + " " + I18n.getUiText("ui.common.mp");
               this._tfMP.width = this._tfMP.textWidth + 5;
               this._tfMP.visible = true;
            }
            else
            {
               this._tfMP.visible = false;
            }
            LinkedCursorSpriteManager.getInstance().addItem(TAKLED_CURSOR_NAME,this._cursorData,true);
         }
         else if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
         {
            LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
         }
         var mp:MapPoint = new MapPoint();
         mp.cellId = this._cells.length > 1 ? uint(this._cells[this._cells.length - 2]) : uint(playerInfos.disposition.cellId);
         this._movementSelection.zone = new Custom(this._cells);
         SelectionManager.getInstance().update(SELECTION_PATH,0,true);
         if(this._cells.length || this._cellsTackled.length)
         {
            cellsToUse = !!this._cells.length ? this._cells : this._cellsTackled;
            if(!Dofus.getInstance().options.getOption("showMovementDistance"))
            {
               orientation = mp.orientationTo(MapPoint.fromCellId(cellsToUse[cellsToUse.length - 1]));
               if(orientation % 2 == 0)
               {
                  orientation++;
               }
               this._movementTargetSelection.zone = new Cross(0,0,DataMapProvider.getInstance());
               ZoneClipRenderer(this._movementTargetSelection.renderer).clipNames = ["pathEnd_" + orientation];
            }
            ZoneClipRenderer(this._movementTargetSelection.renderer).currentStrata = !!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA);
            SelectionManager.getInstance().update(SELECTION_END_PATH,cellsToUse[cellsToUse.length - 1],true);
         }
      }
      
      public function updatePath() : void
      {
         this.drawPath(this._lastCell);
      }
      
      private function removePath() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_PATH);
         if(s)
         {
            s.remove();
            this._movementSelection = null;
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_PATH_TACKLED);
         if(s)
         {
            s.remove();
            this._movementSelectionTackled = null;
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_PATH_UNREACHABLE);
         if(s)
         {
            s.remove();
            this._movementSelectionUnreachable = null;
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_END_PATH);
         if(s)
         {
            s.remove();
            this._movementTargetSelection = null;
         }
         if(LinkedCursorSpriteManager.getInstance().getItem(TAKLED_CURSOR_NAME))
         {
            LinkedCursorSpriteManager.getInstance().removeItem(TAKLED_CURSOR_NAME);
         }
         this._lastPath = null;
         this._cells = null;
      }
      
      private function removeMovementArea() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_MOVEMENT_AREA);
         if(s)
         {
            s.remove();
            this._movementAreaSelection = null;
         }
      }
      
      private function askMoveTo(cell:MapPoint) : Boolean
      {
         var gmmrmsg:GameMapMovementRequestMessage = null;
         if(this._isRequestingMovement)
         {
            return false;
         }
         this._isRequestingMovement = true;
         if(!this._playerEntity)
         {
            _log.warn("The player tried to move before its character was added to the scene. Aborting.");
            return this._isRequestingMovement = false;
         }
         if(IMovable(this._playerEntity).isMoving)
         {
            return this._isRequestingMovement = false;
         }
         if((!this._cells || this._cells.length == 0) && (!this._cellsTackled || this._cellsTackled.length == 0))
         {
            return this._isRequestingMovement = false;
         }
         var path:MovementPath = new MovementPath();
         var cells:Vector.<uint> = this._cells && this._cells.length ? this._cells : this._cellsTackled;
         cells.unshift(this._playerEntity.position.cellId);
         path.fillFromCellIds(cells.slice(0,cells.length - 1));
         path.start = this._playerEntity.position;
         path.end = MapPoint.fromCellId(cells[cells.length - 1]);
         path.path[path.path.length - 1].orientation = path.path[path.path.length - 1].step.orientationTo(path.end);
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(!fightBattleFrame || !fightBattleFrame.fightIsPaused)
         {
            gmmrmsg = new GameMapMovementRequestMessage();
            gmmrmsg.initGameMapMovementRequestMessage(MapMovementAdapter.getServerMovement(path),PlayedCharacterManager.getInstance().currentMap.mapId);
            ConnectionsHandler.getConnection().send(gmmrmsg);
         }
         else
         {
            this._isRequestingMovement = false;
         }
         this.removePath();
         return true;
      }
      
      private function finishTurn() : void
      {
         var gftfmsg:GameFightTurnFinishMessage = new GameFightTurnFinishMessage();
         gftfmsg.initGameFightTurnFinishMessage(AFKFightManager.getInstance().isAfk);
         ConnectionsHandler.getConnection().send(gftfmsg);
         this.removeMovementArea();
         this._finishingTurn = false;
      }
      
      private function startRemindTurn() : void
      {
         if(!this._myTurn)
         {
            return;
         }
         if(this._turnDuration > 0 && Dofus.getInstance().options.getOption("remindTurn"))
         {
            if(this._remindTurnTimeoutId != 0)
            {
               clearTimeout(this._remindTurnTimeoutId);
            }
            this._remindTurnTimeoutId = setTimeout(this.remindTurn,REMIND_TURN_DELAY);
         }
      }
      
      private function remindTurn() : void
      {
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fightBattleFrame && fightBattleFrame.fightIsPaused)
         {
            clearTimeout(this._remindTurnTimeoutId);
            this._remindTurnTimeoutId = 0;
            return;
         }
         var text:String = I18n.getUiText("ui.fight.inactivity");
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         KernelEventsManager.getInstance().processCallback(FightHookList.RemindTurn);
         clearTimeout(this._remindTurnTimeoutId);
         this._remindTurnTimeoutId = 0;
      }
      
      public function onSecondTick() : void
      {
         if(this._remainingDurationSeconds > 0)
         {
            --this._remainingDurationSeconds;
         }
         else
         {
            clearInterval(this._intervalTurn);
         }
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         if(e.propertyName == "transparentOverlayMode")
         {
            if(this._cells && this._cells.length && SelectionManager.getInstance().getSelection(SELECTION_END_PATH).visible)
            {
               ZoneClipRenderer(this._movementTargetSelection.renderer).currentStrata = e.propertyValue == true ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA);
               SelectionManager.getInstance().update(SELECTION_END_PATH,this._cells[this._cells.length - 1],true);
            }
         }
         else if(e.propertyName == "showMovementArea")
         {
            this.drawMovementArea();
         }
      }
      
      private function onUpdateMovementPoints(stat:Stat) : void
      {
         if(stat && stat.entityId === this._currentFighterId && stat.totalValue !== this._lastMP)
         {
            this.drawMovementArea();
         }
      }
   }
}
