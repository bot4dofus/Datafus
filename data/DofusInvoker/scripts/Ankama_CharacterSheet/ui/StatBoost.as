package Ankama_CharacterSheet.ui
{
   import Ankama_CharacterSheet.CharacterSheet;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.StatsUpgradeRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.BoostableCharacteristicEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import damageCalculation.tools.StatIds;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class StatBoost
   {
       
      
      public const LEFT_POSITION:String = "left";
      
      public const RIGHT_POSITION:String = "right";
      
      public const CENTER_POSITION:String = "center";
      
      public const LINKED_UI_ADDITIONAL_WIDTH:int = 40;
      
      public const LINKED_UI_OVERLAP_WIDTH:int = 68;
      
      public const CONTAINERS_VERTICAL_MARGING:int = 20;
      
      public const BLOCK_BORDER_HEIGHT:int = 7;
      
      public const WINDOW_BORDERS_HEIGHT:int = 70;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      private var _characterStats:EntityStats;
      
      private var _statId:uint;
      
      private var _stat:String;
      
      private var _statName:String;
      
      private var _statPointsName:String;
      
      private var _someStatsCanBeScrolled:Boolean;
      
      private var _statPointsAdded:uint = 0;
      
      private var _pointsUsed:uint = 0;
      
      private var _capital:uint;
      
      private var _base:uint;
      
      private var _baseFloor:uint;
      
      private var _currentFloor:uint;
      
      private var _rest:uint;
      
      private var _maxScrollPointsBeforeLimit:uint;
      
      private var _statFloorValueAndCostInBoostForOneStatPoint:Array;
      
      private var _hasAdditionalPoints:Boolean = true;
      
      private var _statVariableAssoc:Dictionary;
      
      private var _statSpells:Array;
      
      private var _characterSheetUi;
      
      private var _characterSheetUiX:Number = 0;
      
      private var _characterSheetUiY:Number = 0;
      
      private var _currentPosition:String = "";
      
      private var _waitingForWidthResize:Boolean = false;
      
      private var _waitingForHeightResize:Boolean = false;
      
      private var _rightUIBtnHelpX:int;
      
      private var _rightUIBtnCloseX:int;
      
      private var _windowWidth:int;
      
      private var _tooltipStrata:int = 4;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_window:GraphicContainer;
      
      public var ctr_block:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var gd_statVariables:Grid;
      
      public var ctr_spells:GraphicContainer;
      
      public var gd_statSpells:Grid;
      
      public var lbl_availablePoints:Label;
      
      public var ctr_capitalChoice:GraphicContainer;
      
      public var btn_radioStat:ButtonContainer;
      
      public var btn_radioScroll:ButtonContainer;
      
      public var ctr_radioStat:GraphicContainer;
      
      public var ctr_radioScroll:GraphicContainer;
      
      public var ctr_calculation:GraphicContainer;
      
      public var inp_pointsValue:Input;
      
      public var btn_less:ButtonContainer;
      
      public var btn_more:ButtonContainer;
      
      public var lbl_capitalStat:Label;
      
      public var lbl_capitalScroll:Label;
      
      public var lbl_statName:Label;
      
      public var lbl_statBase:Label;
      
      public var lbl_statBaseAdd:Label;
      
      public var lbl_statBonus:Label;
      
      public var lbl_statTotal:Label;
      
      public var lbl_currentFloor:Label;
      
      public var tx_floor_info:Texture;
      
      public var ctr_footer:GraphicContainer;
      
      public var btn_valid:ButtonContainer;
      
      public function StatBoost()
      {
         super();
      }
      
      public function main(stat:Array) : void
      {
         if(this.uiApi.me().strata == StrataEnum.STRATA_MAX)
         {
            this._tooltipStrata = StrataEnum.STRATA_SUPERMAX;
         }
         this.uiApi.addComponentHook(this.inp_pointsValue,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.ctr_radioStat,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_radioScroll,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_radioScroll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_radioScroll,ComponentHookList.ON_ROLL_OUT);
         this.sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(HookList.ContextChanged,this.onContextChanged);
         this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
         this._statVariableAssoc = new Dictionary();
         this._waitingForWidthResize = true;
         this.inp_pointsValue.restrictChars = "0-9";
         this.tx_floor_info.dispatchMessages = true;
         this._windowWidth = this.ctr_window.width;
         this.uiApi.addComponentHook(this.tx_floor_info,"onTextureReady");
         if(stat[3])
         {
            this._currentPosition = this.CENTER_POSITION;
         }
         if(this._currentPosition != this.CENTER_POSITION)
         {
            this.sysApi.addEventListener(this.onEnterFrame,"StatBoost");
            this._characterSheetUi = this.uiApi.getUi("characterSheetUi");
            this.uiApi.me().setOnTopAfterMe.push(this._characterSheetUi);
         }
         this.displayUI(stat[0],stat[1],stat[2],stat[3]);
      }
      
      public function displayUI(statKeyword:String, statId:int, someStatsCanBeScrolled:Boolean, uiIsIndependant:Boolean = false) : void
      {
         var spellWrapper:SpellWrapper = null;
         var statAdditionnalPoints:int = 0;
         var statPoints:uint = 0;
         var pointsUsed:uint = 0;
         var currentFloor:int = 0;
         var i:int = 0;
         this._stat = statKeyword;
         this._statId = statId;
         this._someStatsCanBeScrolled = someStatsCanBeScrolled;
         if(uiIsIndependant)
         {
            this._currentPosition = this.CENTER_POSITION;
         }
         var me:UiRootContainer = this.uiApi.me();
         this._statName = this.uiApi.getText("ui.stats." + this._stat);
         this._statPointsName = "ui.stats." + this._stat + "Points";
         this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
         this._base = this._characterStats !== null ? uint(this._characterStats.getStatBaseValue(this._statId)) : uint(0);
         this.lbl_title.text = this._statName;
         this.inp_pointsValue.text = "0";
         this.tx_floor_info.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.ui.skin") + "texture/help_icon_normal.png");
         var statVariables:Vector.<StatVariable> = new Vector.<StatVariable>();
         switch(this._statId)
         {
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_VITALITY:
               statVariables.push(new StatVariable("tx_lifePoints",this.uiApi.getText("ui.stats.lifePoints")));
               break;
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_WISDOM:
               statVariables.push(new StatVariable("tx_attackAP",this.uiApi.getText("ui.stats.PAAttack")),new StatVariable("tx_attackMP",this.uiApi.getText("ui.stats.PMAttack")),new StatVariable("tx_dodgeAP",this.uiApi.getText("ui.stats.dodgeAP")),new StatVariable("tx_dodgeMP",this.uiApi.getText("ui.stats.dodgeMP")));
               break;
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_STRENGTH:
               statVariables.push(new StatVariable("tx_strength",this.uiApi.getText("ui.stats.earthDamage")),new StatVariable("tx_neutral",this.uiApi.getText("ui.stats.neutralDamage")),new StatVariable("tx_pods",this.uiApi.getText("ui.common.weight")),new StatVariable("tx_initiative",this.uiApi.getText("ui.stats.initiative")));
               break;
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE:
               statVariables.push(new StatVariable("tx_intelligence",this.uiApi.getText("ui.stats.fireDamage")),new StatVariable("tx_heal",this.uiApi.getText("ui.stats.healBonus")),new StatVariable("tx_initiative",this.uiApi.getText("ui.stats.initiative")));
               break;
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_CHANCE:
               statVariables.push(new StatVariable("tx_chance",this.uiApi.getText("ui.stats.waterDamage")),new StatVariable("tx_prospecting",this.uiApi.getText("ui.stats.prospecting")),new StatVariable("tx_initiative",this.uiApi.getText("ui.stats.initiative")));
               break;
            case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_AGILITY:
               statVariables.push(new StatVariable("tx_agility",this.uiApi.getText("ui.stats.airDamage")),new StatVariable("tx_tackle",this.uiApi.getText("ui.stats.takleBlock")),new StatVariable("tx_escape",this.uiApi.getText("ui.stats.takleEvade")),new StatVariable("tx_initiative",this.uiApi.getText("ui.stats.initiative")));
         }
         this.gd_statVariables.dataProvider = statVariables;
         this._statSpells = [];
         var playerSpells:Array = this.playerApi.getSpellInventory();
         for each(spellWrapper in playerSpells)
         {
            if(spellWrapper.id != 0 && this.utilApi.isCharacteristicSpell(spellWrapper,this._statId))
            {
               this._statSpells.push(this.dataApi.getSpellWrapper(spellWrapper.id,spellWrapper.spellLevel));
            }
         }
         if(this._statSpells.length == 0)
         {
            this.ctr_spells.visible = false;
         }
         else
         {
            this.ctr_spells.visible = true;
         }
         this.gd_statSpells.dataProvider = this._statSpells;
         this._statFloorValueAndCostInBoostForOneStatPoint = new Array();
         this.displayFloors();
         var noAdditionalPoints:Boolean = this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS) == 0 || !this._someStatsCanBeScrolled;
         this.lbl_availablePoints.visible = noAdditionalPoints;
         if(noAdditionalPoints)
         {
            this.ctr_capitalChoice.visible = false;
            this._capital = this._characterStats.getStatBaseValue(StatIds.STATS_POINTS);
            this.displayPoints();
            this.inp_pointsValue.focus();
            this.inp_pointsValue.setSelection(0,8388607);
         }
         else
         {
            statAdditionnalPoints = this._characterStats.getStatAdditionalValue(this._statId);
            if(CharacterSheet.getInstance().statPointsBoostType == 0 || statAdditionnalPoints >= ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
            {
               this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup",this.btn_radioStat,me);
            }
            else
            {
               this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup",this.btn_radioScroll,me);
            }
            statPoints = 0;
            pointsUsed = 0;
            for(i = 0; i < this._statFloorValueAndCostInBoostForOneStatPoint.length; i++)
            {
               if(this._statFloorValueAndCostInBoostForOneStatPoint[i + 1] && this._statFloorValueAndCostInBoostForOneStatPoint[i + 1][0] > statAdditionnalPoints && this._statFloorValueAndCostInBoostForOneStatPoint[i][0] <= statAdditionnalPoints || !this._statFloorValueAndCostInBoostForOneStatPoint[i + 1])
               {
                  currentFloor = i;
                  break;
               }
            }
            while(statPoints + statAdditionnalPoints < ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
            {
               pointsUsed += this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor][1];
               if(this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor].length > 2)
               {
                  statPoints += int(this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor][2]);
               }
               else
               {
                  statPoints++;
               }
               if(this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor + 1] && statPoints + statAdditionnalPoints >= this._statFloorValueAndCostInBoostForOneStatPoint[currentFloor + 1][0])
               {
                  currentFloor++;
               }
            }
            this._maxScrollPointsBeforeLimit = pointsUsed;
            this.updatePointsType();
            if(statAdditionnalPoints >= ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC)
            {
               this.btn_radioScroll.disabled = true;
               this.ctr_radioScroll.softDisabled = true;
               this.lbl_capitalScroll.cssClass = "disabledboldright";
            }
            else
            {
               this.btn_radioScroll.disabled = false;
               this.ctr_radioScroll.softDisabled = false;
               this.lbl_capitalScroll.cssClass = "whiteboldright";
            }
         }
         this._hasAdditionalPoints = !noAdditionalPoints;
         this._waitingForHeightResize = true;
         if(me.disableRender)
         {
            this.sysApi.addEventListener(this.onEnterFrame,"StatBoost");
         }
         else
         {
            if(this._currentPosition != this.CENTER_POSITION && this._waitingForWidthResize)
            {
               this.resize();
            }
            this.resizeVertically();
         }
      }
      
      public function setBlockHeight(pValue:Number) : void
      {
         var me:UiRootContainer = this.uiApi.me();
         me.getElement("tx_background_block").height = pValue;
         me.getElement("tx_border_frame_block").height = pValue;
         me.getElement("tx_scratch_block").height = pValue;
      }
      
      public function setWindowHeight(pValue:Number) : void
      {
         var element:Object = null;
         var elementSprite:Object = null;
         var elementName:* = null;
         var me:UiRootContainer = this.uiApi.me();
         this.ctr_window.height = pValue;
         var elements:Object = me.getElements();
         for(elementName in elements)
         {
            elementSprite = elements[elementName];
            if(elementSprite.getParent() == this.ctr_window)
            {
               element = me.getElementById(elementName);
               if(element.size && element.size.yUnit == 1)
               {
                  elementSprite.height = this.ctr_window.height;
               }
            }
         }
      }
      
      public function setWindowWidth(pValue:Number) : void
      {
         var element:Object = null;
         var elementSprite:Object = null;
         var elementName:* = null;
         var leftPositionOffsetX:int = 0;
         var me:UiRootContainer = this.uiApi.me();
         this.ctr_window.width = pValue;
         var elements:Object = me.getElements();
         for(elementName in elements)
         {
            elementSprite = elements[elementName];
            if(elementSprite.getParent() == this.ctr_window)
            {
               element = me.getElementById(elementName);
               if(element.size && element.size.xUnit == 1)
               {
                  elementSprite.width = this.ctr_window.width;
               }
            }
         }
         me.processLocation(me.getElementById("tx_border_frame_ctr_window"));
         me.processLocation(me.getElementById("tx_background_ctr_window"));
         me.processLocation(me.getElementById("tx_title_bar_ctr_window"));
         leftPositionOffsetX = 0;
         if(this._currentPosition == this.LEFT_POSITION)
         {
            leftPositionOffsetX = -this.LINKED_UI_ADDITIONAL_WIDTH;
         }
         this.btn_help.xNoCache = pValue - this.btn_help.width - 60 + leftPositionOffsetX;
         this.btn_close.xNoCache = pValue - this.btn_help.width - 30 + leftPositionOffsetX;
         me.getElement("tx_title_bar_right_ctr_window").xNoCache = pValue - me.getElement("tx_title_bar_right_ctr_window").width - 5;
         this._rightUIBtnHelpX = this.btn_help.x;
         this._rightUIBtnCloseX = this.btn_close.x;
      }
      
      public function get statId() : uint
      {
         return this._statId;
      }
      
      public function unload() : void
      {
         var characterSheet:UiRootContainer = this.uiApi.getUi("characterSheetUi");
         if(characterSheet && characterSheet.uiClass)
         {
            characterSheet.uiClass.restoreChildIndex();
         }
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var rect:Rectangle = null;
         if(this._waitingForHeightResize && !this.uiApi.me().disableRender)
         {
            if(this._currentPosition != this.CENTER_POSITION && this._waitingForWidthResize)
            {
               this.resize();
            }
            this.resizeVertically();
            if(this._currentPosition == this.CENTER_POSITION)
            {
               this.sysApi.removeEventListener(this.onEnterFrame);
            }
         }
         if(!this._characterSheetUi)
         {
            return;
         }
         var characterSheetUiRect:Rectangle = this._characterSheetUi.getStageRect();
         if(characterSheetUiRect.x != this._characterSheetUiX || characterSheetUiRect.y != this._characterSheetUiY)
         {
            rect = this.uiApi.getVisibleStageBounds();
            if(characterSheetUiRect.x + characterSheetUiRect.width + this.mainCtr.width - rect.x < rect.width)
            {
               if(this._currentPosition != this.RIGHT_POSITION)
               {
                  this.ctr_block.xNoCache = this.LINKED_UI_ADDITIONAL_WIDTH;
                  this.btn_help.xNoCache = this._rightUIBtnHelpX;
                  this.btn_close.xNoCache = this._rightUIBtnCloseX;
                  this._currentPosition = this.RIGHT_POSITION;
               }
               this.mainCtr.x = characterSheetUiRect.x + characterSheetUiRect.width - this.LINKED_UI_OVERLAP_WIDTH;
            }
            else
            {
               if(this._currentPosition != this.LEFT_POSITION)
               {
                  this.ctr_block.xNoCache = 0;
                  this.btn_help.xNoCache = this._rightUIBtnHelpX - this.LINKED_UI_ADDITIONAL_WIDTH;
                  this.btn_close.xNoCache = this._rightUIBtnCloseX - this.LINKED_UI_ADDITIONAL_WIDTH;
                  this._currentPosition = this.LEFT_POSITION;
               }
               this.mainCtr.x = characterSheetUiRect.x - this.mainCtr.width + this.LINKED_UI_OVERLAP_WIDTH;
            }
            this.mainCtr.y = characterSheetUiRect.y + characterSheetUiRect.height - this.ctr_window.height - this.CONTAINERS_VERTICAL_MARGING;
            this._characterSheetUiX = characterSheetUiRect.x;
            this._characterSheetUiY = characterSheetUiRect.y;
         }
         this.mainCtr.visible = true;
      }
      
      private function resize() : void
      {
         var me:UiRootContainer = this.uiApi.me();
         if(me.disableRender)
         {
            return;
         }
         this.setWindowWidth(this._windowWidth + this.LINKED_UI_ADDITIONAL_WIDTH);
         this._waitingForWidthResize = false;
      }
      
      private function resizeVertically() : void
      {
         var pointsY:int = 0;
         var calculationY:int = 0;
         var footerY:int = 0;
         var characterSheetUiRect:Rectangle = null;
         var statGridHeight:int = this.gd_statVariables.slotHeight * this.gd_statVariables.dataProvider.length;
         var spellY:int = this.gd_statVariables.y + statGridHeight + this.CONTAINERS_VERTICAL_MARGING;
         if(this.ctr_spells.visible)
         {
            this.ctr_spells.y = spellY;
            pointsY = this.ctr_spells.y + this.ctr_spells.height + this.CONTAINERS_VERTICAL_MARGING;
         }
         else
         {
            pointsY = spellY;
         }
         if(this._hasAdditionalPoints)
         {
            this.ctr_capitalChoice.y = pointsY;
            calculationY = pointsY + this.ctr_capitalChoice.height + this.CONTAINERS_VERTICAL_MARGING;
         }
         else
         {
            this.lbl_availablePoints.y = pointsY;
            calculationY = pointsY + this.lbl_availablePoints.height + this.CONTAINERS_VERTICAL_MARGING;
         }
         this.ctr_calculation.y = calculationY;
         this.setBlockHeight(calculationY + this.ctr_calculation.height + this.CONTAINERS_VERTICAL_MARGING + 2 * this.BLOCK_BORDER_HEIGHT);
         footerY = calculationY + this.ctr_calculation.height + this.CONTAINERS_VERTICAL_MARGING + this.BLOCK_BORDER_HEIGHT;
         this.ctr_footer.y = footerY;
         this.setWindowHeight(this.ctr_footer.y + this.ctr_footer.height + this.WINDOW_BORDERS_HEIGHT);
         var me:UiRootContainer = this.uiApi.me();
         me.processLocation(me.getElementById("tx_border_frame_ctr_window"));
         me.processLocation(me.getElementById("tx_background_ctr_window"));
         if(this._currentPosition != this.CENTER_POSITION && this._characterSheetUi)
         {
            characterSheetUiRect = this._characterSheetUi.getStageRect();
            this.mainCtr.y = characterSheetUiRect.y + characterSheetUiRect.height - this.ctr_window.height - this.CONTAINERS_VERTICAL_MARGING;
         }
         this._waitingForHeightResize = false;
         this.mainCtr.visible = true;
      }
      
      private function updatePointsType() : void
      {
         var maxPoints:int = 0;
         if(this.btn_radioStat.selected)
         {
            CharacterSheet.getInstance().statPointsBoostType = 0;
            this._capital = this._characterStats.getStatBaseValue(StatIds.STATS_POINTS);
            this.ctr_radioScroll.bgAlpha = 0;
            this.ctr_radioStat.bgAlpha = 1;
            this.lbl_capitalScroll.text = this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS).toString();
            this._base = this._characterStats.getStatBaseValue(this._statId);
            this.updateBaseFloor();
            if(this._pointsUsed > this._capital)
            {
               this.inp_pointsValue.text = this._capital.toString();
            }
         }
         else
         {
            CharacterSheet.getInstance().statPointsBoostType = 1;
            this._capital = this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS);
            this.ctr_radioScroll.bgAlpha = 1;
            this.ctr_radioStat.bgAlpha = 0;
            this.lbl_capitalStat.text = this._characterStats.getStatBaseValue(StatIds.STATS_POINTS).toString();
            this._base = this._characterStats.getStatAdditionalValue(this._statId);
            this.updateBaseFloor();
            maxPoints = this._capital;
            if(this.ctr_capitalChoice.visible && this.btn_radioScroll.selected && maxPoints > this._maxScrollPointsBeforeLimit)
            {
               maxPoints = this._maxScrollPointsBeforeLimit;
            }
            if(this._pointsUsed > maxPoints)
            {
               this.inp_pointsValue.text = maxPoints.toString();
            }
         }
         this.displayPoints();
         this.inp_pointsValue.focus();
         this.inp_pointsValue.setSelection(0,8388607);
      }
      
      private function validatePointsChoice() : void
      {
         var text:String = null;
         if(this._pointsUsed > 0)
         {
            if(this._rest != 0)
            {
               text = this.uiApi.getText("ui.charaSheet.evolutionWarn",this._pointsUsed,this._pointsUsed - this._rest,this._rest);
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupSendBoost,this.onPopupClose],this.onPopupSendBoost,this.onPopupClose,null,false,false,true,null,this.uiApi.me().strata);
            }
            else
            {
               this.sysApi.sendAction(new StatsUpgradeRequestAction([this.ctr_capitalChoice.visible && !this.btn_radioStat.selected,this._statId,this._pointsUsed]));
               this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
      }
      
      private function addStatPoint(point:int) : void
      {
         var currentFloorModif:int = 0;
         var boostPoints:uint = 0;
         var maxPoints:int = 0;
         if(point > 0)
         {
            boostPoints = this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + currentFloorModif][1] - this._rest;
            maxPoints = this._capital;
            if(this.ctr_capitalChoice.visible && this.btn_radioScroll.selected && maxPoints > this._maxScrollPointsBeforeLimit)
            {
               maxPoints = this._maxScrollPointsBeforeLimit;
            }
            if(maxPoints < this._pointsUsed + boostPoints)
            {
               return;
            }
            this._pointsUsed += boostPoints;
         }
         else
         {
            boostPoints = this._rest;
            if(this._pointsUsed == 0)
            {
               maxPoints = this._capital;
               if(this.ctr_capitalChoice.visible && this.btn_radioScroll.selected && maxPoints > this._maxScrollPointsBeforeLimit)
               {
                  maxPoints = this._maxScrollPointsBeforeLimit;
               }
               this._pointsUsed = maxPoints;
               this.inp_pointsValue.text = this._pointsUsed.toString();
            }
            else
            {
               if(this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor - 1] && this._statPointsAdded + this._base - 1 < this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][0])
               {
                  currentFloorModif = -1;
               }
               if(boostPoints == 0)
               {
                  boostPoints = this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + currentFloorModif][1];
               }
               if(this._pointsUsed < boostPoints)
               {
                  return;
               }
               this._pointsUsed -= boostPoints;
            }
         }
         this.inp_pointsValue.text = this._pointsUsed.toString();
         this.displayPoints();
      }
      
      private function displayPoints() : void
      {
         var statPoints:uint = 0;
         var pointsUsed:uint = this._pointsUsed;
         this._currentFloor = this._baseFloor;
         while(pointsUsed >= this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1])
         {
            pointsUsed -= this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1];
            if(this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor].length > 2)
            {
               statPoints += int(this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][2]);
            }
            else
            {
               statPoints++;
            }
            if(this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + 1] && statPoints + this._base >= this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor + 1][0])
            {
               ++this._currentFloor;
            }
         }
         this._rest = pointsUsed;
         if(this.ctr_capitalChoice.visible)
         {
            if(this.btn_radioStat.selected)
            {
               this.lbl_capitalStat.text = String(this._characterStats.getStatBaseValue(StatIds.STATS_POINTS) - this._pointsUsed);
            }
            else
            {
               this.lbl_capitalScroll.text = String(this._characterStats.getStatAdditionalValue(StatIds.STATS_POINTS) - this._pointsUsed);
            }
         }
         this._statPointsAdded = statPoints;
         this.lbl_availablePoints.text = this.uiApi.getText("ui.stat.availablePoints",this._characterStats.getStatBaseValue(StatIds.STATS_POINTS) - this._pointsUsed);
         this.lbl_statName.text = this._statName;
         this.lbl_statBase.text = this._characterStats.getStatBaseValue(this._statId).toString();
         this.lbl_statBaseAdd.text = "+" + this._statPointsAdded;
         var bonus:int = this._characterStats.getStatAdditionalValue(this._statId) + this._characterStats.getStatObjectsAndMountBonusValue(this._statId);
         this.lbl_statBonus.text = String(bonus);
         this.lbl_statTotal.text = String(this._characterStats.getStatBaseValue(this._statId) + this._statPointsAdded + bonus);
         this.lbl_currentFloor.text = this.uiApi.processText(this.uiApi.getText("ui.stats.floorPointsForStat",this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1],1,this._statName),"",this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1] <= 1,this._statFloorValueAndCostInBoostForOneStatPoint[this._currentFloor][1] == 0);
         if(this.tx_floor_info.finalized)
         {
            this.updateTxFloorPosition();
         }
      }
      
      private function displayFloors() : void
      {
         var statpoints:Vector.<Vector.<uint>> = null;
         var nbBoostForOneCaracPointAndFloor:Vector.<uint> = null;
         switch(this._stat)
         {
            case "vitality":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForVitality;
               break;
            case "wisdom":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForWisdom;
               break;
            case "strength":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForStrength;
               break;
            case "intelligence":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForIntelligence;
               break;
            case "chance":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForChance;
               break;
            case "agility":
               statpoints = this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed).statsPointsForAgility;
         }
         for each(nbBoostForOneCaracPointAndFloor in statpoints)
         {
            this._statFloorValueAndCostInBoostForOneStatPoint.push(nbBoostForOneCaracPointAndFloor);
         }
         this.updateBaseFloor();
      }
      
      private function updateBaseFloor() : void
      {
         for(var i:int = 0; i < this._statFloorValueAndCostInBoostForOneStatPoint.length; i++)
         {
            if(this._statFloorValueAndCostInBoostForOneStatPoint[i + 1] && this._statFloorValueAndCostInBoostForOneStatPoint[i + 1][0] > this._base && this._statFloorValueAndCostInBoostForOneStatPoint[i][0] <= this._base || !this._statFloorValueAndCostInBoostForOneStatPoint[i + 1])
            {
               this._baseFloor = i;
               break;
            }
         }
      }
      
      private function updateTxFloorPosition() : void
      {
         this.tx_floor_info.x = this.lbl_currentFloor.textfield.getLineMetrics(0).x + this.lbl_currentFloor.textfield.textWidth + this.tx_floor_info.width + 5;
      }
      
      public function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void
      {
         this._characterStats = StatsManager.getInstance().getStats(this.playerApi.id());
         this._base = this._characterStats.getStatBaseValue(this._statId);
         this.displayPoints();
      }
      
      private function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         if(context == "fight")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onTextureReady(target:Texture) : void
      {
         if(target == this.tx_floor_info)
         {
            this.updateTxFloorPosition();
         }
      }
      
      public function updateStatVariable(data:Object, components:*, selected:Boolean) : void
      {
         var nameSplit:Array = null;
         if(data)
         {
            components.tx_variable.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + data.gfxId);
            components.lbl_variable.text = data.text;
            nameSplit = components.lbl_variable.customUnicName.split("_");
            this._statVariableAssoc[components.lbl_variable] = {
               "data":data,
               "index":parseInt(nameSplit[nameSplit.length - 1])
            };
         }
         else
         {
            components.tx_variable.uri = null;
            components.lbl_variable.text = "";
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_valid:
               this.validatePointsChoice();
               break;
            case this.btn_less:
               this.addStatPoint(-1);
               break;
            case this.btn_more:
               this.addStatPoint(1);
               break;
            case this.btn_radioStat:
               this.updatePointsType();
               break;
            case this.ctr_radioStat:
               this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup",this.btn_radioStat,this.uiApi.me());
               this.updatePointsType();
               break;
            case this.btn_radioScroll:
               this.updatePointsType();
               break;
            case this.ctr_radioScroll:
               this.uiApi.setRadioGroupSelectedItem("capitalChoiceGroup",this.btn_radioScroll,this.uiApi.me());
               this.updatePointsType();
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var bonusIndex:uint = 0;
         var statAmount:uint = 0;
         var bonusAmount:uint = 0;
         var statTotal:uint = 0;
         if(target == this.tx_floor_info)
         {
            this.uiApi.showTooltip({
               "statName":this._statName,
               "floors":this._statFloorValueAndCostInBoostForOneStatPoint
            },target,false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOP,3,"statFloors",null,null,null,false,this._tooltipStrata);
         }
         else if(target == this.ctr_radioScroll && this.ctr_radioScroll.softDisabled)
         {
            text = this.uiApi.getText("ui.charaSheet.noBoostIfMaxReached",ProtocolConstantsEnum.MAX_ADDITIONNAL_PER_CARAC);
         }
         else if(target == this.lbl_statBonus)
         {
            text = this.uiApi.getText("ui.stats.bonuses");
         }
         else if(target.customUnicName.indexOf("lbl_variable") != -1 && this._statVariableAssoc[target])
         {
            bonusIndex = this._statVariableAssoc[target].index;
            statTotal = this._characterStats.getStatBaseValue(this._statId) + this._characterStats.getStatAdditionalValue(this._statId) + this._characterStats.getStatObjectsAndMountBonusValue(this._statId);
            switch(this._statId)
            {
               case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_WISDOM:
                  statAmount = 10;
                  bonusAmount = 1;
                  break;
               case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_STRENGTH:
                  statAmount = 1;
                  if(bonusIndex == 2)
                  {
                     bonusAmount = 5;
                  }
                  else
                  {
                     if(bonusIndex != 3)
                     {
                        return;
                     }
                     bonusAmount = 1;
                  }
                  break;
               case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_CHANCE:
                  bonusAmount = 1;
                  if(bonusIndex == 1)
                  {
                     statAmount = 10;
                  }
                  else
                  {
                     if(bonusIndex != 2)
                     {
                        return;
                     }
                     statAmount = 1;
                  }
                  break;
               case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_AGILITY:
                  bonusAmount = 1;
                  if(bonusIndex == 1 || bonusIndex == 2)
                  {
                     statAmount = 10;
                  }
                  else
                  {
                     if(bonusIndex != 3)
                     {
                        return;
                     }
                     statAmount = 1;
                  }
                  break;
               case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE:
                  if(bonusIndex == 2)
                  {
                     statAmount = bonusAmount = 1;
                     break;
                  }
                  return;
            }
            if(bonusAmount > 0)
            {
               text = this.uiApi.getText("ui.stats.statIncreases.tooltip",this.uiApi.processText(this.uiApi.getText(this._statPointsName,statAmount),"",statAmount <= 1,statAmount == 0),bonusAmount,(target as Label).text,this.uiApi.processText(this.uiApi.getText(this._statPointsName,statTotal),"",statTotal <= 1,statAmount == 0));
            }
         }
         if(!text)
         {
            return;
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo",false,this._tooltipStrata);
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var spellWrapper:SpellWrapper = null;
         if(item.data)
         {
            spellWrapper = this.playerApi.getSpell(item.data.id);
            if(spellWrapper == null)
            {
               return;
            }
            this.uiApi.showTooltip(spellWrapper,item.container,false,"standard",0,2,3,null,null,null,null,false,this._tooltipStrata);
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:Grid, item:GridItem) : void
      {
         this.modContextMenu.createContextMenu(this.menuApi.create(item.data,"spell"));
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.validatePointsChoice();
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         var input:String = null;
         var maxPoints:int = 0;
         if(target == this.inp_pointsValue)
         {
            input = this.inp_pointsValue.text;
            if(input)
            {
               this._pointsUsed = int(input);
            }
            else
            {
               this._pointsUsed = 0;
            }
            maxPoints = this._capital;
            if(this.ctr_capitalChoice.visible && this.btn_radioScroll.selected && maxPoints > this._maxScrollPointsBeforeLimit)
            {
               maxPoints = this._maxScrollPointsBeforeLimit;
            }
            if(this._pointsUsed > maxPoints)
            {
               this.inp_pointsValue.text = maxPoints.toString();
            }
            else
            {
               this.displayPoints();
            }
         }
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupSendBoost() : void
      {
         this.sysApi.sendAction(new StatsUpgradeRequestAction([this.ctr_capitalChoice.visible && !this.btn_radioStat.selected,this._statId,this._pointsUsed - this._rest]));
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function isSpellActive(pData:SpellWrapper) : Boolean
      {
         return this.dataApi.getSpellLevelBySpell(pData.spell,1).minPlayerLevel <= this.playerApi.getPlayedCharacterInfo().level;
      }
   }
}

class StatVariable
{
    
   
   public var gfxId:String;
   
   public var text:String;
   
   function StatVariable(pGfxId:String, pText:String)
   {
      super();
      this.gfxId = pGfxId;
      this.text = pText;
   }
}
