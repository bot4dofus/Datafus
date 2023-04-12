package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   
   public class PayZoneUiStats implements IHookStats, IUiStats
   {
       
      
      public function PayZoneUiStats(pUi:UiRootContainer)
      {
         super();
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var target:GraphicContainer = null;
         var type:String = null;
         var action:StatsAction = null;
         if(pMessage is MouseClickMessage)
         {
            target = !!pArgs ? pArgs[1] : null;
            if(target)
            {
               switch(target.name)
               {
                  case "btn_topLeft":
                     type = "POPUP";
                     break;
                  case "btn_link":
                     type = "CLIC";
               }
               if(type)
               {
                  action = new StatsAction(InternalStatisticTypeEnum.PAY_ZONE);
                  action.user = StatsAction.getUserId();
                  action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
                  action.setParam("account_id",PlayerManager.getInstance().accountId);
                  action.setParam("server_id",PlayerManager.getInstance().server.id);
                  action.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
                  action.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
                  action.setParam("map_id",PlayedCharacterManager.getInstance().currentMap.mapId);
                  action.setParam("type",type);
                  action.send();
               }
            }
         }
      }
      
      public function remove() : void
      {
      }
   }
}
