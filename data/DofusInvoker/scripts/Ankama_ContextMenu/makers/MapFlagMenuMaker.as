package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   
   public class MapFlagMenuMaker implements IMenuMaker
   {
       
      
      private var disabled:Boolean = false;
      
      private var _worldMapId:int;
      
      public function MapFlagMenuMaker()
      {
         super();
      }
      
      private function askRemoveFlag(flagId:String) : void
      {
         var flagType:int = 0;
         if(flagId.indexOf("flag_srv") == 0)
         {
            flagType = int(flagId.substring(8,9));
            switch(flagType)
            {
               case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                  Api.system.sendAction(new FriendSpouseFollowAction([false]));
                  break;
               case CompassTypeEnum.COMPASS_TYPE_PARTY:
                  Api.system.sendAction(new PartyStopFollowingMemberAction([Api.party.getPartyId(),int(flagId.substring(10))]));
                  break;
               default:
                  Api.system.dispatchHook(HookList.RemoveMapFlag,flagId,this._worldMapId);
            }
         }
         else
         {
            Api.system.dispatchHook(HookList.RemoveMapFlag,flagId,this._worldMapId);
         }
      }
      
      private function askOpenQuest(flagId:String) : void
      {
         var data:Object = null;
         var questId:int = int(flagId.split("_")[2]);
         var quest:Quest = Api.data.getQuest(questId);
         if(quest)
         {
            data = {};
            data.quest = quest;
            data.forceOpen = true;
            Api.system.dispatchHook(HookList.OpenBook,"questTab",data);
         }
      }
      
      private function mountRunToThisPosition(pMapX:int, pMapY:int, worldId:int = -1) : void
      {
         Api.map.autoTravel(pMapX,pMapY,worldId);
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var coords:Array = null;
         var flagX:int = 0;
         var flagY:int = 0;
         var mountInfo:MountData = null;
         var hasAutopilot:Boolean = false;
         var capacityCount:int = 0;
         var i:int = 0;
         var menu:Array = [];
         if(data && data.id.indexOf("flag_") == 0)
         {
            this._worldMapId = param[0];
            if(data.canBeManuallyRemoved)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.map.removeFlag"),this.askRemoveFlag,[data.id],this.disabled));
            }
            if(data.id.indexOf("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) == 0)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.shortcuts.openBookQuest"),this.askOpenQuest,[data.id],this.disabled));
            }
            coords = data.key.split("_");
            flagX = int(coords[0]);
            flagY = int(coords[1]);
            mountInfo = Api.player.getMount();
            if((Api.player.isRidding() || Api.player.isPetsMounting()) && mountInfo)
            {
               if(Api.system.getPlayerManager().hasFreeAutopilot)
               {
                  hasAutopilot = true;
               }
               else
               {
                  capacityCount = mountInfo.ability.length;
                  i = 0;
                  if(capacityCount)
                  {
                     for(i = 0; i < capacityCount; i++)
                     {
                        if(mountInfo.ability[i].id == DataEnum.MOUNT_CAPACITY_AUTOPILOT)
                        {
                           hasAutopilot = true;
                           break;
                        }
                     }
                  }
               }
               if(hasAutopilot)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mountTrip.travel"),this.mountRunToThisPosition,[flagX,flagY,this._worldMapId]));
               }
            }
         }
         return menu;
      }
   }
}
