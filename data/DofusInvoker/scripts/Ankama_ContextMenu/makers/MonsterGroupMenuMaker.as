package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupInformations;
   
   public class MonsterGroupMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function MonsterGroupMenuMaker()
      {
         super();
      }
      
      private function askBestiary(monsterIds:Array) : void
      {
         var data:Object = {};
         data.monsterId = 0;
         data.monsterSearch = null;
         data.monsterIdsList = monsterIds;
         data.forceOpen = true;
         Api.system.dispatchHook(HookList.OpenEncyclopedia,"bestiaryTab",data);
      }
      
      private function insertLink(pInfos:*) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"MonsterGroup",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "monsterName":Api.data.getMonsterFromId(pInfos.staticInfos.mainCreatureLightInfos.genericId).name,
               "infos":Api.roleplay.getMonsterGroupString(pInfos)
            }
         });
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var creature:MonsterInGroupInformations = null;
         var menu:Array = [];
         var monsterIds:Array = [];
         monsterIds.push(data.staticInfos.mainCreatureLightInfos.genericId);
         for each(creature in data.staticInfos.underlings)
         {
            if(monsterIds.indexOf(creature.genericId) == -1)
            {
               monsterIds.push(creature.genericId);
            }
         }
         if(monsterIds.length > 0)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"),this.askBestiary,[monsterIds],disabled));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[data],disabled));
         }
         return menu;
      }
   }
}
