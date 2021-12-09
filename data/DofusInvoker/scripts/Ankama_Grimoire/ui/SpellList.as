package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.Grimoire;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellVariantActivationRequestAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class SpellList
   {
      
      public static const TOOLTIP_SPELL_TAB:String = "tooltipSpellTab";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _breedSpellsListMode:Boolean = true;
      
      private var _spellIdToShow:int = -1;
      
      private var _spells:Array;
      
      private var _scrollPosition:Number;
      
      private var _componentsList:Dictionary;
      
      private var _spellsHash:String;
      
      private var _playerLevel:int;
      
      private var _allSpellCache:Dictionary;
      
      private var _showAllObtentionLevels:Boolean = false;
      
      private var _showSpellTypeId:uint = 4.294967295E9;
      
      private var _highlightedSpellIds:Array;
      
      private var _currentTabName:String;
      
      public var gd_spell:Grid;
      
      public var btn_showAllObtentionLevels:ButtonContainer;
      
      public var cb_spellType:ComboBox;
      
      public var bgcb_spellType:TextureBitmap;
      
      public function SpellList()
      {
         this._spells = [];
         this._componentsList = new Dictionary(true);
         this._allSpellCache = new Dictionary();
         this._highlightedSpellIds = [];
         super();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(oParam:Object = null) : void
      {
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(HookList.SpellListUpdate,this.onSpellsList);
         this.sysApi.addHook(HookList.CharacterLevelUp,this.onCharacterLevelUp);
         this.sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(InventoryHookList.SpellVariantActivated,this.onSpellVariantActivated);
         this.sysApi.addHook(HookList.SpellsToHighlightUpdate,this.onSpellsToHighlightUpdate);
         this.uiApi.addComponentHook(this.btn_showAllObtentionLevels,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_spellType,ComponentHookList.ON_SELECT_ITEM);
         if(!this.sysApi.isFightContext() || this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id())
         {
            this.sysApi.dispatchHook(CustomUiHookList.SpellMovementAllowed,true);
         }
         if(oParam != null)
         {
            if("spellId" in oParam)
            {
               this._spellIdToShow = oParam.spellId;
            }
            if("variantsListTab" in oParam)
            {
               this._breedSpellsListMode = oParam.variantsListTab;
            }
            if(this._breedSpellsListMode)
            {
               this.currentTabName = "btn_tabSpell";
               this.btn_showAllObtentionLevels.visible = true;
            }
            else
            {
               this.currentTabName = "btn_tabSpecialsSpell";
               this.btn_showAllObtentionLevels.visible = false;
            }
         }
         this.sysApi.dispatchHook(CustomUiHookList.SwitchBannerTab,"spells");
         this._showAllObtentionLevels = Grimoire.getInstance().spellShowAllObtentionLevel;
         this.btn_showAllObtentionLevels.selected = this._showAllObtentionLevels;
         this._highlightedSpellIds = Grimoire.getInstance().newSpellIdsToHighlight.concat();
         this.sysApi.log(2,"highlighted spell ids : " + this._highlightedSpellIds);
         this._playerLevel = this.playerApi.getPlayedCharacterInfo().level;
         this.onSpellsList(null);
         if(this.sysApi.getPlayerManager().hasRights)
         {
            this.cb_spellType.visible = true;
            this.bgcb_spellType.visible = true;
         }
         else
         {
            this.cb_spellType.visible = false;
            this.bgcb_spellType.visible = false;
         }
      }
      
      public function updateSpellLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.gd_spellButtons.dataProvider = data;
            componentsRef.tx_spellBound.visible = data.length > 1;
            componentsRef.gd_spellButtons.width = data.length * componentsRef.gd_spellButtons.slotWidth;
            componentsRef.gd_spellButtons.x = (this.gd_spell.slotWidth - componentsRef.gd_spellButtons.width) / 2;
            componentsRef.gd_spellButtons.y = 6;
         }
         else
         {
            componentsRef.gd_spellButtons.dataProvider = [];
         }
      }
      
      public function updateObtentionLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._componentsList[componentsRef.btn_obtention.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_obtention,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.btn_obtention,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_obtention,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_obtention.name] = data;
         if(data)
         {
            componentsRef.lbl_obtentionLevel.text = data.spellLevel.minPlayerLevel;
            if(data.spellLevel.minPlayerLevel > this._playerLevel)
            {
               if(this._showAllObtentionLevels || data.isFirstLevel)
               {
                  componentsRef.btn_obtention.softDisabled = true;
                  componentsRef.btn_obtention.visible = true;
               }
               else
               {
                  componentsRef.btn_obtention.visible = false;
               }
            }
            else
            {
               componentsRef.btn_obtention.softDisabled = false;
               if(this._showAllObtentionLevels)
               {
                  componentsRef.btn_obtention.visible = true;
                  if(this._highlightedSpellIds.indexOf(data.spellLevel.spellId) != -1)
                  {
                     componentsRef.lbl_obtentionLevel.cssClass = "orangecenter";
                  }
                  else
                  {
                     componentsRef.lbl_obtentionLevel.cssClass = "center";
                  }
               }
               else
               {
                  componentsRef.btn_obtention.visible = false;
               }
            }
         }
         else
         {
            componentsRef.btn_obtention.visible = false;
         }
      }
      
      public function updateSpellButtonsLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var spellCache:Object = null;
         var spellLevels:Array = null;
         var showObtentionLevels:Boolean = false;
         var levelsCount:int = 0;
         var i:int = 0;
         var isFirstObtentionLevel:Boolean = false;
         var areAllObtentionLevelsTheSame:Boolean = false;
         var spellLevelsWithFakes:Array = null;
         componentsRef.slot_icon.dropValidator = this.dropValidatorFunction;
         if(!this._componentsList[componentsRef.btn_spell.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_spell,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.btn_spell,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_spell,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_spell.name] = data;
         this._componentsList[componentsRef.slot_icon.name] = data;
         if(!this._componentsList[componentsRef.tx_lock.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_lock,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_lock,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.tx_lock.name] = !!data ? data.spellLevelInfos.minPlayerLevel : 0;
         if(data)
         {
            spellCache = this._allSpellCache[data];
            if(!spellCache)
            {
               spellCache = {};
               this._allSpellCache[data] = spellCache;
               spellCache.lbl_spellName_text = data.name;
               if(this.sysApi.getPlayerManager().hasRights)
               {
                  spellCache.lbl_spellName_text += " (" + data.id + ")";
               }
               spellLevels = (data as SpellWrapper).spell.spellLevelsInfo as Array;
               showObtentionLevels = false;
               if(spellLevels[spellLevels.length - 1].minPlayerLevel > 1)
               {
                  showObtentionLevels = true;
               }
               spellCache.spellLevels = [];
               levelsCount = spellLevels.length;
               areAllObtentionLevelsTheSame = true;
               for(i = 0; i < levelsCount; i++)
               {
                  isFirstObtentionLevel = this._playerLevel < spellLevels[i].minPlayerLevel && i == 0;
                  spellCache.spellLevels[i] = {
                     "spellLevel":spellLevels[i],
                     "isFirstLevel":isFirstObtentionLevel
                  };
                  if(areAllObtentionLevelsTheSame && (levelsCount == 1 || i + 1 < levelsCount && spellLevels[i].minPlayerLevel != spellLevels[i + 1].minPlayerLevel))
                  {
                     areAllObtentionLevelsTheSame = false;
                  }
               }
               if(showObtentionLevels && areAllObtentionLevelsTheSame)
               {
                  showObtentionLevels = false;
               }
               spellCache.showObtentionLevels = showObtentionLevels;
            }
            componentsRef.lbl_spellName.text = spellCache.lbl_spellName_text;
            if(spellCache.spellLevels[0] && spellCache.spellLevels[0].spellLevel.minPlayerLevel > this._playerLevel)
            {
               componentsRef.btn_spell.greyedOut = true;
               componentsRef.slot_icon.allowDrag = false;
               componentsRef.slot_icon.softDisabled = true;
               componentsRef.tx_lock.visible = true;
               componentsRef.lbl_spellName.width = componentsRef.tx_lock.x - componentsRef.lbl_spellName.x - 5;
            }
            else
            {
               componentsRef.btn_spell.greyedOut = false;
               componentsRef.slot_icon.softDisabled = false;
               componentsRef.tx_lock.visible = false;
               componentsRef.lbl_spellName.width = componentsRef.tx_lock.x + componentsRef.tx_lock.width - componentsRef.lbl_spellName.x;
               componentsRef.slot_icon.allowDrag = data.variantActivated;
            }
            componentsRef.ctr_newSpell.visible = this._highlightedSpellIds.indexOf(data.id) != -1;
            componentsRef.btn_spell.selected = data.variantActivated;
            if(spellCache.showObtentionLevels)
            {
               if(spellCache.spellLevels.length > 1)
               {
                  componentsRef.gd_obtentionLevels.dataProvider = spellCache.spellLevels;
               }
               else
               {
                  spellLevelsWithFakes = [null,spellCache.spellLevels[0],null];
                  componentsRef.gd_obtentionLevels.dataProvider = spellLevelsWithFakes;
               }
            }
            else
            {
               componentsRef.gd_obtentionLevels.dataProvider = [];
            }
            componentsRef.btn_spell.softDisabled = false;
            componentsRef.btn_spell.visible = true;
            if(!componentsRef.slot_icon.data || componentsRef.slot_icon.data.gfxId != data.gfxId)
            {
               componentsRef.slot_icon.data = data;
            }
            componentsRef.slot_icon.selected = false;
         }
         else
         {
            this._componentsList[componentsRef.tx_lock.name] = 0;
            componentsRef.btn_spell.selected = false;
            componentsRef.lbl_spellName.text = "";
            componentsRef.slot_icon.data = null;
            componentsRef.btn_spell.softDisabled = true;
            componentsRef.gd_obtentionLevels.dataProvider = [];
            componentsRef.btn_spell.reset();
            componentsRef.btn_spell.visible = false;
         }
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints(this.currentTabName);
      }
      
      private function getSpellTypesForCombobox() : Array
      {
         var variant:Array = null;
         var alreadyIn:Boolean = false;
         var typeId:uint = 0;
         var typeSpell:Object = null;
         var spellTypes:Array = [];
         spellTypes.push({
            "label":this.uiApi.getText("ui.common.allTypes"),
            "value":uint.MAX_VALUE
         });
         for each(variant in this._spells)
         {
            alreadyIn = false;
            typeId = variant[0].spell.typeId;
            for each(typeSpell in spellTypes)
            {
               if(typeSpell.value == typeId)
               {
                  alreadyIn = true;
               }
            }
            if(!alreadyIn)
            {
               spellTypes.push({
                  "label":this.dataApi.getSpellType(typeId).longName,
                  "value":typeId
               });
            }
         }
         return spellTypes;
      }
      
      private function updateSpellGrid(force:Boolean = false) : void
      {
         var spellWrapper:SpellWrapper = null;
         var variants:Array = null;
         var spellLevelInfos:SpellLevel = null;
         this._allSpellCache = new Dictionary();
         var DP:Array = [];
         var hash:* = "";
         var i:int = 0;
         for each(variants in this._spells)
         {
            if(this._showSpellTypeId == uint.MAX_VALUE || variants[0].spell.typeId == this._showSpellTypeId)
            {
               DP.push(variants);
            }
            for each(spellWrapper in variants)
            {
               if(spellWrapper && spellWrapper.spell && (this._showSpellTypeId == uint.MAX_VALUE || variants[0].spell.typeId == this._showSpellTypeId))
               {
                  spellLevelInfos = spellWrapper.spellLevelInfos;
                  hash += spellLevelInfos.id;
                  if(spellLevelInfos.grade <= 1 && spellLevelInfos.minPlayerLevel > this._playerLevel)
                  {
                     hash += "x";
                  }
                  hash += "-";
                  if(this._spellIdToShow != -1 && this._spellIdToShow == spellWrapper.id)
                  {
                     this._scrollPosition = i;
                     this._spellIdToShow = -1;
                     force = true;
                  }
               }
            }
            i++;
         }
         if(this._spellsHash != hash || force)
         {
            this.gd_spell.dataProvider = DP;
            if(this._scrollPosition != -1)
            {
               this.gd_spell.moveTo(this._scrollPosition,true);
               this._scrollPosition = -1;
            }
            this._spellsHash = hash;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var spellWrapper:SpellWrapper = null;
         var selectionAllowed:Boolean = false;
         var spellVariants:Array = null;
         var variantAvailableCount:int = 0;
         var itsTheRightVariantsList:Boolean = false;
         var sw:SpellWrapper = null;
         if(target.name.indexOf("btn_spell") != -1 || target.name.indexOf("slot_icon") != -1)
         {
            spellWrapper = this._componentsList[target.name];
            if(spellWrapper == null)
            {
               return;
            }
            if(spellWrapper.spellLevelInfos.minPlayerLevel > this._playerLevel)
            {
               return;
            }
            selectionAllowed = false;
            for each(spellVariants in this.gd_spell.dataProvider)
            {
               if(!(!spellVariants || spellVariants.length <= 1))
               {
                  variantAvailableCount = 0;
                  itsTheRightVariantsList = false;
                  for each(sw in spellVariants)
                  {
                     if(sw.id == spellWrapper.id)
                     {
                        itsTheRightVariantsList = true;
                     }
                     if(sw.spellLevelInfos.minPlayerLevel <= this._playerLevel)
                     {
                        variantAvailableCount++;
                     }
                  }
                  if(itsTheRightVariantsList && variantAvailableCount > 1)
                  {
                     selectionAllowed = true;
                     break;
                  }
               }
            }
            if(selectionAllowed)
            {
               this.sysApi.sendAction(new SpellVariantActivationRequestAction([spellWrapper.id]));
            }
         }
         else if(target == this.btn_showAllObtentionLevels)
         {
            this._showAllObtentionLevels = this.btn_showAllObtentionLevels.selected;
            Grimoire.getInstance().spellShowAllObtentionLevel = this._showAllObtentionLevels;
            this.updateSpellGrid(true);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.cb_spellType)
         {
            this._showSpellTypeId = this.cb_spellType.dataProvider[(target as ComboBox).selectedIndex].value;
            switch(selectMethod)
            {
               case SelectMethodEnum.CLICK:
               case SelectMethodEnum.UP_ARROW:
               case SelectMethodEnum.DOWN_ARROW:
               case SelectMethodEnum.WHEEL:
                  this.updateSpellGrid();
            }
         }
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         this.modContextMenu.createContextMenu(this.menuApi.create(item.data,"spell",[{"advanced":true}]));
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:Object = null;
         var spellItem:SpellWrapper = null;
         var btnSpellName:String = null;
         var btnSpellNameArray:Array = null;
         var i:int = 0;
         var spellWrapper:SpellWrapper = null;
         var isWeapon:Boolean = false;
         var settings:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var setting:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         var tooltipText:String = "";
         if(target.name.indexOf("btn_obtention") != -1)
         {
            data = this._componentsList[target.name];
            spellItem = this.dataApi.getSpellWrapper(data.spellLevel.spellId,data.spellLevel.grade);
            btnSpellName = "";
            btnSpellNameArray = target.name.replace("btn_obtention","btn_spell").split("m");
            for(i = 0; i < 4; i++)
            {
               btnSpellName += btnSpellNameArray[i] + "m";
            }
            this.uiApi.showTooltip(spellItem,this.uiApi.me().getElement(btnSpellName.substr(0,btnSpellName.length - 2)),false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{"footer":false},null,false,SpellBase.getInstance().getTooltipStrata());
            if(!target.softDisabled)
            {
               Grimoire.getInstance().removeSpellIdToHighlight(data.spellLevel.spellId);
            }
         }
         else if(target.name.indexOf("tx_lock") != -1)
         {
            data = this._componentsList[target.name];
            tooltipText = this.uiApi.getText("ui.spell.unlockAtRequiredLevel",data);
         }
         else if(target.name.indexOf("btn_spell") != -1 || target.name.indexOf("slot_icon") != -1)
         {
            spellWrapper = this._componentsList[target.name];
            if(spellWrapper == null)
            {
               return;
            }
            isWeapon = spellWrapper.isSpellWeapon;
            if(isWeapon)
            {
               settings = {};
               itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
               if(itemTooltipSettings == null)
               {
                  itemTooltipSettings = this.tooltipApi.createItemSettings();
                  this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
               }
               for each(setting in this.sysApi.getObjectVariables(itemTooltipSettings))
               {
                  settings[setting] = itemTooltipSettings[setting];
               }
               settings.ref = target;
               data = this.tooltipApi.getWeaponTooltipInfo(spellWrapper,null,settings);
               this.uiApi.showTooltip(data,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{
                  "footer":true,
                  "isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus")
               },null,false,SpellBase.getInstance().getTooltipStrata());
            }
            else
            {
               this.uiApi.showTooltip(spellWrapper,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,{
                  "footer":true,
                  "isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus")
               },null,false,SpellBase.getInstance().getTooltipStrata());
            }
            if(!target.softDisabled)
            {
               Grimoire.getInstance().removeSpellIdToHighlight(spellWrapper.id);
            }
            return;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo",false,SpellBase.getInstance().getTooltipStrata());
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip(TOOLTIP_SPELL_TAB);
         this.sysApi.dispatchHook(CustomUiHookList.SpellMovementAllowed,false);
      }
      
      private function onSpellsToHighlightUpdate(newSpellIdsToHighlight:Array) : void
      {
         var spellWrapperArray:Array = null;
         var i:int = 0;
         var spell:SpellWrapper = null;
         var isNewHighlighted:* = false;
         var isAlreadyHighlighted:* = false;
         var indexToUpdate:Array = [];
         for(i = 0; i < this.gd_spell.dataProvider.length; i++)
         {
            spellWrapperArray = this.gd_spell.dataProvider[i];
            for each(spell in spellWrapperArray)
            {
               isNewHighlighted = newSpellIdsToHighlight.indexOf(spell.id) != -1;
               isAlreadyHighlighted = this._highlightedSpellIds.indexOf(spell.id) != -1;
               if(isAlreadyHighlighted && !isNewHighlighted || !isAlreadyHighlighted && isNewHighlighted)
               {
                  indexToUpdate.push(i);
               }
            }
         }
         this._highlightedSpellIds = newSpellIdsToHighlight.concat();
         for each(i in indexToUpdate)
         {
            this.gd_spell.updateItem(i);
         }
      }
      
      private function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void
      {
         if(!oneLifePointRegenOnly)
         {
            this.gd_spell.updateItems();
         }
      }
      
      private function onSpellVariantActivated(activatedSpellId:uint, deactivatedSpellId:uint) : void
      {
         this.sysApi.log(2,"Activation de " + activatedSpellId + "    (précédent " + deactivatedSpellId + ")");
         var spellsLength:int = this.gd_spell.dataProvider.length;
         for(var i:int = 0; i < spellsLength; i++)
         {
            if(this.gd_spell.dataProvider[i] && (this.gd_spell.dataProvider[i][0].id == activatedSpellId || this.gd_spell.dataProvider[i][0].id == deactivatedSpellId))
            {
               this.gd_spell.updateItem(i);
               return;
            }
         }
      }
      
      private function onCharacterLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array) : void
      {
         this._playerLevel = pNewLevel;
         this.onSpellsList(null);
      }
      
      public function onSpellsList(spellList:Object) : void
      {
         if(this._breedSpellsListMode)
         {
            this._spells = Grimoire.getInstance().currentBreedSpells;
         }
         else
         {
            this._spells = Grimoire.getInstance().currentSpecialSpells;
         }
         if(this.sysApi.getPlayerManager().hasRights)
         {
            this.cb_spellType.dataProvider = this.getSpellTypesForCombobox();
            this.cb_spellType.selectedIndex = 0;
         }
         this.updateSpellGrid();
      }
      
      public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object) : Boolean
      {
         return false;
      }
      
      public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object) : void
      {
         iSlotDataHolder.data = data;
      }
   }
}
