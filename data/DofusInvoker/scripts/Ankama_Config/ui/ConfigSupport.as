package Ankama_Config.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   
   public class ConfigSupport extends ConfigUi
   {
       
      
      public var btnGotoSupport:ButtonContainer;
      
      public var btn_goToSupportFAQ:ButtonContainer;
      
      public var btn_allowDebug:ButtonContainer;
      
      public var tx_information:Texture;
      
      public var lbl_infoDebug:Label;
      
      private var _isInDebugMode:Boolean;
      
      public function ConfigSupport()
      {
         super();
      }
      
      public function main(arg:*) : void
      {
         uiApi.addComponentHook(this.btnGotoSupport,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_goToSupportFAQ,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.tx_information,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.tx_information,ComponentHookList.ON_ROLL_OUT);
         showDefaultBtn(false);
         var os:String = sysApi.getOs();
         var bugReportKey:String = os == "Mac OS" ? "F1" : "F11";
         this._isInDebugMode = configApi.getDebugMode();
         this.lbl_infoDebug.text = uiApi.getText("ui.option.debugMode.info",bugReportKey);
         uiApi.addComponentHook(this.btn_allowDebug,ComponentHookList.ON_RELEASE);
         this.btn_allowDebug.selected = this._isInDebugMode;
         if(configApi.debugFileExists())
         {
            this.btn_allowDebug.softDisabled = true;
            uiApi.addComponentHook(this.btn_allowDebug,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(this.btn_allowDebug,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      override public function onRelease(target:Object) : void
      {
         switch(target)
         {
            case this.btnGotoSupport:
               sysApi.goToUrl(uiApi.getText("ui.link.support"));
               break;
            case this.btn_goToSupportFAQ:
               sysApi.goToUrl(uiApi.getText("ui.link.FAQ"));
               break;
            case this.btn_allowDebug:
               this._isInDebugMode = this.btn_allowDebug.selected;
               configApi.setDebugMode(this._isInDebugMode);
               sysApi.enableLogs(this._isInDebugMode);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_information:
               uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.assistance.informationTooltip")),target,false,"standard",5,3,3,null,null,null,"TextInfo");
               break;
            case this.btn_allowDebug:
               uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.debugMode.hasFile")),target,false,"standard",5,3,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
