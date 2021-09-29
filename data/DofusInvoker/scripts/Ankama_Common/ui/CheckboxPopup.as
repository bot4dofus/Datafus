package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class CheckboxPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _validCallBack:Function;
      
      private var _cancelCallback:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_title_popup:Label;
      
      public var lbl_description:TextArea;
      
      public var btn_label_btn_checkbox:Label;
      
      public var btn_checkbox:ButtonContainer;
      
      public var btn_close_popup:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_undo:ButtonContainer;
      
      public function CheckboxPopup()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.lbl_title_popup.text = param.title;
         this.lbl_description.text = param.content;
         this.btn_checkbox.selected = param.defaultSelect;
         this.btn_label_btn_checkbox.text = param.checkboxText;
         this._validCallBack = param.validCallBack;
         this._cancelCallback = param.cancelCallback;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_ok)
         {
            if(this._validCallBack != null)
            {
               this._validCallBack(this.btn_checkbox.selected);
            }
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else if(target == this.btn_close_popup || target == this.btn_undo)
         {
            if(this._cancelCallback != null)
            {
               this._cancelCallback();
            }
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.VALID_UI:
               if(this._validCallBack != null)
               {
                  this._validCallBack(this.btn_checkbox.selected);
               }
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case ShortcutHookListEnum.CLOSE_UI:
               this.onRelease(this.btn_close_popup);
               return true;
         }
         return false;
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
   }
}
