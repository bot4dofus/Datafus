package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class FightWorldMenuMaker extends WorldMenuMaker
   {
       
      
      public function FightWorldMenuMaker()
      {
         super();
      }
      
      private function onInvisibleModeChange(value:Boolean) : void
      {
         Api.system.sendAction(new ToggleDematerializationAction([]));
      }
      
      private function onCellSelectionOnly(value:Boolean) : void
      {
         switchOption("dofus","cellSelectionOnly");
      }
      
      private function onShowMovementDistance(value:Boolean) : void
      {
         switchOption("dofus","showMovementDistance");
      }
      
      private function onShowMovementArea(value:Boolean) : void
      {
         switchOption("dofus","showMovementArea");
      }
      
      private function onShowUsedPaPmChange(value:Boolean) : void
      {
         switchOption("dofus","showUsedPaPm");
      }
      
      private function onRemindTurnChange(value:Boolean) : void
      {
         switchOption("dofus","remindTurn");
      }
      
      private function onOrderFightersChange(value:Boolean) : void
      {
         switchOption("dofus","orderFighters");
         Api.system.dispatchHook(HookList.OrderFightersSwitched,value);
      }
      
      private function onShowTacticMode(value:Boolean) : void
      {
         switchOption("dofus","showTacticMode");
         Api.system.sendAction(new ShowTacticModeAction([]));
      }
      
      private function onHideDeadFighters(value:Boolean) : void
      {
         switchOption("dofus","hideDeadFighters");
         Api.system.dispatchHook(HookList.HideDeadFighters,Api.system.getOption("hideDeadFighters","dofus"));
      }
      
      private function onShowLogPvDetails(value:Boolean) : void
      {
         switchOption("dofus","showLogPvDetails");
      }
      
      private function onHideSummonedFighters(value:Boolean) : void
      {
         switchOption("dofus","hideSummonedFighters");
         Api.system.dispatchHook(HookList.HideSummonedFighters,Api.system.getOption("hideSummonedFighters","dofus"));
      }
      
      private function onShowPermanentTargetsTooltips(value:Boolean) : void
      {
         switchOption("dofus","showPermanentTargetsTooltips");
      }
      
      private function onShowDamagesPreview(value:Boolean) : void
      {
         switchOption("dofus","showDamagesPreview");
      }
      
      private function onShowMovePreview(value:Boolean) : void
      {
         switchOption("dofus","showMovePreview");
      }
      
      private function onShowBreed(value:Boolean) : void
      {
         switchOption("dofus","showBreed");
      }
      
      private function onShowAlignmentWings(value:Boolean) : void
      {
         switchOption("dofus","showAlignmentWings");
      }
      
      private function onSpectatorAutoShowCurrentFighterInfo(value:Boolean) : void
      {
         switchOption("dofus","spectatorAutoShowCurrentFighterInfo");
      }
      
      private function onShowStates(value:Boolean) : void
      {
         switchOption("dofus","toggleEntityIcons");
      }
      
      private function onShowMountsInFight(value:Boolean) : void
      {
         switchOption("dofus","showMountsInFight");
      }
      
      override public function createMenu(data:*, param:Object) : Array
      {
         var menu:Array = super.createMenu(data,param);
         var subMenu:Array = [];
         subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.general")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showUsedPaPm"),this.onShowUsedPaPmChange,Api.system.getOption("showUsedPaPm","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.orderFighters"),this.onOrderFightersChange,Api.system.getOption("orderFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showMountsInFight"),this.onShowMountsInFight,Api.system.getOption("showMountsInFight","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.fightTargetMode"),this.onCellSelectionOnly,Api.system.getOption("cellSelectionOnly","dofus"),"cellSelectionOnly"));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showMovementDistance"),this.onShowMovementDistance,Api.system.getOption("showMovementDistance","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showMovementArea"),this.onShowMovementArea,Api.system.getOption("showMovementArea","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.spectatorAutoShowCurrentFighterInfo"),this.onSpectatorAutoShowCurrentFighterInfo,Api.system.getOption("spectatorAutoShowCurrentFighterInfo","dofus")));
         var showStatesShortcut:Shortcut = Shortcut.getShortcutByName("toggleEntityIcons");
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showStates",showStatesShortcut !== null ? showStatesShortcut.shortcutKeyText : Api.ui.getText("ui.common.error")),this.onShowStates,Api.system.getOption("toggleEntityIcons","dofus")));
         subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.title.rollover")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showDamagesPreview"),this.onShowDamagesPreview,Api.system.getOption("showDamagesPreview","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showMovePreview"),this.onShowMovePreview,Api.system.getOption("showMovePreview","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showBreed"),this.onShowBreed,Api.system.getOption("showBreed","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showAlignmentWings"),this.onShowAlignmentWings,Api.system.getOption("showAlignmentWings","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showPermanentTargetsTooltips"),this.onShowPermanentTargetsTooltips,Api.system.getOption("showPermanentTargetsTooltips","dofus")));
         subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.title.chatAndTimeline")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showLogPvDetails"),this.onShowLogPvDetails,Api.system.getOption("showLogPvDetails","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.hideDeadFighters"),this.onHideDeadFighters,Api.system.getOption("hideDeadFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.hideSummonedFighters"),this.onHideSummonedFighters,Api.system.getOption("hideSummonedFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.remindTurn"),this.onRemindTurnChange,Api.system.getOption("remindTurn","dofus")));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.fightOptions"),null,null,false,subMenu));
         return menu;
      }
   }
}
