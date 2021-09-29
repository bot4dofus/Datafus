package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyCancelInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyKickRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   
   public class CompanionMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function CompanionMenuMaker()
      {
         super();
      }
      
      private function onDismiss() : void
      {
         var companionUID:int = 0;
         var item:ItemWrapper = null;
         var equipment:Vector.<ItemWrapper> = Api.storage.getViewContent("equipment");
         for each(item in equipment)
         {
            if(item && item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)
            {
               companionUID = item.objectUID;
               break;
            }
         }
         if(companionUID != 0)
         {
            Api.system.sendAction(new ObjectSetPositionAction([companionUID,63,1]));
         }
      }
      
      private function onSwitchPlaces(cellId:int, companionId:Number) : void
      {
         Api.system.sendAction(new GameFightPlacementSwapPositionsRequestAction([cellId,companionId]));
      }
      
      protected function onKick(targetId:Number) : void
      {
         Api.system.sendAction(new GameContextKickAction([targetId]));
      }
      
      protected function kickPlayer(partyId:int, playerId:Number) : void
      {
         Api.system.sendAction(new PartyKickRequestAction([partyId,playerId]));
      }
      
      protected function cancelPartyInvitation(partyId:int, guestId:Number) : void
      {
         Api.system.sendAction(new PartyCancelInvitationAction([partyId,guestId]));
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var cData:Object = null;
         var playerId:Number = NaN;
         var playerName:String = null;
         var companionId:Number = NaN;
         var companionName:String = null;
         var partyId:int = 0;
         var playerIsGuest:* = false;
         var partyMember:PartyMemberWrapper = null;
         if(data is GameFightEntityInformation)
         {
            cData = data as GameFightEntityInformation;
            if(Api.player.isInFight() && !Api.player.isInPreFight())
            {
               return [];
            }
            playerId = cData.masterId;
            companionId = cData.contextualId;
            companionName = Api.data.getCompanion(cData.entityModelId).name;
            if(playerId != Api.player.id())
            {
               playerName = Api.fight.getFighterName(playerId);
               companionName = Api.ui.getText("ui.common.belonging",companionName,playerName);
            }
            else
            {
               playerName = Api.player.getPlayedCharacterInfo().name;
            }
         }
         else
         {
            cData = data as PartyCompanionWrapper;
            playerId = cData.id;
            playerName = cData.masterName;
            companionId = cData.id;
            companionName = cData.name;
         }
         var menu:Array = [];
         var companionTeam:String = Api.fight.getFighterInformations(playerId).team;
         var ownTeam:String = Api.fight.getFighterInformations(Api.player.id()).team;
         menu.push(ContextMenu.static_createContextMenuTitleObject(companionName));
         if(playerId == Api.player.id())
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.dismiss"),this.onDismiss,[],disabled));
         }
         else
         {
            if(Api.player.isInPreFight() && Api.fight.isFightLeader())
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.fight.kickSomeone",playerName),this.onKick,[playerId],disabled));
            }
            if(Api.player.isInParty())
            {
               partyId = Api.party.getPartyId();
               if(partyId > 0 && Api.party.getPartyLeaderId(partyId) == Api.player.id())
               {
                  playerIsGuest = false;
                  for each(partyMember in Api.party.getPartyMembers(0))
                  {
                     if(partyMember.id == playerId)
                     {
                        playerIsGuest = !partyMember.isMember;
                        break;
                     }
                  }
                  if(playerIsGuest)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.cancelInvitationForSomeone",playerName),this.cancelPartyInvitation,[partyId,playerId]));
                  }
                  else
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickSomeone",playerName),this.kickPlayer,[partyId,playerId]));
                  }
               }
            }
         }
         if(Api.player.isInPreFight() && companionTeam == ownTeam && cData.hasOwnProperty("disposition") && cData.disposition)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.switchPlaces"),this.onSwitchPlaces,[cData.disposition.cellId,companionId],disabled));
         }
         if(menu.length == 1)
         {
            menu = null;
         }
         return menu;
      }
   }
}
