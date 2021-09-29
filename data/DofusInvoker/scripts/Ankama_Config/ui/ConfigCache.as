package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   
   public class ConfigCache extends ConfigUi
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btnSelectiveClearCache:ButtonContainer;
      
      public var btnCompleteClearCache:ButtonContainer;
      
      public var lbl_SelectiveClearCacheExplicativeText:Label;
      
      public var lbl_CompleteClearCacheExplicativeText:Label;
      
      private var _popupName:String;
      
      public function ConfigCache()
      {
         super();
      }
      
      public function main(args:*) : void
      {
         uiApi.addComponentHook(this.btnSelectiveClearCache,"onRelease");
         uiApi.addComponentHook(this.btnCompleteClearCache,"onRelease");
         showDefaultBtn(false);
      }
      
      public function unload() : void
      {
         if(this._popupName != null && uiApi.getUi(this._popupName))
         {
            uiApi.unloadUi(this._popupName);
         }
      }
      
      override public function onRelease(target:Object) : void
      {
         switch(target)
         {
            case this.btnSelectiveClearCache:
               if(this._popupName == null)
               {
                  this._popupName = this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.popup.clearCache"),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.onSelectiveClearCache,this.onPopupClose],this.onSelectiveClearCache,this.onPopupClose);
               }
               break;
            case this.btnCompleteClearCache:
               if(this._popupName == null)
               {
                  this._popupName = this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.popup.clearCache"),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.onCompleteClearCache,this.onPopupClose],this.onCompleteClearCache,this.onPopupClose);
               }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      public function onSelectiveClearCache() : void
      {
         this._popupName = null;
         sysApi.clearCache(true);
      }
      
      public function onCompleteClearCache() : void
      {
         this._popupName = null;
         sysApi.clearCache(false);
      }
      
      private function onPopupClose() : void
      {
         this._popupName = null;
      }
   }
}
