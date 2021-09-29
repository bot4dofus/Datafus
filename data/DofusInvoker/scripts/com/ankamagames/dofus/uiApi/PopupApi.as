package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.popup.PopupButton;
   import com.ankamagames.dofus.datacenter.popup.PopupInformation;
   import com.ankamagames.dofus.internalDatacenter.AdministrablePopupWrapper;
   import com.ankamagames.dofus.logic.common.managers.PopupManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class PopupApi implements IApi
   {
       
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      public function PopupApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(PopupApi));
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
      
      public function showPopup(pId:uint) : void
      {
         PopupManager.getInstance().showPopup(pId);
      }
      
      public function preparePopup(pPopupInformation:PopupInformation) : uint
      {
         return PopupManager.getInstance().preparePopup(pPopupInformation);
      }
      
      public function addImageToPopup(pId:uint, image:String) : void
      {
         PopupManager.getInstance().addImageToPopup(pId,image);
      }
      
      public function addLinkButtonToPopup(pId:uint, pButton:PopupButton) : void
      {
         PopupManager.getInstance().addLinkButtonToPopup(pId,pButton);
      }
      
      public function addActionButtonToPopup(pId:uint, pButton:PopupButton) : void
      {
         PopupManager.getInstance().addActionButtonToPopup(pId,pButton);
      }
      
      public function addItemToPopup(pId:uint, itemId:uint, quantity:uint) : void
      {
         PopupManager.getInstance().addItemToPopup(pId,itemId,quantity);
      }
      
      public function getPopup(pId:uint) : AdministrablePopupWrapper
      {
         return PopupManager.getInstance().getPopup(pId);
      }
      
      public function clearAllPopup() : void
      {
         PopupManager.getInstance().clearAllPopup();
      }
   }
}
