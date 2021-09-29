package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessColorsUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessDissociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   
   public class MountMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function MountMenuMaker()
      {
         super();
      }
      
      private function onDetails(data:Object) : void
      {
         Api.system.sendAction(new MountInformationInPaddockRequestAction([data.id]));
      }
      
      private function onOpenMountOptions() : void
      {
         Api.system.sendAction(new OpenMountAction([]));
      }
      
      private function onEquipMount() : void
      {
         Api.system.sendAction(new MountToggleRidingRequestAction([]));
      }
      
      private function onHarnessDissociate() : void
      {
         Api.system.sendAction(new MountHarnessDissociateRequestAction([]));
      }
      
      private function onUseHarnessColors(useHarnessColors:Boolean) : void
      {
         Api.system.sendAction(new MountHarnessColorsUpdateRequestAction([useHarnessColors]));
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var myMount:MountData = null;
         var harnessOptionsDisabled:* = false;
         Api.ui.hideTooltip();
         var menu:Array = [];
         if(data.hasOwnProperty("ownerName"))
         {
            menu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.mount.mountOf",data.ownerName)));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.viewMountDetails"),this.onDetails,[param[0]],disabled));
         }
         else
         {
            myMount = Api.player.getMount();
            harnessOptionsDisabled = myMount.harnessGID == 0;
            menu.push(ContextMenu.static_createContextMenuTitleObject(myMount.name,false));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.options"),this.onOpenMountOptions,null,disabled));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.equip"),this.onEquipMount,null,disabled));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.dissociate"),this.onHarnessDissociate,null,disabled || harnessOptionsDisabled));
            if(myMount.useHarnessColors)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.useMountColors"),this.onUseHarnessColors,[false],disabled || harnessOptionsDisabled));
            }
            else
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.harness.useHarnessColors"),this.onUseHarnessColors,[true],disabled || harnessOptionsDisabled));
            }
         }
         return menu;
      }
   }
}
