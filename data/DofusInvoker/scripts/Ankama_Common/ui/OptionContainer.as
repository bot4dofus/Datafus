package Ankama_Common.ui
{
   import Ankama_Common.options.OptionManager;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class OptionContainer
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var ctr_subUi:ScrollContainer;
      
      public var lbl_subTitle:Label;
      
      public var lbl_subDescription:Label;
      
      public var btn_default:ButtonContainer;
      
      public var btn_close2:ButtonContainer;
      
      public var gd_optionCategories:Grid;
      
      public var btn_close:ButtonContainer;
      
      private var _subUi:Object;
      
      private var _currentSubUiId:String;
      
      public function OptionContainer()
      {
         super();
      }
      
      public function main(tab:String) : void
      {
         var optionManager:OptionManager = null;
         var i:uint = 0;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.gd_optionCategories.autoSelectMode = 0;
         this.gd_optionCategories.dataProvider = OptionManager.getInstance().items;
         this.btn_default.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_close2.soundId = SoundEnum.CANCEL_BUTTON;
         this.uiApi.addComponentHook(this.gd_optionCategories,"onSelectItem");
         this.uiApi.addComponentHook(this.btn_default,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_close2,"onRelease");
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.ctr_subUi.verticalScrollSpeed = 25;
         if(tab)
         {
            optionManager = OptionManager.getInstance();
            for(i = 0; i < optionManager.items.length; i++)
            {
               if(optionManager.items[i].id == tab)
               {
                  this.gd_optionCategories.selectedIndex = i;
                  break;
               }
            }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = this.gd_optionCategories.selectedItem;
         if(this._currentSubUiId == item.ui)
         {
            return;
         }
         this.lbl_subTitle.text = item.name;
         this.lbl_subDescription.text = item.description;
         if(this._subUi)
         {
            this.uiApi.unloadUi(this._subUi.name);
         }
         if(item.ui)
         {
            this.ctr_subUi.verticalScrollbarValue = 0;
            this.btn_default.visible = true;
            this._subUi = this.uiApi.loadUiInside(item.ui,this.ctr_subUi,"subConfigUi",null);
            this._currentSubUiId = item.ui;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_default:
               if(this._subUi && Object(this._subUi.uiClass).hasOwnProperty("reset"))
               {
                  this._subUi.uiClass.reset();
               }
               break;
            case this.btn_close:
            case this.btn_close2:
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function unload() : void
      {
         if(this._subUi)
         {
            this.uiApi.hideTooltip();
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this.uiApi.unloadUi(this._subUi.name);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "optionMenu1":
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
         return true;
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onSelectiveClearCache() : void
      {
         this.sysApi.clearCache(true);
      }
      
      public function onCompleteClearCache() : void
      {
         this.sysApi.clearCache(false);
      }
   }
}
