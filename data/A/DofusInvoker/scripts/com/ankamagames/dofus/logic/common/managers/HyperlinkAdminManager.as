package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   
   public class HyperlinkAdminManager
   {
       
      
      public function HyperlinkAdminManager()
      {
         super();
      }
      
      public static function addCmd(auto:String, cmd:String) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.ConsoleAddCmd,auto.toLowerCase() == "true",Base64.decode(cmd));
      }
   }
}
