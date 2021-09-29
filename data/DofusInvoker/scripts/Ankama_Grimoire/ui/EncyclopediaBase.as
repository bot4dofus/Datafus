package Ankama_Grimoire.ui
{
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class EncyclopediaBase
   {
      
      private static var _self:EncyclopediaBase;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      private var _currentTabUi:String = "";
      
      private var _currentTabIndex:uint = 0;
      
      private var _currentTabName:String;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_tabBestiary:ButtonContainer;
      
      public var btn_tabEquipment:ButtonContainer;
      
      public var btn_tabConsumable:ButtonContainer;
      
      public var btn_tabResources:ButtonContainer;
      
      public var btn_tabSkin:ButtonContainer;
      
      public var lbl_btn_tabBestiary:Label;
      
      public var lbl_btn_tabEquipment:Label;
      
      public var lbl_btn_tabConsumable:Label;
      
      public var lbl_btn_tabResources:Label;
      
      public var lbl_btn_tabSkin:Label;
      
      public function EncyclopediaBase()
      {
         super();
      }
      
      public static function getInstance() : EncyclopediaBase
      {
         if(_self == null)
         {
            throw new Error("SpellBase singleton Error");
         }
         return _self;
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(params:Object) : void
      {
         _self = this;
         this.uiApi.addComponentHook(this.btn_tabBestiary,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabEquipment,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabConsumable,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabResources,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabSkin,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.lbl_btn_tabBestiary.text = this.uiApi.getText("ui.common.bestiary");
         this.lbl_btn_tabEquipment.text = this.uiApi.getText("ui.common.equipments");
         this.lbl_btn_tabConsumable.text = this.uiApi.getText("ui.common.consumables");
         this.lbl_btn_tabResources.text = this.uiApi.getText("ui.common.ressources");
         this.lbl_btn_tabSkin.text = this.uiApi.getText("ui.common.cosmetic");
         if(this._currentTabUi == "" || params && params[1].hasOwnProperty("resourceSearch"))
         {
            if(params)
            {
               this.openTab(params[0],params[1]);
            }
            else
            {
               this.openTab(EnumTab.BESTIARY_TAB);
            }
         }
      }
      
      public function openTab(tab:String, params:Object = null) : void
      {
         if(this._currentTabUi == tab && params && !params.forceOpen && !params.forceOpenResourceTab && !params.forceOpenConsumableTab && !params.forceOpenEquipmentTab)
         {
            return;
         }
         this.uiApi.unloadUi("subEncyclopediaList");
         if(tab == "")
         {
            this._currentTabUi = EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB;
            this._currentTabIndex = 1;
         }
         else
         {
            this._currentTabUi = tab;
            switch(this._currentTabUi)
            {
               case EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB:
                  this._currentTabIndex = 1;
                  break;
               case EnumTab.ENCYCLOPEDIA_CONSUMABLE_TAB:
                  this._currentTabIndex = 2;
                  break;
               case EnumTab.ENCYCLOPEDIA_RESOURCE_TAB:
                  this._currentTabIndex = 3;
                  break;
               case EnumTab.ENCYCLOPEDIA_SKIN_TAB:
                  this._currentTabIndex = 4;
                  break;
               default:
                  this._currentTabIndex = 0;
            }
         }
         if(!params)
         {
            params = {};
         }
         params.currentTab = this._currentTabIndex;
         this.currentTabName = this.getButtonByTab(this._currentTabUi).name;
         if(this._currentTabUi == EnumTab.BESTIARY_TAB)
         {
            this.uiApi.loadUiInside(this._currentTabUi,this.uiCtr,"subEncyclopediaList",params);
         }
         else
         {
            this.uiApi.loadUiInside("encyclopediaList",this.uiCtr,"subEncyclopediaList",params);
         }
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.getButtonByTab(this._currentTabUi),this.uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      private function getButtonByTab(tab:String) : ButtonContainer
      {
         var returnButton:ButtonContainer = null;
         switch(tab)
         {
            case EnumTab.BESTIARY_TAB:
               returnButton = this.btn_tabBestiary;
               break;
            case EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB:
               returnButton = this.btn_tabEquipment;
               break;
            case EnumTab.ENCYCLOPEDIA_CONSUMABLE_TAB:
               returnButton = this.btn_tabConsumable;
               break;
            case EnumTab.ENCYCLOPEDIA_RESOURCE_TAB:
               returnButton = this.btn_tabResources;
               break;
            case EnumTab.ENCYCLOPEDIA_SKIN_TAB:
               returnButton = this.btn_tabSkin;
         }
         return returnButton;
      }
      
      public function onOpenEncyclopedia(tab:String = null, params:Object = null) : void
      {
         this.openTab(tab,params);
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi("subEncyclopediaList");
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_tabBestiary:
               this.openTab(EnumTab.BESTIARY_TAB,{"forceOpen":true});
               this.currentTabName = target.name;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_tabEquipment:
               this.openTab(EnumTab.ENCYCLOPEDIA_EQUIPMENT_TAB);
               this.currentTabName = target.name;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_tabConsumable:
               this.openTab(EnumTab.ENCYCLOPEDIA_CONSUMABLE_TAB);
               this.currentTabName = target.name;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_tabResources:
               this.openTab(EnumTab.ENCYCLOPEDIA_RESOURCE_TAB);
               this.currentTabName = target.name;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_tabSkin:
               this.openTab(EnumTab.ENCYCLOPEDIA_SKIN_TAB);
               this.currentTabName = target.name;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_help:
               this.hintsApi.showSubHints(this.currentTabName);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
