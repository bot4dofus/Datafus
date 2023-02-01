package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationRequest;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationModeEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class ExternalNotificationApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function ExternalNotificationApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(ExternalNotificationApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function setMaxNotifications(pValue:int) : void
      {
         ExternalNotificationManager.getInstance().setMaxNotifications(pValue);
      }
      
      public function setNotificationsMode(pValue:int) : void
      {
         ExternalNotificationManager.getInstance().setNotificationsMode(pValue);
      }
      
      public function setDisplayDuration(pValueId:int) : void
      {
         ExternalNotificationManager.getInstance().setDisplayDuration(pValueId);
      }
      
      public function isExternalNotificationTypeIgnored(pExternalNotificationType:int) : Boolean
      {
         return ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(pExternalNotificationType);
      }
      
      public function areExternalNotificationsEnabled() : Boolean
      {
         return ExternalNotificationManager.getInstance().notificationsEnabled;
      }
      
      public function getShowMode() : int
      {
         return ExternalNotificationManager.getInstance().showMode;
      }
      
      public function canAddExternalNotification(pExternalNotificationType:int) : Boolean
      {
         if(BuildInfos.BUILD_TYPE != BuildTypeEnum.RELEASE && XmlConfig.getInstance().getBooleanEntry("config.dev.externalNotiflood"))
         {
            return true;
         }
         return ExternalNotificationManager.getInstance().canAddExternalNotification(pExternalNotificationType);
      }
      
      public function addExternalNotification(pNotificationType:int, pId:String, pUiName:String, pTitle:String, pMessage:String, pIconPath:String, pIconId:int, pIconBg:String, pCss:String = "normal2", pCssClass:String = "left", pEntityContactData:Object = null, duration:int = 0, pSoundId:String = "16011", pAlwaysShow:Boolean = false, pHookName:String = null, pHookParams:Array = null) : String
      {
         var displayData:Object = {
            "title":pTitle,
            "message":pMessage,
            "iconPath":pIconPath,
            "icon":pIconId,
            "iconBg":pIconBg,
            "css":pCss,
            "cssClass":pCssClass,
            "entityContactData":pEntityContactData
         };
         var req:ExternalNotificationRequest = new ExternalNotificationRequest(pNotificationType,ExternalNotificationManager.getInstance().clientId,ExternalNotificationManager.getInstance().otherClientsIds,pId,!!pAlwaysShow ? int(ExternalNotificationModeEnum.ALWAYS) : int(ExternalNotificationManager.getInstance().showMode),pUiName,displayData,duration,pSoundId,ExternalNotificationManager.getInstance().notificationPlaySound(pNotificationType),ExternalNotificationManager.getInstance().notificationNotify(pNotificationType),pHookName,pHookParams);
         ExternalNotificationManager.getInstance().handleNotificationRequest(req);
         return req.instanceId;
      }
      
      public function removeExternalNotification(pInstanceId:String, pActivateClientWindow:Boolean = false) : void
      {
         var ids:Array = pInstanceId.split("#");
         ExternalNotificationManager.getInstance().closeExternalNotification(ids[0],ids[1],pActivateClientWindow);
      }
      
      public function resetExternalNotificationDisplayTimeout(pInstanceId:String) : void
      {
         var ids:Array = pInstanceId.split("#");
         ExternalNotificationManager.getInstance().resetNotificationDisplayTimeout(ids[0],ids[1]);
      }
   }
}
