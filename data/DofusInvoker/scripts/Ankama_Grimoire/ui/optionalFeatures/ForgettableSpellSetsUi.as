package Ankama_Grimoire.ui.optionalFeatures
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.types.game.presets.SpellForPreset;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class ForgettableSpellSetsUi
   {
      
      public static const TOOLTIP_UI_NAME:String = "ForgettableSpellSetsUiTooltip";
      
      public static const STANDARD_TOOLTIP_UI_NAME:String = "standard";
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playedCharacterApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var systemApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Module(name="Ankama_Common")]
      public var ankamaCommon:Common;
      
      protected var _componentsDictionary:Dictionary;
      
      private var _currentSpellSetBuild:BuildWrapper = null;
      
      private var _isModsterActivated:Boolean = false;
      
      public var btn_close:ButtonContainer;
      
      public var ctr_noSpellSetYet:GraphicContainer;
      
      public var gd_spellSets:Grid;
      
      public function ForgettableSpellSetsUi()
      {
         this._componentsDictionary = new Dictionary(true);
         super();
      }
      
      public function main(paramsObject:Object = null) : void
      {
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this._isModsterActivated = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.MODSTERS);
         this.systemApi.addHook(InventoryHookList.PresetsUpdate,this.onPresetsUpdate);
         this.systemApi.addHook(InventoryHookList.PresetUsed,this.onPresetUsed);
         this.systemApi.addHook(InventoryHookList.PresetSelected,this.onPresetSelected);
         this.systemApi.addHook(InventoryHookList.PresetError,this.onPresetError);
         this.loadSpellSets();
         if(paramsObject != null)
         {
            this.moveToPreset(paramsObject[0]);
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateForgettableSpellSetLine(spellSetDescr:Object, components:*, isSelected:Boolean) : void
      {
         this.uiApi.removeComponentHook(components.btn_equipSpellSet,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_editSpellSet,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_RELEASE);
         this.uiApi.removeComponentHook(components.btn_editSpellSet,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_editSpellSet,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_ROLL_OUT);
         components.gd_forgettableSpells.renderer.allowDrop = false;
         if(spellSetDescr === null)
         {
            components.slot_spellSetIcon.data = null;
            components.lbl_spellSetName.text = null;
            components.gd_forgettableSpells.dataProvider = [];
            components.lineBlock.visible = false;
            return;
         }
         this.uiApi.addComponentHook(components.btn_editSpellSet,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(components.btn_editSpellSet,ComponentHookList.ON_ROLL_OUT);
         if(this._currentSpellSetBuild !== null && spellSetDescr.spellSetId === this._currentSpellSetBuild.id)
         {
            components.btn_equipSpellSet.disabled = true;
         }
         else
         {
            components.btn_equipSpellSet.disabled = false;
            this.uiApi.addComponentHook(components.btn_equipSpellSet,ComponentHookList.ON_RELEASE);
            this._componentsDictionary[components.btn_equipSpellSet.name] = spellSetDescr;
         }
         this.uiApi.addComponentHook(components.btn_editSpellSet,ComponentHookList.ON_RELEASE);
         this._componentsDictionary[components.btn_editSpellSet.name] = spellSetDescr;
         if(spellSetDescr.forgettableSpells !== null && spellSetDescr.forgettableSpells.length > 0)
         {
            this.uiApi.addComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.btn_shareForgettableSpells,ComponentHookList.ON_RELEASE);
            components.btn_shareForgettableSpells.disabled = false;
            this._componentsDictionary[components.btn_shareForgettableSpells.name] = spellSetDescr;
         }
         else
         {
            components.btn_shareForgettableSpells.disabled = true;
         }
         components.lineBlock.visible = true;
         components.slot_spellSetIcon.data = spellSetDescr.spellSetData;
         components.lbl_spellSetName.text = spellSetDescr.spellSetName;
         components.gd_forgettableSpells.dataProvider = spellSetDescr.forgettableSpells;
         this.additionnalComponents(spellSetDescr,components);
      }
      
      private function equipSpellSet(spellSetDescr:Object) : void
      {
         this._currentSpellSetBuild = spellSetDescr.spellSetData;
         this.systemApi.sendAction(new PresetUseRequestAction([spellSetDescr.spellSetId]));
      }
      
      private function editSpellSet(spellSetDescr:Object) : void
      {
         if(!this.uiApi.getUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP))
         {
            this.uiApi.loadUi(UIEnum.FORGETTABLE_SPELL_SET_POP_UP,UIEnum.FORGETTABLE_SPELL_SET_POP_UP,[ForgettableSpellSetPopUp.ACTION_EDIT_SPELL_SET,spellSetDescr,!!this._isModsterActivated ? UIEnum.FORGETTABLE_MODSTERS_UI : UIEnum.FORGETTABLE_SPELLS_UI]);
         }
      }
      
      private function shareForgettableSpells(forgettableSpells:Array) : void
      {
         var forgettableSpellIds:Array = [];
         var currentSpellWrapper:SpellWrapper = null;
         for each(currentSpellWrapper in forgettableSpells)
         {
            if(currentSpellWrapper !== null)
            {
               forgettableSpellIds.push(currentSpellWrapper.spellId);
            }
         }
         forgettableSpellIds = forgettableSpellIds.sort(Array.NUMERIC);
         this.systemApi.goToUrl(this.uiApi.getText("ui.link.shareTemporisSpells") + forgettableSpellIds.toString());
      }
      
      private function loadSpellSets() : void
      {
         var item:Object = null;
         var index:uint = 0;
         var builds:Array = this.inventoryApi.getBuilds(2);
         var spellSets:Array = [];
         var currentBuildWrapper:BuildWrapper = null;
         var forgettableSpells:Array = null;
         var currentSpellWrapper:SpellWrapper = null;
         var currentSpellsForPreset:Vector.<SpellForPreset> = null;
         var currentSpellId:uint = 0;
         for each(item in builds)
         {
            if(item is BuildWrapper)
            {
               currentBuildWrapper = item as BuildWrapper;
               forgettableSpells = [];
               if(currentBuildWrapper.forgettableSpellsPreset !== null)
               {
                  currentSpellsForPreset = currentBuildWrapper.forgettableSpellsPreset.forgettableSpells;
               }
               else
               {
                  currentSpellsForPreset = null;
               }
               if(currentSpellsForPreset !== null)
               {
                  for(index = 0; index < currentSpellsForPreset.length; index++)
                  {
                     currentSpellId = currentSpellsForPreset[index].spellId;
                     if(this.playedCharacterApi.isForgettableSpell(currentSpellId))
                     {
                        currentSpellWrapper = this.dataApi.getSpellWrapper(currentSpellId);
                        if(currentSpellWrapper !== null)
                        {
                           forgettableSpells.push(currentSpellWrapper);
                        }
                     }
                  }
               }
               spellSets.push({
                  "spellSetName":currentBuildWrapper.buildName,
                  "spellSetId":currentBuildWrapper.id,
                  "spellSetIcon":currentBuildWrapper.iconUri,
                  "spellSetIconId":currentBuildWrapper.gfxId,
                  "forgettableSpells":forgettableSpells,
                  "spellSetData":currentBuildWrapper
               });
            }
         }
         this.ctr_noSpellSetYet.visible = spellSets.length <= 0;
         this.gd_spellSets.dataProvider = spellSets;
      }
      
      private function closeMe() : void
      {
         if(this.uiApi !== null)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function showSpellTooltip(data:Object, target:Object) : void
      {
         if(data === null || target === null || data === null)
         {
            return;
         }
         this.uiApi.showTooltip(data,target,false,STANDARD_TOOLTIP_UI_NAME,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{
            "isTheoretical":this.systemApi.getOption("useTheoreticalValuesInSpellTooltips","dofus"),
            "footer":false
         },null,false);
      }
      
      private function moveToPreset(presetId:int) : void
      {
         var preset:Object = null;
         if(presetId == -1)
         {
            return;
         }
         var index:int = -1;
         for each(preset in this.gd_spellSets.dataProvider)
         {
            index++;
            if(preset.spellSetId == presetId)
            {
               this.gd_spellSets.moveTo(index,true);
               break;
            }
         }
      }
      
      protected function additionnalComponents(spellSetDescr:Object, components:*) : void
      {
      }
      
      protected function get editSetOverText() : String
      {
         return this.uiApi.getText("ui.temporis.editOrDeleteSpellSet");
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
         var tooltipText:String = null;
         if(target.name.indexOf("btn_editSpellSet") !== -1)
         {
            tooltipText = this.editSetOverText;
         }
         else if(target.name.indexOf("btn_shareForgettableSpells") !== -1)
         {
            tooltipText = this.uiApi.getText("ui.temporis.shareSpellSet");
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,0,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
         this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.closeMe();
               break;
            default:
               if(target.name in this._componentsDictionary)
               {
                  if(target.name.indexOf("btn_equipSpellSet") !== -1)
                  {
                     this.equipSpellSet(this._componentsDictionary[target.name]);
                  }
                  else if(target.name.indexOf("btn_editSpellSet") !== -1)
                  {
                     this.editSpellSet(this._componentsDictionary[target.name]);
                  }
                  else if(target.name.indexOf("btn_shareForgettableSpells") !== -1)
                  {
                     this.shareForgettableSpells(this._componentsDictionary[target.name].forgettableSpells);
                  }
               }
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(target.name.indexOf("gd_forgettableSpells") !== -1 && item.data !== null)
         {
            this.showSpellTooltip(item.data,item.container);
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip(STANDARD_TOOLTIP_UI_NAME);
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         var me:UiRootContainer = null;
         if(shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
         {
            me = this.uiApi.me();
            if(me === null)
            {
               return false;
            }
            this.uiApi.unloadUi(me.name);
            return true;
         }
         return false;
      }
      
      public function onPresetsUpdate(buildId:int = -1) : void
      {
         this.loadSpellSets();
      }
      
      public function onPresetSelected(buildId:int) : void
      {
         this.loadSpellSets();
      }
      
      public function onPresetUsed(buildId:int) : void
      {
         this.loadSpellSets();
      }
      
      public function onPresetError(reasonText:String) : void
      {
         this.loadSpellSets();
      }
   }
}
