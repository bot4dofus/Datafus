package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.PortalUseRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.PortalInformation;
   
   public class PortalMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public var _portalId:int;
      
      public var _areaName:String;
      
      public function PortalMenuMaker()
      {
         super();
      }
      
      private function onPortalTalk(entityId:Number) : void
      {
         Api.system.sendAction(new NpcGenericActionRequestAction([entityId,3]));
      }
      
      private function onPortalUse() : void
      {
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.dimension.confirmTeleport",this._areaName),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onValid],this.onValid);
      }
      
      protected function onValid() : void
      {
         Api.system.sendAction(new PortalUseRequestAction([this._portalId]));
      }
      
      private function insertLink(pPortalName:String) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"Map",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "elementName":pPortalName + " "
            }
         });
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var name:String = null;
         var menu:Array = [];
         var dead:* = !Api.player.isAlive();
         var portalInfos:PortalInformation = data.portal;
         this._portalId = portalInfos.portalId;
         var area:Area = Api.data.getArea(portalInfos.areaId);
         if(area)
         {
            this._areaName = area.name;
         }
         else
         {
            this._areaName = "???";
         }
         name = Api.ui.getText("ui.dimension.portal",this._areaName);
         menu.push(ContextMenu.static_createContextMenuTitleObject(name));
         if(!param.rightClick)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onPortalTalk,[param.entity.id]));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.use"),this.onPortalUse,null,disabled || dead));
         }
         else
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[name],disabled));
         }
         return menu;
      }
   }
}
