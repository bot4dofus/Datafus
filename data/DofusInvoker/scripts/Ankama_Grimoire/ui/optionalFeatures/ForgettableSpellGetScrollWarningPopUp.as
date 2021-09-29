package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   
   public class ForgettableSpellGetScrollWarningPopUp
   {
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      private var _spellDescr:Object;
      
      private var _validationCallback:Function;
      
      public var btn_close:ButtonContainer;
      
      public var btn_cancelGetScrollAction:ButtonContainer;
      
      public var btn_confirmGetScrollAction:ButtonContainer;
      
      public var cbx_impactedSpellSets:ComboBox;
      
      public function ForgettableSpellGetScrollWarningPopUp()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         if(params.length <= 2)
         {
            throw new Error("You must provide the spell description, spellSets used and the validation callback");
         }
         this._spellDescr = params[0];
         this.cbx_impactedSpellSets.dataProvider = params[1];
         this._validationCallback = params[2];
         if(this._spellDescr === null || this.cbx_impactedSpellSets.dataProvider === null || this._validationCallback === null)
         {
            throw new Error("The arguments provided must not be null");
         }
         this.cbx_impactedSpellSets.finalize();
         this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_GET_SCROLL_WARNING_POP_UP).strata = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_UI).strata - 1;
         this.btn_cancelGetScrollAction.soundId = SoundEnum.OK_BUTTON;
         this.btn_confirmGetScrollAction.soundId = SoundEnum.OK_BUTTON;
         this.uiApi.addComponentHook(this.btn_cancelGetScrollAction,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_confirmGetScrollAction,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function closeMe() : void
      {
         if(this.uiApi !== null)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function confirmGetScrollAction() : void
      {
         this._validationCallback(this._spellDescr,true);
         this.closeMe();
      }
      
      public function onShortcut(shortcut:String) : Boolean
      {
         switch(shortcut)
         {
            case ShortcutHookListEnum.VALID_UI:
               this.confirmGetScrollAction();
               return true;
            case ShortcutHookListEnum.CLOSE_UI:
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.closeMe();
               break;
            case this.btn_confirmGetScrollAction:
               this.confirmGetScrollAction();
               break;
            case this.btn_cancelGetScrollAction:
               this.closeMe();
         }
      }
   }
}
