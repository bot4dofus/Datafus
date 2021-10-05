package Ankama_Grimoire.ui
{
   import Ankama_Grimoire.Grimoire;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class SpellBase
   {
      
      private static var _self:SpellBase;
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _currentTabUi:String = "";
      
      private var _currentParams:Object;
      
      private var _tooltipStrata:int = 4;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_gameplay_class:ButtonContainer;
      
      public var btn_tabSpell:ButtonContainer;
      
      public var btn_tabSpecialsSpell:ButtonContainer;
      
      public var btn_tabFinishMove:ButtonContainer;
      
      public var tx_warningTabSpell:Texture;
      
      public var tx_warningTabSpecial:Texture;
      
      public function SpellBase()
      {
         super();
      }
      
      public static function getInstance() : SpellBase
      {
         if(_self == null)
         {
            throw new Error("SpellBase singleton Error");
         }
         return _self;
      }
      
      public function main(params:Object) : void
      {
         if(this.uiApi.me().strata == StrataEnum.STRATA_MAX)
         {
            this._tooltipStrata = StrataEnum.STRATA_SUPERMAX;
         }
         _self = this;
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_tabSpell.soundId = SoundEnum.TAB;
         this.btn_tabSpecialsSpell.soundId = SoundEnum.TAB;
         this.btn_tabFinishMove.soundId = SoundEnum.TAB;
         this.sysApi.addHook(HookList.SpellsToHighlightUpdate,this.onSpellsToHighlightUpdate);
         this.sysApi.addHook(HookList.SpellListUpdate,this.onSpellsList);
         this.sysApi.addHook(BeriliaHookList.StrataUpdate,this.onStrataUpdate);
         this.uiApi.addComponentHook(this.btn_gameplay_class,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabSpell,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabSpecialsSpell,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabFinishMove,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_gameplay_class,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_gameplay_class,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         if(params != null)
         {
            this.openTab(params[0],params[1],this.uiApi.me().restoreSnapshotAfterLoading);
         }
         else
         {
            this.openTab(EnumTab.SPELLSLIST_TAB,{"variantsListTab":true},this.uiApi.me().restoreSnapshotAfterLoading);
         }
         this.onSpellsToHighlightUpdate(Grimoire.getInstance().newSpellIdsToHighlight);
         this.onSpellsList(null);
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         if(this.soundApi)
         {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         }
         this.closeTab(this._currentTabUi);
      }
      
      public function getTooltipStrata() : int
      {
         return this._tooltipStrata;
      }
      
      private function toggleGameplayClassWindow() : void
      {
         if(!this.uiApi.getUi(EnumTab.GAMEPLAY_CLASS_WINDOW))
         {
            this.uiApi.loadUi(EnumTab.GAMEPLAY_CLASS_WINDOW,EnumTab.GAMEPLAY_CLASS_WINDOW,null,this.uiApi.me().strata);
         }
         else
         {
            this.uiApi.unloadUi(EnumTab.GAMEPLAY_CLASS_WINDOW);
         }
      }
      
      private function closeGameplayClassWindow() : void
      {
         if(this.uiApi.getUi(EnumTab.GAMEPLAY_CLASS_WINDOW))
         {
            this.uiApi.unloadUi(EnumTab.GAMEPLAY_CLASS_WINDOW);
         }
      }
      
      public function openTab(tab:String = "", params:Object = null, restoreSnapshot:Boolean = true) : void
      {
         if(tab != "" && this._currentTabUi == tab && (!params || (!"variantsListTab" in params || this._currentParams.variantsListTab == params.variantsListTab) && !"spellId" in params))
         {
            this.closeSpellBase();
            return;
         }
         if(params && "spellId" in params)
         {
            restoreSnapshot = false;
         }
         if(this._currentTabUi != "")
         {
            this.uiApi.unloadUi("subSpellUi");
         }
         if(tab == "")
         {
            this._currentTabUi = EnumTab.SPELLSLIST_TAB;
            params = {"variantsListTab":true};
         }
         else
         {
            this._currentTabUi = tab;
         }
         var isClassSpellTab:Boolean = tab == EnumTab.SPELLSLIST_TAB && params.variantsListTab == true;
         this.btn_gameplay_class.visible = isClassSpellTab;
         this.uiCtr.getUi().restoreSnapshotAfterLoading = restoreSnapshot;
         this._currentParams = params;
         this.uiApi.loadUiInside(this._currentTabUi,this.uiCtr,"subSpellUi",params);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.getButtonByTab(this._currentTabUi),this.uiApi.me());
         this.getButtonByTab(this._currentTabUi).selected = true;
      }
      
      private function getButtonByTab(tab:String) : ButtonContainer
      {
         var returnButton:ButtonContainer = null;
         switch(tab)
         {
            case EnumTab.SPELLSLIST_TAB:
               if(this._currentParams && this._currentParams.hasOwnProperty("variantsListTab") && !this._currentParams.variantsListTab)
               {
                  returnButton = this.btn_tabSpecialsSpell;
               }
               else
               {
                  returnButton = this.btn_tabSpell;
               }
               break;
            case EnumTab.FINISHMOVES_TAB:
               returnButton = this.btn_tabFinishMove;
         }
         return returnButton;
      }
      
      private function closeTab(tab:String) : void
      {
         this.uiApi.unloadUi("subSpellUi");
         this.closeGameplayClassWindow();
      }
      
      private function closeSpellBase() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         switch(target)
         {
            case this.btn_gameplay_class:
               text = this.uiApi.getText("ui.grimoire.mecanics");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.closeSpellBase();
               break;
            case this.btn_gameplay_class:
               this.toggleGameplayClassWindow();
               return;
            case this.btn_tabSpell:
               this.openTab(EnumTab.SPELLSLIST_TAB,{"variantsListTab":true});
               break;
            case this.btn_tabSpecialsSpell:
               this.openTab(EnumTab.SPELLSLIST_TAB,{"variantsListTab":false});
               break;
            case this.btn_tabFinishMove:
               this.openTab(EnumTab.FINISHMOVES_TAB,{"variantsListTab":false});
               break;
            case this.btn_help:
               this.uiApi.me().childUiRoot.uiClass.showTabHints();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.closeSpellBase();
               return true;
            default:
               return false;
         }
      }
      
      private function onSpellsToHighlightUpdate(newSpellIdsToHighlight:Array) : void
      {
         var spellWrapperArray:Array = null;
         var spell:SpellWrapper = null;
         var currentSpecialSpells:Array = null;
         this.sysApi.log(2,"  ° SpellBase   spells to highlight : " + newSpellIdsToHighlight);
         this.tx_warningTabSpell.visible = false;
         this.tx_warningTabSpecial.visible = false;
         if(!newSpellIdsToHighlight.length)
         {
            return;
         }
         var currentBreedSpells:Array = Grimoire.getInstance().currentBreedSpells;
         for each(spellWrapperArray in currentBreedSpells)
         {
            for each(spell in spellWrapperArray)
            {
               if(newSpellIdsToHighlight.indexOf(spell.id) != -1)
               {
                  this.tx_warningTabSpell.visible = true;
               }
            }
         }
         currentSpecialSpells = Grimoire.getInstance().currentSpecialSpells;
         for each(spellWrapperArray in currentSpecialSpells)
         {
            for each(spell in spellWrapperArray)
            {
               if(newSpellIdsToHighlight.indexOf(spell.id) != -1)
               {
                  this.tx_warningTabSpecial.visible = true;
               }
            }
         }
      }
      
      private function onSpellsList(spellList:Object) : void
      {
         if(Grimoire.getInstance().currentBreedSpells.length == 0)
         {
            this.btn_tabSpell.disabled = true;
            if(this.btn_tabSpell.selected)
            {
               this.openTab(EnumTab.SPELLSLIST_TAB,{"variantsListTab":false});
            }
         }
         else
         {
            this.btn_tabSpell.disabled = false;
         }
         if(Grimoire.getInstance().currentSpecialSpells.length == 0)
         {
            this.btn_tabSpecialsSpell.disabled = true;
            if(this.btn_tabSpecialsSpell.selected)
            {
               this.openTab(EnumTab.SPELLSLIST_TAB,{"variantsListTab":true});
            }
         }
         else
         {
            this.btn_tabSpecialsSpell.disabled = false;
         }
      }
      
      private function onStrataUpdate(uiName:String, strata:int) : void
      {
         if(this.uiApi.me().name == uiName)
         {
            this._tooltipStrata = strata;
         }
      }
   }
}
