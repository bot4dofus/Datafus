package Ankama_Grimoire.ui
{
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class Guidebook
   {
      
      private static const STORAGE_NEW_TEMPORIS_REWARD:String = "storageNewTemporisReward";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_tabCollection:ButtonContainer;
      
      public var btn_tabTemporis:ButtonContainer;
      
      public var btn_tabGameGuide:ButtonContainer;
      
      public var btn_tabGameProgress:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var lbl_btn_tabCollection:Label;
      
      public var lbl_btn_tabTemporis:Label;
      
      public var lbl_btn_tabGameProgress:Label;
      
      public var lbl_btn_tabGameGuide:Label;
      
      public var tx_tabTemporisWarning:Texture;
      
      private var _currentTabUi:String = "";
      
      public function Guidebook()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         var shortcut:String = null;
         var rawAreNewTemporisRewardsAvailable:* = undefined;
         var deltaX:Number = NaN;
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabGameGuide,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabGameProgress,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_btn_tabGameProgress.text = this.uiApi.getText("ui.guidebook.gameProgress");
         this.lbl_btn_tabGameGuide.text = this.uiApi.getText("ui.guidebook.gameGuide");
         if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_ACHIEVEMENT_PROGRESS))
         {
            this.btn_tabCollection.visible = true;
            this.uiApi.addComponentHook(this.btn_tabCollection,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_tabCollection,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_tabCollection,ComponentHookList.ON_ROLL_OUT);
            this.lbl_btn_tabCollection.text = this.uiApi.getText("ui.collection.title");
            this.btn_tabTemporis.visible = this.tx_tabTemporisWarning.visible = true;
            this.uiApi.addComponentHook(this.btn_tabTemporis,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.btn_tabTemporis,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_tabTemporis,ComponentHookList.ON_ROLL_OUT);
            this.lbl_title.text = this.uiApi.getText("ui.temporis.titleGuidebook");
            this.lbl_btn_tabTemporis.text = this.uiApi.getText("ui.temporis.temporisTabName");
            rawAreNewTemporisRewardsAvailable = this.sysApi.getData(STORAGE_NEW_TEMPORIS_REWARD);
            if(rawAreNewTemporisRewardsAvailable is Boolean)
            {
               this.tx_tabTemporisWarning.visible = rawAreNewTemporisRewardsAvailable as Boolean;
            }
            else
            {
               this.tx_tabTemporisWarning.visible = false;
            }
            this.sysApi.addHook(HookList.AreTemporisRewardsAvailable,this.onTemporisRewardsAvailable);
         }
         else
         {
            this.btn_tabCollection.visible = false;
            this.btn_tabTemporis.visible = this.tx_tabTemporisWarning.visible = false;
            this.lbl_title.text = this.uiApi.getText("ui.guidebook.title");
            deltaX = this.btn_tabTemporis.width / 2 + this.btn_tabCollection.width / 2;
            this.btn_tabGameGuide.x -= deltaX;
            this.btn_tabGameProgress.x -= deltaX;
         }
         shortcut = this.bindsApi.getShortcutBindStr("openGuidebook");
         if(shortcut != "")
         {
            this.lbl_title.text += " (" + shortcut + ")";
         }
         if(params is Array)
         {
            if(params.length == 1)
            {
               this.openTab(params[0],null,false);
            }
            else
            {
               this.openTab(params[0],params[1],false);
            }
         }
      }
      
      public function openTab(tab:String = "", params:Array = null, restoreSnapshot:Boolean = true) : void
      {
         if(this._currentTabUi == tab)
         {
            return;
         }
         if(this._currentTabUi != "")
         {
            this.uiApi.unloadUi("subGuideUi");
         }
         if(!this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_ACHIEVEMENT_PROGRESS) && (tab == EnumTab.TEMPORIS_TAB || tab == EnumTab.COLLECTION_TAB))
         {
            this._currentTabUi = EnumTab.GUIDEBOOK_GAME_SUGGESTION;
         }
         else
         {
            this._currentTabUi = tab;
         }
         this.uiCtr.getUi().restoreSnapshotAfterLoading = restoreSnapshot;
         this.uiApi.loadUiInside(this._currentTabUi,this.uiCtr,"subGuideUi",params);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.getButtonByTab(this._currentTabUi),this.uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      public function getCurrentTab() : String
      {
         return this._currentTabUi;
      }
      
      public function unload() : void
      {
         this.sysApi.setData("lastGuidebookTab",this._currentTabUi,DataStoreEnum.BIND_ACCOUNT);
         this.closeTab(this._currentTabUi);
      }
      
      private function closeTab(tab:String) : void
      {
         this.uiApi.unloadUi("subGuideUi");
      }
      
      private function closeGuideBook() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function getButtonByTab(tab:String) : ButtonContainer
      {
         var returnButton:ButtonContainer = null;
         switch(tab)
         {
            case EnumTab.COLLECTION_TAB:
               returnButton = this.btn_tabCollection;
               break;
            case EnumTab.TEMPORIS_TAB:
               returnButton = this.btn_tabTemporis;
               break;
            case EnumTab.GUIDEBOOK_GAME_GUIDE:
               returnButton = this.btn_tabGameGuide;
               break;
            case EnumTab.GUIDEBOOK_GAME_SUGGESTION:
               returnButton = this.btn_tabGameProgress;
         }
         return returnButton;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_tabCollection:
               this.openTab(EnumTab.COLLECTION_TAB);
               break;
            case this.btn_tabTemporis:
               this.openTab(EnumTab.TEMPORIS_TAB);
               break;
            case this.btn_tabGameGuide:
               this.openTab(EnumTab.GUIDEBOOK_GAME_GUIDE);
               break;
            case this.btn_tabGameProgress:
               this.openTab(EnumTab.GUIDEBOOK_GAME_SUGGESTION);
               break;
            case this.btn_close:
               this.closeGuideBook();
               break;
            case this.btn_help:
               this.hintsApi.showSubHints(this._currentTabUi);
         }
      }
      
      public function onRollOver(target:Object) : void
      {
      }
      
      public function onRollOut(target:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.closeGuideBook();
               return true;
            default:
               return false;
         }
      }
      
      private function onTemporisRewardsAvailable(temporisRewardsAvailable:Boolean) : void
      {
         this.sysApi.setData(STORAGE_NEW_TEMPORIS_REWARD,temporisRewardsAvailable);
         this.tx_tabTemporisWarning.visible = temporisRewardsAvailable;
      }
   }
}
