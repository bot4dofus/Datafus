package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickIndoorMerchantAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeOnHumanVendorRequestAction;
   
   public class HumanVendorMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function HumanVendorMenuMaker()
      {
         super();
      }
      
      private function onMerchantPlayerBuyClick(data:Object) : void
      {
         Api.system.sendAction(new ExchangeOnHumanVendorRequestAction([data.contextualId,data.disposition.cellId]));
      }
      
      private function onMerchantHouseKickOff(data:Object) : void
      {
         Api.system.sendAction(new HouseKickIndoorMerchantAction([data.disposition.cellId]));
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var menu:Array = new Array();
         var dead:* = !Api.player.isAlive();
         menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.humanVendor.playerShop",data.name,null,disabled)));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.buy"),this.onMerchantPlayerBuyClick,[data],disabled || dead));
         if(Api.player.isInHisHouse())
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.kickOff"),this.onMerchantHouseKickOff,[data]));
         }
         return menu;
      }
   }
}
