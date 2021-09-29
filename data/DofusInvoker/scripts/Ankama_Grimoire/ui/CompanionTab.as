package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.CompanionCharacteristic;
   import com.ankamagames.dofus.datacenter.monsters.CompanionSpell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.geom.ColorTransform;
   
   public class CompanionTab
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _colorDisable:ColorTransform;
      
      private var _coloravailable:ColorTransform;
      
      private var _allCompanions:Array;
      
      private var _myCompanions:Array;
      
      private var _selectedCompanion:Companion;
      
      private var _selectedSpell:SpellWrapper;
      
      private var _initialSpellId:uint;
      
      private var _shownTooltipId:int;
      
      private var _currentlyEquipedGID:int;
      
      private var _etherealResText:String;
      
      private var _myLevel:uint;
      
      private var _illusUri:String;
      
      private var _currentTabName:String;
      
      public var gd_companions:Grid;
      
      public var btn_carac:ButtonContainer;
      
      public var btn_spells:ButtonContainer;
      
      public var btn_equip:ButtonContainer;
      
      public var btn_lbl_btn_equip:Label;
      
      public var ctr_carac:GraphicContainer;
      
      public var ctr_spells:GraphicContainer;
      
      public var tx_spellIcon:Texture;
      
      public var lbl_spellName:Label;
      
      public var lbl_spellInitial:Label;
      
      public var gd_spell:Grid;
      
      public var tx_illu:Texture;
      
      public var tx_etherealGauge:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var gd_carac:Grid;
      
      public var lbl_description:TextArea;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public function CompanionTab()
      {
         this._colorDisable = new ColorTransform(1,1,1,0.4);
         this._coloravailable = new ColorTransform();
         this._allCompanions = [];
         this._myCompanions = [];
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var compGID:int = 0;
         var ei:EffectInstance = null;
         var selectedCompanionIndex:int = 0;
         var comp:Companion = null;
         this.sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         this.uiApi.addComponentHook(this.gd_companions,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.tx_etherealGauge,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_etherealGauge,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         this._myLevel = this.playerApi.getPlayedCharacterInfo().level;
         if(this._myLevel > ProtocolConstantsEnum.MAX_LEVEL)
         {
            this._myLevel = ProtocolConstantsEnum.MAX_LEVEL;
         }
         this._illusUri = this.uiApi.me().getConstant("illus");
         var iw:ItemWrapper = this.inventoryApi.getEquipementItemByPosition(CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY);
         var companionItems:Array = [];
         var isEthereal:Boolean = false;
         if(iw)
         {
            this._currentlyEquipedGID = iw.objectGID;
            companionItems.push(iw);
         }
         for each(iw in this.inventoryApi.getStorageObjectsByType(169))
         {
            companionItems.push(iw);
         }
         for each(iw in companionItems)
         {
            isEthereal = false;
            for each(ei in iw.effects)
            {
               if(ei.effectId == ActionIds.ACTION_SET_COMPANION)
               {
                  compGID = int(ei.parameter0);
               }
               if(ei.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
               {
                  isEthereal = true;
               }
            }
            if(iw.objectGID == this._currentlyEquipedGID || !this._myCompanions[compGID] || this._myCompanions[compGID] && this._myCompanions[compGID].isEthereal && this._myCompanions[compGID].item.objectGID != this._currentlyEquipedGID)
            {
               this._myCompanions[compGID] = {
                  "item":iw,
                  "isEthereal":isEthereal
               };
            }
         }
         selectedCompanionIndex = -1;
         for each(comp in this.dataApi.getAllCompanions())
         {
            if(comp.visible)
            {
               if(oParam != null && oParam.hasOwnProperty("companion") && oParam.companion != null)
               {
                  if(comp.id == oParam.companion.id)
                  {
                     selectedCompanionIndex = this._allCompanions.length;
                  }
               }
               this._allCompanions.push(comp);
            }
         }
         this.gd_companions.dataProvider = this._allCompanions;
         this.gd_companions.selectedIndex = selectedCompanionIndex >= 0 ? int(selectedCompanionIndex) : 0;
         this._selectedCompanion = this.gd_companions.dataProvider[0];
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_carac,this.uiApi.me());
         this.btn_carac.selected = true;
         this.currentTabName = "btn_carac";
         this.displayCompanionCarac();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.tx_selected.visible = selected;
            componentsRef.tx_look.uri = this.uiApi.createUri(this._illusUri + "small_" + data.assetId + ".jpg");
            if(this._myCompanions[data.id])
            {
               Texture(componentsRef.tx_look).transform.colorTransform = this._coloravailable;
            }
            else
            {
               Texture(componentsRef.tx_look).transform.colorTransform = this._colorDisable;
            }
         }
         else
         {
            componentsRef.tx_selected.visible = false;
            componentsRef.tx_look.uri = null;
         }
      }
      
      public function updateSpellLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.btn_spell.selected = selected;
            componentsRef.btn_spell.softDisabled = false;
            componentsRef.lbl_spellName.text = data.name;
            componentsRef.slot_icon.allowDrag = false;
            componentsRef.slot_icon.data = data;
            componentsRef.slot_icon.selected = false;
         }
         else
         {
            componentsRef.btn_spell.selected = false;
            componentsRef.lbl_spellName.text = "";
            componentsRef.slot_icon.data = null;
            componentsRef.btn_spell.softDisabled = true;
            componentsRef.btn_spell.reset();
         }
      }
      
      public function updateCaracLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.lbl_carac.text = data.text;
         }
         else
         {
            componentsRef.lbl_carac.text = "";
         }
      }
      
      public function moveToCompanion(id:int) : void
      {
         var comp:Companion = null;
         var index:uint = 0;
         for each(comp in this.gd_companions.dataProvider)
         {
            if(comp.id == id)
            {
               this.gd_companions.selectedIndex = index;
            }
            index++;
         }
      }
      
      public function onPopupClose() : void
      {
      }
      
      private function displayCompanionCarac() : void
      {
         var compCarac:CompanionCharacteristic = null;
         var carac:Characteristic = null;
         var caracId:int = 0;
         this.ctr_carac.visible = true;
         this.ctr_spells.visible = false;
         this.lbl_name.text = this._selectedCompanion.name;
         this.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + this._myLevel;
         this.tx_illu.uri = this.uiApi.createUri(this._illusUri + "big_" + this._selectedCompanion.assetId + ".jpg");
         var caracs:Array = [];
         var value:int = 0;
         for each(caracId in this._selectedCompanion.characteristics)
         {
            compCarac = this.dataApi.getCompanionCharacteristic(caracId);
            value = this.getStatValue(compCarac.statPerLevelRange,this._myLevel);
            caracs.push({
               "text":compCarac.name + this.uiApi.getText("ui.common.colon") + value,
               "order":compCarac.order
            });
         }
         caracs.sortOn("order",Array.NUMERIC);
         this.gd_carac.dataProvider = caracs;
         this.lbl_description.text = this._selectedCompanion.description;
         this.currentTabName = this.btn_carac.name;
      }
      
      private function displayCompanionSpells() : void
      {
         var compSpell:CompanionSpell = null;
         var sw:SpellWrapper = null;
         var gradeByLevel:Array = null;
         var compSpellId:int = 0;
         var spellLevel:SpellLevel = null;
         var i:int = 0;
         this.ctr_spells.visible = true;
         this.ctr_carac.visible = false;
         var spells:Array = [];
         var grade:uint = 1;
         this._initialSpellId = 0;
         if(this._selectedCompanion.startingSpellLevelId != 0)
         {
            spellLevel = this.dataApi.getSpellLevel(this._selectedCompanion.startingSpellLevelId);
            if(spellLevel)
            {
               sw = this.dataApi.getSpellWrapper(spellLevel.spellId,spellLevel.grade);
               spells.push(sw);
               this._initialSpellId = sw.id;
            }
         }
         var compSpellIds:Vector.<uint> = this._selectedCompanion.spells;
         compSpellIds.sort(Array.NUMERIC);
         for each(compSpellId in compSpellIds)
         {
            compSpell = this.dataApi.getCompanionSpell(compSpellId);
            gradeByLevel = compSpell.gradeByLevel.split(",");
            for(i = 0; i < gradeByLevel.length; i += 2)
            {
               if(gradeByLevel[i + 1] <= this._myLevel)
               {
                  grade = gradeByLevel[i];
               }
            }
            sw = this.dataApi.getSpellWrapper(compSpell.spellId,grade);
            spells.push(sw);
         }
         this.gd_spell.dataProvider = spells;
         this.gd_spell.selectedIndex = 0;
         this.currentTabName = this.btn_spells.name;
      }
      
      private function displayCompanionInfos() : void
      {
         var used:Boolean = false;
         var resPos:uint = 0;
         var effect:Object = null;
         var diceNum:uint = 0;
         this.tx_etherealGauge.visible = false;
         this.btn_equip.disabled = true;
         this.btn_lbl_btn_equip.text = this.uiApi.getText("ui.common.equip");
         var myCompanionOfThisType:Object = this._myCompanions[this._selectedCompanion.id];
         if(myCompanionOfThisType)
         {
            used = false;
            if(myCompanionOfThisType.isEthereal)
            {
               for each(effect in myCompanionOfThisType.item.effects)
               {
                  if(effect.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                  {
                     this._etherealResText = effect.description;
                     if(effect.hasOwnProperty("diceNum"))
                     {
                        diceNum = effect.diceNum;
                     }
                     else
                     {
                        diceNum = 0;
                     }
                     resPos = int(diceNum / effect.value * 100);
                     this.tx_etherealGauge.gotoAndStop = resPos.toString();
                     this.tx_etherealGauge.visible = true;
                     if(diceNum == 0)
                     {
                        used = true;
                     }
                  }
               }
            }
            if(!used)
            {
               this.btn_equip.disabled = false;
               if(this._currentlyEquipedGID == myCompanionOfThisType.item.objectGID)
               {
                  this.btn_lbl_btn_equip.text = this.uiApi.getText("ui.common.unequip");
               }
            }
         }
      }
      
      private function updateSpellDisplay() : void
      {
         this.lbl_spellName.text = this._selectedSpell.spell.name;
         this.tx_spellIcon.uri = this._selectedSpell.fullSizeIconUri;
         this.lbl_spellInitial.visible = this._initialSpellId == this._selectedSpell.id;
         this.showSpellTooltip(this._selectedSpell);
      }
      
      private function showSpellTooltip(spellItem:SpellWrapper) : void
      {
         if(this._shownTooltipId == spellItem.spellId)
         {
            return;
         }
         this._shownTooltipId = spellItem.spellId;
         this.uiApi.showTooltip(spellItem,null,false,"tooltipSpellTab",0,2,3,null,null,{
            "smallSpell":false,
            "description":true,
            "isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus"),
            "noBg":true,
            "spellTab":true
         },null,true);
      }
      
      private function getStatValue(pStatPerLevelRange:Object, pLevel:int) : int
      {
         var value:Number = 0;
         var numValues:int = pStatPerLevelRange.length;
         var i:int = 0;
         var j:int = 0;
         for(var levelDone:int = pStatPerLevelRange[i][0] !== 1 ? 1 : 0; i < numValues; )
         {
            for(j = levelDone; j < pStatPerLevelRange[i][0]; j++)
            {
               if(j < pLevel)
               {
                  value += pStatPerLevelRange[i][1];
               }
            }
            levelDone = pStatPerLevelRange[i][0];
            i++;
         }
         return Math.floor(value);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var myComp:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_carac:
               this.displayCompanionCarac();
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_spells:
               this.displayCompanionSpells();
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_equip:
               myComp = this._myCompanions[this._selectedCompanion.id];
               if(myComp)
               {
                  if(myComp.item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)
                  {
                     this.sysApi.sendAction(new ObjectSetPositionAction([myComp.item.objectUID,63,1]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new ObjectSetPositionAction([myComp.item.objectUID,CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY,1]));
                  }
               }
               break;
            case this.btn_help:
               this.hintsApi.showSubHints(this.currentTabName);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.tx_etherealGauge:
               text = this._etherealResText;
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
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_spell)
         {
            this._selectedSpell = this.gd_spell.dataProvider[(target as Grid).selectedIndex];
            if(this._selectedSpell == null)
            {
               return;
            }
            this.updateSpellDisplay();
         }
         else if(target == this.gd_companions)
         {
            this._selectedCompanion = this.gd_companions.selectedItem;
            if(this.ctr_spells.visible)
            {
               this.displayCompanionSpells();
            }
            else
            {
               this.displayCompanionCarac();
            }
            this.displayCompanionInfos();
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
      }
      
      public function onObjectModified(item:Object) : void
      {
         var isEthereal:Boolean = false;
         var compGID:int = 0;
         var ei:EffectInstance = null;
         if(item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)
         {
            this._currentlyEquipedGID = item.objectGID;
            isEthereal = false;
            for each(ei in item.effects)
            {
               if(ei.effectId == ActionIds.ACTION_SET_COMPANION)
               {
                  compGID = int(ei.parameter0);
               }
               if(ei.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
               {
                  isEthereal = true;
               }
            }
            this._myCompanions[compGID] = {
               "item":item,
               "isEthereal":isEthereal
            };
            if(this._myCompanions[this._selectedCompanion.id] && this._myCompanions[this._selectedCompanion.id].item.objectGID == this._currentlyEquipedGID)
            {
               this.displayCompanionInfos();
            }
         }
         else if(item.position == 63 && this._currentlyEquipedGID == item.objectGID)
         {
            if(this._myCompanions[this._selectedCompanion.id] && this._myCompanions[this._selectedCompanion.id].item.objectGID == this._currentlyEquipedGID)
            {
               this._currentlyEquipedGID = 0;
               this.displayCompanionInfos();
            }
            else
            {
               this._currentlyEquipedGID = 0;
            }
         }
      }
   }
}
