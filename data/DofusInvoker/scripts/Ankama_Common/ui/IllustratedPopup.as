package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class IllustratedPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var btn_close_popup:ButtonContainer;
      
      public var tx_illu:Texture;
      
      public var ta_content:Label;
      
      private var _onCloseCallback:Function;
      
      public function IllustratedPopup()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         if(!args)
         {
            args = new Object();
            args.content = "Hello World";
            args.illustrationFileName = "tx_illuHavenbagUnlocked.png";
            args.onClose = null;
         }
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close_popup.soundId = SoundEnum.WINDOW_CLOSE;
         if(args)
         {
            this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + args.illustrationFileName);
            this.ta_content.text = args.content;
            this._onCloseCallback = args.onClose;
         }
         else
         {
            this.sysApi.log(16,"No params for this IllustratedPopup? You probably did something wrong, chap.");
         }
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_popup:
               this.closeMe();
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
