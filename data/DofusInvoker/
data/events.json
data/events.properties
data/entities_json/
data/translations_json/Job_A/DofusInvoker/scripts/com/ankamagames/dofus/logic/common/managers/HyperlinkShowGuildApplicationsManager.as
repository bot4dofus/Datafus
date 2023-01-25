package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   
   public class HyperlinkShowGuildApplicationsManager
   {
       
      
      public function HyperlinkShowGuildApplicationsManager()
      {
         super();
      }
      
      public static function getLink(text:String = null) : String
      {
         text = !!text ? "::" + text : "";
         return "{guildApplications" + text + "}";
      }
      
      public static function showGuildApplications() : void
      {
         KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationsUiRequested);
      }
   }
}
