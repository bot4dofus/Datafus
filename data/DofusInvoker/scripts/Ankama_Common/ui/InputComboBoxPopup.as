package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.InputComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class InputComboBoxPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _validCallBack:Function;
      
      private var _cancelCallback:Function;
      
      private var _resetCallback:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_title_popup:Label;
      
      public var lbl_description:Label;
      
      public var lbl_input:InputComboBox;
      
      public var btn_close_popup:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_emptyOptionHistory:ButtonContainer;
      
      public var _resetButtonTooltip:String;
      
      public function InputComboBoxPopup()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.uiApi.addComponentHook(this.btn_emptyOptionHistory,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_emptyOptionHistory,ComponentHookList.ON_ROLL_OUT);
         this.lbl_title_popup.text = param.title;
         this.lbl_description.text = param.content;
         this.lbl_input.input.text = param.defaultValue;
         this.lbl_input.input.selectAll();
         this._validCallBack = param.validCallBack;
         this._cancelCallback = param.cancelCallback;
         this._resetCallback = param.resetCallback;
         this._resetButtonTooltip = param.resetButtonTooltip;
         this.lbl_input.input.restrictChars = param.restric;
         this.lbl_input.maxChars = param.maxChars;
         this.lbl_input.focus();
         this.lbl_input.dataProvider = param.dataProvider;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var unload:Boolean = true;
         if(target == this.btn_ok)
         {
            if(this._validCallBack != null)
            {
               this._validCallBack(this.lbl_input.input.text);
            }
         }
         else if(target == this.btn_close_popup)
         {
            if(this._cancelCallback != null)
            {
               this._cancelCallback();
            }
         }
         else if(target == this.btn_emptyOptionHistory)
         {
            unload = false;
            this.lbl_input.dataProvider = new Array();
            if(this._resetCallback != null)
            {
               this._resetCallback();
            }
         }
         if(unload)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.btn_emptyOptionHistory:
               text = this._resetButtonTooltip;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(this.lbl_input == null)
         {
            return true;
         }
         switch(s)
         {
            case ShortcutHookListEnum.VALID_UI:
               if(this._validCallBack != null)
               {
                  this._validCallBack(this.lbl_input.input.text);
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
