package Ankama_GameUiCore.ui
{
   import Ankama_GameUiCore.ui.enums.KISPopupTypeEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   
   public class KISPopUp
   {
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var window_popup:GraphicContainer;
      
      public var lbl_title_window_popup:Label;
      
      public var ctr_body:GraphicContainer;
      
      public var lbl_description:Label;
      
      public var btn_close_window_popup:ButtonContainer;
      
      public var lbl_footer:Label;
      
      public var btn_ok:ButtonContainer;
      
      public function KISPopUp()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         switch(params[0])
         {
            case KISPopupTypeEnum.INACTIVITY:
               this.showInactivityPopup();
               break;
            case KISPopupTypeEnum.MISSING_EQUIPMENT:
               this.showMissingEquipmentPopup(params[1] == PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM);
         }
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.uiApi.addComponentHook(this.btn_ok,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.me().setOnTop();
         this.lbl_title_window_popup.text = this.lbl_title_window_popup.text.toUpperCase();
         this.lbl_description.fullWidthAndHeight();
         this.lbl_footer.fullWidthAndHeight();
         this.window_popup.height = this.ctr_body.y + this.ctr_body.height - this.lbl_title_window_popup.y + Number(this.uiApi.me().getConstant("bottom_margin"));
      }
      
      private function showInactivityPopup() : void
      {
         this.lbl_description.text = this.uiApi.getText("ui.pvp.idleWarning");
         this.lbl_title_window_popup.text = this.uiApi.getText("ui.common.warning");
         this.lbl_title_window_popup.cssClass = "center";
         this.lbl_footer.text = this.uiApi.getText("ui.pvp.rulesRespectWarning");
      }
      
      private function showMissingEquipmentPopup(isTeam:Boolean) : void
      {
         this.lbl_description.text = !!isTeam ? this.uiApi.getText("ui.pvp.missingEquipmentTeam") : this.uiApi.getText("ui.pvp.missingEquipment");
         this.lbl_title_window_popup.text = this.uiApi.getText("ui.common.warning");
         this.lbl_title_window_popup.cssClass = "center";
         this.lbl_footer.text = this.uiApi.getText("ui.pvp.rulesRespectWarning");
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function closeMe() : void
      {
         if(this.uiApi !== null)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function validate() : void
      {
         this.closeMe();
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         switch(shortcutLabel)
         {
            case ShortcutHookListEnum.VALID_UI:
               this.validate();
               return true;
            case ShortcutHookListEnum.CLOSE_UI:
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.mainCtr:
               this.uiApi.me().setOnTop();
               break;
            case this.btn_close_window_popup:
            case this.btn_ok:
               this.validate();
         }
      }
   }
}
