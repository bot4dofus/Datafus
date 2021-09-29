package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.InputComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.themes.utils.actions.ThemeDeleteRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeInstallRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeListRequestAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class ThemeInstaller
   {
      
      private static const URL_REGEX:RegExp = /^http(s)?:\/\/((\d+\.\d+\.\d+\.\d+)|(([\w-]+\.)+([a-z,A-Z][\w-]*)))(:[1-9][0-9]*)?(\/([\w-.\/:%+@&=]+[\w- .\/?:%+@&=]*)?)?(#(.*))?$/i;
      
      private static const WHITESPACE_TRIM_REGEX:RegExp = /^\s*(.*?)\s*$/g;
      
      private static const ERROR_JSON_URL_INVALID:int = 1;
      
      private static const ERROR_JSON_NOT_FOUND:int = 2;
      
      private static const ERROR_THEME_ARCHIVE_INVALID:int = 3;
      
      private static const ERROR_THEME_UPATE:int = 4;
      
      private static const ERROR_THEME_DELETE:int = 5;
      
      private static const ERROR_THEME_INSTALL:int = 6;
      
      private static const ERROR_THEME_DM_NOT_FOUND:int = 7;
      
      private static const ERROR_THEME_URL_INVALID:int = 8;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var lbl_infos:Label;
      
      public var lbl_currentUrl:Label;
      
      public var icbx_url:InputComboBox;
      
      public var tx_help:TextureBitmap;
      
      public var ctn_help_tooltip:GraphicContainer;
      
      public var inp_filter:Input;
      
      public var btn_closeSearch:ButtonContainer;
      
      public var btn_label_cb_version:Label;
      
      public var cb_version:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_more_info:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var gdModules:Grid;
      
      public var tx_bg:Texture;
      
      public var tx_bg1:Texture;
      
      public var tx_inputUrl:Texture;
      
      public var btn_fetch:ButtonContainer;
      
      public var cbx_categories:ComboBox;
      
      private var _themeList:Array;
      
      private var _keyWords:Array;
      
      private var _lastSelection:int;
      
      private var _activePopupName:String;
      
      private var _isUpdating:Boolean;
      
      private var _searchCriteria:String = "";
      
      private var _componentsList:Dictionary;
      
      private var _popupText:String;
      
      public function ThemeInstaller()
      {
         this._componentsList = new Dictionary(true);
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(HookList.ThemeList,this.onThemeList);
         this.sysApi.addHook(BeriliaHookList.ThemeInstallationProgress,this.onThemeInstallationProgress);
         this.sysApi.addHook(HookList.ThemeInstallationError,this.onThemeInstallationError);
         this.uiApi.addComponentHook(this.tx_help,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_help,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_filter,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_more_info,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         this.sysApi.addHook(BeriliaHookList.FocusChange,this.onFocusChange);
         this.ctn_help_tooltip.visible = false;
         this.inp_filter.text = this.uiApi.getText("ui.common.search.input");
         this.btn_closeSearch.visible = false;
         this.btn_label_cb_version.text = this.uiApi.getText("ui.option.compatibility") + " : " + this.sysApi.getCurrentVersion().major + "." + this.sysApi.getCurrentVersion().minor;
         var lastUsedUrls:Array = this.sysApi.getData("lastThemeListUrls",DataStoreEnum.BIND_COMPUTER);
         if(lastUsedUrls && lastUsedUrls.length > 0)
         {
            this.icbx_url.input.text = lastUsedUrls[0];
            this.icbx_url.dataProvider = lastUsedUrls;
            this.onRelease(this.btn_fetch);
         }
         else
         {
            this.icbx_url.input.text = "http://";
         }
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this.icbx_url.input.haveFocus)
               {
                  this.onRelease(this.btn_fetch);
                  return true;
               }
               break;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
         }
         return false;
      }
      
      public function updateUrlLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var mod:String = !!componentsRef.hasOwnProperty("btn_removeUrl") ? "" : "2";
         if(!this._componentsList[componentsRef["btn_removeUrl" + mod].name])
         {
            this.uiApi.addComponentHook(componentsRef["btn_removeUrl" + mod],"onRelease");
            this.uiApi.addComponentHook(componentsRef["btn_removeUrl" + mod],"onRollOut");
            this.uiApi.addComponentHook(componentsRef["btn_removeUrl" + mod],"onRollOver");
         }
         this._componentsList[componentsRef["btn_removeUrl" + mod].name] = data;
         if(data)
         {
            componentsRef["lbl_url" + mod].text = data;
            componentsRef["btn_removeUrl" + mod].visible = true;
            if(selected)
            {
               componentsRef["btn_url" + mod].selected = true;
            }
            else
            {
               componentsRef["btn_url" + mod].selected = false;
            }
         }
         else
         {
            componentsRef["lbl_url" + mod].text = "";
            componentsRef["btn_removeUrl" + mod].visible = false;
            componentsRef["btn_url" + mod].selected = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var url:String = null;
         var newHistory:Array = null;
         var lastUsedUrls:* = undefined;
         var canAddUrlToHistory:Boolean = false;
         var lastUsedUrl:* = undefined;
         var urlToDelete:String = null;
         var oldUrls:Array = null;
         var urls:Array = null;
         var oldUrl:String = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.cb_version:
               this.applyFilter();
               break;
            case this.ctr_more_info:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.themes.moreInfo"));
               break;
            case this.btn_fetch:
               url = this.icbx_url.input.text;
               this._themeList = [];
               this._keyWords = [];
               this.gdModules.dataProvider = [];
               this.cbx_categories.dataProvider = [];
               this.cb_version.selected = false;
               this.inp_filter.text = this.uiApi.getText("ui.common.search.input");
               this.btn_closeSearch.visible = false;
               if(URL_REGEX.test(url))
               {
                  if(url.search("zip") == url.length - 3)
                  {
                     this.startInstall({
                        "url":url,
                        "name":url
                     });
                  }
                  else
                  {
                     newHistory = [];
                     lastUsedUrls = this.icbx_url.dataProvider;
                     canAddUrlToHistory = true;
                     for each(lastUsedUrl in lastUsedUrls)
                     {
                        if(lastUsedUrl == url)
                        {
                           canAddUrlToHistory = false;
                        }
                        newHistory.push(lastUsedUrl);
                     }
                     if(canAddUrlToHistory)
                     {
                        newHistory.unshift(url);
                     }
                     this.icbx_url.dataProvider = newHistory;
                     this.sysApi.setData("lastThemeListUrls",newHistory,DataStoreEnum.BIND_COMPUTER);
                     this.sysApi.sendAction(new ThemeListRequestAction([url]));
                  }
               }
               else if(this.sysApi.getBuildType() == BuildTypeEnum.DEBUG)
               {
                  if(url.search("zip") == url.length - 3)
                  {
                     this.startInstall({
                        "url":"file://" + url,
                        "name":url
                     });
                  }
                  else
                  {
                     this.sysApi.sendAction(new ThemeListRequestAction(["file://" + url]));
                  }
               }
               break;
            case this.btn_closeSearch:
               this.inp_filter.text = this.uiApi.getText("ui.common.search.input");
               this.btn_closeSearch.visible = false;
               this._searchCriteria = "";
               this.applyFilter();
               break;
            case this.inp_filter:
               if(this.uiApi.getText("ui.common.search.input") == this.inp_filter.text)
               {
                  this.inp_filter.text = "";
               }
               break;
            default:
               if(target.name.indexOf("btn_removeUrl") != -1)
               {
                  urlToDelete = this._componentsList[target.name];
                  oldUrls = this.sysApi.getData("lastThemeListUrls");
                  urls = [];
                  for each(oldUrl in oldUrls)
                  {
                     if(oldUrl != urlToDelete)
                     {
                        urls.push(oldUrl);
                     }
                  }
                  this.sysApi.setData("lastThemeListUrls",urls);
                  this.icbx_url.dataProvider = urls;
                  this.icbx_url.selectedIndex = 0;
               }
         }
         if(target != this.inp_filter && this.inp_filter && this.inp_filter.text.length == 0)
         {
            this.inp_filter.text = this.uiApi.getText("ui.common.search.input");
            this.btn_closeSearch.visible = false;
            this.gdModules.dataProvider = this._themeList;
         }
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_filter.haveFocus)
         {
            this._searchCriteria = this.inp_filter.text.toLowerCase();
            if(!this._searchCriteria || !this._searchCriteria.length)
            {
               this._searchCriteria = "";
               this.btn_closeSearch.visible = false;
               this.gdModules.dataProvider = this._themeList;
            }
            else
            {
               this.btn_closeSearch.visible = true;
               this.applyFilter();
            }
         }
      }
      
      public function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         if(!this.inp_filter.haveFocus)
         {
         }
      }
      
      public function onFocusChange(pTarget:Object) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_help:
               this.ctn_help_tooltip.visible = true;
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_help:
               this.ctn_help_tooltip.visible = false;
         }
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cbx_categories:
               this.applyFilter();
         }
      }
      
      public function startInstall(data:Object, update:Boolean = false) : void
      {
         this._isUpdating = update;
         if(this._isUpdating)
         {
            this._popupText = this.uiApi.getText("ui.module.marketplace.updatemodulemsg",data.name,data.version) + "\n" + this.uiApi.getText("ui.queue.wait");
         }
         else
         {
            this._popupText = this.uiApi.getText("ui.module.marketplace.installmodulemsg",data.name) + "\n" + this.uiApi.getText("ui.queue.wait");
         }
         this._activePopupName = this.modCommon.openNoButtonPopup(this.uiApi.getText("ui.theme.updatetheme"),this._popupText);
         this.sysApi.sendAction(new ThemeInstallRequestAction([data.url]));
      }
      
      public function startUninstall(data:Object) : void
      {
         this._activePopupName = this.modCommon.openNoButtonPopup(this.uiApi.getText("ui.module.marketplace.uninstallmodule"),this.uiApi.getText("ui.module.marketplace.uninstallmodulemsg",data.name) + "\n" + this.uiApi.getText("ui.queue.wait"));
         this.sysApi.sendAction(new ThemeDeleteRequestAction([data.author + "_" + data.name]));
         this._lastSelection = this.gdModules.selectedIndex;
      }
      
      public function onThemeList(themes:*) : void
      {
         this.updateThemeList(themes);
      }
      
      public function onThemeInstallationProgress(percent:Number) : void
      {
         var popupUi:UiRootContainer = null;
         if(percent == 1 || percent == -1)
         {
            this.uiApi.unloadUi(this._activePopupName);
            if(this.icbx_url.input.text.toLowerCase().search("zip") != this.icbx_url.input.text.length - 3)
            {
               this.onRelease(this.btn_fetch);
            }
         }
         else
         {
            popupUi = this.uiApi.getUi(this._activePopupName);
            if(popupUi && popupUi.uiClass)
            {
               popupUi.uiClass.content = this._popupText + Math.ceil(percent * 100) + "%";
            }
         }
      }
      
      public function onThemeInstallationError(errorId:int) : void
      {
         var errorMsg:String = null;
         var errorTitle:String = this.uiApi.getText("ui.common.error");
         switch(errorId)
         {
            case ERROR_JSON_URL_INVALID:
               this.sysApi.setData("lastThemeListUrl","",DataStoreEnum.BIND_COMPUTER);
               errorMsg = this.uiApi.getText("ui.module.marketplace.error.invalidurl");
               this.updateThemeList([]);
               break;
            case ERROR_JSON_NOT_FOUND:
               this.sysApi.setData("lastThemeListUrl","",DataStoreEnum.BIND_COMPUTER);
               errorMsg = this.uiApi.getText("ui.module.marketplace.error.missingjson");
               this.updateThemeList([]);
               break;
            case ERROR_THEME_ARCHIVE_INVALID:
               errorMsg = this.uiApi.getText("ui.theme.error.invalidzip");
               this.uiApi.unloadUi(this._activePopupName);
               break;
            case ERROR_THEME_UPATE:
               errorMsg = this.uiApi.getText("ui.theme.error.update");
               this.uiApi.unloadUi(this._activePopupName);
               break;
            case ERROR_THEME_DELETE:
               errorMsg = this.uiApi.getText("ui.theme.error.uninstall");
               this.uiApi.unloadUi(this._activePopupName);
               break;
            case ERROR_THEME_INSTALL:
               errorMsg = this.uiApi.getText("ui.theme.error.install");
               this.uiApi.unloadUi(this._activePopupName);
               break;
            case ERROR_THEME_URL_INVALID:
               errorMsg = this.uiApi.getText("ui.theme.error.invalidurl2");
               this.uiApi.unloadUi(this._activePopupName);
               break;
            default:
               errorMsg = this.uiApi.getText("ui.module.marketplace.error");
         }
         var urls:Array = this.icbx_url.dataProvider;
         if(urls.indexOf(this.icbx_url.input.text) != -1)
         {
            urls.removeAt(urls.indexOf(this.icbx_url.input.text));
         }
         this.sysApi.setData("lastThemeListUrls",urls,DataStoreEnum.BIND_COMPUTER);
         this.modCommon.openPopup(errorTitle,errorMsg,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function applyFilter() : void
      {
         var filteredThemeList:Array = null;
         if(this._themeList && this._themeList.length)
         {
            filteredThemeList = this._themeList.filter(this.filterFunction);
            if(this.cbx_categories.selectedIndex != 0)
            {
               filteredThemeList = filteredThemeList.filter(this.filterKeyWord);
            }
            this.gdModules.dataProvider = filteredThemeList;
         }
      }
      
      private function filterFunction(element:*, index:int, arr:Array) : Boolean
      {
         var version:Array = null;
         if(this.cb_version.selected)
         {
            version = element.dofusVersion.split(".");
            if(!version || version.length < 2 || this.sysApi.getCurrentVersion().major != version[0] || this.sysApi.getCurrentVersion().minor != version[1])
            {
               return false;
            }
         }
         if(this._searchCriteria == "")
         {
            return true;
         }
         return element.name.toLowerCase().indexOf(this._searchCriteria) >= 0 || element.author.toLowerCase().indexOf(this._searchCriteria) >= 0;
      }
      
      private function filterKeyWord(element:*, index:int, arr:Array) : Boolean
      {
         var keyword:String = null;
         var keywords:Array = element.keyWords.split(",");
         for each(keyword in keywords)
         {
            if(this.cbx_categories.selectedItem == keyword.replace(WHITESPACE_TRIM_REGEX,"$1"))
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateThemeList(dp:*) : void
      {
         var securedObject:Object = null;
         var theme:Object = null;
         var key:* = null;
         var keywords:Array = null;
         var cat:String = null;
         this._keyWords = [];
         this._themeList = [];
         for each(securedObject in dp)
         {
            theme = new Object();
            this._themeList.push(theme);
            for(key in securedObject)
            {
               theme[key] = securedObject[key];
            }
            keywords = [];
            if(theme["keyWords"])
            {
               keywords = theme.keyWords.split(",");
            }
            for each(cat in keywords)
            {
               cat = cat.replace(WHITESPACE_TRIM_REGEX,"$1");
               if(this._keyWords.indexOf(cat) == -1)
               {
                  this._keyWords.push(cat);
               }
            }
         }
         if(this._themeList.length == 0)
         {
            this.gdModules.visible = false;
            this.lbl_infos.visible = true;
            this.lbl_infos.text = this.uiApi.getText("ui.module.marketplace.nomodule");
            return;
         }
         this.lbl_infos.visible = false;
         this.gdModules.visible = true;
         this._themeList.sortOn(["dofusVersion","name"],[Array.DESCENDING,Array.CASEINSENSITIVE]);
         this.gdModules.dataProvider = this._themeList;
         this.gdModules.selectedIndex = this._lastSelection;
         this._keyWords.sort();
         this._keyWords.unshift(this.uiApi.getText("ui.common.allTypesForObject"));
         this.cbx_categories.dataProvider = this._keyWords;
         this.cbx_categories.selectedIndex = 0;
         this.cbx_categories.visible = this._themeList.length > 0;
         this.cbx_categories.selectedIndex = 0;
      }
   }
}
