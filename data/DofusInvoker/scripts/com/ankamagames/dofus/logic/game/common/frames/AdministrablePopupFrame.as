package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.logic.common.managers.PopupManager;
   import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.initialization.SetCharacterRestrictionsMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class AdministrablePopupFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AdministrablePopupFrame));
      
      private static const POPUP_MOUNT_ID:uint = 19;
       
      
      private var _popupManager:PopupManager;
      
      public function AdministrablePopupFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.LOW;
      }
      
      public function pushed() : Boolean
      {
         this._popupManager = PopupManager.getInstance();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is SetCharacterRestrictionsMessage:
               if(!this._popupManager.allPopupInitialized)
               {
                  this._popupManager.getAllPopup();
                  this._popupManager.checkPopupToDisplay();
               }
               return true;
            case msg is CharacterLevelUpMessage:
            case msg is MapComplementaryInformationsDataMessage:
               this._popupManager.checkPopupToDisplay();
               return false;
            case msg is MountSetMessage:
               this._popupManager.addPopupToDisplay(POPUP_MOUNT_ID,false);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         this._popupManager.clearAllPopup();
         this._popupManager.allPopupInitialized = false;
         this._popupManager = null;
         return true;
      }
   }
}
