package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRequestOnTaxCollectorAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   
   public class TaxCollectorMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function TaxCollectorMenuMaker()
      {
         super();
      }
      
      private function onTalkTaxCollectorClick(pTaxCollectorContextualId:int) : void
      {
         Api.system.sendAction(new NpcGenericActionRequestAction([pTaxCollectorContextualId,3]));
      }
      
      private function onCollectTaxCollectorClick(pTaxCollectorContextualId:int) : void
      {
         Api.system.sendAction(new ExchangeRequestOnTaxCollectorAction([]));
      }
      
      private function onAttackTaxCollectorClick(pTaxCollectorContextualId:int) : void
      {
         Api.system.sendAction(new GameRolePlayTaxCollectorFightRequestAction([]));
      }
      
      private function insertLink(pTaxCollectorText:String) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"Map",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "elementName":pTaxCollectorText + " "
            }
         });
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var playerInfos:Object = null;
         var lDisabled:* = false;
         var aDisabled:Boolean = false;
         var menu:Array = [];
         var dead:* = !Api.player.isAlive();
         var taxCollectorName:String = Api.data.getTaxCollectorFirstname(data.identification.firstNameId).firstname + " " + Api.data.getTaxCollectorName(data.identification.lastNameId).name;
         menu.push(ContextMenu.static_createContextMenuTitleObject(taxCollectorName));
         if(param.rightClick)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[Api.ui.getText("ui.guild.taxCollector",data.identification.guildIdentity.guildName)],disabled));
            return menu;
         }
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onTalkTaxCollectorClick,[param.entity.id]));
         if(Api.social.hasGuild() && Api.social.getGuild().guildId == data.identification.guildIdentity.guildId)
         {
            playerInfos = Api.player.getPlayedCharacterInfo();
            lDisabled = !(Api.social.hasGuildRight(playerInfos.id,GuildWrapper.COLLECT) || data.identification.callerId == playerInfos.id && Api.social.hasGuildRight(playerInfos.id,GuildWrapper.COLLECT_MY_TAX_COLLECTORS));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.CollectTaxCollector"),this.onCollectTaxCollectorClick,[param.entity.id],disabled || lDisabled || dead));
         }
         else
         {
            aDisabled = false;
            if(data.taxCollectorAttack != 0)
            {
               aDisabled = true;
            }
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.attack"),this.onAttackTaxCollectorClick,[param.entity.id],disabled || aDisabled || dead));
         }
         return menu;
      }
   }
}
