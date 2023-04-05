package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HyperlinkURLManager
   {
       
      
      public function HyperlinkURLManager()
      {
         super();
      }
      
      public static function openURL(url:String) : void
      {
         if(authorizedUrl(url))
         {
            navigateToURL(new URLRequest(url),"_blank");
         }
      }
      
      private static function authorizedUrl(url:String) : Boolean
      {
         if(url.indexOf("http") != 0)
         {
            return false;
         }
         return true;
      }
      
      public static function chatLinkRelease(link:String, sender:uint, senderName:String) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatLinkRelease,link,sender,senderName);
      }
      
      public static function chatWarning() : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.ChatWarning);
      }
      
      public static function rollOver(pX:int, pY:int, link:String, sender:uint, senderName:String) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.url"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
