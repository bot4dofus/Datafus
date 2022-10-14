package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.EntityMovementStoppedMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.dofus.logic.game.roleplay.messages.CharacterMovementStoppedMessage;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.display.Sprite;
   
   public class MoveBehavior extends AbstractBehavior
   {
       
      
      private var _abstractEntitiesFrame:AbstractEntitiesFrame;
      
      private var _fakepos:int = -1;
      
      public var forceWalk:Boolean;
      
      public function MoveBehavior()
      {
         super();
         type = NORMAL;
         isAvailableToStart = true;
      }
      
      override public function processInputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         var entity:IEntity = null;
         var tmpCellId:uint = 0;
         var ccm:CellClickMessage = null;
         canBeStacked = false;
         if(this._abstractEntitiesFrame == null)
         {
            this._abstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         }
         if((pMsgToProcess is CellClickMessage || pMsgToProcess is EntityClickMessage) && !PlayedCharacterManager.getInstance().isFighting && pMode == type)
         {
            entity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(pMsgToProcess is CellClickMessage)
            {
               tmpCellId = (pMsgToProcess as CellClickMessage).cellId;
            }
            else
            {
               if(!(pMsgToProcess is EntityClickMessage && this._abstractEntitiesFrame.getEntityInfos((pMsgToProcess as EntityClickMessage).entity.id) is GameRolePlayGroupMonsterInformations))
               {
                  return false;
               }
               tmpCellId = (pMsgToProcess as EntityClickMessage).entity.position.cellId;
            }
            if(entity != null && entity.position.cellId != tmpCellId)
            {
               pendingMessage = pMsgToProcess;
               canBeStacked = true;
               isAvailableToStart = true;
               if(pMsgToProcess is CellClickMessage)
               {
                  ccm = pMsgToProcess as CellClickMessage;
                  position = ccm.cell;
                  if(!position)
                  {
                     position = MapPoint.fromCellId(ccm.cellId);
                  }
               }
               else if(pMsgToProcess is EntityClickMessage)
               {
                  position = (pMsgToProcess as EntityClickMessage).entity.position;
               }
               this.forceWalk = OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown);
               return true;
            }
         }
         else if(pMsgToProcess is CellClickMessage && !PlayedCharacterManager.getInstance().isFighting && pMode == ALWAYS)
         {
            this._fakepos = (pMsgToProcess as CellClickMessage).cellId;
            return true;
         }
         return false;
      }
      
      override public function processOutputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         var entity:IEntity = null;
         if(pMsgToProcess is CellClickMessage && pMode == ALWAYS)
         {
            isAvailableToStart = false;
         }
         else if(pMsgToProcess is CharacterMovementStoppedMessage || pMsgToProcess is EntityMovementStoppedMessage)
         {
            this._fakepos = -1;
            entity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(entity != null && entity.position.cellId == position.cellId)
            {
               this._fakepos = -1;
               actionStarted = true;
               return true;
            }
            this._fakepos = entity.position.cellId;
         }
         return false;
      }
      
      override public function checkAvailability(pMsgToProcess:Message) : void
      {
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            isAvailableToStart = false;
         }
         else
         {
            isAvailableToStart = true;
         }
      }
      
      override public function copy() : AbstractBehavior
      {
         var cp:MoveBehavior = null;
         cp = new MoveBehavior();
         cp.pendingMessage = this.pendingMessage;
         cp.position = this.position;
         cp.type = this.type;
         cp.forceWalk = this.forceWalk;
         cp.sprite = !!cp.forceWalk ? EmbedAssets.getSprite("CHECKPOINT_CLIP_WALK") : EmbedAssets.getSprite("CHECKPOINT_CLIP");
         return cp;
      }
      
      override public function get needToWait() : Boolean
      {
         return this._fakepos != -1;
      }
      
      override public function getFakePosition() : MapPoint
      {
         var mp:MapPoint = new MapPoint();
         mp.cellId = this._fakepos;
         return mp;
      }
      
      override public function processMessageToWorker() : void
      {
         var rpMovementFrame:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         rpMovementFrame.forceNextMovementBehavior(!!this.forceWalk ? uint(AtouinConstants.MOVEMENT_WALK) : uint(AtouinConstants.MOVEMENT_NORMAL));
         super.processMessageToWorker();
      }
      
      override public function isAvailableToProcess(pMsg:Message) : Boolean
      {
         var rpMovementFrame:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         return !rpMovementFrame.isRequestingMovement;
      }
   }
}
