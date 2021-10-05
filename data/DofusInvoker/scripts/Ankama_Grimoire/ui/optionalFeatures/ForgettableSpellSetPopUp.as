package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.items.PresetIcon;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.CharacterPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.SavablePresetTypeEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ForgettableSpellSetPopUp
   {
      
      public static const ACTION_CREATE_SPELL_SET:uint = 0;
      
      public static const ACTION_EDIT_SPELL_SET:uint = 1;
       
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var systemApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      private var _actionId:uint;
      
      private var _spellSetDescr:Object;
      
      private var _currentSelectedSpellSetIconIndex:uint;
      
      private var _buildNameNamingRule:NamingRule;
      
      private var _buildNameRegex:RegExp = null;
      
      private var _isPresetSaving:Boolean = false;
      
      private var _isPresetBeingDeleted:Boolean = false;
      
      private var _oldSpellSetName:String = null;
      
      private var _oldSpellSetIconId:Number = NaN;
      
      public var btn_close:ButtonContainer;
      
      public var btn_createSpellSet:ButtonContainer;
      
      public var btn_editSpellSet:ButtonContainer;
      
      public var btn_deleteSpellSet:ButtonContainer;
      
      public var ctr_setSpellSetIcon:GraphicContainer;
      
      public var ctr_spellSetIcons:GraphicContainer;
      
      public var ctr_spellSetName:GraphicContainer;
      
      public var ctr_spellSetIcon:GraphicContainer;
      
      public var inp_spellSetName:Input;
      
      public var gd_spellSetIcons:Grid;
      
      public var lbl_title:Label;
      
      public var lbl_error:Label;
      
      public var lbl_deleteSpellSet:Label;
      
      public var tx_spellSetIcon:Texture;
      
      public var tx_spellSetName:TextureBitmap;
      
      public function ForgettableSpellSetPopUp()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         var spellSetIcon:PresetIcon = null;
         if(params.length <= 0)
         {
            throw new Error("You should provide at least the action ID");
         }
         this._actionId = params[0];
         var spellSetIcons:Array = [];
         for each(spellSetIcon in this.dataApi.getPresetIcons())
         {
            spellSetIcons.push(spellSetIcon);
         }
         this.gd_spellSetIcons.dataProvider = spellSetIcons;
         if(this._actionId === ACTION_EDIT_SPELL_SET)
         {
            if(params.length <= 1)
            {
               throw new Error("When editing a spell set, you should provide its description");
            }
            this._spellSetDescr = params[1];
            this._oldSpellSetName = this._spellSetDescr.spellSetName;
            this._oldSpellSetIconId = this._spellSetDescr.spellSetIconId;
            this.lbl_title.text = this.uiApi.getText("ui.temporis.editSpellSet");
            this.btn_createSpellSet.visible = false;
            this.btn_editSpellSet.visible = true;
            this.btn_deleteSpellSet.visible = true;
            this.lbl_deleteSpellSet.x = this.btn_deleteSpellSet.x;
            this.lbl_deleteSpellSet.width = this.btn_deleteSpellSet.width;
         }
         else
         {
            this._spellSetDescr = {};
            this.lbl_title.text = this.uiApi.getText("ui.temporis.createSpellSet");
            this.btn_createSpellSet.visible = true;
            this.btn_editSpellSet.visible = false;
            this.lbl_deleteSpellSet.visible = false;
            this.btn_deleteSpellSet.visible = false;
         }
         if(!this._spellSetDescr.hasOwnProperty("spellSetName"))
         {
            this._spellSetDescr.spellSetName = "";
         }
         if(!this._spellSetDescr.hasOwnProperty("spellSetIconId"))
         {
            this._spellSetDescr.spellSetIconId = spellSetIcons.length > 0 ? spellSetIcons[Math.floor(Math.random() * spellSetIcons.length)].id : -1;
         }
         this.inp_spellSetName.text = this._spellSetDescr.spellSetName;
         this.updateSpellSetIconOrderFromId(this._spellSetDescr.spellSetIconId);
         this.updateSpellSetIcon(this._spellSetDescr.spellSetIconId);
         var parentUi:UiRootContainer = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_UI);
         var childUi:UiRootContainer = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP);
         if(parentUi !== null && childUi !== null)
         {
            childUi.strata = parentUi.strata - 1;
         }
         this._buildNameNamingRule = this.systemApi.getCurrentServer().community.namingRulePresetName;
         this._buildNameRegex = new RegExp(this._buildNameNamingRule.regexp,"g");
         this.inp_spellSetName.maxChars = this._buildNameNamingRule.maxLength;
         this.inp_spellSetName.focus();
         this.btn_createSpellSet.soundId = SoundEnum.OK_BUTTON;
         this.btn_editSpellSet.soundId = SoundEnum.OK_BUTTON;
         this.btn_deleteSpellSet.soundId = SoundEnum.DELETE_BUTTON;
         this.systemApi.addHook(InventoryHookList.PresetsUpdate,this.onPresetsUpdate);
         this.systemApi.addHook(InventoryHookList.PresetError,this.onPresetError);
         this.systemApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.uiApi.addComponentHook(this.btn_createSpellSet,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_editSpellSet,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_deleteSpellSet,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_spellSetName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_setSpellSetIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_spellSetIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_spellSetIcons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateSpellSetIconSlot(data:*, components:*, isSelected:Boolean) : void
      {
         components.btn_icon.selected = false;
         if(data !== null)
         {
            components.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("iconsUri") + "small_" + data.id);
            components.btn_icon.selected = isSelected;
         }
         else
         {
            components.tx_icon.uri = null;
         }
      }
      
      private function updateSpellSetIcon(spellSetIconId:Number) : void
      {
         this._spellSetDescr.spellSetIconId = spellSetIconId;
         this._currentSelectedSpellSetIconIndex = this.gd_spellSetIcons.selectedIndex;
         this.tx_spellSetIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("iconsUri") + "icon_" + this._spellSetDescr.spellSetIconId);
      }
      
      private function updateSpellSetIconOrderFromId(spellSetIconId:Number) : void
      {
         var icon:PresetIcon = null;
         var index:Number = -1;
         for each(icon in this.dataApi.getPresetIcons())
         {
            if(icon.id == spellSetIconId)
            {
               index = icon.order;
               break;
            }
         }
         this.gd_spellSetIcons.selectedIndex = index;
         this.gd_spellSetIcons.updateItem(index);
      }
      
      private function deleteSpellSet(spellSetDescr:Object, isForce:Boolean = false) : void
      {
         if(!isForce)
         {
            if(!this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP))
            {
               this.uiApi.loadUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP,UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP,[spellSetDescr,function():void
               {
                  deleteSpellSet(spellSetDescr,true);
               }]);
            }
         }
         else
         {
            this._isPresetBeingDeleted = true;
            this.systemApi.sendAction(new PresetDeleteRequestAction([spellSetDescr.spellSetId]));
         }
      }
      
      private function closeMe() : void
      {
         if(this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP) !== null)
         {
            if(this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP) !== null)
            {
               this.uiApi.unloadUi(UIEnum.FORGETTABLE_SPELL_SET_DELETION_POP_UP);
            }
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function submitSpellSet() : void
      {
         this._spellSetDescr.spellSetName = this.systemApi.trimString(this.inp_spellSetName.text);
         var buildNameObject:Object = this.checkBuildName(this._spellSetDescr.spellSetName);
         if(!buildNameObject.isBuildNameValid)
         {
            this.lbl_error.text = buildNameObject.errorText;
            return;
         }
         this.inp_spellSetName.text = "";
         this.lbl_error.text = "";
         var buildId:int = this._actionId === ACTION_CREATE_SPELL_SET ? -1 : int(this._spellSetDescr.spellSetId);
         this._isPresetSaving = true;
         this.systemApi.sendAction(new CharacterPresetSaveRequestAction([buildId,this._spellSetDescr.spellSetIconId,this._spellSetDescr.spellSetName,true,SavablePresetTypeEnum.SPELL_PRESET]));
      }
      
      private function checkBuildName(buildName:String) : Object
      {
         var errorText:String = null;
         var isBuildNameValid:Boolean = true;
         if(buildName.length < this._buildNameNamingRule.minLength)
         {
            errorText = this.uiApi.getText("ui.build.errorNameShort");
            isBuildNameValid = false;
         }
         else if(buildName.length > this._buildNameNamingRule.maxLength)
         {
            errorText = this.uiApi.getText("ui.build.errorNameLong");
            isBuildNameValid = false;
         }
         else if(!this._buildNameRegex.test(buildName))
         {
            errorText = this.uiApi.getText("ui.build.errorName");
            isBuildNameValid = false;
         }
         return {
            "isBuildNameValid":isBuildNameValid,
            "errorText":errorText
         };
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         switch(shortcutLabel)
         {
            case ShortcutHookListEnum.VALID_UI:
               this.submitSpellSet();
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
         var isSpellSetIconContainerVisible:Boolean = this.ctr_spellSetIcons.visible;
         this.ctr_spellSetIcons.visible = false;
         switch(target)
         {
            case this.btn_close:
               this.closeMe();
               break;
            case this.btn_createSpellSet:
            case this.btn_editSpellSet:
               this.submitSpellSet();
               break;
            case this.btn_deleteSpellSet:
               this.deleteSpellSet(this._spellSetDescr);
               break;
            case this.inp_spellSetName:
               this.lbl_error.text = "";
               break;
            case this.ctr_setSpellSetIcon:
            case this.tx_spellSetIcon:
               this.gd_spellSetIcons.selectedIndex = this._currentSelectedSpellSetIconIndex;
               this.ctr_spellSetIcons.visible = !isSpellSetIconContainerVisible;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != GridItemSelectMethodEnum.MANUAL)
         {
            this.ctr_spellSetIcons.visible = false;
         }
         if(target === this.gd_spellSetIcons)
         {
            this.updateSpellSetIcon((target as Grid).selectedItem.id);
         }
      }
      
      public function onPresetsUpdate(buildId:int = -1) : void
      {
         if(this._isPresetBeingDeleted)
         {
            this._isPresetBeingDeleted = false;
            this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.temporis.spellSetDeleted",this._spellSetDescr.spellSetName));
            this.closeMe();
         }
         else if(this._isPresetSaving)
         {
            this._isPresetSaving = false;
            if(this._actionId === ACTION_CREATE_SPELL_SET)
            {
               this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.temporis.spellSetCreated",this._spellSetDescr.spellSetName));
            }
            else if(this._actionId === ACTION_EDIT_SPELL_SET)
            {
               if(this._oldSpellSetName !== this._spellSetDescr.spellSetName && this._oldSpellSetIconId === this._spellSetDescr.spellSetIconId)
               {
                  this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.temporis.spellSetNameUpdated",this._oldSpellSetName,this._spellSetDescr.spellSetName));
               }
               else if(this._oldSpellSetName === this._spellSetDescr.spellSetName && this._oldSpellSetIconId !== this._spellSetDescr.spellSetIconId)
               {
                  this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.temporis.spellSetIconUpdated",this._spellSetDescr.spellSetName));
               }
               else if(this._oldSpellSetName !== this._spellSetDescr.spellSetName && this._oldSpellSetIconId !== this._spellSetDescr.spellSetIconId)
               {
                  this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.temporis.spellSetNameAndIconUpdated",this._oldSpellSetName,this._spellSetDescr.spellSetName));
               }
            }
            this.closeMe();
         }
      }
      
      public function onPresetError(reasonText:String) : void
      {
         var errorText:String = null;
         this._isPresetSaving = false;
         this._isPresetBeingDeleted = false;
         switch(reasonText)
         {
            case "unknownSave":
            case "unknownDelete":
               errorText = this.uiApi.getText("ui.common.unknownFail");
               break;
            case "badId":
               errorText = this.uiApi.getText("ui.preset.error.5");
               break;
            case "inactive":
               errorText = this.uiApi.getText("ui.preset.error.inactive");
               break;
            case "tooMany":
               errorText = this.uiApi.getText("ui.preset.error.tooMany");
               break;
            case "invalidPlayerState":
               errorText = this.uiApi.getText("ui.preset.error.invalidPlayerState");
               break;
            default:
               errorText = this.uiApi.getText("ui.common.unknownFail");
         }
         this.lbl_error.text = errorText;
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(this._actionId === ACTION_EDIT_SPELL_SET)
         {
            this.ctr_spellSetName.x = 171;
            this.ctr_spellSetIcon.x = -292;
            this.tx_spellSetName.width = 245;
            this.inp_spellSetName.width = 210;
         }
      }
   }
}
