package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaUnregisterAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.getTimer;
   
   public class KolizeumStats implements IUiStats, IHookStats
   {
       
      
      private var _action:StatsAction;
      
      private var _timer:uint = 0;
      
      private var _useEnter:Boolean = false;
      
      private var _joinQueue:uint = 0;
      
      private var _joinTimer:uint = 0;
      
      private var _leaveQueue:uint = 0;
      
      private var _leaveTime:uint = 0;
      
      private var _clickLadder:Boolean = false;
      
      private var _clickHelp:Boolean = false;
      
      public function KolizeumStats(ui:UiRootContainer)
      {
         super();
         this._action = new StatsAction(InternalStatisticTypeEnum.KOLIZEUM);
         this._action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         this._action.setParam("account_id",PlayerManager.getInstance().accountId);
         this._action.setParam("server_id",PlayerManager.getInstance().server.id);
         this._action.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         this._timer = getTimer();
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var target:GraphicContainer = null;
         if(pMessage is ArenaRegisterAction)
         {
            ++this._joinQueue;
            this._joinTimer = getTimer();
            if(ArenaRegisterAction(pMessage).shortcut)
            {
               this._useEnter = true;
            }
         }
         else if(pMessage is ArenaUnregisterAction)
         {
            ++this._leaveQueue;
            this._joinTimer = int(Math.round(Number(getTimer() - this._joinTimer) / 1000));
            this._leaveTime = Math.max(this._leaveTime,this._joinTimer);
         }
         else if(pMessage is MouseClickMessage)
         {
            target = !!pArgs ? pArgs[1] : null;
            if(target)
            {
               if(target.name == "btn_help")
               {
                  this._clickHelp = true;
               }
               else if(target.name == "lbl_ladderAccess")
               {
                  this._clickLadder = true;
               }
            }
         }
      }
      
      public function remove() : void
      {
         this._timer = int(Math.round(Number(getTimer() - this._timer) / 1000));
         this._action.setParam("map_id",PlayedCharacterManager.getInstance().currentMap.mapId);
         this._action.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         this._action.setParam("action_duration_seconds",this._timer);
         this._action.setParam("use_enter",this._useEnter);
         this._action.setParam("join_queue",this._joinQueue);
         this._action.setParam("leave_queue",this._leaveQueue);
         this._action.setParam("leave_time",this._leaveTime);
         this._action.setParam("clic_ladder",this._clickLadder);
         this._action.setParam("clic_help",this._clickHelp);
         this._action.send();
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
      }
   }
}
