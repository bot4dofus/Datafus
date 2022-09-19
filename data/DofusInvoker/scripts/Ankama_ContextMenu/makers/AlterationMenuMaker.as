package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import flash.geom.Rectangle;
   
   public class AlterationMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
      
      private static const TOOLTIP_TARGET:Rectangle = new Rectangle(20,20,0,0);
       
      
      private var _shortcutColor:String;
      
      public function AlterationMenuMaker()
      {
         super();
         this._shortcutColor = (Api.system.getConfigEntry("colors.contextmenu.shortcut") as String).replace("0x","#");
      }
      
      private static function displayAlterationInChat(alteration:AlterationWrapper) : void
      {
         Api.system.dispatchHook(CustomUiHookList.InsertHyperlink,alteration);
      }
      
      private static function pinTooltip(alteration:AlterationWrapper) : void
      {
         Api.ui.showTooltip(alteration,TOOLTIP_TARGET,false,TooltipManager.TOOLTIP_STANDARD_NAME,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPLEFT,0,"alteration",null,{"pinnable":true},null,true,StrataEnum.STRATA_TOOLTIP,1,"storage");
      }
      
      private function getShortcutLabel(shortcutText:String) : String
      {
         return "<font color=\'".concat(this._shortcutColor).concat("\'>(").concat(shortcutText).concat(")</font>");
      }
      
      public function createMenu(data:*, params:Object) : Array
      {
         var shiftClickShortcutLabeL:String = null;
         var alteration:AlterationWrapper = data as AlterationWrapper;
         Api.ui.hideTooltip();
         var menu:Array = [];
         var uiName:String = null;
         if(params && params.length > 1 && params[1] is String)
         {
            uiName = params[1];
         }
         var uiChat:UiRootContainer = Api.ui.getUi("chat");
         if(uiChat !== null)
         {
            shiftClickShortcutLabeL = this.getShortcutLabel(Api.ui.getText("ui.keyboard.shift").concat(" + ").concat(Api.ui.getText("ui.mouse.click")));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.alteration.displayAlterationInChat").concat(" ").concat(shiftClickShortcutLabeL),displayAlterationInChat,[alteration],disabled));
         }
         if(!uiName || uiName.indexOf("_pin@") === -1)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.tooltip.pin").concat(" ").concat(this.getShortcutLabel("Alt")),pinTooltip,[alteration]));
         }
         return menu;
      }
   }
}
