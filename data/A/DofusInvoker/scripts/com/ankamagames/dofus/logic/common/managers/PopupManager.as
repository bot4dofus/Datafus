package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.items.criterion.CriterionUtils;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.SeasonCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ServerTypeItemCriterion;
   import com.ankamagames.dofus.datacenter.popup.PopupButton;
   import com.ankamagames.dofus.datacenter.popup.PopupInformation;
   import com.ankamagames.dofus.internalDatacenter.AdministrablePopupWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.AdministrablePopupActionTypeEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class PopupManager
   {
      
      private static var _self:PopupManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PopupManager));
       
      
      private var _dsc:DataStoreType;
      
      private var _dsa:DataStoreType;
      
      private var _cacheName:String = "AdministrablePopupDisplayed";
      
      private var _popupList:Vector.<AdministrablePopupWrapper>;
      
      private var _popupToDisplay:Vector.<AdministrablePopupWrapper>;
      
      public var allPopupInitialized:Boolean;
      
      private var _displayTimer:BenchmarkTimer;
      
      public function PopupManager()
      {
         this._dsc = new DataStoreType("Dofus_Popup",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
         this._dsa = new DataStoreType("Dofus_Popup",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
         this._displayTimer = new BenchmarkTimer(500,1,"PopupManager._displayTimer");
         super();
         this._popupList = new Vector.<AdministrablePopupWrapper>();
      }
      
      public static function getInstance() : PopupManager
      {
         if(_self == null)
         {
            _self = new PopupManager();
         }
         return _self;
      }
      
      public function getAllPopup() : void
      {
         var criterionList:Vector.<IItemCriterion> = null;
         var respectAllCriterion:* = false;
         var isPrepared:Boolean = false;
         var popupInformation:PopupInformation = null;
         var criterion:IItemCriterion = null;
         var popups:Array = PopupInformation.getPopupInformations();
         for each(popupInformation in popups)
         {
            if(popupInformation.autoTrigger)
            {
               criterionList = CriterionUtils.getCriteriaFromString(popupInformation.criterion);
               respectAllCriterion = criterionList.length > 0;
               isPrepared = false;
               for each(criterion in criterionList)
               {
                  if((criterion is ServerTypeItemCriterion || criterion is SeasonCriterion) && !this.isInCache(popupInformation))
                  {
                     this.preparePopup(popupInformation);
                     isPrepared = true;
                  }
                  else if(!criterion.isRespected)
                  {
                     respectAllCriterion = false;
                     break;
                  }
               }
               if(!isPrepared && !respectAllCriterion && !this.isInCache(popupInformation))
               {
                  this.preparePopup(popupInformation);
               }
            }
         }
         this.allPopupInitialized = true;
      }
      
      public function showPopup(pId:uint) : int
      {
         var popupInfo:PopupInformation = PopupInformation.getPopupInformationById(pId);
         if(!popupInfo)
         {
            return -1;
         }
         if(this.isInCache(popupInfo))
         {
            return pId;
         }
         this.preparePopup(popupInfo);
         this.checkPopupToDisplay(pId);
         return pId;
      }
      
      public function preparePopup(pPopupInformation:PopupInformation) : uint
      {
         var button:PopupButton = null;
         var popup:AdministrablePopupWrapper = new AdministrablePopupWrapper();
         popup.id = pPopupInformation.id;
         popup.title = pPopupInformation.title;
         popup.contentText = pPopupInformation.description;
         popup.criterion = pPopupInformation.criterion;
         popup.cacheType = pPopupInformation.cacheType;
         this._popupList.push(popup);
         if(pPopupInformation.illuName != "")
         {
            this.addImageToPopup(pPopupInformation.id,pPopupInformation.illuName);
         }
         if(pPopupInformation.buttons.length > 0)
         {
            for each(button in pPopupInformation.buttons)
            {
               if(button.actionType == AdministrablePopupActionTypeEnum.LINK)
               {
                  this.addLinkButtonToPopup(pPopupInformation.id,button);
               }
               else if(button.actionType == AdministrablePopupActionTypeEnum.ACTION)
               {
                  this.addActionButtonToPopup(pPopupInformation.id,button);
               }
            }
         }
         popup.name = "popup_" + pPopupInformation.id;
         return pPopupInformation.id;
      }
      
      public function addImageToPopup(pId:uint, image:String) : void
      {
         var popup:AdministrablePopupWrapper = this.getPopup(pId);
         if(popup)
         {
            popup.image = image;
         }
      }
      
      public function addLinkButtonToPopup(pId:uint, pButton:PopupButton) : void
      {
         var popup:AdministrablePopupWrapper = this.getPopup(pId);
         if(popup)
         {
            popup.addButton(pButton);
         }
      }
      
      public function addActionButtonToPopup(pId:uint, pButton:PopupButton) : void
      {
         var popup:AdministrablePopupWrapper = this.getPopup(pId);
         if(popup)
         {
            popup.addButton(pButton);
         }
      }
      
      public function addItemToPopup(pId:uint, itemId:uint, quantity:uint) : void
      {
         var popup:AdministrablePopupWrapper = this.getPopup(pId);
         if(popup)
         {
            popup.addItem(itemId,quantity);
         }
      }
      
      public function getPopup(pId:uint) : AdministrablePopupWrapper
      {
         var popup:AdministrablePopupWrapper = null;
         for each(popup in this._popupList)
         {
            if(popup.id == pId)
            {
               return popup;
            }
         }
         return null;
      }
      
      public function checkPopupToDisplay(pId:int = -1) : void
      {
         var groupCriterion:GroupItemCriterion = null;
         var popup:AdministrablePopupWrapper = null;
         this.restartDisplayTimer();
         if(!this._popupToDisplay)
         {
            this._popupToDisplay = new Vector.<AdministrablePopupWrapper>();
         }
         if(pId == -1)
         {
            for each(popup in this._popupList)
            {
               if(!this.isInCache(popup))
               {
                  groupCriterion = new GroupItemCriterion(popup.criterion);
                  if(groupCriterion.isRespected)
                  {
                     this._popupToDisplay.push(popup);
                  }
               }
            }
            for each(popup in this._popupToDisplay)
            {
               if(this._popupList.indexOf(popup) != -1)
               {
                  this._popupList.splice(this._popupList.indexOf(popup),1);
               }
            }
         }
         else
         {
            popup = this.getPopup(pId);
            if(!popup)
            {
               return;
            }
            groupCriterion = new GroupItemCriterion(popup.criterion);
            if(groupCriterion.isRespected)
            {
               if(this._popupList.indexOf(popup) != -1)
               {
                  this._popupList.splice(this._popupList.indexOf(popup),1);
               }
               this._popupToDisplay.push(popup);
            }
         }
      }
      
      public function sendPopup(pId:int = -1) : void
      {
         if(!this._popupToDisplay)
         {
            this._popupToDisplay = new Vector.<AdministrablePopupWrapper>();
         }
         if(this._popupToDisplay.length > 1)
         {
            this.openPopup(this._popupToDisplay);
         }
         else if(this._popupToDisplay.length == 1)
         {
            this.openPopup(Vector.<AdministrablePopupWrapper>([this._popupToDisplay[0]]));
         }
         this.addPopupToCache();
         this._popupToDisplay = new Vector.<AdministrablePopupWrapper>();
      }
      
      public function clearAllPopup() : void
      {
         this._popupList = new Vector.<AdministrablePopupWrapper>();
         this._popupToDisplay = new Vector.<AdministrablePopupWrapper>();
      }
      
      public function addPopupToDisplay(pId:uint = 1.0, checkCriterion:Boolean = true) : void
      {
         var popup:AdministrablePopupWrapper = null;
         if(checkCriterion)
         {
            this.checkPopupToDisplay(pId);
         }
         else
         {
            this.restartDisplayTimer();
            popup = this.getPopup(pId);
            if(!popup)
            {
               return;
            }
            if(!this._popupToDisplay)
            {
               this._popupToDisplay = new Vector.<AdministrablePopupWrapper>();
            }
            if(!this.isInCache(popup))
            {
               if(this._popupList.indexOf(popup) != -1)
               {
                  this._popupList.splice(this._popupList.indexOf(popup),1);
               }
               this._popupToDisplay.push(popup);
            }
         }
      }
      
      private function addPopupToCache() : void
      {
         var currentDataStoreType:DataStoreType = null;
         var popup:AdministrablePopupWrapper = null;
         var cachedPopup:Array = [];
         for each(popup in this._popupToDisplay)
         {
            if(popup.cacheType == DataStoreEnum.BIND_ACCOUNT)
            {
               this._cacheName = "AdministrablePopupDisplayed";
               currentDataStoreType = this._dsa;
            }
            else
            {
               if(popup.cacheType != DataStoreEnum.BIND_CHARACTER)
               {
                  continue;
               }
               this._cacheName = "AdministrablePopupDisplayed" + PlayedCharacterManager.getInstance().id;
               currentDataStoreType = this._dsc;
            }
            cachedPopup = StoreDataManager.getInstance().getData(currentDataStoreType,this._cacheName);
            if(cachedPopup == null)
            {
               cachedPopup = [];
            }
            if(cachedPopup.indexOf(popup.id) == -1)
            {
               cachedPopup.push(popup.id);
            }
            StoreDataManager.getInstance().setData(currentDataStoreType,this._cacheName,cachedPopup);
         }
      }
      
      private function restartDisplayTimer() : void
      {
         this._displayTimer.reset();
         this._displayTimer.addEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this._displayTimer.start();
      }
      
      private function onDisplayTimer(r:TimerEvent = null) : void
      {
         this._displayTimer.reset();
         this._displayTimer.removeEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this.sendPopup();
      }
      
      private function openPopup(popupList:Vector.<AdministrablePopupWrapper>) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.OpenPopup,popupList);
      }
      
      private function isInCache(popup:Object) : Boolean
      {
         var cachePopup:Array = null;
         if(popup.cacheType == DataStoreEnum.BIND_ACCOUNT)
         {
            this._cacheName = "AdministrablePopupDisplayed";
            cachePopup = StoreDataManager.getInstance().getSetData(this._dsa,this._cacheName,[]);
         }
         else
         {
            if(popup.cacheType != DataStoreEnum.BIND_CHARACTER)
            {
               return false;
            }
            this._cacheName = "AdministrablePopupDisplayed" + PlayedCharacterManager.getInstance().id;
            cachePopup = StoreDataManager.getInstance().getSetData(this._dsc,this._cacheName,[]);
         }
         return cachePopup.indexOf(popup.id) != -1;
      }
   }
}
