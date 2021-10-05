package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ForgettableSpellSetDeletionPopUp
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      private var _validationCallback:Function;
      
      public var btn_close:ButtonContainer;
      
      public var btn_confirmSpellSetDeletion:ButtonContainer;
      
      public var btn_cancelSpellSetDeletion:ButtonContainer;
      
      public var lbl_spellSetName:Label;
      
      public function ForgettableSpellSetDeletionPopUp()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         if(params.length <= 1)
         {
            throw new Error("You should provide the spell set description and the validation callback");
         }
         var spellSetDescr:Object = params[0];
         this._validationCallback = params[1];
         if(spellSetDescr === null || this._validationCallback === null)
         {
            throw new Error("The arguments provided must not be null");
         }
         var parentUi:UiRootContainer = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP);
         var childUi:UiRootContainer = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP);
         if(parentUi !== null && childUi !== null)
         {
            childUi.strata = parentUi.strata - 1;
         }
         this.lbl_spellSetName.text = spellSetDescr.spellSetName;
         this.btn_confirmSpellSetDeletion.soundId = SoundEnum.OK_BUTTON;
         this.btn_cancelSpellSetDeletion.soundId = SoundEnum.CANCEL_BUTTON;
         this.uiApi.addComponentHook(this.btn_confirmSpellSetDeletion,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_cancelSpellSetDeletion,ComponentHookList.ON_RELEASE);
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
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         switch(shortcutLabel)
         {
            case ShortcutHookListEnum.VALID_UI:
               this._validationCallback();
               return true;
            case ShortcutHookListEnum.CLOSE_UI:
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
            case this.btn_cancelSpellSetDeletion:
               this.closeMe();
               break;
            case this.btn_confirmSpellSetDeletion:
               this._validationCallback();
         }
      }
   }
}
