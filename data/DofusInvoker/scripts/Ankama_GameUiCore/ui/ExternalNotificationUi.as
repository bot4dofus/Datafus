package Ankama_GameUiCore.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ExternalNotificationApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.geom.Rectangle;
   
   public class ExternalNotificationUi
   {
      
      private static const DEBUG:Boolean = false;
       
      
      private var _instanceId:String;
      
      private const TITLE_FONT_SIZE:uint = 12;
      
      private const MESSAGE_FONT_SIZE:uint = 12;
      
      private var _entityId:Number = -1;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ExternalNotificationApi")]
      public var extNotifApi:ExternalNotificationApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var ctr_extNotif:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_notif:Label;
      
      public var btn_close:ButtonContainer;
      
      public var tx_slot:Texture;
      
      public var tx_iconBg:Texture;
      
      public var tx_icon:Texture;
      
      public var ed_player:EntityDisplayer;
      
      public function ExternalNotificationUi()
      {
         super();
      }
      
      public function main(pDisplayData:Object) : void
      {
         var path:* = null;
         this._instanceId = this.uiApi.me().name;
         if(this.configApi.getConfigProperty("dofus","notificationsAlphaWindows") == true)
         {
            this.ctr_extNotif.alpha = 0.9;
         }
         this.ctr_extNotif.mouseChildren = this.ctr_extNotif.handCursor = true;
         this.uiApi.addComponentHook(this.ctr_extNotif,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_extNotif,ComponentHookList.ON_ROLL_OVER);
         if(pDisplayData.title)
         {
            this.setLabelText(this.lbl_title,pDisplayData.title,this.TITLE_FONT_SIZE,this.lbl_title.cssClass);
         }
         if(pDisplayData.entityContactData)
         {
            this._entityId = pDisplayData.entityContactData.id;
            this.ed_player.visible = false;
            this.uiApi.addComponentHook(this.ed_player,"onEntityReady");
            this.sysApi.addHook(HookList.ContactLook,this.onContactLook);
            this.sysApi.sendAction(new ContactLookRequestByIdAction([pDisplayData.entityContactData.contactCategory,pDisplayData.entityContactData.id]));
         }
         else if(pDisplayData.iconPath)
         {
            path = this.sysApi.getConfigEntry("config.gfx.path") + pDisplayData.iconPath + "/";
            if(pDisplayData.iconBg)
            {
               this.tx_iconBg.uri = this.uiApi.createUri(path + pDisplayData.iconBg + ".png");
            }
            this.tx_icon.uri = this.uiApi.createUri(path + pDisplayData.icon + ".png");
         }
         if(pDisplayData.cssClass != "p")
         {
            this.lbl_notif.cssClass = pDisplayData.cssClass;
         }
         if(pDisplayData.css != "normal")
         {
            this.lbl_notif.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + pDisplayData.css + ".css");
         }
         this.setLabelText(this.lbl_notif,pDisplayData.message,this.MESSAGE_FONT_SIZE,pDisplayData.cssClass);
      }
      
      private function setLabelText(pLabel:Label, pMsg:String, pFontSize:uint, pCssClass:String) : void
      {
         if(this.sysApi.getCurrentLanguage() == "ja")
         {
            pLabel.useEmbedFonts = false;
         }
         pLabel.setCssSize(pFontSize,pCssClass);
         pLabel.appendText(pMsg,pCssClass);
      }
      
      public function onContactLook(pEntityId:Number, pEntityName:String, pEntityLook:Object) : void
      {
         if(this._entityId == pEntityId)
         {
            this.ed_player.entityScale = 1;
            this.ed_player.xOffset = this.ed_player.yOffset = 0;
            this.ed_player.withoutMount = true;
            this.ed_player.animation = "AnimStatique";
            this.ed_player.direction = 3;
            this.ed_player.look = pEntityLook;
         }
      }
      
      public function onEntityReady(pEntityDisplayer:Object) : void
      {
         var headBounds:Rectangle = null;
         var entityBounds:Rectangle = null;
         var yOffset:Number = NaN;
         if(this.ed_player == pEntityDisplayer)
         {
            headBounds = this.ed_player.getSlotBounds("Tete");
            if(headBounds)
            {
               entityBounds = this.ed_player.getEntityBounds();
               yOffset = entityBounds.height / 2;
               if(headBounds.y > 0)
               {
                  yOffset -= 10;
               }
               this.ed_player.entityScale = 2;
               this.ed_player.yOffset = yOffset;
               this.ed_player.updateMask();
               this.ed_player.updateScaleAndOffsets();
            }
            this.ed_player.visible = true;
         }
      }
      
      public function onRelease(pTarget:GraphicContainer) : void
      {
         switch(pTarget)
         {
            case this.btn_close:
               this.extNotifApi.removeExternalNotification(this._instanceId);
               break;
            case this.ctr_extNotif:
               this.extNotifApi.removeExternalNotification(this._instanceId,true);
         }
      }
      
      public function onRollOver(pTarget:GraphicContainer) : void
      {
         if(pTarget == this.ctr_extNotif)
         {
            this.extNotifApi.resetExternalNotificationDisplayTimeout(this._instanceId);
         }
      }
   }
}
