package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class PreGameMainMenu
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Module(name="Ankama_Common")]
      public var commonMod:Common;
      
      public var btnClose:ButtonContainer;
      
      public var btnOptions:ButtonContainer;
      
      public var btnDisconnect:ButtonContainer;
      
      public var btnQuitGame:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public function PreGameMainMenu()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnOptions,"onRelease");
         this.uiApi.addComponentHook(this.btnDisconnect,"onRelease");
         this.uiApi.addComponentHook(this.btnQuitGame,"onRelease");
         this.uiApi.addComponentHook(this.btnCancel,"onRelease");
         if(this.uiApi.getUi("login"))
         {
            this.btnDisconnect.disabled = true;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btnOptions:
               this.commonMod.openOptionMenu(false,"performance");
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btnDisconnect:
               this.commonMod.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmDisconnect"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmDisconnect,this.onCancel],this.onConfirmDisconnect,this.onCancel);
               break;
            case this.btnQuitGame:
               this.commonMod.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmQuitGame"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmQuitGame,this.onCancel],this.onConfirmQuitGame,this.onCancel);
               break;
            case this.btnCancel:
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onConfirmDisconnect() : void
      {
         this.sysApi.sendAction(new ResetGameAction([]));
      }
      
      private function onConfirmQuitGame() : void
      {
         this.sysApi.sendAction(new QuitGameAction([]));
      }
      
      private function onCancel() : void
      {
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         return true;
      }
   }
}
