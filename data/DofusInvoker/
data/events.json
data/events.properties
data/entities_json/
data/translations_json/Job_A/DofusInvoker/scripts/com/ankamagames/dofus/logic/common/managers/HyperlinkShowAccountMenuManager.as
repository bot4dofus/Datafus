package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   
   public class HyperlinkShowAccountMenuManager
   {
       
      
      public function HyperlinkShowAccountMenuManager()
      {
         super();
      }
      
      public static function showAccountMenu(accountName:String, accountTag:String, accountId:int, category:uint = 0) : void
      {
         var _modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         _modContextMenu.createContextMenu(MenusFactory.create({
            "name":accountName,
            "tag":accountTag,
            "id":accountId,
            "category":category
         },"account"));
      }
      
      public static function getAccountName(accountName:String, accountId:int, category:uint = 0, chan:uint = 0) : String
      {
         var priority:int = 0;
         var accountNameClean:String = unescape(accountName);
         switch(chan)
         {
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
            case ChatActivableChannelsEnum.CHANNEL_ADMIN:
               priority = 3;
               break;
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
               priority = 4;
               break;
            default:
               priority = 1;
         }
         if(accountNameClean && accountNameClean.indexOf("★") == 0)
         {
            accountNameClean = accountNameClean.substr(1);
         }
         ChatAutocompleteNameManager.getInstance().addEntry(accountNameClean,priority);
         return accountNameClean;
      }
   }
}
