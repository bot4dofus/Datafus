package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightPreparationFrame;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   
   public class HyperlinkSwapPositionRequest
   {
       
      
      public function HyperlinkSwapPositionRequest()
      {
         super();
      }
      
      public static function showMenu(pRequestId:uint, pIsRequester:Boolean) : void
      {
         var frame:FightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
         if(frame && frame.isSwapPositionRequestValid(pRequestId))
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.ShowSwapPositionRequestMenu,pRequestId,pIsRequester);
         }
      }
   }
}
