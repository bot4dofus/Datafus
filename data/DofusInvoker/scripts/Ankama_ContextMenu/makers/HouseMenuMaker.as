package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   
   public class HouseMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function HouseMenuMaker()
      {
         super();
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var menu:Array = [];
         menu.push(ContextMenu.static_createContextMenuTitleObject(data.name));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[data.name],disabled));
         return menu;
      }
      
      private function insertLink(houseName:String) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"Map",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "elementName":houseName + " "
            }
         });
      }
   }
}
