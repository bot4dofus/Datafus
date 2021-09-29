package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   
   public class SecureModeIcon
   {
       
      
      private var _secureModeNeedReboot:Object;
      
      public var btn_open:ButtonContainer;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public function SecureModeIcon()
      {
         super();
      }
      
      public function main(secureModeNeedReboot:Object) : void
      {
         this._secureModeNeedReboot = secureModeNeedReboot;
         this.uiApi.addComponentHook(this.btn_open,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_open,ComponentHookList.ON_ROLL_OUT);
      }
      
      public function onRelease(target:ButtonContainer) : void
      {
         if(!this.uiApi.getUi("secureMode"))
         {
            this.uiApi.loadUi("secureMode","secureMode",this._secureModeNeedReboot,StrataEnum.STRATA_HIGH);
         }
      }
      
      public function onRollOver(target:ButtonContainer) : void
      {
         this.uiApi.showTooltip(this.uiApi.getText("ui.modeSecure.tooltip.icon"),target);
      }
      
      public function onRollOut(target:ButtonContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
