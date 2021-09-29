package Ankama_Dungeon.ui
{
   import Ankama_Dungeon.enum.EnumRoomDifficulty;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breach.BreachDungeonModificator;
   import com.ankamagames.dofus.datacenter.misc.BreachPrize;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.breach.BreachBranchWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRoomUnlockAction;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.LuaApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class BreachBossSelection
   {
       
      
      private const BUDGET_AND_FRAGMENTS_OFFET:int = -2;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="LuaApi")]
      public var luaApi:LuaApi;
      
      private var _componentsList:Dictionary;
      
      public var ctr_window:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var gd_bosses:Grid;
      
      public var btn_close:ButtonContainer;
      
      public function BreachBossSelection()
      {
         this._componentsList = new Dictionary(true);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.addHook(BreachHookList.BreachBranchesList,this.onBreachBranchesList);
         this.sysApi.addHook(BreachHookList.BreachBuyRoom,this.onUnlockRoom);
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         if(this.sysApi.hasWorldInteraction())
         {
            this.sysApi.disableWorldInteraction();
         }
         if(oParam)
         {
            this.lbl_title.text = this.uiApi.getText("ui.breach.guardians",this.breachApi.getFloor());
            if(oParam.branches.length <= 3)
            {
               this.ctr_window.height = this.uiApi.me().getConstant("heightFewBosses");
               this.gd_bosses.height = this.uiApi.me().getConstant("gridHeightFewBosses");
               if(oParam.branches.length < 3)
               {
                  this.ctr_window.width = this.uiApi.me().getConstant("widthTwoBosses");
                  this.gd_bosses.width = this.uiApi.me().getConstant("gridWidthTwoBosses");
               }
               else
               {
                  this.ctr_window.width = this.uiApi.me().getConstant("widthManyBosses");
                  this.gd_bosses.width = this.uiApi.me().getConstant("gridWidthManyBosses");
               }
            }
            else
            {
               this.ctr_window.height = this.uiApi.me().getConstant("heightManyBosses");
               this.ctr_window.width = this.uiApi.me().getConstant("widthManyBosses");
               this.gd_bosses.height = this.uiApi.me().getConstant("gridHeightManyBosses");
               this.gd_bosses.width = this.uiApi.me().getConstant("gridWidthManyBosses");
            }
            this.gd_bosses.dataProvider = oParam.branches;
            this.uiApi.me().render();
         }
         else
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         if(this.uiApi.getUi("breachShop"))
         {
            this.uiApi.unloadUi("breachShop");
         }
         if(!this.sysApi.hasWorldInteraction())
         {
            this.sysApi.enableWorldInteraction();
         }
      }
      
      public function updateBosses(data:*, componentsRef:*, selected:Boolean) : void
      {
         var difficulty:uint = 0;
         var priceStr:String = null;
         var newSize:Number = NaN;
         var marginCurrency:Number = NaN;
         var margin:Number = NaN;
         var newButtonX:Number = NaN;
         var toMoveX:Number = NaN;
         if(!this._componentsList[componentsRef.lbl_diffScore.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_diffScore,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_diffScore,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.lbl_diffScore.name] = data;
         if(!this._componentsList[componentsRef.tx_slot.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_slot,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_slot,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.tx_slot.name] = data;
         if(!this._componentsList[componentsRef.ed_bossAlone.name])
         {
            this.uiApi.addComponentHook(componentsRef.ed_bossAlone,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ed_bossAlone,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.ed_bossAlone.name] = data;
         if(!this._componentsList[componentsRef.ed_boss1.name])
         {
            this.uiApi.addComponentHook(componentsRef.ed_boss1,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ed_boss1,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.ed_boss1.name] = data;
         if(!this._componentsList[componentsRef.ed_boss2.name])
         {
            this.uiApi.addComponentHook(componentsRef.ed_boss2,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ed_boss2,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.ed_boss2.name] = data;
         if(data)
         {
            componentsRef.ctr_buyRoom.visible = true;
            this._componentsList["ctr_buyRoom_" + String(data.room)] = componentsRef.ctr_buyRoom;
            componentsRef.lbl_bossName.text = this.dataApi.getMonsterFromId(data.bosses[0].genericId).name;
            componentsRef.tx_bossNumber.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "roman_numeral_" + data.room + ".png");
            componentsRef.lbl_diffScore.text = data.score;
            difficulty = this.luaApi.getScoreDifficulty(this.breachApi.getFloor(),data.score,data.relativeScore);
            if(difficulty == EnumRoomDifficulty.EASY_ROOM)
            {
               componentsRef.tx_background2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/slot_dark_background_easy.png");
            }
            else if(difficulty == EnumRoomDifficulty.HARD_ROOM)
            {
               componentsRef.tx_background2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/slot_dark_background_difficult.png");
            }
            else
            {
               componentsRef.tx_background2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "slot/slot_dark_background_medium.png");
            }
            if(data.bosses.length > 1)
            {
               componentsRef.lbl_bossName.text += " " + this.uiApi.getText("ui.common.and") + " " + this.dataApi.getMonsterFromId(data.bosses[1].genericId).name;
               componentsRef.tx_bossAlone.visible = false;
               componentsRef.ed_bossAlone.visible = false;
               componentsRef.ed_boss1.look = this.dataApi.getMonsterFromId(data.bosses[0].genericId).look;
               componentsRef.ed_boss2.look = this.dataApi.getMonsterFromId(data.bosses[1].genericId).look;
               componentsRef.tx_boss1.visible = true;
               componentsRef.ed_boss1.visible = true;
               componentsRef.tx_boss2.visible = true;
               componentsRef.ed_boss2.visible = true;
            }
            else
            {
               componentsRef.tx_boss1.visible = false;
               componentsRef.ed_boss1.visible = false;
               componentsRef.tx_boss2.visible = false;
               componentsRef.ed_boss2.visible = false;
               componentsRef.ed_bossAlone.look = this.dataApi.getMonsterFromId(data.bosses[0].genericId).look;
               componentsRef.ed_bossAlone.visible = true;
               componentsRef.tx_bossAlone.visible = true;
            }
            componentsRef.gd_bonuses.dataProvider = data.rewards.sort(this.breachApi.sortByPriceDescending);
            if(data.modifier >= 0)
            {
               data.modifierObj = this.dataApi.getSpellPair(data.modifier);
            }
            if(data.modifierObj)
            {
               componentsRef.tx_slot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("spells_uri") + data.modifierObj.iconId);
            }
            else
            {
               componentsRef.tx_slot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "/slot/emptySlot.png");
            }
            componentsRef.blk_bossChoice.visible = true;
            componentsRef.ctr_buyRoom.visible = data.isLocked;
            if(data.isLocked)
            {
               priceStr = this.utilApi.kamasToString(data.unlockPrice,"");
               componentsRef.lbl_buyRoom.text = priceStr;
               newSize = this.uiApi.getTextSize(componentsRef.lbl_buyRoom.text,componentsRef.lbl_buyRoom.css,componentsRef.lbl_buyRoom.cssClass).width + 5;
               marginCurrency = 6;
               margin = 10;
               newButtonX = this.gd_bosses.x + this.gd_bosses.slotWidth / 2 - componentsRef.btn_buyRoom.width / 2;
               toMoveX = newButtonX - componentsRef.btn_buyRoom.x;
               componentsRef.btn_buyRoom.x = newButtonX;
               componentsRef.lbl_buyRoom.x += toMoveX;
               componentsRef.lbl_buyRoom.width = newSize;
               componentsRef.tx_currency.x = componentsRef.lbl_buyRoom.x + newSize + marginCurrency;
               componentsRef.btn_buyRoom.width = newSize + componentsRef.tx_currency.width + marginCurrency + margin * 2;
               componentsRef.btn_buyRoom.finalize();
               this._componentsList[componentsRef.btn_buyRoom.name] = data;
               this.uiApi.addComponentHook(componentsRef.btn_buyRoom,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_buyRoom,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_buyRoom,ComponentHookList.ON_ROLL_OUT);
            }
         }
         else
         {
            componentsRef.blk_bossChoice.visible = false;
         }
      }
      
      public function updatePossiblePurchase(data:*, componentsRef:*, selected:Boolean) : void
      {
         var bp:BreachPrize = null;
         if(!this._componentsList[componentsRef.ctr_bonus.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_bonus,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ctr_bonus,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.ctr_bonus.name] = data;
         if(!this._componentsList[componentsRef.tx_bonusCurrency.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_bonusCurrency,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_bonusCurrency,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.tx_bonusCurrency.name] = data;
         if(data)
         {
            bp = this.dataApi.getBreachPrizeById(data.id);
            if(bp)
            {
               componentsRef.lbl_bonusName.text = bp.name;
               componentsRef.tx_bonusCurrency.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_spiral_grey.png");
               componentsRef.ctr_bonus.visible = true;
            }
         }
         else
         {
            componentsRef.ctr_bonus.visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            default:
               if(target.name.indexOf("btn_buyRoom") != 1 && this._componentsList[target.name])
               {
                  this.sysApi.sendAction(new BreachRoomUnlockAction([this._componentsList[target.name].room]));
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var ttData:Object = null;
         var breachDungeonModificator:BreachDungeonModificator = null;
         var spellTooltipSettings:SpellTooltipSettings = null;
         var monsterGroup:Vector.<MonsterInGroupLightInformations> = null;
         var branchInfo:Object = null;
         var rewardToObtain:Object = null;
         var toDisplay:Object = null;
         var locks:Vector.<uint> = null;
         var reward:BreachPrize = null;
         var prizeCurrency:* = false;
         var data:Object = null;
         var prize:BreachPrize = null;
         var dataCurrency:Object = null;
         if(target.name.indexOf("tx_slot") != -1)
         {
            if(this._componentsList[target.name])
            {
               if(this._componentsList[target.name].modifierObj)
               {
                  breachDungeonModificator = this.dataApi.getBreachDungeonModificator(this._componentsList[target.name].modifier);
                  spellTooltipSettings = this.tooltipApi.createSpellSettings();
                  spellTooltipSettings.header = true;
                  spellTooltipSettings.isTheoretical = this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus");
                  spellTooltipSettings.footer = false;
                  if(breachDungeonModificator && breachDungeonModificator.tooltipBaseline)
                  {
                     spellTooltipSettings.subtitle = this.uiApi.getText(breachDungeonModificator.tooltipBaseline);
                  }
                  this.uiApi.showTooltip(this.dataApi.getSpellPair(this._componentsList[target.name].modifier),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,0,null,null,spellTooltipSettings);
               }
               else
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.breach.noModifier")),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,0,null,null,"TextInfo");
               }
            }
         }
         else if(target.name.indexOf("ed_boss") != -1)
         {
            if(this._componentsList[target.name])
            {
               monsterGroup = this._componentsList[target.name].bosses.concat(this._componentsList[target.name].monsters);
               branchInfo = {
                  "monsterGroup":monsterGroup,
                  "score":this._componentsList[target.name].score,
                  "relativeScore":this._componentsList[target.name].relativeScore
               };
               this.uiApi.showTooltip(branchInfo,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"breachMonsterGroup",null,null,"BreachGroupMonsterCache");
            }
         }
         else if(target.name.indexOf("ctr_budget") != -1)
         {
            ttData = {
               "title":this.uiApi.getText("ui.breach.groupBudget"),
               "text":this.uiApi.getText("ui.breach.groupBudgetDescription")
            };
            this.uiApi.showTooltip(ttData,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"textWithTitle",null,null);
         }
         else if(target.name.indexOf("ctr_fragments") != -1)
         {
            ttData = {
               "title":this.uiApi.getText("ui.breach.fragments"),
               "text":this.uiApi.getText("ui.breach.fragmentsDescription")
            };
            this.uiApi.showTooltip(ttData,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"textWithTitle",null,null);
         }
         else if(target.name.indexOf("lbl_diffScore") != -1)
         {
            rewardToObtain = {};
            rewardToObtain.text = this.utilApi.kamasToString(0,"");
            rewardToObtain.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_spiral.png");
            toDisplay = {};
            toDisplay.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_spiral.png");
            toDisplay.title = this.uiApi.getText("ui.breach.roomHeader",this._componentsList[target.name].room,this.dataApi.getSubAreaFromMap(this._componentsList[target.name].map).name);
            toDisplay.text = this.uiApi.getText("ui.breach.difficultyScore",this._componentsList[target.name].score) + "\n\n" + this.uiApi.getText("ui.breach.rewardToObtain");
            toDisplay.reward = this.utilApi.kamasToString(this._componentsList[target.name].prize,"");
            toDisplay.iconOffset = {
               "x":0,
               "y":-3
            };
            toDisplay.texturePosition = "lastLine";
            this.uiApi.showTooltip(toDisplay,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOM,3,"breachRoom",null);
         }
         else if(target.name.indexOf("ctr_bonus") != -1)
         {
            locks = this._componentsList[target.name].buyLocks.concat();
            reward = this.dataApi.getBreachPrizeById(this._componentsList[target.name].id);
            if(!reward)
            {
               return;
            }
            prizeCurrency = !reward.currency;
            data = {
               "locks":locks,
               "criterion":this._componentsList[target.name].buyCriterion,
               "description":reward.description,
               "item":reward.item,
               "name":reward.name
            };
            this.uiApi.showTooltip(data,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"breachReward",null,{"isBudget":prizeCurrency});
         }
         else if(target.name.indexOf("tx_bonusCurrency") != -1)
         {
            prize = this.dataApi.getBreachPrizeById(this._componentsList[target.name].id);
            dataCurrency = {};
            dataCurrency.text = this.utilApi.kamasToString(this._componentsList[target.name].price,"");
            if(prize.currency == DataEnum.BREACH_REWARD_CURRENCY_BUDGET)
            {
               dataCurrency.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_spiral_grey.png");
            }
            else
            {
               dataCurrency.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_fragment.png");
            }
            this.uiApi.showTooltip(dataCurrency,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"textWithTexture",null,null);
         }
         else if(target.name.indexOf("btn_buyRoom") != -1)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.breach.roomDefeat")),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOP,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onBreachBranchesList(branches:Array) : void
      {
         this.gd_bosses.dataProvider = branches;
         this.uiApi.me().render();
      }
      
      private function onUnlockRoom(branches:Array) : void
      {
         var branch:BreachBranchWrapper = null;
         for each(branch in branches)
         {
            if(!branch.isLocked)
            {
               this._componentsList["ctr_buyRoom_" + String(branch.room)].visible = false;
            }
         }
      }
      
      protected function onShortCut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
