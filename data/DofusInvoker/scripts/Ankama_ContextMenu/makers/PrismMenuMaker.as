package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismModuleExchangeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismSetSabotagedRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismUseRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.AlliancePrismModuleTypeEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismInformation;
   
   public class PrismMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public var _subAreaId:int;
      
      public function PrismMenuMaker()
      {
         super();
      }
      
      private function onPrismTalk(entityId:Number) : void
      {
         Api.system.sendAction(new NpcGenericActionRequestAction([entityId,3]));
      }
      
      private function onPrismAttacked() : void
      {
         Api.system.sendAction(new PrismAttackRequestAction([]));
      }
      
      private function onPrismTeleport() : void
      {
         Api.system.sendAction(new PrismUseRequestAction([AlliancePrismModuleTypeEnum.TELEPORTER]));
      }
      
      private function onPrismRecycle() : void
      {
         Api.system.sendAction(new PrismUseRequestAction([AlliancePrismModuleTypeEnum.RECYCLER]));
      }
      
      private function onPrismModulesManage() : void
      {
         Api.system.sendAction(new PrismModuleExchangeRequestAction([]));
      }
      
      private function onPrismModify() : void
      {
         var subAreaId:int = Api.player.currentSubArea().id;
         Api.system.dispatchHook(SocialHookList.OpenSocial,2,1,[subAreaId]);
      }
      
      private function onPrismSabotage(nextVulneDate:Number) : void
      {
         this._subAreaId = Api.player.currentSubArea().id;
         var vulneStart:String = Api.time.getDate(nextVulneDate * 1000) + " " + Api.time.getClock(nextVulneDate * 1000);
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.prism.sabotageConfirm",Api.player.currentSubArea().name,vulneStart),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onValidSabotage],this.onValidSabotage);
      }
      
      protected function onValidSabotage() : void
      {
         Api.system.sendAction(new PrismSetSabotagedRequestAction([this._subAreaId]));
      }
      
      private function insertLink(pPrismText:String) : void
      {
         Api.system.dispatchHook(BeriliaHookList.MouseShiftClick,{
            "data":"Map",
            "params":{
               "x":Api.player.currentMap().outdoorX,
               "y":Api.player.currentMap().outdoorY,
               "worldMapId":Api.player.currentSubArea().worldmap.id,
               "elementName":pPrismText + " "
            }
         });
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var name:String = null;
         var prismText:String = null;
         var alInsiderPrismInfos:AllianceInsiderPrismInformation = null;
         var mo:ObjectItem = null;
         var effect:ObjectEffect = null;
         var menu:Array = [];
         var dead:* = !Api.player.isAlive();
         var prismInfos:PrismInformation = data.prism;
         name = Api.social.getAllianceNameAndTag(prismInfos);
         if(param.rightClick)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            prismText = Api.ui.getText("ui.prism.prismInState",Api.ui.getText("ui.prism.state" + prismInfos.state)) + " " + Api.ui.replaceKey(name);
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.chat.insertCoordinates"),this.insertLink,[prismText],disabled));
            return menu;
         }
         if(prismInfos is AlliancePrismInformation)
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onPrismTalk,[param.entity.id]));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.attack"),this.onPrismAttacked,null,disabled || dead || prismInfos.state != PrismStateEnum.PRISM_STATE_NORMAL));
         }
         else if(prismInfos is AllianceInsiderPrismInformation)
         {
            alInsiderPrismInfos = prismInfos as AllianceInsiderPrismInformation;
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onPrismTalk,[param.entity.id]));
            if(alInsiderPrismInfos.modulesObjects && alInsiderPrismInfos.modulesObjects.length > 0)
            {
               for each(mo in alInsiderPrismInfos.modulesObjects)
               {
                  if(mo.objectGID == DataEnum.ITEM_GID_TELEPORTATION_MODULE)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.teleport"),this.onPrismTeleport,null,prismInfos.state == PrismStateEnum.PRISM_STATE_VULNERABLE));
                  }
                  else
                  {
                     for each(effect in mo.effects)
                     {
                        if(effect.actionId == ActionIds.ACTION_NUGGETS_REPARTITION)
                        {
                           menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.recycle.recycle"),this.onPrismRecycle,null,prismInfos.state == PrismStateEnum.PRISM_STATE_VULNERABLE));
                        }
                     }
                  }
               }
            }
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.prism.manageModules"),this.onPrismModulesManage,null,prismInfos.state == PrismStateEnum.PRISM_STATE_VULNERABLE));
            if(Api.social.hasGuildRight(Api.player.id(),"setAlliancePrism"))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.modify"),this.onPrismModify));
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.prism.sabotage"),this.onPrismSabotage,[alInsiderPrismInfos.nextVulnerabilityDate],prismInfos.state != PrismStateEnum.PRISM_STATE_NORMAL));
            }
         }
         return menu;
      }
   }
}
