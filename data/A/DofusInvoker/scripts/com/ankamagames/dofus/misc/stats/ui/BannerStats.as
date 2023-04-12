package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.userInterface.ButtonWrapper;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   
   public class BannerStats implements IUiStats, IHookStats
   {
       
      
      private var _currentBtnMenuId:uint;
      
      public function BannerStats(pUi:UiRootContainer)
      {
         super();
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var simsg:SelectItemMessage = null;
         var grid:Grid = null;
         switch(true)
         {
            case pMessage is SelectItemMessage:
               simsg = pMessage as SelectItemMessage;
               grid = simsg.target as Grid;
               if(grid && (grid.name == "gd_btnUis" || grid.name == "gd_additionalBtns"))
               {
                  if(grid.selectedItem && grid.selectedItem is ButtonWrapper && this._currentBtnMenuId != grid.selectedItem.id)
                  {
                     this.sendOpenMenu(grid.selectedItem);
                     this._currentBtnMenuId = grid.selectedItem.id;
                  }
                  else
                  {
                     this._currentBtnMenuId = 0;
                  }
               }
         }
      }
      
      private function sendOpenMenu(button:ButtonWrapper) : void
      {
         var statsAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.BANNER);
         statsAction.user = StatsAction.getUserId();
         statsAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         statsAction.setParam("account_id",PlayerManager.getInstance().accountId);
         statsAction.setParam("server_id",PlayerManager.getInstance().server.id);
         statsAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         statsAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         statsAction.setParam("button_id",button.id);
         statsAction.setParam("button_name",button.name);
         statsAction.send();
      }
      
      public function remove() : void
      {
      }
   }
}
