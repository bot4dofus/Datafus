package Ankama_Web.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ShopPopupOverlayWarning
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var btn_website:ButtonContainer;
      
      public var btn_close_ctr_popupWindow:ButtonContainer;
      
      public function ShopPopupOverlayWarning()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_ctr_popupWindow:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_website:
               this.sysApi.goToUrl(this.uiApi.getText("ui.shop.websiteUrl"));
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
