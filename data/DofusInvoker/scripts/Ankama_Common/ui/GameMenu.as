package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GameMenu
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      public var btn_abo:ButtonContainer;
      
      public var btn_options:ButtonContainer;
      
      public var btn_menu:ButtonContainer;
      
      public var ctr_bg:GraphicContainer;
      
      public var tx_lagometer:Texture;
      
      private var _btnSubscribeNeeded:Boolean = true;
      
      public function GameMenu()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.addHook(HookList.SubscriptionEndDateUpdate,this.onSubscriptionEndDateUpdate);
         this.sysApi.addHook(HookList.LaggingNotification,this.onLaggingNotification);
         this.uiApi.addComponentHook(this.btn_abo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_abo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_abo,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_options,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_options,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_options,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_menu,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_menu,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_menu,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("optionMenu1",this.onShortcut);
         this.onSubscriptionEndDateUpdate();
         this.tx_lagometer.visible = false;
      }
      
      private function onLaggingNotification(isLagging:Boolean) : void
      {
         this.tx_lagometer.visible = isLagging;
      }
      
      private function onSubscriptionEndDateUpdate() : void
      {
         var newCheckSubscribeNeeded:Boolean = false;
         if(this.sysApi.getPlayerManager().subscriptionEndDate > 0 || this.sysApi.getPlayerManager().hasRights)
         {
            newCheckSubscribeNeeded = false;
         }
         else
         {
            newCheckSubscribeNeeded = true;
         }
         if(this._btnSubscribeNeeded == newCheckSubscribeNeeded)
         {
            return;
         }
         if(newCheckSubscribeNeeded)
         {
            this.btn_abo.visible = true;
            this.ctr_bg.width += 25;
            this.ctr_bg.x -= 25;
         }
         else
         {
            this.btn_abo.visible = false;
            this.ctr_bg.width -= 25;
            this.ctr_bg.x += 25;
         }
         this._btnSubscribeNeeded = newCheckSubscribeNeeded;
      }
      
      public function unload() : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         this.sysApi.log(8,"release sur " + target + " : " + target.name);
         switch(target)
         {
            case this.btn_menu:
               this.sysApi.sendAction(new OpenMainMenuAction([]));
               break;
            case this.btn_abo:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
               break;
            case this.btn_options:
               if(this.uiApi.getUi("optionContainer"))
               {
                  this.modCommon.openOptionMenu(true,"performance");
               }
               else
               {
                  this.modCommon.openOptionMenu(false,"performance");
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:Object = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_abo:
               tooltipText = this.uiApi.getText("ui.header.subscribe");
               break;
            case this.btn_menu:
               tooltipText = this.uiApi.getText("ui.banner.mainMenu");
               break;
            case this.btn_options:
               tooltipText = this.uiApi.getText("ui.common.optionsMenu");
         }
         data = this.uiApi.textTooltipInfo(tooltipText);
         this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "optionMenu1":
               if(this.uiApi.getUi("optionContainer"))
               {
                  this.modCommon.openOptionMenu(true,"performance");
               }
               else
               {
                  this.modCommon.openOptionMenu(false,"performance");
               }
               return true;
            default:
               return false;
         }
      }
   }
}
