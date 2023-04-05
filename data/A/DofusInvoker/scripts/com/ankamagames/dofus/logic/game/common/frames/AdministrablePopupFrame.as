package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.datacenter.popup.PopupInformation;
   import com.ankamagames.dofus.logic.common.managers.PopupManager;
   import com.ankamagames.dofus.network.messages.game.character.stats.CharacterLevelUpMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.initialization.SetCharacterRestrictionsMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class AdministrablePopupFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AdministrablePopupFrame));
      
      private static const POPUP_PHISHING_PREVENTION_ID:uint = 15;
      
      private static const POPUP_MOUNT_ID:uint = 19;
      
      private static const THIRTY_DAYS:uint = 2592000000;
       
      
      private var _popupManager:PopupManager;
      
      private var _justConnected:Boolean = true;
      
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
         var now:Number = NaN;
         var lastPrevention:Number = NaN;
         var popupInfo:PopupInformation = null;
         switch(true)
         {
            case msg is SetCharacterRestrictionsMessage:
               if(!this._popupManager.allPopupInitialized)
               {
                  this._popupManager.getAllPopup();
                  this._popupManager.checkPopupToDisplay();
               }
               if(this._justConnected)
               {
                  this._justConnected = false;
                  now = new Date().getTime();
                  lastPrevention = StoreDataManager.getInstance().getSetData(Constants.DATASTORE_PREVENTION_POPUP,"lastPhishingPrevention",now);
                  if(now - lastPrevention > THIRTY_DAYS)
                  {
                     popupInfo = PopupInformation.getPopupInformationById(POPUP_PHISHING_PREVENTION_ID);
                     StoreDataManager.getInstance().setData(Constants.DATASTORE_PREVENTION_POPUP,"lastPhishingPrevention",now);
                     PopupManager.getInstance().preparePopup(popupInfo);
                     PopupManager.getInstance().checkPopupToDisplay(POPUP_PHISHING_PREVENTION_ID);
                  }
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
