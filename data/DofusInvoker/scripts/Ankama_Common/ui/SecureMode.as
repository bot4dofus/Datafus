package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import org.openapitools.event.ApiClientEvent;
   
   public class SecureMode
   {
       
      
      private const TOO_MANY_SAVED_COMPUTER_ERROR:String = "TOOMANYCERTIFICATE";
      
      private var _callBackOnSecured:Object;
      
      private var _callBackOnCancelled:Function;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SecurityApi")]
      public var securityApi:SecurityApi;
      
      public var main_window:GraphicContainer;
      
      public var inp_save:Input;
      
      public var inp_code:Input;
      
      public var btn_label_btn_saveComputer:Label;
      
      public var tx_bgCodeError:TextureBitmap;
      
      public var lbl_codeError:Label;
      
      public var tx_bgSaveError:TextureBitmap;
      
      public var lbl_saveError:Label;
      
      public var btn_manageComputers:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_restrictMode:ButtonContainer;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_resend:ButtonContainer;
      
      public var btn_notReceived:ButtonContainer;
      
      public var btn_saveComputer:ButtonContainer;
      
      public var tx_disableTop:Texture;
      
      public var tx_infoRestrict:Texture;
      
      public var tx_infoCode:Texture;
      
      public var tx_infoSave:Texture;
      
      public function SecureMode()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.uiApi.addComponentHook(this.btn_manageComputers,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_restrictMode,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_valid,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_resend,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_notReceived,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_infoRestrict,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_infoCode,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_infoSave,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_infoRestrict,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_infoCode,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_infoSave,ComponentHookList.ON_ROLL_OUT);
         this.sysApi.addHook(HookList.SecureModeChange,this.onSecureModeChange);
         if(param)
         {
            if(param.hasOwnProperty("callBackOnSecured"))
            {
               this._callBackOnSecured = {"fct":param.callBackOnSecured};
               if(this._callBackOnSecured && param.hasOwnProperty("callBackOnSecuredParams"))
               {
                  this._callBackOnSecured.params = param.callBackOnSecuredParams;
               }
            }
            if(param.hasOwnProperty("callBackOnCancelled"))
            {
               this._callBackOnCancelled = param.callBackOnCancelled;
            }
            if(param.hasOwnProperty("offset") && param.offset)
            {
               this.uiApi.me().showModalContainer = false;
               this.main_window.x += param.offset.x;
               this.main_window.y += param.offset.y;
            }
         }
         if(this.btn_label_btn_saveComputer.textWidth < this.btn_label_btn_saveComputer.width)
         {
            this.btn_label_btn_saveComputer.fullWidthAndHeight();
         }
         this.securityApi.askSecureModeCode();
         this.inp_save.placeholderText = this.uiApi.getText("ui.common.exampleShort") + " " + this.uiApi.getText("ui.common.houseWord");
         this.inp_save.restrictChars = "A-Z a-z0-9";
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.tx_infoCode:
               text = this.uiApi.getText("ui.shield.popupInfoCode");
               break;
            case this.tx_infoRestrict:
               text = this.uiApi.getText("ui.shield.popupInfoRestrict");
               break;
            case this.tx_infoSave:
               text = this.uiApi.getText("ui.shield.popupInfoSave");
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
      
      public function onRelease(target:GraphicContainer) : void
      {
         var disable:Boolean = false;
         switch(target)
         {
            case this.btn_restrictMode:
               disable = this.btn_restrictMode.state == StatesEnum.STATE_SELECTED || this.btn_restrictMode.state == StatesEnum.STATE_SELECTED_OVER;
               this.tx_disableTop.visible = disable;
               this.btn_resend.disabled = disable;
               this.btn_notReceived.disabled = disable;
               this.btn_manageComputers.disabled = disable;
               this.btn_saveComputer.disabled = disable;
               this.inp_code.text = "";
               this.inp_code.disabled = disable;
               this.inp_save.disabled = disable;
               this.btn_saveComputer.selected = false;
               break;
            case this.btn_resend:
               this.securityApi.askSecureModeCode();
               break;
            case this.btn_notReceived:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.support.faq.shieldArticle"));
               break;
            case this.btn_manageComputers:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.support.faq.shieldManageComputer"));
               break;
            case this.btn_valid:
               this.tx_bgCodeError.visible = false;
               this.lbl_codeError.visible = false;
               this.tx_bgSaveError.visible = false;
               this.lbl_saveError.visible = false;
               if(this.btn_restrictMode.state == StatesEnum.STATE_SELECTED)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
                  if(this._callBackOnCancelled != null)
                  {
                     this._callBackOnCancelled();
                  }
               }
               else if(this.btn_saveComputer.state == StatesEnum.STATE_SELECTED)
               {
                  if(this.inp_save.text == "" || this.inp_save.text == this.inp_save.placeholderText)
                  {
                     this.tx_bgSaveError.visible = true;
                     this.lbl_saveError.text = this.uiApi.getText("ui.shield.popupErrorSave");
                     this.lbl_saveError.visible = true;
                  }
                  else
                  {
                     this.securityApi.sendSecureModeCode(this.inp_code.text,this.onResponse,this.onError,this.inp_save.text);
                  }
               }
               else
               {
                  this.securityApi.sendSecureModeCode(this.inp_code.text,this.onResponse,this.onError,null);
               }
         }
      }
      
      private function onResponse() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         if(this._callBackOnSecured)
         {
            this._callBackOnSecured.fct(this._callBackOnSecured.params);
         }
      }
      
      private function onError(e:ApiClientEvent) : void
      {
         if(e.response.errorMessage == this.TOO_MANY_SAVED_COMPUTER_ERROR)
         {
            this.tx_bgSaveError.visible = true;
            this.lbl_saveError.text = this.uiApi.getText("ui.shield.popupErrorTooManyComputers");
            this.lbl_saveError.visible = true;
            this.securityApi.askSecureModeCode();
         }
         else
         {
            this.tx_bgCodeError.visible = true;
            this.lbl_codeError.visible = true;
         }
      }
      
      private function onSecureModeChange(active:Boolean) : void
      {
         if(!active)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            if(this._callBackOnSecured)
            {
               this._callBackOnSecured.fct(this._callBackOnSecured.params);
            }
         }
      }
   }
}
