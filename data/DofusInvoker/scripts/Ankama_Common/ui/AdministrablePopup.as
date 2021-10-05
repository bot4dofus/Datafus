package Ankama_Common.ui
{
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.popup.PopupButton;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.types.enums.AdministrablePopupActionTypeEnum;
   import com.ankamagames.dofus.types.enums.AdministrablePopupButtonTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.filesystem.File;
   import flash.utils.Dictionary;
   
   public class AdministrablePopup extends Popup
   {
       
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var administrablePopup:GraphicContainer;
      
      public var btn_main:ButtonContainer;
      
      public var lbl_btn_main:Label;
      
      public var tx_btn_main:TextureBitmap;
      
      public var btn_secondary:ButtonContainer;
      
      public var lbl_btn_secondary:Label;
      
      public var tx_btn_secondary:TextureBitmap;
      
      public var btn_close_administrablePopup:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var tx_illu:Texture;
      
      public var ctr_items:GraphicContainer;
      
      public var gd_items:Grid;
      
      public var tx_previousPopup:Texture;
      
      public var tx_nextPopup:Texture;
      
      private var _componentList:Dictionary;
      
      private var _popupList:Vector.<Object>;
      
      private var _currentPopup:Object;
      
      private var _currentPopupIndex:int = 0;
      
      private var _mainButtonCallback:Function;
      
      private var _secondaryButtonCallback:Function;
      
      private var _onCloseCallback:Function;
      
      private var _totalHeight:int = 0;
      
      private var _hasImage:Boolean;
      
      private var _hasItemList:Boolean;
      
      private var _hasButton:Boolean;
      
      private var _margin:int = 10;
      
      private var _labelOffset:int = 25;
      
      public function AdministrablePopup()
      {
         this._componentList = new Dictionary();
         super();
      }
      
      override public function main(params:Object) : void
      {
         if(params.length <= 0)
         {
            return;
         }
         sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         uiApi.addComponentHook(this.tx_previousPopup,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.tx_nextPopup,ComponentHookList.ON_RELEASE);
         this._popupList = Vector.<Object>(params);
         this._currentPopup = this._popupList[this._currentPopupIndex];
         this.checkParams();
         this._totalHeight = this.administrablePopup.height;
      }
      
      public function updateItemLine(data:*, components:*, selected:Boolean) : void
      {
         var item:ItemWrapper = null;
         if(data)
         {
            if(!this._componentList[components.tx_itemIcon.name])
            {
               uiApi.addComponentHook(components.tx_itemIcon,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(components.tx_itemIcon,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_itemIcon.name] = data;
            if(!this._componentList[components.tx_itemBg.name])
            {
               uiApi.addComponentHook(components.tx_itemBg,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(components.tx_itemBg,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.tx_itemBg.name] = data;
            item = this.dataApi.getItemWrapper(data.id);
            components.tx_itemIcon.uri = item.iconUri;
            components.lbl_name.text = item.name;
            components.lbl_quantity.text = "x " + data.quantity;
         }
      }
      
      private function saveAllPosition() : void
      {
         this.lbl_title.setSavedPosition(this.lbl_title.anchorX,this.lbl_title.anchorY);
         lbl_content.setSavedPosition(lbl_content.anchorX,lbl_content.anchorY);
         this.ctr_items.setSavedPosition(this.ctr_items.anchorX,this.ctr_items.anchorY);
         this.btn_main.setSavedPosition(this.btn_main.anchorX,this.btn_main.anchorY);
         this.lbl_btn_secondary.setSavedPosition(this.lbl_btn_secondary.x,this.lbl_btn_secondary.y);
      }
      
      private function restoreAllPosition() : void
      {
         this.lbl_title.x = this.lbl_title.getSavedPosition().x;
         this.lbl_title.y = this.lbl_title.getSavedPosition().y;
         lbl_content.x = lbl_content.getSavedPosition().x;
         lbl_content.y = lbl_content.getSavedPosition().y;
         this.ctr_items.x = this.ctr_items.getSavedPosition().x;
         this.ctr_items.y = this.ctr_items.getSavedPosition().y;
         this.btn_main.x = this.btn_main.getSavedPosition().x;
         this.btn_main.y = this.btn_main.getSavedPosition().y;
         this.lbl_btn_secondary.x = this.lbl_btn_secondary.getSavedPosition().x;
         this.lbl_btn_secondary.y = this.lbl_btn_secondary.getSavedPosition().y;
      }
      
      private function checkParams() : void
      {
         this._hasImage = this._currentPopup.image && (this._currentPopup.image != "" || this._currentPopup.image != null);
         this._hasItemList = this._currentPopup.itemList && this._currentPopup.itemList.length > 0;
         this._hasButton = this._currentPopup.buttonList && this._currentPopup.buttonList.length > 0;
      }
      
      private function updateIllu() : void
      {
         var imageNameWithLang:String = null;
         var path:String = null;
         var file:File = null;
         if(this._hasImage)
         {
            imageNameWithLang = sysApi.getCurrentLanguage() + this._currentPopup.image.substr(2);
            path = uiApi.me().getConstant("illus") + "popup/" + imageNameWithLang;
            file = File.applicationDirectory.resolvePath(imageNameWithLang);
            if(file.exists)
            {
               this.tx_illu.uri = uiApi.createUri(file.nativePath);
            }
            else
            {
               this.tx_illu.uri = uiApi.createUri(uiApi.me().getConstant("illus") + "popup/" + this._currentPopup.image);
            }
            this.tx_illu.visible = true;
            this._totalHeight += this.tx_illu.height;
         }
         else
         {
            this.tx_illu.visible = false;
         }
      }
      
      private function updateText() : void
      {
         this.lbl_title.text = this._currentPopup.title;
         if(this._hasImage)
         {
            this._totalHeight += this.lbl_title.contentHeight + this._margin;
            this.lbl_title.y = this.tx_illu.y + this.tx_illu.height + this._margin;
         }
         else
         {
            this._totalHeight += this.lbl_title.contentHeight + this._margin;
            this.lbl_title.y = this.tx_illu.y + this._margin;
         }
         if(this._currentPopup.contentText == "")
         {
            lbl_content.text = "";
            lbl_content.y = this.lbl_title.y + this.lbl_title.contentHeight;
            lbl_content.height = 0;
         }
         else
         {
            lbl_content.text = this.parseText(this._currentPopup.contentText);
            this._totalHeight += lbl_content.contentHeight + this._margin;
            lbl_content.x = this.administrablePopup.width / 2 - lbl_content.width / 2 - this._margin * 2;
            lbl_content.y = this.lbl_title.y + this.lbl_title.contentHeight + this._margin;
         }
      }
      
      private function parseText(contentText:String) : String
      {
         return contentText;
      }
      
      private function updateItem() : void
      {
         this.ctr_items.visible = false;
         if(this._hasItemList)
         {
            this.ctr_items.visible = true;
            this.gd_items.height = this.gd_items.slotHeight * Math.ceil(this._currentPopup.itemList.length / 2);
            this._totalHeight += this.gd_items.anchorY + this.gd_items.contentHeight + this._margin;
            this.ctr_items.y = lbl_content.y + lbl_content.contentHeight + this._margin;
            this.gd_items.dataProvider = this._currentPopup.itemList;
         }
      }
      
      private function updateButtons() : void
      {
         var linkUrl:String = null;
         var button:PopupButton = null;
         var textSize:int = 0;
         this.btn_main.visible = false;
         this.btn_secondary.visible = false;
         for each(button in this._currentPopup.buttonList)
         {
            if(button.type == AdministrablePopupButtonTypeEnum.MAIN_BUTTON)
            {
               this.btn_main.visible = true;
               this.lbl_btn_main.text = button.text;
               this.lbl_btn_main.fullWidth(0,this._labelOffset);
               this.btn_main.width = this.lbl_btn_main.width + this.tx_btn_main.width;
               this.btn_main.x = this.administrablePopup.width / 2 - this.btn_main.width / 2 - this._margin * 2;
               if(button.actionType == AdministrablePopupActionTypeEnum.LINK)
               {
                  linkUrl = uiApi.getText("ui." + button.actionValue);
                  this.lbl_btn_main.cssClass = "left";
                  this.tx_btn_main.visible = true;
                  this._mainButtonCallback = function():void
                  {
                     sysApi.goToUrl(linkUrl);
                  };
               }
               else
               {
                  this.lbl_btn_main.cssClass = "p";
                  this.tx_btn_main.visible = false;
                  if(button.actionType == AdministrablePopupActionTypeEnum.ACTION)
                  {
                     this._mainButtonCallback = function():void
                     {
                        var apiAction:DofusApiAction = DofusApiAction.getApiActionByName(button.actionName);
                        var action:AbstractAction = utilApi.callRWithParameters(apiAction.actionClass["create"],button.actionParams);
                        sysApi.sendAction(action);
                     };
                  }
               }
            }
            else if(button.type == AdministrablePopupButtonTypeEnum.SECONDARY_BUTTON)
            {
               this.btn_secondary.visible = true;
               this.lbl_btn_secondary.text = button.text;
               textSize = uiApi.getTextSize(this.lbl_btn_secondary.text,this.lbl_btn_secondary.css,this.lbl_btn_secondary.cssClass).width;
               if(button.actionType == AdministrablePopupActionTypeEnum.LINK)
               {
                  linkUrl = uiApi.getText("ui." + button.actionValue);
                  this.tx_btn_secondary.visible = true;
                  this.btn_secondary.width = textSize + this.tx_btn_secondary.width;
                  this.tx_btn_secondary.x = this.btn_secondary.width;
                  this.tx_btn_secondary.y = 4;
                  this.btn_secondary.x = this.btn_main.x - this.btn_secondary.contentWidth - this._margin;
                  this._secondaryButtonCallback = function():void
                  {
                     sysApi.goToUrl(linkUrl);
                  };
               }
               else
               {
                  this.tx_btn_secondary.visible = false;
                  this.btn_secondary.width = textSize;
                  this.btn_secondary.x = this.btn_main.x - this.btn_secondary.contentWidth + this.tx_btn_secondary.width - this._margin;
                  if(button.actionType == AdministrablePopupActionTypeEnum.ACTION)
                  {
                     this._secondaryButtonCallback = function():void
                     {
                        var apiAction:DofusApiAction = DofusApiAction.getApiActionByName(button.actionName);
                        var action:AbstractAction = utilApi.callRWithParameters(apiAction.actionClass["create"],button.actionParams);
                        sysApi.sendAction(action);
                     };
                  }
               }
            }
         }
         this._totalHeight += this.btn_main.contentHeight + this._margin;
         if(this._hasItemList)
         {
            this.btn_main.y = this.ctr_items.y + this.gd_items.anchorY + this.gd_items.height + this._margin;
         }
         else
         {
            this.btn_main.y = lbl_content.y + lbl_content.contentHeight + this._margin;
         }
         this.btn_secondary.y = this.btn_main.y + this.btn_main.contentHeight - this.btn_secondary.contentHeight - 3;
      }
      
      private function updateCloseCallback() : void
      {
         if(this._currentPopup.closeCallback != null)
         {
            this._onCloseCallback = this._currentPopup.closeCallback;
         }
      }
      
      private function placeArrow() : void
      {
         if(this._popupList.length > 1)
         {
            this.tx_previousPopup.x = 25;
            this.tx_previousPopup.y = this.lbl_title.y + this.lbl_title.contentHeight / 2 - this.tx_previousPopup.height / 2;
            this.tx_nextPopup.x = 600;
            this.tx_nextPopup.y = this.lbl_title.y + this.lbl_title.contentHeight / 2 - this.tx_nextPopup.height / 2;
            this.tx_previousPopup.visible = true;
            this.tx_nextPopup.visible = true;
         }
         else
         {
            this.tx_previousPopup.visible = false;
            this.tx_nextPopup.visible = false;
         }
      }
      
      private function updatePopupInfo(popup:Object) : void
      {
         this.restoreAllPosition();
         this._totalHeight = 64;
         this.administrablePopup.height = 64;
         this._currentPopup = popup;
         this.checkParams();
         this.updateIllu();
         this.updateText();
         this.updateItem();
         if(this._hasButton)
         {
            this.updateButtons();
         }
         this.updateCloseCallback();
         this.administrablePopup.height = this._totalHeight;
         this.placeArrow();
         uiApi.me().render();
      }
      
      private function displayItemTooltip(target:Object, item:Object) : void
      {
         var setting:String = null;
         var settings:Object = new Object();
         var itemTooltipSettings:ItemTooltipSettings = sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:Vector.<String> = sysApi.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         settings["showEffects"] = true;
         uiApi.showTooltip(this.dataApi.getItemWrapper(item.id),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,settings);
      }
      
      private function closeCurrentPopup() : void
      {
         var popupToRemoveIndex:int = 0;
         if(this._popupList.length > 1)
         {
            popupToRemoveIndex = this._currentPopupIndex;
            this._currentPopupIndex = this._currentPopupIndex + 1 >= this._popupList.length ? 0 : int(this._currentPopupIndex);
            this._popupList.removeAt(popupToRemoveIndex);
            if(this._onCloseCallback != null)
            {
               this._onCloseCallback();
            }
            this.updatePopupInfo(this._popupList[this._currentPopupIndex]);
         }
         else
         {
            this.closeMe();
         }
      }
      
      private function closeMe() : void
      {
         if(uiApi)
         {
            uiApi.unloadUi(uiApi.me().name);
         }
         if(this._onCloseCallback != null)
         {
            this._onCloseCallback();
         }
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(uiApi.me().name == name)
         {
            this.saveAllPosition();
            this.updateIllu();
            this.updateText();
            this.updateItem();
            if(this._hasButton)
            {
               this.updateButtons();
            }
            this.updateCloseCallback();
            this.administrablePopup.height = this._totalHeight;
            this.placeArrow();
            uiApi.me().render();
         }
      }
      
      override public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.VALID_UI:
               if(this._mainButtonCallback != null)
               {
                  this._mainButtonCallback();
               }
               else
               {
                  this.closeCurrentPopup();
               }
               return true;
            case ShortcutHookListEnum.CLOSE_UI:
               this.closeCurrentPopup();
               return true;
            default:
               return false;
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_administrablePopup:
               this.closeCurrentPopup();
               break;
            case this.tx_previousPopup:
               this._currentPopupIndex = this._currentPopupIndex - 1 < 0 ? int(this._popupList.length - 1) : int(this._currentPopupIndex - 1);
               this.updatePopupInfo(this._popupList[this._currentPopupIndex]);
               break;
            case this.tx_nextPopup:
               this._currentPopupIndex = this._currentPopupIndex + 1 >= this._popupList.length ? 0 : int(this._currentPopupIndex + 1);
               this.updatePopupInfo(this._popupList[this._currentPopupIndex]);
               break;
            case this.btn_main:
               if(this._mainButtonCallback != null)
               {
                  this._mainButtonCallback();
               }
               else
               {
                  this.closeCurrentPopup();
               }
               break;
            case this.btn_secondary:
               if(this._secondaryButtonCallback != null)
               {
                  this._secondaryButtonCallback();
               }
               else
               {
                  this.closeCurrentPopup();
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tmpItem:Object = null;
         if(target.name.indexOf("tx_itemBg") != -1 || target.name.indexOf("tx_itemIcon") != -1)
         {
            tmpItem = this._componentList[target.name];
            this.displayItemTooltip(target,tmpItem);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
