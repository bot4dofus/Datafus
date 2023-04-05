package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.inventory.UpdatedStorageTabInformation;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildUpdateChestTabRequestAction extends AbstractAction implements Action
   {
       
      
      public var storageTabInfo:UpdatedStorageTabInformation;
      
      public function GuildUpdateChestTabRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pStorageTabInfo:UpdatedStorageTabInformation) : GuildUpdateChestTabRequestAction
      {
         var a:GuildUpdateChestTabRequestAction = new GuildUpdateChestTabRequestAction(arguments);
         a.storageTabInfo = pStorageTabInfo;
         return a;
      }
   }
}
