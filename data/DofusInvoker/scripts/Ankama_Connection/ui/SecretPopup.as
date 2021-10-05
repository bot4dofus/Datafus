package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class SecretPopup
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _id:Number;
      
      private var _name:String;
      
      public var lbl_secretQuestion:TextArea;
      
      public var inp_answer:Input;
      
      public var btn_secretOk:ButtonContainer;
      
      public var btn_secretClose:ButtonContainer;
      
      public function SecretPopup()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_secretQuestion.text = this.sysApi.getPlayerManager().secretQuestion;
         this.inp_answer.maxChars = 50;
         this.inp_answer.focus();
         this._id = params[0];
         this._name = params[1];
      }
      
      public function unload() : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_secretOk:
               this.onValidateSecretAnswer();
               break;
            case this.btn_secretClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.onValidateSecretAnswer();
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onValidateSecretAnswer() : void
      {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.warnBeforeDelete",this._name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupDelete,this.onPopupClose],this.onPopupDelete,this.onPopupClose);
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupDelete() : void
      {
         this.sysApi.sendAction(new CharacterDeletionAction([this._id,this.inp_answer.text]));
         this.uiApi.getUi("characterSelection").uiClass.lockSelection();
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
