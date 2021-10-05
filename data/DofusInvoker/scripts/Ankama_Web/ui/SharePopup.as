package Ankama_Web.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class SharePopup
   {
      
      private static const SHARE_URL_FACEBOOK:String = "https://www.facebook.com/sharer/sharer.php?u=%url%";
      
      private static const SHARE_URL_TWITTER:String = "https://twitter.com/intent/tweet?url=%url%&hashtags=DOFUS";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var ctr_main:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_web:ButtonContainer;
      
      public var btn_fb:ButtonContainer;
      
      public var btn_twitter:ButtonContainer;
      
      public var btn_goTo:ButtonContainer;
      
      public var lbl_url:Label;
      
      private var _url:String;
      
      public function SharePopup()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this._url = params.url;
         if(!this._url)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         this.uiApi.addComponentHook(this.btn_fb,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_fb,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_twitter,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_twitter,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_goTo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_goTo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_url,ComponentHookList.ON_RELEASE);
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.lbl_url.text = this._url;
         this.lbl_url.allowTextMouse(true);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
      }
      
      public function unload() : void
      {
         this._url = null;
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_fb:
               tooltipText = this.uiApi.getText("ui.social.share.popup.serviceTooltip","Facebook");
               break;
            case this.btn_twitter:
               tooltipText = this.uiApi.getText("ui.social.share.popup.serviceTooltip","Twitter");
               break;
            case this.btn_goTo:
               tooltipText = this.uiApi.getText("ui.shortcuts.openWebBrowser");
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function toggleVisibility() : void
      {
         this.ctr_main.visible = !this.ctr_main.visible;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var serviceUrl:String = null;
         switch(target)
         {
            case this.lbl_url:
               this.lbl_url.selectAll();
               break;
            case this.btn_close:
               this.toggleVisibility();
               return;
            case this.btn_fb:
               serviceUrl = SHARE_URL_FACEBOOK.replace("%url%",this._url);
               break;
            case this.btn_twitter:
               serviceUrl = SHARE_URL_TWITTER.replace("%url%",this._url);
               break;
            case this.btn_goTo:
               this.sysApi.goToUrl(this._url);
               break;
            case this.btn_web:
            default:
               serviceUrl = this._url;
         }
         if(serviceUrl)
         {
            this.sysApi.goToUrl(encodeURI(serviceUrl));
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               if(this.ctr_main.visible)
               {
                  this.ctr_main.visible = false;
                  return true;
               }
               return false;
               break;
            default:
               return false;
         }
      }
   }
}
