package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementPositionRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsAcceptAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsCancelAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.dofus.logic.game.fight.types.SwapPositionRequest;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPositionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementPossiblePositionsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsAcceptMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsCancelMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsCancelledMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsOfferMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightReadyMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightRemoveTeamMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightUpdateTeamMessage;
   import com.ankamagames.dofus.network.messages.game.idol.IdolFightPreparationUpdateMessage;
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.CursorSpriteManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import flash.utils.getQualifiedClassName;
   
   public class FightPreparationFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightPreparationFrame));
      
      public static const PLAYER_TEAM_ALPHA:Number = 1;
      
      public static const ENEMY_TEAM_ALPHA:Number = 0.3;
      
      public static const COLOR_CHALLENGER:Color = new Color(14492160);
      
      public static const COLOR_DEFENDER:Color = new Color(8925);
      
      public static const SELECTION_CHALLENGER:String = "FightPlacementChallengerTeam";
      
      public static const SELECTION_DEFENDER:String = "FightPlacementDefenderTeam";
       
      
      private var _fightContextFrame:FightContextFrame;
      
      private var _playerTeam:uint;
      
      private var _challengerPositions:Vector.<uint>;
      
      private var _defenderPositions:Vector.<uint>;
      
      private var _swapPositionRequests:Vector.<SwapPositionRequest>;
      
      private var _fightersId:Vector.<Number>;
      
      public function FightPreparationFrame(fightContextFrame:FightContextFrame)
      {
         super();
         this._fightContextFrame = fightContextFrame;
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get fightersList() : Vector.<Number>
      {
         return this._fightersId;
      }
      
      public function pushed() : Boolean
      {
         CursorSpriteManager.resetCursor();
         Atouin.getInstance().cellOverEnabled = true;
         this._fightContextFrame.entitiesFrame.untargetableEntities = true;
         DataMapProvider.getInstance().isInFight = true;
         this._swapPositionRequests = new Vector.<SwapPositionRequest>(0);
         this._fightersId = new Vector.<Number>();
         return true;
      }
      
      public function updateSwapPositionRequestsIcons() : void
      {
         var swapPositionRequest:SwapPositionRequest = null;
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            swapPositionRequest.updateIcon();
         }
      }
      
      public function setSwapPositionRequestsIconsVisibility(pVisible:Boolean) : void
      {
         var swapPositionRequest:SwapPositionRequest = null;
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            swapPositionRequest.visible = pVisible;
         }
      }
      
      public function removeSwapPositionRequest(pRequestId:uint) : void
      {
         var swapPositionRequest:SwapPositionRequest = null;
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            if(swapPositionRequest.requestId == pRequestId)
            {
               this._swapPositionRequests.splice(this._swapPositionRequests.indexOf(swapPositionRequest),1);
            }
         }
      }
      
      public function isSwapPositionRequestValid(pRequestId:uint) : Boolean
      {
         var swapPositionRequest:SwapPositionRequest = null;
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            if(swapPositionRequest.requestId == pRequestId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function process(msg:Message) : Boolean
      {
         var playerInfos:GameFightFighterInformations = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var swapPositionRequest:SwapPositionRequest = null;
         var gflmsg:GameFightLeaveMessage = null;
         var fighterSwapPositionRequests:Vector.<SwapPositionRequest> = null;
         var gfpppmsg:GameFightPlacementPossiblePositionsMessage = null;
         var ccmsg:CellClickMessage = null;
         var cellEntity:AnimatedCharacter = null;
         var gfppra:GameFightPlacementPositionRequestAction = null;
         var iedi:IdentifiedEntityDispositionInformations = null;
         var entitySwapPositionsRequests:Vector.<SwapPositionRequest> = null;
         var gfpspra:GameFightPlacementSwapPositionsRequestAction = null;
         var gfpsprmsg:GameFightPlacementSwapPositionsRequestMessage = null;
         var gfpspomsg:GameFightPlacementSwapPositionsOfferMessage = null;
         var gfpspaa:GameFightPlacementSwapPositionsAcceptAction = null;
         var gfpspamsg:GameFightPlacementSwapPositionsAcceptMessage = null;
         var gfpspca:GameFightPlacementSwapPositionsCancelAction = null;
         var gfpspcmsg:GameFightPlacementSwapPositionsCancelMessage = null;
         var gfpspcdmsg:GameFightPlacementSwapPositionsCancelledMessage = null;
         var gfra:GameFightReadyAction = null;
         var gfrmsg:GameFightReadyMessage = null;
         var ecmsg:EntityClickMessage = null;
         var clickedEntity:IInteractive = null;
         var gcka:GameContextKickAction = null;
         var gckmsg:GameContextKickMessage = null;
         var gfutmsg:GameFightUpdateTeamMessage = null;
         var gfutmsg_myId:Number = NaN;
         var alreadyInTeam:Boolean = false;
         var gfrtmmsg:GameFightRemoveTeamMemberMessage = null;
         var indexOfCharToRemove:int = 0;
         var gfemsg2:GameFightEndMessage = null;
         var fightContextFrame:FightContextFrame = null;
         var ifpum:IdolFightPreparationUpdateMessage = null;
         var gfemsg:GameFightEndMessage = null;
         var fightContextFrame2:FightContextFrame = null;
         var entity:IEntity = null;
         var modContextMenu:Object = null;
         var menu:ContextMenuData = null;
         var fighter:Object = null;
         var fighterInfos:Object = null;
         var gfpprmsg:GameFightPlacementPositionRequestMessage = null;
         var gfpprmsg2:GameFightPlacementPositionRequestMessage = null;
         var requesterInfos:GameFightFighterInformations = null;
         var requestText:String = null;
         var cancellerInfo:GameFightFighterInformations = null;
         var cancellerName:String = null;
         var teamMember:FightTeamMemberInformations = null;
         switch(true)
         {
            case msg is GameFightLeaveMessage:
               gflmsg = msg as GameFightLeaveMessage;
               if(gflmsg.charId == PlayedCharacterManager.getInstance().id)
               {
                  PlayedCharacterManager.getInstance().fightId = -1;
                  Kernel.getWorker().removeFrame(this);
                  KernelEventsManager.getInstance().processCallback(HookList.GameFightLeave,gflmsg.charId);
                  gfemsg = new GameFightEndMessage();
                  gfemsg.initGameFightEndMessage();
                  fightContextFrame2 = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
                  if(fightContextFrame2)
                  {
                     fightContextFrame2.process(gfemsg);
                  }
                  else
                  {
                     Kernel.getWorker().process(gfemsg);
                  }
                  return true;
               }
               fighterSwapPositionRequests = this.getPlayerSwapPositionRequests(gflmsg.charId);
               for each(swapPositionRequest in fighterSwapPositionRequests)
               {
                  swapPositionRequest.destroy();
               }
               return false;
               break;
            case msg is GameFightPlacementPossiblePositionsMessage:
               gfpppmsg = msg as GameFightPlacementPossiblePositionsMessage;
               this.displayZone(SELECTION_CHALLENGER,this._challengerPositions = gfpppmsg.positionsForChallengers,COLOR_CHALLENGER,gfpppmsg.teamNumber == TeamEnum.TEAM_CHALLENGER ? Number(PLAYER_TEAM_ALPHA) : Number(ENEMY_TEAM_ALPHA));
               this.displayZone(SELECTION_DEFENDER,this._defenderPositions = gfpppmsg.positionsForDefenders,COLOR_DEFENDER,gfpppmsg.teamNumber == TeamEnum.TEAM_DEFENDER ? Number(PLAYER_TEAM_ALPHA) : Number(ENEMY_TEAM_ALPHA));
               this._playerTeam = gfpppmsg.teamNumber;
               return true;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               for each(entity in EntitiesManager.getInstance().getEntitiesOnCell(ccmsg.cellId))
               {
                  if(entity is AnimatedCharacter && !(entity as AnimatedCharacter).isMoving)
                  {
                     cellEntity = entity as AnimatedCharacter;
                     break;
                  }
               }
               if(cellEntity)
               {
                  modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                  fighter = new Object();
                  fighter.name = this._fightContextFrame.getFighterName(cellEntity.id);
                  entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  fighterInfos = entitiesFrame.getEntityInfos(cellEntity.id);
                  playerInfos = entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations;
                  if(fighterInfos is GameFightCharacterInformations)
                  {
                     menu = MenusFactory.create(fighterInfos as GameFightCharacterInformations,"player",[cellEntity]);
                  }
                  else if(fighterInfos is GameFightEntityInformation)
                  {
                     menu = MenusFactory.create(fighterInfos as GameFightEntityInformation,"companion",[cellEntity]);
                  }
                  else
                  {
                     if(!(fighterInfos.contextualId != playerInfos.contextualId && fighterInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId))
                     {
                        return true;
                     }
                     menu = MenusFactory.create(fighterInfos,"fightAlly",[cellEntity]);
                  }
                  if(menu)
                  {
                     modContextMenu.createContextMenu(menu);
                  }
               }
               else if(this.isValidPlacementCell(ccmsg.cellId,this._playerTeam) && !this._fightContextFrame.onlyTheOtherTeamCanPlace)
               {
                  gfpprmsg = new GameFightPlacementPositionRequestMessage();
                  gfpprmsg.initGameFightPlacementPositionRequestMessage(ccmsg.cellId);
                  ConnectionsHandler.getConnection().send(gfpprmsg);
               }
               return true;
            case msg is GameFightPlacementPositionRequestAction:
               gfppra = msg as GameFightPlacementPositionRequestAction;
               if(!this._fightContextFrame.onlyTheOtherTeamCanPlace)
               {
                  gfpprmsg2 = new GameFightPlacementPositionRequestMessage();
                  gfpprmsg2.initGameFightPlacementPositionRequestMessage(gfppra.cellId);
                  ConnectionsHandler.getConnection().send(gfpprmsg2);
               }
               return true;
            case msg is GameEntitiesDispositionMessage:
            case msg is GameFightPlacementSwapPositionsMessage:
               SoundManager.getInstance().manager.playUISound(UISoundEnum.FIGHT_POSITION);
               for each(iedi in msg["dispositions"])
               {
                  entitySwapPositionsRequests = this.getPlayerSwapPositionRequests(iedi.id);
                  for each(swapPositionRequest in entitySwapPositionsRequests)
                  {
                     swapPositionRequest.destroy();
                  }
               }
               return false;
            case msg is GameFightPlacementSwapPositionsRequestAction:
               gfpspra = msg as GameFightPlacementSwapPositionsRequestAction;
               gfpsprmsg = new GameFightPlacementSwapPositionsRequestMessage();
               gfpsprmsg.initGameFightPlacementSwapPositionsRequestMessage(gfpspra.cellId,gfpspra.requestedId);
               ConnectionsHandler.getConnection().send(gfpsprmsg);
               return true;
            case msg is GameFightPlacementSwapPositionsOfferMessage:
               gfpspomsg = msg as GameFightPlacementSwapPositionsOfferMessage;
               entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               swapPositionRequest = new SwapPositionRequest(gfpspomsg.requestId,gfpspomsg.requesterId,gfpspomsg.requestedId);
               if(swapPositionRequest.requestedId == PlayedCharacterManager.getInstance().id)
               {
                  requesterInfos = entitiesFrame.getEntityInfos(gfpspomsg.requesterId) as GameFightFighterInformations;
                  swapPositionRequest.showRequesterIcon();
                  requestText = I18n.getUiText("ui.fight.swapPositionRequest",[(requesterInfos as GameFightFighterNamedInformations).name]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{swapPositionRequest," + gfpspomsg.requestId + ",true::" + requestText + "}",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp(),false);
                  this._swapPositionRequests.push(swapPositionRequest);
               }
               else if(swapPositionRequest.requesterId == PlayedCharacterManager.getInstance().id)
               {
                  swapPositionRequest.showRequestedIcon();
                  this._swapPositionRequests.push(swapPositionRequest);
               }
               return true;
            case msg is GameFightPlacementSwapPositionsErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.fight.swapPositionRequestError"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp(),false);
               return true;
            case msg is GameFightPlacementSwapPositionsAcceptAction:
               gfpspaa = msg as GameFightPlacementSwapPositionsAcceptAction;
               gfpspamsg = new GameFightPlacementSwapPositionsAcceptMessage();
               gfpspamsg.initGameFightPlacementSwapPositionsAcceptMessage(gfpspaa.requestId);
               ConnectionsHandler.getConnection().send(gfpspamsg);
               return true;
            case msg is GameFightPlacementSwapPositionsCancelAction:
               gfpspca = msg as GameFightPlacementSwapPositionsCancelAction;
               gfpspcmsg = new GameFightPlacementSwapPositionsCancelMessage();
               gfpspcmsg.initGameFightPlacementSwapPositionsCancelMessage(gfpspca.requestId);
               ConnectionsHandler.getConnection().send(gfpspcmsg);
               return true;
            case msg is GameFightPlacementSwapPositionsCancelledMessage:
               gfpspcdmsg = msg as GameFightPlacementSwapPositionsCancelledMessage;
               swapPositionRequest = this.getSwapPositionRequest(gfpspcdmsg.requestId);
               if(swapPositionRequest)
               {
                  swapPositionRequest.destroy();
                  if(swapPositionRequest.requesterId == PlayedCharacterManager.getInstance().id && gfpspcdmsg.cancellerId != PlayedCharacterManager.getInstance().id)
                  {
                     entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                     cancellerInfo = entitiesFrame.getEntityInfos(gfpspcdmsg.cancellerId) as GameFightFighterInformations;
                     cancellerName = (cancellerInfo as GameFightFighterNamedInformations).name;
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.fight.swapPositionRequestRefused",["{player," + cancellerName + "," + cancellerInfo.contextualId + "::" + cancellerName + "}"]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp(),false);
                  }
               }
               return true;
            case msg is GameEntityDispositionErrorMessage:
               _log.error("Cette position n\'est pas accessible.");
               return true;
            case msg is GameFightReadyAction:
               gfra = msg as GameFightReadyAction;
               gfrmsg = new GameFightReadyMessage();
               gfrmsg.initGameFightReadyMessage(gfra.isReady);
               ConnectionsHandler.getConnection().send(gfrmsg);
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               clickedEntity = ecmsg.entity as IInteractive;
               if(clickedEntity)
               {
                  modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
                  fighter = new Object();
                  fighter.name = this._fightContextFrame.getFighterName(clickedEntity.id);
                  entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  fighterInfos = entitiesFrame.getEntityInfos(clickedEntity.id);
                  playerInfos = entitiesFrame.getEntityInfos(PlayedCharacterManager.getInstance().id) as GameFightFighterInformations;
                  if(fighterInfos is GameFightCharacterInformations)
                  {
                     menu = MenusFactory.create(fighter,"player",[clickedEntity]);
                  }
                  else if(fighterInfos is GameFightEntityInformation)
                  {
                     menu = MenusFactory.create(fighterInfos as GameFightEntityInformation,"companion",[clickedEntity]);
                  }
                  else
                  {
                     if(!(fighterInfos && playerInfos && fighterInfos.contextualId != playerInfos.contextualId && fighterInfos.spawnInfo.teamId == playerInfos.spawnInfo.teamId))
                     {
                        return true;
                     }
                     menu = MenusFactory.create(fighterInfos,"fightAlly",[clickedEntity]);
                  }
                  if(menu)
                  {
                     modContextMenu.createContextMenu(menu);
                  }
               }
               return true;
            case msg is GameContextKickAction:
               gcka = msg as GameContextKickAction;
               gckmsg = new GameContextKickMessage();
               gckmsg.initGameContextKickMessage(gcka.targetId);
               ConnectionsHandler.getConnection().send(gckmsg);
               return true;
            case msg is GameFightUpdateTeamMessage:
               gfutmsg = msg as GameFightUpdateTeamMessage;
               gfutmsg_myId = PlayedCharacterManager.getInstance().id;
               alreadyInTeam = false;
               for each(teamMember in gfutmsg.team.teamMembers)
               {
                  if(teamMember.id == gfutmsg_myId)
                  {
                     alreadyInTeam = true;
                  }
                  if(this._fightersId.indexOf(teamMember.id) == -1)
                  {
                     this._fightersId.push(teamMember.id);
                  }
               }
               if(alreadyInTeam || gfutmsg.team.teamMembers.length >= 1 && gfutmsg.team.teamMembers[0].id == gfutmsg_myId)
               {
                  PlayedCharacterManager.getInstance().teamId = gfutmsg.team.teamId;
                  this._fightContextFrame.isFightLeader = gfutmsg.team.leaderId == gfutmsg_myId;
               }
               return true;
            case msg is GameFightRemoveTeamMemberMessage:
               gfrtmmsg = msg as GameFightRemoveTeamMemberMessage;
               this._fightContextFrame.entitiesFrame.process(RemoveEntityAction.create(gfrtmmsg.charId));
               indexOfCharToRemove = this._fightersId.indexOf(gfrtmmsg.charId);
               if(indexOfCharToRemove != -1)
               {
                  this._fightersId.splice(indexOfCharToRemove,1);
               }
               return true;
            case msg is GameContextDestroyMessage:
               gfemsg2 = new GameFightEndMessage();
               gfemsg2.initGameFightEndMessage();
               fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFrame)
               {
                  fightContextFrame.process(gfemsg2);
               }
               else
               {
                  Kernel.getWorker().process(gfemsg2);
               }
               return true;
            case msg is IdolFightPreparationUpdateMessage:
               ifpum = msg as IdolFightPreparationUpdateMessage;
               KernelEventsManager.getInstance().processCallback(FightHookList.IdolFightPreparationUpdate,ifpum.idolSource,ifpum.idols);
               return true;
            case msg is ShowTacticModeAction:
               this.removeSelections();
               if(!TacticModeManager.getInstance().tacticModeActivated)
               {
                  TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap);
               }
               else if(!(msg as ShowTacticModeAction).force)
               {
                  TacticModeManager.getInstance().hide();
               }
               if(this._challengerPositions && this._challengerPositions.length > 0)
               {
                  this.displayZone(SELECTION_CHALLENGER,this._challengerPositions,COLOR_CHALLENGER,this._playerTeam == TeamEnum.TEAM_CHALLENGER ? Number(PLAYER_TEAM_ALPHA) : Number(ENEMY_TEAM_ALPHA));
               }
               if(this._defenderPositions && this._defenderPositions.length > 0)
               {
                  this.displayZone(SELECTION_DEFENDER,this._defenderPositions,COLOR_DEFENDER,this._playerTeam == TeamEnum.TEAM_DEFENDER ? Number(PLAYER_TEAM_ALPHA) : Number(ENEMY_TEAM_ALPHA));
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var swapPositionRequest:SwapPositionRequest = null;
         DataMapProvider.getInstance().isInFight = false;
         this.removeSelections();
         this._fightContextFrame.entitiesFrame.untargetableEntities = Dofus.getInstance().options.getOption("cellSelectionOnly");
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            swapPositionRequest.destroy();
         }
         return true;
      }
      
      private function removeSelections() : void
      {
         var sc:Selection = SelectionManager.getInstance().getSelection(SELECTION_CHALLENGER);
         if(sc)
         {
            sc.remove();
         }
         var sd:Selection = SelectionManager.getInstance().getSelection(SELECTION_DEFENDER);
         if(sd)
         {
            sd.remove();
         }
      }
      
      private function displayZone(name:String, cells:Vector.<uint>, color:Color, alpha:Number = 1.0) : void
      {
         var s:Selection = new Selection();
         s.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,alpha);
         s.color = color;
         s.zone = new Custom(cells);
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name);
      }
      
      private function isValidPlacementCell(cellId:uint, team:uint) : Boolean
      {
         var i:uint = 0;
         var mapPoint:MapPoint = MapPoint.fromCellId(cellId);
         if(!DataMapProvider.getInstance().pointMov(mapPoint.x,mapPoint.y,false))
         {
            return false;
         }
         var validCells:Vector.<uint> = new Vector.<uint>();
         switch(team)
         {
            case TeamEnum.TEAM_CHALLENGER:
               validCells = this._challengerPositions;
               break;
            case TeamEnum.TEAM_DEFENDER:
               validCells = this._defenderPositions;
               break;
            case TeamEnum.TEAM_SPECTATOR:
               return false;
         }
         if(validCells)
         {
            for(i = 0; i < validCells.length; i++)
            {
               if(validCells[i] == cellId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getSwapPositionRequest(pRequestId:uint) : SwapPositionRequest
      {
         var swapPositionRequest:SwapPositionRequest = null;
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            if(swapPositionRequest.requestId == pRequestId)
            {
               return swapPositionRequest;
            }
         }
         return null;
      }
      
      private function getPlayerSwapPositionRequests(pPlayerId:Number) : Vector.<SwapPositionRequest>
      {
         var swapPositionRequest:SwapPositionRequest = null;
         var swapPositionRequests:Vector.<SwapPositionRequest> = new Vector.<SwapPositionRequest>(0);
         for each(swapPositionRequest in this._swapPositionRequests)
         {
            if(swapPositionRequest.requesterId == pPlayerId || swapPositionRequest.requestedId == pPlayerId)
            {
               swapPositionRequests.push(swapPositionRequest);
            }
         }
         return swapPositionRequests;
      }
   }
}
