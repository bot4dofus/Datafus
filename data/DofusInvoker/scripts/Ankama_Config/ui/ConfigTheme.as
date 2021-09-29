package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import Ankama_Config.types.ConfigProperty;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.themes.utils.actions.ThemeDeleteRequestAction;
   import flash.utils.Dictionary;
   
   public class ConfigTheme extends ConfigUi
   {
       
      
      public var output:Object;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _themes:Array;
      
      private var _choosenTheme:String;
      
      private var _choosenThemeObj;
      
      private var _selectedThemeId:String;
      
      private var _themeBtnList:Dictionary;
      
      private var _officialIconUri;
      
      public var grid_theme:Grid;
      
      public var lbl_name:Label;
      
      public var lbl_themeVersion:Label;
      
      public var lbl_author:Label;
      
      public var lbl_description:TextArea;
      
      public var tx_preview:Texture;
      
      public var btn_installTheme:ButtonContainer;
      
      public var btn_applyTheme:ButtonContainer;
      
      public var btn_deleteTheme:ButtonContainer;
      
      public var lbl_versionCompatibility:Label;
      
      public function ConfigTheme()
      {
         this._themeBtnList = new Dictionary(true);
         super();
      }
      
      public function main(args:*) : void
      {
         var path:* = sysApi.getConfigEntry("config.ui.common.themes") + "darkStone/texture/tx_logo_ankama.png";
         this._officialIconUri = uiApi.createUri(path);
         uiApi.addComponentHook(this.btn_deleteTheme,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_deleteTheme,ComponentHookList.ON_ROLL_OUT);
         sysApi.addHook(BeriliaHookList.ThemeInstallationProgress,this.onThemeInstallationProgress);
         sysApi.toggleThemeInstaller();
         var properties:Array = new Array();
         properties.push(new ConfigProperty("grid_theme","currentUiSkin","dofus"));
         init(properties);
         this.onThemeInstallationProgress(1);
         showDefaultBtn(false);
      }
      
      public function onThemeInstallationProgress(percent:Number) : void
      {
         var selected:int = 0;
         var theme:* = undefined;
         var i:uint = 0;
         if(percent == 1 || percent == -1)
         {
            this._selectedThemeId = configApi.getCurrentTheme();
            this._themes = new Array();
            selected = -1;
            for each(theme in configApi.getAllThemes())
            {
               if(theme && (theme.type == 1 || sysApi.getBuildType() != BuildTypeEnum.RELEASE && sysApi.getConfigEntry("config.dev.mode")))
               {
                  this._themes.push(theme);
               }
            }
            this._themes.sortOn(["type","official","name"],[Array.DESCENDING | Array.NUMERIC,Array.DESCENDING | Array.NUMERIC,Array.NUMERIC]);
            i = 0;
            for each(theme in this._themes)
            {
               if(theme.fileName == this._selectedThemeId)
               {
                  selected = i;
                  break;
               }
               i++;
            }
            if(selected < 0)
            {
               for each(theme in this._themes)
               {
                  if(theme.official && theme.type > 0)
                  {
                     this._choosenTheme = theme.fileName;
                     this._choosenThemeObj = theme;
                     break;
                  }
               }
               this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.option.resetGameForNewSkin"),[uiApi.getText("ui.common.ok")],[this.onConfirmChangeTheme]);
            }
            this.grid_theme.dataProvider = this._themes;
            this.grid_theme.selectedIndex = selected;
         }
      }
      
      public function unload() : void
      {
         sysApi.toggleThemeInstaller();
      }
      
      private function saveOptions() : void
      {
      }
      
      private function undoOptions() : void
      {
      }
      
      private function displayTheme(theme:*) : void
      {
         var version:* = undefined;
         if(theme == null)
         {
            return;
         }
         var desc:String = theme.description;
         if(desc.indexOf("[") != -1 && desc.indexOf("]") != -1)
         {
            desc = uiApi.getText(desc.slice(1,-1));
         }
         this.lbl_description.text = desc;
         var name:String = theme.name;
         if(name.indexOf("[") != -1 && name.indexOf("]") != -1)
         {
            name = uiApi.getText(name.slice(1,-1));
         }
         this.lbl_name.text = name;
         this.lbl_themeVersion.text = theme.version[0] + "." + theme.version[1] + "." + theme.version[2];
         this.lbl_themeVersion.visible = !theme.official;
         if(theme.creationDate && theme.modificationDate && theme.author)
         {
            this.lbl_author.text = uiApi.getText("ui.theme.authoranddate",theme.creationDate,theme.author,theme.modificationDate);
         }
         else
         {
            this.lbl_author.text = theme.author;
            if(theme.modificationDate)
            {
               this.lbl_author.text += " - " + uiApi.getText("ui.prism.lastVulnerabilityChange",theme.modificationDate);
            }
         }
         if(theme.official)
         {
            this.lbl_versionCompatibility.visible = false;
         }
         else
         {
            this.lbl_versionCompatibility.visible = true;
            this.lbl_versionCompatibility.text = uiApi.getText("ui.option.compatibility") + uiApi.getText("ui.common.colon") + theme.dofusVersion[0] + "." + theme.dofusVersion[1];
            version = theme.dofusVersion;
            if(version && version.length >= 0 && version[0] == sysApi.getCurrentVersion().major && version[1] == sysApi.getCurrentVersion().minor)
            {
               this.lbl_versionCompatibility.cssClass = "bonus";
            }
            else
            {
               this.lbl_versionCompatibility.cssClass = "malus";
            }
         }
         if(theme.previewUri != "")
         {
            this.tx_preview.uri = theme.previewRealUri;
         }
         else
         {
            this.tx_preview.uri = null;
         }
         if(theme.fileName != this._selectedThemeId && theme.type == 1)
         {
            this.btn_applyTheme.disabled = false;
         }
         else
         {
            this.btn_applyTheme.disabled = true;
         }
         if(theme.official)
         {
            this.btn_deleteTheme.visible = false;
         }
         else
         {
            this.btn_deleteTheme.visible = true;
            this.btn_deleteTheme.softDisabled = this._selectedThemeId == theme.fileName;
         }
      }
      
      public function updateThemeLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var theme:Object = null;
         var name:String = null;
         if(data)
         {
            componentsRef.btn_theme.visible = true;
            componentsRef.btn_theme.selected = selected;
            componentsRef.btn_theme.state = !!selected ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
            theme = data;
            name = theme.name;
            if(name.indexOf("[") != -1 && name.indexOf("]") != -1)
            {
               name = uiApi.getText(name.slice(1,-1));
            }
            componentsRef.lbl_name.text = name;
            componentsRef.tx_selected.visible = this._selectedThemeId == theme.fileName;
            if(data.type != 1)
            {
               componentsRef.lbl_name.softDisabled = true;
            }
            else
            {
               componentsRef.lbl_name.softDisabled = false;
            }
            componentsRef.tx_official.visible = theme.official;
            if(componentsRef.tx_official.visible && !componentsRef.tx_official.uri)
            {
               componentsRef.tx_official.uri = this._officialIconUri;
            }
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.btn_theme.visible = false;
            componentsRef.tx_selected.visible = false;
            componentsRef.tx_official.visible = false;
            componentsRef.tx_official.uri = null;
         }
      }
      
      override public function onRelease(target:Object) : void
      {
         switch(target)
         {
            case this.btn_installTheme:
               if(uiApi.getUi("themeInstaller"))
               {
                  uiApi.unloadUi("themeInstaller");
               }
               uiApi.loadUi("themeInstaller",null,{},StrataEnum.STRATA_TOP);
               break;
            case this.btn_deleteTheme:
               this._choosenTheme = this.grid_theme.selectedItem.folderFullPath;
               this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.module.marketplace.uninstallmodulewarning",this.grid_theme.selectedItem.name),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmDeleteTheme,null]);
               break;
            case this.btn_applyTheme:
               this._choosenTheme = this.grid_theme.selectedItem.folderFullPath;
               this._choosenThemeObj = this.grid_theme.selectedItem;
               this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.option.resetGameForNewSkin"),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmChangeTheme,null]);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.grid_theme:
               this.displayTheme(this.grid_theme.selectedItem);
         }
      }
      
      public function onConfirmChangeTheme() : void
      {
         setProperty("dofus","currentUiSkin",!!this._choosenThemeObj.official ? this._choosenThemeObj.name : this._choosenTheme);
         sysApi.clearCache(true);
      }
      
      public function onConfirmDeleteTheme() : void
      {
         sysApi.sendAction(new ThemeDeleteRequestAction([this._choosenTheme]));
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target == this.btn_deleteTheme)
         {
            if(this.btn_deleteTheme.softDisabled)
            {
               text = uiApi.getText("ui.theme.marketplace.removeTip");
            }
         }
         else
         {
            text = uiApi.getText("ui.option.themeApply");
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
