package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.WebBrowser;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.setTimeout;
   
   public class LoginThirdParty
   {
       
      
      private var _jsApi:Object;
      
      private var _timeoutId:uint;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var browser:WebBrowser;
      
      public function LoginThirdParty()
      {
         super();
      }
      
      public function main(popup:String = null) : void
      {
         this._jsApi = {
            "loginClassic":this.JS_API_LoginClassic,
            "loginWithTicket":this.JS_API_LoginWithTicket,
            "getLastLogin":this.JS_API_GetLastLogin,
            "setLastLogin":this.JS_API_SetLastLogin,
            "setPort":this.sysApi.setPort,
            "getPort":this.sysApi.getPort,
            "getLaunchArgs":this.sysApi.getLaunchArgs,
            "setBlankLink":this.browser.setBlankLink,
            "getPartnerInfo":this.sysApi["getPartnerInfo"]
         };
         this._timeoutId = setTimeout(this.init,1);
      }
      
      public function init() : void
      {
         this.sysApi.goToThirdPartyLogin(this.browser);
         this.uiApi.addComponentHook(this.browser,ComponentHookList.ON_DOM_READY);
      }
      
      public function onBrowserDomReady(target:Object) : void
      {
         this.browser.javascriptCall("ankInit",this._jsApi);
      }
      
      private function JS_API_LoginClassic(login:String, pass:String) : void
      {
         this.sysApi.sendAction(new LoginValidationAction([login,pass,true]));
      }
      
      private function JS_API_LoginWithTicket(ticket:String, autoSelectServer:Boolean, serverId:uint = 0) : void
      {
         this.sysApi.sendAction(new LoginValidationWithTicketAction(["",ticket,autoSelectServer,serverId]));
      }
      
      private function JS_API_GetLastLogin() : String
      {
         return !!this.sysApi.getData("LastLogin") ? this.sysApi.getData("LastLogin") : "";
      }
      
      private function JS_API_SetLastLogin(login:String) : void
      {
         this.sysApi.setData("LastLogin",login);
      }
   }
}
