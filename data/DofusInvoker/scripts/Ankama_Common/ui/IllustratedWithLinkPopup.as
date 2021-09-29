package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class IllustratedWithLinkPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var btn_close_popup:ButtonContainer;
      
      public var tx_illu:Texture;
      
      public var lbl_title:Label;
      
      public var lbl_content:Label;
      
      public var btn_link:ButtonContainer;
      
      public var lbl_btn_link:Label;
      
      public var tx_btn_link:TextureBitmap;
      
      public var btn_knowMore:ButtonContainer;
      
      public var popup:GraphicContainer;
      
      private var _onCloseCallback:Function;
      
      private var _onButtonReleaseCallback:Function;
      
      private var _onButtonKnowMoreReleaseCallback:Function;
      
      private var _link:String;
      
      public function IllustratedWithLinkPopup()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         var marginX:int = 0;
         if(!args)
         {
            this.sysApi.log(16,"No params for this IllustratedPopup? You probably did something wrong, chap.");
            return;
         }
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         if(this.btn_close_popup)
         {
            this.btn_close_popup.soundId = SoundEnum.WINDOW_CLOSE;
         }
         this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + args.illustrationFileName);
         this.lbl_title.text = args.title;
         this.lbl_content.text = args.content;
         this.lbl_content.y = this.lbl_title.y + this.lbl_title.contentHeight + this.lbl_content.anchorY;
         this.popup.height += this.lbl_content.contentHeight;
         if(!args.onButtonRelease && !args.link)
         {
            this.btn_link.visible = false;
         }
         else
         {
            marginX = 25;
            if(args.btnText != "")
            {
               this.lbl_btn_link.fixedWidth = false;
               this.lbl_btn_link.text = args.btnText;
            }
            this.btn_link.width = this.lbl_btn_link.contentWidth + marginX * 2;
            this.popup.height += this.btn_link.anchorY + this.btn_link.contentHeight / 2;
            this.btn_link.y = this.lbl_content.y + this.lbl_content.contentHeight + this.btn_link.anchorY;
            this.lbl_btn_link.x = marginX;
            if(args.link != "")
            {
               this._link = args.link;
               this.btn_link.width += this.tx_btn_link.width;
               this.lbl_btn_link.x += this.tx_btn_link.width / 2;
            }
            else
            {
               this.tx_btn_link.visible = false;
            }
         }
         if(!args.onButtonKnowMoreRelease)
         {
            this.btn_knowMore.visible = false;
         }
         this.uiApi.me().render();
         this._onButtonReleaseCallback = args.onButtonRelease;
         this._onCloseCallback = args.onClose;
         this._onButtonKnowMoreReleaseCallback = args.onButtonKnowMoreRelease;
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_popup:
               this.closeMe();
               break;
            case this.btn_link:
               if(this._onButtonReleaseCallback != null)
               {
                  this._onButtonReleaseCallback();
               }
               else if(this._link)
               {
                  this.sysApi.goToUrl(this._link);
               }
               break;
            case this.btn_knowMore:
               if(this._onButtonKnowMoreReleaseCallback != null)
               {
                  this._onButtonKnowMoreReleaseCallback();
               }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      private function closeMe() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         if(this._onCloseCallback != null)
         {
            this._onCloseCallback();
         }
      }
   }
}
