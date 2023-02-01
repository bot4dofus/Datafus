package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityHideRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityLockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivitySuggestionsRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.progression.suggestion.ActivityHideRequestMessage;
   import com.ankamagames.dofus.network.messages.game.progression.suggestion.ActivityLockRequestMessage;
   import com.ankamagames.dofus.network.messages.game.progression.suggestion.ActivitySuggestionsMessage;
   import com.ankamagames.dofus.network.messages.game.progression.suggestion.ActivitySuggestionsRequestMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.getQualifiedClassName;
   
   public class ProgressionFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ProgressionFrame));
       
      
      public function ProgressionFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function process(msg:Message) : Boolean
      {
         var asra:ActivitySuggestionsRequestAction = null;
         var asrm:ActivitySuggestionsRequestMessage = null;
         var alra:ActivityLockRequestAction = null;
         var alrm:ActivityLockRequestMessage = null;
         var ahra:ActivityHideRequestAction = null;
         var ahrm:ActivityHideRequestMessage = null;
         var asm:ActivitySuggestionsMessage = null;
         switch(true)
         {
            case msg is ActivitySuggestionsRequestAction:
               asra = msg as ActivitySuggestionsRequestAction;
               asrm = new ActivitySuggestionsRequestMessage();
               asrm.initActivitySuggestionsRequestMessage(asra.minLevel,asra.maxLevel,asra.areaId,asra.activityCategoryId,asra.nbCards);
               ConnectionsHandler.getConnection().send(asrm);
               return true;
            case msg is ActivityLockRequestAction:
               alra = msg as ActivityLockRequestAction;
               alrm = new ActivityLockRequestMessage();
               alrm.initActivityLockRequestMessage(alra.activityId,alra.lock);
               ConnectionsHandler.getConnection().send(alrm);
               return true;
            case msg is ActivityHideRequestAction:
               ahra = msg as ActivityHideRequestAction;
               ahrm = new ActivityHideRequestMessage();
               ahrm.initActivityHideRequestMessage(ahra.activityId);
               ConnectionsHandler.getConnection().send(ahrm);
               return true;
            case msg is ActivitySuggestionsMessage:
               asm = msg as ActivitySuggestionsMessage;
               KernelEventsManager.getInstance().processCallback(HookList.ActivitySuggestions,asm.lockedActivitiesIds,asm.unlockedActivitiesIds);
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}
