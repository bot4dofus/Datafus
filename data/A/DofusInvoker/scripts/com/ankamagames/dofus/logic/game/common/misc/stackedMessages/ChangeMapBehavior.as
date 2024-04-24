package com.ankamagames.dofus.logic.game.common.misc.stackedMessages
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   
   public class ChangeMapBehavior extends AbstractBehavior
   {
       
      
      public var forceWalk:Boolean;
      
      public function ChangeMapBehavior()
      {
         super();
         type = STOP;
      }
      
      override public function processInputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         var cellId:uint = 0;
         var walkingId:String = null;
         if(pendingMessage == null && pMsgToProcess is AdjacentMapClickMessage)
         {
            pendingMessage = pMsgToProcess;
            cellId = (pendingMessage as AdjacentMapClickMessage).cellId;
            position = MapPoint.fromCellId(cellId);
            this.forceWalk = OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown);
            walkingId = !!this.forceWalk ? "_WALK" : "";
            if(CellUtil.isLeftCol(cellId))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_LEFT" + walkingId);
            }
            else if(CellUtil.isRightCol(cellId))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_RIGHT" + walkingId);
            }
            else if(CellUtil.isBottomRow(cellId))
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_BOTTOM" + walkingId);
            }
            else
            {
               sprite = EmbedAssets.getSprite("CHECKPOINT_CLIP_TOP" + walkingId);
            }
            return true;
         }
         return false;
      }
      
      override public function processOutputMessage(pMsgToProcess:Message, pMode:String) : Boolean
      {
         return true;
      }
      
      override public function copy() : AbstractBehavior
      {
         var cp:ChangeMapBehavior = new ChangeMapBehavior();
         cp.pendingMessage = this.pendingMessage;
         cp.position = this.position;
         cp.sprite = this.sprite;
         cp.forceWalk = this.forceWalk;
         return cp;
      }
      
      override public function processMessageToWorker() : void
      {
         var rpMovementFrame:RoleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
         if(rpMovementFrame)
         {
            rpMovementFrame.forceNextMovementBehavior(!!this.forceWalk ? uint(AtouinConstants.MOVEMENT_WALK) : uint(AtouinConstants.MOVEMENT_NORMAL));
         }
         super.processMessageToWorker();
      }
   }
}
