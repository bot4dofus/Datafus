package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.npcs.NpcAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import flash.utils.Dictionary;
   
   public class NpcMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function NpcMenuMaker()
      {
         super();
      }
      
      private function onNPCMenuClick(pNPCId:int, pActionId:int) : void
      {
         Api.system.sendAction(new NpcGenericActionRequestAction([pNPCId,pActionId]));
      }
      
      private function insertLink(pNpcName:String) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"Map",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "elementName":pNpcName + " "
            }
         });
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var realActions:Dictionary = null;
         var actionId:uint = 0;
         var action:* = undefined;
         var actionData:NpcAction = null;
         var menu:Array = [];
         var dead:* = !Api.player.isAlive();
         var npcId:int = data.npcId;
         var npc:Npc = Api.data.getNpc(npcId);
         var npcActions:Vector.<uint> = npc.actions;
         if(param.rightClick)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[npc.name],disabled));
            return menu;
         }
         if(npcActions.length > 0)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(npc.name));
            realActions = new Dictionary();
            for each(actionId in npcActions)
            {
               actionData = Api.data.getNpcAction(actionId);
               if(actionData && (actionData.realId != actionId || !realActions[actionData.realId]))
               {
                  realActions[actionData.realId] = actionData.name;
               }
            }
            for(action in realActions)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(realActions[action],this.onNPCMenuClick,[param.entity.id,action],disabled || dead));
            }
         }
         return menu;
      }
   }
}
