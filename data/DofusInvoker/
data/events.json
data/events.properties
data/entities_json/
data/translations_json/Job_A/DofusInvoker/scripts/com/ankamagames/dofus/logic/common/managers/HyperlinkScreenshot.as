package com.ankamagames.dofus.logic.common.managers
{
   import by.blooddy.crypto.MD5;
   import by.blooddy.crypto.image.JPEGEncoder;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.ScreenCaptureFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkScreenshot
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkScreenshot));
      
      private static var sysApi:SystemApi = new SystemApi();
       
      
      public function HyperlinkScreenshot()
      {
         super();
      }
      
      public static function click(pFilePath:String) : void
      {
         var f:File = new File(unescape(pFilePath));
         var _modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var menu:Array = new Array();
         menu.push(_modContextMenu.createContextMenuItemObject(I18n.getUiText("ui.common.openDirectory"),onOpenLocation,[f]));
         if(PlayerManager.getInstance().subscriptionEndDate > 0)
         {
            menu.push(_modContextMenu.createContextMenuItemObject(I18n.getUiText("ui.common.socialNetworkShare"),onShareFile,[f],!f.exists));
         }
         _modContextMenu.createContextMenu(menu);
      }
      
      private static function onOpenLocation(pFile:File) : void
      {
         if(pFile.exists && pFile.parent)
         {
            pFile.parent.openWithDefaultApplication();
         }
      }
      
      private static function onShareFile(pFile:File) : void
      {
         var fs:FileStream = null;
         var ba:ByteArray = null;
         var checkSum:String = null;
         var screenshotAsBase64:String = null;
         if(pFile.exists)
         {
            fs = new FileStream();
            try
            {
               fs.open(pFile,FileMode.READ);
            }
            catch(e:Error)
            {
               onUploadFail();
               return;
            }
            ba = new ByteArray();
            fs.readBytes(ba);
            fs.close();
            checkSum = (Kernel.getWorker().getFrame(ScreenCaptureFrame) as ScreenCaptureFrame).getChecksum(pFile.name);
            if(checkSum && MD5.hashBytes(ba) == checkSum)
            {
               screenshotAsBase64 = Base64.encodeByteArray(JPEGEncoder.encode(PNGEncoder2.decode(ba),80));
               if(screenshotAsBase64)
               {
                  if(Berilia.getInstance().getUi("sharePopup"))
                  {
                     Berilia.getInstance().unloadUi("sharePopup");
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.screenshot.upload",[pFile.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  sysApi.getUrltoShareContent({
                     "title":I18n.getUiText("ui.social.share.staticPage.defaultTitle",[PlayedCharacterManager.getInstance().infos.name]),
                     "description":I18n.getUiText("ui.social.share.staticPage.defaultDescription"),
                     "image":screenshotAsBase64
                  },function(url:String = null):void
                  {
                     if(url)
                     {
                        KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenSharePopup,url);
                     }
                  });
               }
            }
            else
            {
               onUploadFail();
            }
         }
         else
         {
            onUploadFail();
         }
      }
      
      private static function onUploadFail() : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.screenshot.uploadfail"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
      }
   }
}
