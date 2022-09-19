package Ankama_Common
{
   import Ankama_Common.options.OptionItem;
   import Ankama_Common.options.OptionManager;
   import Ankama_Common.ui.AdministrablePopup;
   import Ankama_Common.ui.BetaMenu;
   import Ankama_Common.ui.CheckboxPopup;
   import Ankama_Common.ui.DelayedClosurePopup;
   import Ankama_Common.ui.EvolutiveFeedUi;
   import Ankama_Common.ui.FeedUi;
   import Ankama_Common.ui.GameMenu;
   import Ankama_Common.ui.IllustratedPopup;
   import Ankama_Common.ui.IllustratedWithLinkPopup;
   import Ankama_Common.ui.ImagePopup;
   import Ankama_Common.ui.InputComboBoxPopup;
   import Ankama_Common.ui.InputPopup;
   import Ankama_Common.ui.ItemRecipes;
   import Ankama_Common.ui.ItemsList;
   import Ankama_Common.ui.ItemsSet;
   import Ankama_Common.ui.LargePopup;
   import Ankama_Common.ui.LockedPopup;
   import Ankama_Common.ui.OptionContainer;
   import Ankama_Common.ui.PasswordMenu;
   import Ankama_Common.ui.PollPopup;
   import Ankama_Common.ui.Popup;
   import Ankama_Common.ui.QuantityPopup;
   import Ankama_Common.ui.QueuePopup;
   import Ankama_Common.ui.Recipes;
   import Ankama_Common.ui.SecureMode;
   import Ankama_Common.ui.SecureModeIcon;
   import Ankama_Common.ui.TextButtonPopup;
   import Ankama_Common.ui.items.RecipeItem;
   import Ankama_Common.ui.items.RecipesFilterWrapper;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuSeparator;
   import Ankama_ContextMenu.contextMenu.ContextMenuTitle;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.AdministrablePopupWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Common extends Sprite
   {
      
      private static var _self:Common;
      
      private static const VIP_IDS:Array = [3003078,3003178,65611403,3031421,3029727,3029948,3030024];
       
      
      private var include_Popup:Popup = null;
      
      private var include_InputPopup:InputPopup = null;
      
      private var include_InputComboBoxPopup:InputComboBoxPopup = null;
      
      private var include_CheckboxPopup:CheckboxPopup = null;
      
      private var include_PollPopup:PollPopup = null;
      
      private var include_ImagePopup:ImagePopup = null;
      
      private var include_TextButtonPopup:TextButtonPopup = null;
      
      private var include_LargePopup:LargePopup = null;
      
      private var include_DelayedClosurePopup:DelayedClosurePopup = null;
      
      private var include_QuantityPopup:QuantityPopup = null;
      
      private var include_OptionContainer:OptionContainer = null;
      
      private var include_PasswordMenu:PasswordMenu = null;
      
      private var include_ItemRecipes:ItemRecipes = null;
      
      private var include_ItemsSet:ItemsSet = null;
      
      private var include_ItemsList:ItemsList = null;
      
      private var include_RecipeItem:RecipeItem = null;
      
      private var include_GameMenu:GameMenu = null;
      
      private var include_BetaMenu:BetaMenu = null;
      
      private var include_QueuePopup:QueuePopup = null;
      
      private var include_Recipes:Recipes = null;
      
      private var include_FeedUi:FeedUi = null;
      
      private var include_EvolutiveFeedUi:EvolutiveFeedUi = null;
      
      private var include_LockedPopup:LockedPopup = null;
      
      private var include_SecureMode:SecureMode = null;
      
      private var include_SecureModeIcon:SecureModeIcon = null;
      
      private var include_illustratedPopup:IllustratedPopup = null;
      
      private var include_illustratedWithLinkPopup:IllustratedWithLinkPopup = null;
      
      private var include_administrablePopup:AdministrablePopup = null;
      
      private var _secureModeNeedReboot:Object;
      
      private var _lastPage:int = -1;
      
      private var _popupId:uint = 0;
      
      private var _lastFoodQuantity:int = 1;
      
      private var _recipeSlotsNumber:int;
      
      private var _jobSearchOptions:Dictionary;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modMenu:ContextMenu = null;
      
      private var _currentPopupNumber:int = 0;
      
      public function Common()
      {
         this._secureModeNeedReboot = {"reboot":false};
         this._jobSearchOptions = new Dictionary();
         super();
      }
      
      public static function getInstance() : Common
      {
         return _self;
      }
      
      public function main() : void
      {
         Api.ui = this.uiApi;
         Api.system = this.sysApi;
         Api.tooltip = this.tooltipApi;
         this.uiApi.initDefaultBinds();
         this.uiApi.addShortcutHook("toggleFullscreen",this.onToggleFullScreen);
         this.sysApi.addHook(HookList.OpenRecipe,this.onOpenItemRecipes);
         this.sysApi.addHook(HookList.OpenSet,this.onOpenItemSet);
         this.sysApi.addHook(HookList.OpenFeed,this.onOpenFeed);
         this.sysApi.addHook(HookList.OpenEvolutiveFeed,this.onOpenEvolutiveFeed);
         this.sysApi.addHook(HookList.OpenMountFeed,this.onOpenMountFeed);
         this.sysApi.addHook(HookList.OpenItemsList,this.onOpenItemsList);
         this.sysApi.addHook(HookList.LoginQueueStatus,this.onLoginQueueStatus);
         this.sysApi.addHook(HookList.QueueStatus,this.onQueueStatus);
         this.sysApi.addHook(ChatHookList.ShowObjectLinked,this.onShowObjectLinked);
         this.sysApi.addHook(HookList.SecureModeChange,this.onSecureModeChange);
         this.sysApi.addHook(HookList.ErrorPopup,this.onErrorPopup);
         this.sysApi.addHook(HookList.ClosePopup,this.onClosePopup);
         this.sysApi.addHook(HookList.OpenPopup,this.onOpenPopup);
         this.sysApi.addHook(HookList.GameStart,this.onGameStart);
         var accountId:uint = this.sysApi.getPlayerManager().accountId;
         var visibleBugReportBtn:Boolean = this.sysApi.getBuildType() == BuildTypeEnum.BETA && (!this.sysApi.getConfigKey("eventMode") || this.sysApi.getConfigKey("eventMode") == "false");
         var visiblePartyTimeBtn:Boolean = this.sysApi.getBuildType() >= BuildTypeEnum.INTERNAL && VIP_IDS.indexOf(accountId) != -1;
         if(visibleBugReportBtn || visiblePartyTimeBtn)
         {
            this.uiApi.loadUi("betaMenu","betaMenu",{
               "visibleBugReportBtn":visibleBugReportBtn,
               "visiblePartyTimeBtn":visiblePartyTimeBtn
            },StrataEnum.STRATA_TOP);
         }
         this.uiApi.loadUi("gameMenu","gameMenu",null,StrataEnum.STRATA_TOP);
         this.uiApi.preloadCss("theme://css/chat.css");
         OptionManager.getInstance().reset();
         _self = this;
      }
      
      public function get lastFoodQuantity() : int
      {
         return this._lastFoodQuantity;
      }
      
      public function set lastFoodQuantity(qty:int) : void
      {
         this._lastFoodQuantity = qty;
      }
      
      public function get recipeSlotsNumber() : int
      {
         return this._recipeSlotsNumber;
      }
      
      public function set recipeSlotsNumber(value:int) : void
      {
         this._recipeSlotsNumber = value;
      }
      
      public function addOptionItem(id:String, name:String, description:String, ui:String = null, childItems:Array = null) : void
      {
         OptionManager.getInstance().addItem(new OptionItem(id,name,description,ui,childItems));
      }
      
      public function getJobSearchOptionsByJobId(id:int) : RecipesFilterWrapper
      {
         return this._jobSearchOptions[id];
      }
      
      public function setJobSearchOptionsByJobId(filter:RecipesFilterWrapper) : void
      {
         this._jobSearchOptions[filter.jobId] = filter;
      }
      
      private function onOpenPopup(popupList:Vector.<AdministrablePopupWrapper>) : void
      {
         this.uiApi.loadUi("administrablePopup",popupList[0].name,popupList,StrataEnum.STRATA_TOP);
      }
      
      private function onErrorPopup(pErrorMsg:String) : void
      {
         this.openPopup(this.uiApi.getText("ui.common.error"),pErrorMsg,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onClosePopup() : void
      {
         --this._currentPopupNumber;
      }
      
      public function openPopup(title:String, content:String, buttonText:Array, buttonCallback:Array = null, onEnterKey:Function = null, onCancel:Function = null, image:Object = null, largeText:Boolean = false, useHyperLink:Boolean = false, displayBtnIcons:Boolean = true, buttonIcons:Array = null, strata:int = 3, addExternalPicto:Boolean = false) : String
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.buttonText = buttonText;
         params.buttonCallback = !!buttonCallback ? buttonCallback : new Array();
         params.onEnterKey = onEnterKey;
         params.onCancel = onCancel;
         params.image = image;
         params.useHyperLink = useHyperLink;
         params.displayBtnIcons = displayBtnIcons;
         params.buttonIcons = buttonIcons;
         params.hideModalContainer = this._currentPopupNumber > 1;
         params.addExternalPicto = addExternalPicto;
         var popupName:String = "popup" + ++this._popupId;
         if(image == null)
         {
            if(largeText)
            {
               this.uiApi.loadUi("largePopup",popupName,params,strata);
            }
            else
            {
               this.uiApi.loadUi("popup",popupName,params,strata);
            }
         }
         else
         {
            this.uiApi.loadUi("imagepopup",popupName,params,strata);
         }
         return popupName;
      }
      
      public function openNoButtonPopup(title:String, content:String) : String
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.noButton = true;
         params.hideModalContainer = this._currentPopupNumber > 1;
         var popupName:String = "popup" + ++this._popupId;
         this.uiApi.loadUi("popup",popupName,params,3);
         return popupName;
      }
      
      public function openTextPopup(title:String, content:String, buttonText:Array, buttonCallback:Array = null, onEnterKey:Function = null, onCancel:Function = null) : String
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.buttonText = buttonText;
         params.buttonCallback = !!buttonCallback ? buttonCallback : new Array();
         params.onEnterKey = onEnterKey;
         params.onCancel = onCancel;
         params.noHtml = true;
         params.hideModalContainer = this._currentPopupNumber > 1;
         var popupName:String = "popup" + ++this._popupId;
         this.uiApi.loadUi("popup",popupName,params,3);
         return popupName;
      }
      
      public function openDelayedClosurePopup(contentText:String, delay:int, marginTop:int = 0) : void
      {
         var params:Object = new Object();
         params.content = contentText;
         params.delay = delay * 1000;
         params.marginTop = marginTop;
         if(this.uiApi.getUi("delayedclosurepopup"))
         {
            this.uiApi.unloadUi("delayedclosurepopup");
         }
         this.uiApi.loadUi("delayedclosurepopup",null,params,3);
      }
      
      public function openLockedPopup(title:String, content:String, onCancel:Function = null, closeAtHook:Boolean = false, closeParam:Array = null, autoClose:Boolean = false, useHyperLink:Boolean = false) : String
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.onCancel = onCancel;
         params.closeAtHook = closeAtHook;
         params.closeParam = closeParam != null ? closeParam : ["5000"];
         params.autoClose = autoClose;
         params.useHyperLink = useHyperLink;
         params.hideModalContainer = this._currentPopupNumber > 1;
         var popupName:String = "popup" + ++this._popupId;
         this.uiApi.loadUi("lockedPopup",popupName,params,3);
         return popupName;
      }
      
      public function openQuantityPopup(min:Number, max:Number, defaultValue:Number, validCallback:Function, cancelCallback:Function = null, lockValue:Boolean = false, target:GraphicContainer = null) : void
      {
         var params:Object = new Object();
         params.target = target;
         params.min = min;
         params.max = max;
         params.defaultValue = defaultValue;
         params.validCallback = validCallback;
         params.cancelCallback = cancelCallback;
         params.lockValue = lockValue;
         if(this.uiApi.getUi("quantityPopup"))
         {
            this.uiApi.unloadUi("quantityPopup");
         }
         this.uiApi.loadUi("quantityPopup",null,params,3);
      }
      
      public function openInputPopup(title:String, content:String, validCallback:Function, cancelCallback:Function, defaultValue:String = "", restric:String = null, maxChars:int = 0) : void
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.validCallBack = validCallback;
         params.cancelCallback = cancelCallback;
         params.defaultValue = defaultValue;
         params.restric = restric;
         params.maxChars = maxChars;
         params.hideModalContainer = this._currentPopupNumber > 1;
         this.uiApi.loadUi("inputPopup","inputPopup" + this._popupId++,params,3);
      }
      
      public function openInputComboBoxPopup(title:String, content:String, resetButtonTooltip:String, validCallback:Function, cancelCallback:Function, resetCallback:Function, defaultValue:String = "", restric:String = null, maxChars:int = 0, dataProvider:* = null) : void
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.resetButtonTooltip = resetButtonTooltip;
         params.validCallBack = validCallback;
         params.cancelCallback = cancelCallback;
         params.resetCallback = resetCallback;
         params.defaultValue = defaultValue;
         params.restric = restric;
         params.maxChars = maxChars;
         params.hideModalContainer = this._currentPopupNumber > 1;
         params.dataProvider = dataProvider;
         this.uiApi.loadUi("inputComboBoxPopup","inputComboBoxPopup" + this._popupId++,params,3);
      }
      
      public function openCheckboxPopup(title:String, content:String, validCallback:Function, cancelCallback:Function, checkboxText:String, defaultSelect:Boolean = false) : void
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.validCallBack = validCallback;
         params.cancelCallback = cancelCallback;
         params.checkboxText = checkboxText;
         params.defaultSelect = defaultSelect;
         params.hideModalContainer = this._currentPopupNumber > 1;
         this.uiApi.loadUi("checkboxPopup","checkboxPopup" + this._popupId++,params,3);
      }
      
      public function openPollPopup(title:String, content:String, answers:Array, onlyOneAnswer:Boolean, validCallback:Function, cancelCallback:Function) : void
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.validCallBack = validCallback;
         params.cancelCallback = cancelCallback;
         params.answers = answers;
         params.onlyOneAnswer = onlyOneAnswer;
         params.hideModalContainer = this._currentPopupNumber > 1;
         this.uiApi.loadUi("pollPopup","pollPopup" + this._popupId++,params,3);
      }
      
      public function openTextButtonPopup(title:String, content:String, buttonText:Array, buttonCallback:Array, onEnterKey:Function = null, onCancel:Function = null) : String
      {
         ++this._currentPopupNumber;
         var params:Object = new Object();
         params.title = title;
         params.content = content;
         params.buttonText = buttonText;
         params.buttonCallback = !!buttonCallback ? buttonCallback : new Array();
         params.onEnterKey = onEnterKey;
         params.onCancel = onCancel;
         var popupName:String = "popup" + ++this._popupId;
         this.uiApi.loadUi("textButtonPopup",popupName,params,StrataEnum.STRATA_TOP);
         return popupName;
      }
      
      public function closeAllMenu() : void
      {
         this.modMenu.closeAllMenu();
      }
      
      public function createContextMenu(menu:Array) : void
      {
         this.modMenu.createContextMenu(menu);
      }
      
      public function createContextMenuTitleObject(label:String) : ContextMenuTitle
      {
         return this.modMenu.createContextMenuTitleObject(label);
      }
      
      public function createContextMenuItemObject(label:String, callback:Function = null, callbackArgs:Array = null, disabled:Boolean = false, child:Array = null, selected:Boolean = false, radioStyle:Boolean = true, help:String = null, forceCloseOnSelect:Boolean = false) : ContextMenuItem
      {
         return this.modMenu.createContextMenuItemObject(label,callback,callbackArgs,disabled,child,selected,radioStyle,help,forceCloseOnSelect);
      }
      
      public function createContextMenuSeparatorObject() : ContextMenuSeparator
      {
         return this.modMenu.createContextMenuSeparatorObject();
      }
      
      public function openOptionMenu(close:Boolean = false, tab:String = null) : void
      {
         if(!close && !this.uiApi.getUi("optionContainer"))
         {
            this.uiApi.loadUi("optionContainer",null,tab,StrataEnum.STRATA_TOP);
         }
         if(close)
         {
            this.uiApi.unloadUi("optionContainer");
         }
      }
      
      private function onToggleFullScreen(shortcut:String) : Boolean
      {
         if(shortcut != "toggleFullscreen")
         {
            return true;
         }
         var isFullScreen:Boolean = this.configApi.getConfigProperty("dofus","fullScreen");
         this.configApi.setConfigProperty("dofus","fullScreen",!isFullScreen);
         return false;
      }
      
      private function onOpenItemRecipes(item:ItemWrapper) : void
      {
         Api.ui.unloadUi("itemRecipes");
         Api.ui.loadUi("itemRecipes","itemRecipes",{"item":item},2);
      }
      
      private function onOpenItemSet(item:ItemWrapper) : void
      {
         Api.ui.unloadUi("itemsSet");
         Api.ui.loadUi("itemsSet","itemsSet",{"item":item},2);
      }
      
      private function onOpenFeed(item:ItemWrapper) : void
      {
         Api.ui.unloadUi("feedUi");
         Api.ui.loadUi("feedUi","feedUi",{
            "item":item,
            "type":1
         },2);
      }
      
      private function onOpenEvolutiveFeed(itemToFeed:ItemWrapper) : void
      {
         Api.ui.unloadUi("evolutiveFeedUi");
         Api.ui.loadUi("evolutiveFeedUi","evolutiveFeedUi",{"itemToFeed":itemToFeed},StrataEnum.STRATA_TOP);
      }
      
      private function onOpenMountFeed(mountId:int, mountFamilyId:int, location:int, foodList:Object) : void
      {
         Api.ui.unloadUi("feedUi");
         Api.ui.loadUi("feedUi","feedUi",{
            "type":2,
            "mountId":mountId,
            "mountFamilyId":mountFamilyId,
            "mountLocation":location,
            "foodList":foodList
         },StrataEnum.STRATA_TOP);
      }
      
      private function onOpenItemsList(selectedItemUID:int, items:Vector.<ItemWrapper>, title:String, callback:Function) : void
      {
         if(this.uiApi.getUi("itemsList"))
         {
            Api.ui.getUi("itemsList").uiClass.display(selectedItemUID,items,title,callback);
         }
         else
         {
            Api.ui.loadUi("itemsList","itemsList",{
               "selectedItemUID":selectedItemUID,
               "items":items,
               "title":title,
               "callback":callback
            },StrataEnum.STRATA_TOP);
         }
      }
      
      private function onShowObjectLinked(item:ItemWrapper = null) : void
      {
         var setting:String = null;
         var settings:Object = new Object();
         var itemTooltipSettings:ItemTooltipSettings = Api.system.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = Api.tooltip.createItemSettings();
            Api.system.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:Vector.<String> = Api.system.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         settings.pinnable = true;
         if(!item.objectUID)
         {
            settings.showEffects = true;
         }
         Api.ui.showTooltip(item,new Rectangle(420,220,0,0),false,"standard",0,0,0,null,null,settings,null,true,4,1,"common");
      }
      
      public function openPasswordMenu(size:int, changeOrUse:Boolean, onConfirm:Function, onCancel:Function = null) : void
      {
         if(!this.uiApi.getUi("passwordMenu"))
         {
            this.uiApi.loadUi("passwordMenu","passwordMenu",{
               "size":size,
               "changeOrUse":changeOrUse,
               "confirmCallBack":onConfirm,
               "cancelCallBack":onCancel
            });
         }
      }
      
      public function createRecipesObject(name:String, father:GraphicContainer, subRecipesCtr:Object, jobId:int, skillId:int = 0, matsCountMode:Boolean = false, storage:String = "", jobLevel:int = 0, ingredientsToleranceFilter:int = 8) : UiRootContainer
      {
         if(!this.uiApi.getUi(name))
         {
            return this.uiApi.loadUiInside("recipes",father,name,{
               "subRecipesCtr":subRecipesCtr,
               "jobId":jobId,
               "skillId":skillId,
               "matsCountMode":matsCountMode,
               "storage":storage,
               "jobLevel":jobLevel,
               "ingredientsToleranceFilter":ingredientsToleranceFilter
            });
         }
         father.addContent(this.uiApi.getUi(name));
         return this.uiApi.getUi(name);
      }
      
      public function onLoginQueueStatus(position:uint, total:uint) : void
      {
         if(!this.uiApi.getUi("queuePopup") && position > 0)
         {
            this.uiApi.loadUi("queuePopup","queuePopup",[position,total,true],3);
         }
      }
      
      public function onQueueStatus(position:uint, total:uint) : void
      {
         if(!this.uiApi.getUi("queuePopup") && position > 0)
         {
            this.uiApi.loadUi("queuePopup","queuePopup",[position,total,false],3);
         }
      }
      
      private function onSecureModeChange(active:Boolean) : void
      {
         if(active && !this.uiApi.getUi("secureModeIcon"))
         {
            this.uiApi.loadUi("secureModeIcon","secureModeIcon",this._secureModeNeedReboot,StrataEnum.STRATA_HIGH);
            this.uiApi.loadUi("secureMode","secureMode",this._secureModeNeedReboot,StrataEnum.STRATA_HIGH);
         }
         if(!active && this.uiApi.getUi("secureModeIcon"))
         {
            this.uiApi.unloadUi("secureModeIcon");
         }
      }
      
      public function unload() : void
      {
         Api.system = null;
         Api.ui = null;
         Api.tooltip = null;
         Api.data = null;
      }
      
      public function onGameStart() : void
      {
         if(this.secureApi.SecureModeisActive())
         {
            this.uiApi.loadUi("secureModeIcon","secureModeIcon",null,StrataEnum.STRATA_HIGH);
         }
      }
   }
}
