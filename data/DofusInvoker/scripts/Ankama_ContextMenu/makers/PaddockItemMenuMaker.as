package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.PaddockInstanceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.PaddockWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   
   public class PaddockItemMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function PaddockItemMenuMaker()
      {
         super();
      }
      
      private function onPaddockRemoved(cellId:uint) : void
      {
         Api.system.sendAction(new PaddockRemoveItemRequestAction([cellId]));
      }
      
      private function onPaddockMoved(o:Object, cellId:uint) : void
      {
         Api.system.sendAction(new PaddockMoveItemRequestAction([o]));
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var guild:GuildWrapper = null;
         var paddockInstance:PaddockInstanceWrapper = null;
         var menu:Array = [];
         var paddock:PaddockWrapper = Api.mount.getCurrentPaddock();
         if(paddock)
         {
            if(paddock.paddockInstances.length == 0)
            {
               this.addMenuItems(menu,data,param);
            }
            else
            {
               guild = Api.social.getGuild();
               if(guild && Api.social.hasGuildRight(Api.player.id(),GuildRightsEnum.RIGHT_MANAGE_PADDOCKS))
               {
                  for each(paddockInstance in paddock.paddockInstances)
                  {
                     if(paddockInstance.guildIdentity && paddockInstance.guildIdentity.guildId == guild.guildId)
                     {
                        this.addMenuItems(menu,data,param);
                        break;
                     }
                  }
               }
            }
         }
         return menu;
      }
      
      private function addMenuItems(menu:Array, data:*, param:Object) : void
      {
         var dead:* = !Api.player.isAlive();
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.remove"),this.onPaddockRemoved,[param[0].position.cellId],disabled || dead));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.move"),this.onPaddockMoved,[data,param[0].position.cellId],disabled || dead));
      }
   }
}
