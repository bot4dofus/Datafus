package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOutMessage;
   import com.ankamagames.atouin.messages.AdjacentMapOverMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.EntityMovementStartMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOverMessage;
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.atouin.messages.MapsLoadingStartedMessage;
   import com.ankamagames.berilia.components.messages.BrowserDomChange;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.components.messages.DropMessage;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.components.messages.MapMoveMessage;
   import com.ankamagames.berilia.components.messages.MapRollOverMessage;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.components.messages.TextClickMessage;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
   import com.ankamagames.berilia.types.messages.AllUiXmlParsedMessage;
   import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.network.messages.connection.CredentialsAcknowledgementMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicAckMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicNoOperationMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSynchronizeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightTurnReadyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.SlaveSwitchContextMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.initialization.OnConnectionEventMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectJobAddedMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.ConnectionResumedMessage;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class CleanupCrewFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CleanupCrewFrame));
       
      
      public function CleanupCrewFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.LOWEST;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is ServerConnectionFailedMessage:
            case msg is BasicAckMessage:
            case msg is BasicNoOperationMessage:
            case msg is CredentialsAcknowledgementMessage:
            case msg is OnConnectionEventMessage:
            case msg is ObjectJobAddedMessage:
            case msg is AllUiXmlParsedMessage:
            case msg is ConnectionResumedMessage:
            case msg is GameStartingMessage:
            case msg is BannerEmptySlotClickAction:
            case msg is MapRenderProgressMessage:
            case msg is GameEntitiesDispositionMessage:
            case msg is GameFightShowFighterMessage:
            case msg is TextureReadyMessage:
            case msg is EntityReadyMessage:
            case msg is MapRollOverMessage:
            case msg is ChangeMessage:
            case msg is SelectItemMessage:
            case msg is MapMoveMessage:
            case msg is TextClickMessage:
            case msg is DropMessage:
            case msg is MouseMiddleClickMessage:
            case msg is MapsLoadingStartedMessage:
            case msg is EntityMovementStartMessage:
            case msg is MapContainerRollOverMessage:
            case msg is MapContainerRollOutMessage:
            case msg is GameContextDestroyMessage:
            case msg is PlayerStatusUpdateMessage:
            case msg is MapComplementaryInformationsDataMessage:
            case msg is GameFightTurnReadyRequestMessage:
            case msg is GameFightSynchronizeMessage:
            case msg is CellClickMessage:
            case msg is AdjacentMapClickMessage:
            case msg is AdjacentMapOutMessage:
            case msg is AdjacentMapOverMessage:
            case msg is EntityMouseOverMessage:
            case msg is InteractiveElementActivationMessage:
            case msg is InteractiveElementMouseOverMessage:
            case msg is InteractiveElementMouseOutMessage:
            case msg is MouseOverMessage:
            case msg is MouseOutMessage:
            case msg is MouseDownMessage:
            case msg is MouseUpMessage:
            case msg is MouseClickMessage:
            case msg is MouseDoubleClickMessage:
            case msg is MouseRightClickMessage:
            case msg is MouseRightClickOutsideMessage:
            case msg is MouseRightDownMessage:
            case msg is MouseRightReleaseOutsideMessage:
            case msg is MouseRightUpMessage:
            case msg is KeyboardKeyDownMessage:
            case msg is KeyboardKeyUpMessage:
            case msg is MouseRightClickOutsideMessage:
            case msg is MouseRightClickMessage:
            case msg is MouseReleaseOutsideMessage:
            case msg is ItemRollOverMessage:
            case msg is ItemRollOutMessage:
            case msg is MouseWheelMessage:
            case msg is CellOverMessage:
            case msg is CellOutMessage:
            case msg is EntityMouseOutMessage:
            case msg is PlaySoundAction:
            case msg is ShowEntitiesTooltipsAction:
            case msg is SlaveSwitchContextMessage:
            case msg is VideoBufferChangeMessage:
            case msg is BrowserDomChange:
               return true;
            default:
               _log.info("[Warning] " + (getQualifiedClassName(msg) as String).split("::")[1] + " wasn\'t stopped by a frame.");
               return true;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}
