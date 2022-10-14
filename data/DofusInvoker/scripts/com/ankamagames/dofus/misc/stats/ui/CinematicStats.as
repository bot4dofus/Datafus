package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.components.VideoPlayer;
   import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.getTimer;
   
   public class CinematicStats implements IUiStats, IHookStats
   {
       
      
      private var _action:StatsAction;
      
      private var _startTime:int;
      
      private var _tutorialAction:StatsAction;
      
      public function CinematicStats(pUi:UiRootContainer)
      {
         super();
         var flv:String = (pUi.getElement("vplayer") as VideoPlayer).flv;
         if(flv.indexOf("10.flv") != -1)
         {
            this._action = StatsAction.get(InternalStatisticTypeEnum.LOOK_CINEMATIC);
            this._action.setParam("account_id",PlayerManager.getInstance().accountId);
            this._action.setParam("server_id",PlayerManager.getInstance().server.id);
            this._action.setParam("step_id",300);
            this._action.start();
            this._action.send();
            StatisticsManager.getInstance().setFirstTimeUserExperience(pUi.name,false);
            this._startTime = getTimer();
            this._tutorialAction = StatsAction.get(InternalStatisticTypeEnum.TUTORIAL_START);
            this._tutorialAction.setParam("trailer_skip",false);
         }
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var vbcmsg:VideoBufferChangeMessage = null;
         if(pMessage is VideoBufferChangeMessage)
         {
            vbcmsg = pMessage as VideoBufferChangeMessage;
            if(vbcmsg.state == 2)
            {
               this.onVideoEnd();
            }
         }
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         if(pHook == CustomUiHookList.StopCinematic)
         {
            this._tutorialAction.setParam("trailer_skip",true);
            this.onVideoEnd();
         }
      }
      
      public function remove() : void
      {
      }
      
      private function onVideoEnd() : void
      {
         this._tutorialAction.setParam("action_duration_seconds",int((getTimer() - this._startTime) / 1000));
      }
   }
}
