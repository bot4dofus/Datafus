package Ankama_Config.ui.item
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ThemeItem
   {
      
      private static var lastSelectedTexture:Texture;
      
      private static var currentlySelectedData:Object;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_name:Label;
      
      public var lbl_desc:Label;
      
      public var lbl_compatibility:Label;
      
      public var lbl_made:Label;
      
      public var lbl_themeVersion:Label;
      
      public var btn_install:ButtonContainer;
      
      public var btn_delete:ButtonContainer;
      
      public var btn_update:ButtonContainer;
      
      public var tx_bg:Texture;
      
      public var tx_selected:Texture;
      
      public var tx_previewUrl:Texture;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _data:Object;
      
      private var _selected:Boolean;
      
      private var _uiClass:Object;
      
      private var _upToDateColor:int;
      
      private var _notUpToDateColor:int;
      
      public function ThemeItem()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._data = oParam.data;
         this._selected = oParam.selected;
         if(oParam.grid.hasOwnProperty("object"))
         {
            this._uiClass = oParam.grid.object.getUi().uiClass;
         }
         else
         {
            this._uiClass = oParam.grid.getUi().uiClass;
         }
         this.update(this._data,this._selected);
         this.uiApi.addComponentHook(this.mainCtr,ComponentHookList.ON_RELEASE);
         this._upToDateColor = this.uiApi.me().getConstant("upToDateColor");
         this._notUpToDateColor = int(this.uiApi.me().getConstant("notUpToDateColor"));
      }
      
      public function unload() : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function update(data:Object, selected:Boolean) : void
      {
         var version:Array = null;
         this._data = data;
         if(data)
         {
            this.lbl_name.text = data.name;
            this.lbl_desc.text = data.description;
            this.lbl_compatibility.text = this.uiApi.getText("ui.option.compatibility") + " : " + data.dofusVersion;
            version = data.dofusVersion.split(".");
            if(version && version.length >= 0 && version[0] == this.sysApi.getCurrentVersion().major && version[1] == this.sysApi.getCurrentVersion().minor)
            {
               this.lbl_compatibility.cssClass = "bonus";
            }
            else
            {
               this.lbl_compatibility.cssClass = "malus";
            }
            this.lbl_themeVersion.text = data.version;
            this.lbl_made.text = this.uiApi.getText("ui.theme.authoranddate",data.creationDate,data.author,data.modificationDate);
            this.btn_delete.visible = data.exist;
            this.btn_delete.softDisabled = this.configApi.getCurrentTheme() == data.author + "_" + data.name;
            this.uiApi.addComponentHook(this.btn_delete,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_delete,ComponentHookList.ON_ROLL_OUT);
            this.btn_install.visible = !data.exist;
            this.btn_update.visible = !this.btn_install.visible && !data.upToDate;
            this.tx_bg.visible = data.exist;
            this.tx_bg.bgColor = !!data.upToDate ? this._upToDateColor : this._notUpToDateColor;
            this.tx_previewUrl.visible = true;
            this.tx_previewUrl.uri = this.uiApi.createUri(data.previewUrl);
         }
         else
         {
            this.lbl_name.text = "";
            this.lbl_desc.text = "";
            this.lbl_compatibility.text = "";
            this.lbl_made.text = "";
            this.lbl_themeVersion.text = "";
            this.btn_delete.visible = false;
            this.btn_install.visible = false;
            this.btn_update.visible = false;
            this.tx_bg.visible = false;
            this.tx_previewUrl.visible = false;
         }
         this.tx_selected.visible = selected;
         lastSelectedTexture = this.tx_selected;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(this._data && currentlySelectedData != this._data)
         {
            if(lastSelectedTexture)
            {
               lastSelectedTexture.visible = false;
            }
            currentlySelectedData = this._data;
            this.tx_selected.visible = true;
            lastSelectedTexture = this.tx_selected;
         }
         switch(target)
         {
            case this.btn_install:
               this._uiClass.startInstall(this._data);
               break;
            case this.btn_delete:
               this.modCommon.openPopup(this.uiApi.getText("ui.module.marketplace.uninstallmodule"),this.uiApi.getText("ui.module.marketplace.uninstallmodulewarning",this._data.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onDeleteOk]);
               break;
            case this.btn_update:
               this._uiClass.startInstall(this._data,true);
         }
      }
      
      private function onDeleteOk() : void
      {
         this._uiClass.startUninstall(this._data);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target && target.name.indexOf("btn_delete") != -1)
         {
            if(target.softDisabled)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.theme.marketplace.removeTip")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function select(selected:Boolean) : void
      {
      }
   }
}
