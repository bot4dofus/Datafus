package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   
   public class WorldMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      public function WorldMenuMaker()
      {
         super();
      }
      
      private function onQualityChange(value:uint) : void
      {
         Api.config.setConfigProperty("dofus","flashQuality",value);
         Api.config.setConfigProperty("dofus","dofusQuality",3);
      }
      
      private function onZoom(zoomIn:Boolean) : void
      {
         Api.system.mouseZoom(zoomIn);
      }
      
      private function onResetZoom() : void
      {
         Api.system.resetZoom();
      }
      
      private function onDisplayGridChange(value:Boolean) : void
      {
         this.switchOption("atouin","alwaysShowGrid");
      }
      
      private function onTransparentOverlayModeChange(value:Boolean) : void
      {
         this.switchOption("atouin","transparentOverlayMode");
      }
      
      private function onMapInfoChange(value:Boolean) : void
      {
         this.switchOption("dofus","mapCoordinates");
      }
      
      private function onShowPlayersNames(value:Boolean) : void
      {
         ContextMenu.getInstance().playersNamesVisible = value;
         Api.system.sendAction(new ShowAllNamesAction([]));
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var menu:Array = [];
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom") + " +",this.onZoom,[true],Api.system.getMaxZoom() == Api.system.getCurrentZoom() || disabled));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom") + " -",this.onZoom,[false],Api.system.getCurrentZoom() == 1 || disabled));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.zoom") + " 100%",this.onResetZoom,null,Api.system.getCurrentZoom() == 1 || disabled));
         menu.push(ContextMenu.static_createContextMenuSeparatorObject());
         var subMenu:Array = [];
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.flashQuality"),null,null,!Api.system.setQualityIsEnable() || disabled,subMenu));
         var currentQuality:uint = Api.config.getConfigProperty("dofus","flashQuality");
         subMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.quality.low"),this.onQualityChange,[0],false,null,currentQuality == 0,true));
         subMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.quality.medium"),this.onQualityChange,[1],false,null,currentQuality == 1,true));
         subMenu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.quality.high"),this.onQualityChange,[2],false,null,currentQuality == 2,true));
         subMenu = [];
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.general"),null,null,disabled,subMenu));
         subMenu.push(this.createItemOption(Api.ui.getText("ui.option.displayGrid"),this.onDisplayGridChange,Api.system.getOption("alwaysShowGrid","atouin"),"showGrid"));
         subMenu.push(this.createItemOption(Api.ui.getText("ui.option.transparentOverlayMode"),this.onTransparentOverlayModeChange,Api.system.getOption("transparentOverlayMode","atouin"),"transparancyMode"));
         subMenu.push(this.createItemOption(Api.ui.getText("ui.option.mapInfo"),this.onMapInfoChange,Api.system.getOption("mapCoordinates","dofus"),"showCoord"));
         subMenu.push(this.createItemOption(Api.ui.getText("ui.shortcuts.displayNames"),this.onShowPlayersNames,ContextMenu.getInstance().playersNamesVisible,"showAllNames"));
         return menu;
      }
      
      protected function switchOption(configModuleName:String, propertyName:String) : void
      {
         Api.config.setConfigProperty(configModuleName,propertyName,!Api.system.getOption(propertyName,configModuleName));
      }
      
      protected function createItemOption(text:String, callback:Function, selected:Boolean, shortcut:String = null) : ContextMenuItem
      {
         var bind:String = null;
         var finalText:String = text;
         if(shortcut)
         {
            bind = Api.binds.getShortcutBindStr(shortcut);
            if(bind)
            {
               finalText += " (" + bind + ")";
            }
         }
         return ContextMenu.static_createContextMenuItemObject(finalText,callback,[!selected],false,null,selected,false);
      }
   }
}
