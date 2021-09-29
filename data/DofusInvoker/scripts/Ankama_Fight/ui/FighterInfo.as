package Ankama_Fight.ui
{
   import Ankama_GameUiCore.ui.BannerMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   
   public class FighterInfo
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_entity:GraphicContainer;
      
      public var btn_spectatorPanel:ButtonContainer;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lbl_name:Label;
      
      public var lbl_lifePoints:Label;
      
      public var lbl_shieldPoints:Label;
      
      public var lbl_actionPoints:Label;
      
      public var lbl_movementPoints:Label;
      
      public var lbl_action:Label;
      
      public var lbl_movement:Label;
      
      public var lbl_tackle:Label;
      
      public var lbl_criticalDmgReduction:Label;
      
      public var lbl_pushDmgReduction:Label;
      
      public var lbl_neutralPercent:Label;
      
      public var lbl_strengthPercent:Label;
      
      public var lbl_intelligencePercent:Label;
      
      public var lbl_chancePercent:Label;
      
      public var lbl_agilityPercent:Label;
      
      public var lbl_neutral:Label;
      
      public var lbl_strength:Label;
      
      public var lbl_intelligence:Label;
      
      public var lbl_chance:Label;
      
      public var lbl_agility:Label;
      
      public var tx_shieldPoints:Texture;
      
      public var tx_actionPoints:Texture;
      
      public var tx_movementPoints:Texture;
      
      public var tx_action:Texture;
      
      public var tx_movement:Texture;
      
      public var tx_tackle:Texture;
      
      public var tx_criticalDmgReduction:Texture;
      
      public var tx_pushDmgReduction:Texture;
      
      public var tx_neutralPercent:Texture;
      
      public var tx_strengthPercent:Texture;
      
      public var tx_intelligencePercent:Texture;
      
      public var tx_chancePercent:Texture;
      
      public var tx_agilityPercent:Texture;
      
      public var tx_neutral:Texture;
      
      public var tx_strength:Texture;
      
      public var tx_intelligence:Texture;
      
      public var tx_chance:Texture;
      
      public var tx_agility:Texture;
      
      private var _fighterId:Number;
      
      private var _lastFighterId:Number;
      
      private var _stats:Dictionary;
      
      private var _textureByLabel:Dictionary;
      
      public function FighterInfo()
      {
         this._stats = new Dictionary();
         this._textureByLabel = new Dictionary();
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(FightHookList.FighterInfoUpdate,this.onFighterInfoUpdate);
         this.sysApi.addHook(FightHookList.SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(FightHookList.SpectatorWantLeave,this.onSpectatorWantLeave);
         this.sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         this.mainCtr.visible = false;
         this.entityDisplayer.useFade = false;
         this._textureByLabel[this.lbl_shieldPoints] = this.tx_shieldPoints;
         this._textureByLabel[this.lbl_actionPoints] = this.tx_actionPoints;
         this._textureByLabel[this.lbl_movementPoints] = this.tx_movementPoints;
         this._textureByLabel[this.lbl_action] = this.tx_action;
         this._textureByLabel[this.lbl_movement] = this.tx_movement;
         this._textureByLabel[this.lbl_tackle] = this.tx_tackle;
         this._textureByLabel[this.lbl_criticalDmgReduction] = this.tx_criticalDmgReduction;
         this._textureByLabel[this.lbl_pushDmgReduction] = this.tx_pushDmgReduction;
         this._textureByLabel[this.lbl_neutralPercent] = this.tx_neutralPercent;
         this._textureByLabel[this.lbl_strengthPercent] = this.tx_strengthPercent;
         this._textureByLabel[this.lbl_intelligencePercent] = this.tx_intelligencePercent;
         this._textureByLabel[this.lbl_chancePercent] = this.tx_chancePercent;
         this._textureByLabel[this.lbl_agilityPercent] = this.tx_agilityPercent;
         this._textureByLabel[this.lbl_neutral] = this.tx_neutral;
         this._textureByLabel[this.lbl_strength] = this.tx_strength;
         this._textureByLabel[this.lbl_intelligence] = this.tx_intelligence;
         this._textureByLabel[this.lbl_chance] = this.tx_chance;
         this._textureByLabel[this.lbl_agility] = this.tx_agility;
         this.forceLabelUpdate();
      }
      
      public function unload() : void
      {
         var bannerUi:BannerMenu = this.uiApi.getUi("bannerMenu").uiClass;
         bannerUi.gd_btnUis.mouseChildren = true;
      }
      
      private function forceLabelUpdate() : void
      {
         var ls:String = null;
         var letterSpacing:int = 0;
         if(this.sysApi.getActiveFontType() == "smallScreen" && this.lbl_lifePoints.aStyleObj && this.lbl_lifePoints.aStyleObj[this.lbl_lifePoints.cssClass])
         {
            ls = this.lbl_lifePoints.aStyleObj[this.lbl_lifePoints.cssClass].letterSpacing;
            letterSpacing = parseInt(ls.substring(0,ls.indexOf("px")));
            this.lbl_lifePoints.updateTextFormatProperty("letterSpacing",letterSpacing);
         }
      }
      
      private function showEntityDisplayer() : void
      {
         this.entityDisplayer.look = this.fightApi.getFighterInformations(this._fighterId).look;
         this.entityDisplayer.setAnimationAndDirection("AnimStatique",1);
         this.entityDisplayer.visible = true;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_spectatorPanel)
         {
            if(!this.uiApi.getUi("spectatorPanel"))
            {
               this.sysApi.dispatchHook(FightHookList.SpectateUpdate,0,"","");
               this.btn_spectatorPanel.selected = true;
            }
            else
            {
               this.uiApi.unloadUi("spectatorPanel");
               this.btn_spectatorPanel.selected = false;
            }
         }
      }
      
      private function updateStatText(label:Label, text:String, isAPercent:Boolean = false) : void
      {
         if(text == "0")
         {
            label.cssClass = "fighterinfodisabled";
            this._textureByLabel[label].disabled = true;
         }
         else
         {
            label.cssClass = "fighterinfo";
            this._textureByLabel[label].disabled = false;
         }
         if(isAPercent)
         {
            text += "%";
         }
         label.text = text;
      }
      
      public function onFontActiveTypeChanged() : void
      {
         this.forceLabelUpdate();
      }
      
      public function onFighterInfoUpdate(infos:Object = null) : void
      {
         var mouseOverEntityInfos:GameFightFighterInformations = null;
         var mouseOverEntity:Boolean = false;
         var mouseOverTimelineEntity:Boolean = false;
         var mouseOverTimelineEntityId:Number = NaN;
         var stats:EntityStats = null;
         var nameText:* = null;
         var level:int = 0;
         var breedText:String = null;
         var lifePoints:Number = NaN;
         var maxLifePoints:Number = NaN;
         var shieldPoints:Number = NaN;
         var actionPoints:Number = NaN;
         var movementPoints:Number = NaN;
         var dodgePALostProbability:Number = NaN;
         var dodgePMLostProbability:Number = NaN;
         var tackleBlock:Number = NaN;
         var criticalDamageFixedResist:Number = NaN;
         var pushDamageFixedResist:Number = NaN;
         var globalResistPercent:Number = NaN;
         var neutralElementResistPercent:Number = NaN;
         var earthElementResistPercent:Number = NaN;
         var fireElementResistPercent:Number = NaN;
         var waterElementResistPercent:Number = NaN;
         var airElementResistPercent:Number = NaN;
         var neutralElementReduction:Number = NaN;
         var earthElementReduction:Number = NaN;
         var fireElementReduction:Number = NaN;
         var waterElementReduction:Number = NaN;
         var airElementReduction:Number = NaN;
         var bannerUi:BannerMenu = this.uiApi.getUi("bannerMenu").uiClass;
         if(infos && !this.fightApi.preFightIsActive())
         {
            mouseOverEntityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(FightContextFrame.fighterEntityTooltipId) as GameFightFighterInformations;
            mouseOverEntity = mouseOverEntityInfos && mouseOverEntityInfos.disposition.cellId == FightContextFrame.currentCell;
            mouseOverTimelineEntity = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).timelineOverEntity;
            mouseOverTimelineEntityId = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame).timelineOverEntityId;
            if(this.fightApi.isSpectator() && this.sysApi.getOption("spectatorAutoShowCurrentFighterInfo","dofus") && (mouseOverEntity && this._fighterId == mouseOverEntityInfos.contextualId || mouseOverTimelineEntity && this._fighterId == mouseOverTimelineEntityId))
            {
               return;
            }
            stats = StatsManager.getInstance().getStats(infos.contextualId);
            bannerUi.gd_btnUis.mouseChildren = false;
            if(this.fightApi.isSpectator() && this.sysApi.getOption("spectatorAutoShowCurrentFighterInfo","dofus"))
            {
               this.btn_spectatorPanel.visible = false;
            }
            if(stats !== null)
            {
               this.entityDisplayer.disabled = stats.getHealthPoints() <= 0;
            }
            nameText = this.fightApi.getFighterName(infos.contextualId) + "  ";
            level = this.fightApi.getFighterLevel(infos.contextualId);
            if(infos.contextualId > 0 && level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               nameText += this.uiApi.getText("ui.common.short.prestige") + (level - ProtocolConstantsEnum.MAX_LEVEL);
            }
            else
            {
               nameText += this.uiApi.getText("ui.common.short.level") + level;
            }
            if(infos.hasOwnProperty("breed") && infos.breed > 0)
            {
               breedText = this.dataApi.getBreed(infos.breed).shortName;
               nameText += " - " + breedText;
            }
            this.lbl_name.text = nameText;
            this._lastFighterId = this._fighterId;
            this._fighterId = infos.contextualId;
            if(stats !== null)
            {
               lifePoints = stats.getHealthPoints();
               maxLifePoints = stats.getMaxHealthPoints();
               if(this._stats["lifePoints"] != lifePoints || this._stats["maxLifePoints"] != maxLifePoints)
               {
                  this._stats["lifePoints"] = lifePoints;
                  this._stats["maxLifePoints"] = maxLifePoints;
                  this.updateLifePoints();
               }
               shieldPoints = stats.getStatTotalValue(StatIds.SHIELD);
               if(this._stats["shieldPoints"] != shieldPoints)
               {
                  this._stats["shieldPoints"] = shieldPoints;
                  this.updateShieldPoints();
               }
               actionPoints = stats.getStatTotalValue(StatIds.ACTION_POINTS);
               if(this._stats["fighterUsedAP"] != actionPoints)
               {
                  this._stats["fighterUsedAP"] = actionPoints;
                  this.updateStatText(this.lbl_actionPoints,this._stats["fighterUsedAP"]);
               }
               movementPoints = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS);
               if(this._stats["movementPoints"] != movementPoints)
               {
                  this._stats["movementPoints"] = movementPoints;
                  this.updateStatText(this.lbl_movementPoints,this._stats["movementPoints"]);
               }
               dodgePALostProbability = stats.getStatTotalValue(StatIds.DODGE_PA_LOST_PROBABILITY);
               if(this._stats["dodgePALostProbability"] != dodgePALostProbability)
               {
                  this._stats["dodgePALostProbability"] = dodgePALostProbability;
                  this.updateStatText(this.lbl_action,dodgePALostProbability.toString());
               }
               dodgePMLostProbability = stats.getStatTotalValue(StatIds.DODGE_PM_LOST_PROBABILITY);
               if(this._stats["dodgePMLostProbability"] != dodgePMLostProbability)
               {
                  this._stats["dodgePMLostProbability"] = dodgePMLostProbability;
                  this.updateStatText(this.lbl_movement,this._stats["dodgePMLostProbability"]);
               }
               tackleBlock = stats.getStatTotalValue(StatIds.TACKLE_BLOCK);
               if(this._stats["tackleBlock"] != tackleBlock)
               {
                  this._stats["tackleBlock"] = tackleBlock;
                  this.updateStatText(this.lbl_tackle,this._stats["tackleBlock"] > 0 ? this._stats["tackleBlock"].toString() : "0");
               }
               criticalDamageFixedResist = stats.getStatTotalValue(StatIds.CRITICAL_DAMAGE_REDUCTION);
               if(this._stats["criticalDamageReduction"] != criticalDamageFixedResist)
               {
                  this._stats["criticalDamageReduction"] = criticalDamageFixedResist;
                  this.updateStatText(this.lbl_criticalDmgReduction,this._stats["criticalDamageReduction"]);
               }
               pushDamageFixedResist = stats.getStatTotalValue(StatIds.PUSH_DAMAGE_REDUCTION);
               if(this._stats["pushDamageReduction"] != pushDamageFixedResist)
               {
                  this._stats["pushDamageReduction"] = pushDamageFixedResist;
                  this.updateStatText(this.lbl_pushDmgReduction,this._stats["pushDamageReduction"]);
               }
               globalResistPercent = stats.getStatTotalValue(StatIds.RESIST_PERCENT);
               neutralElementResistPercent = stats.getStatTotalValue(StatIds.NEUTRAL_ELEMENT_RESIST_PERCENT) + globalResistPercent;
               earthElementResistPercent = stats.getStatTotalValue(StatIds.EARTH_ELEMENT_RESIST_PERCENT) + globalResistPercent;
               fireElementResistPercent = stats.getStatTotalValue(StatIds.FIRE_ELEMENT_RESIST_PERCENT) + globalResistPercent;
               waterElementResistPercent = stats.getStatTotalValue(StatIds.WATER_ELEMENT_RESIST_PERCENT) + globalResistPercent;
               airElementResistPercent = stats.getStatTotalValue(StatIds.AIR_ELEMENT_RESIST_PERCENT) + globalResistPercent;
               neutralElementReduction = stats.getStatTotalValue(StatIds.NEUTRAL_ELEMENT_REDUCTION);
               earthElementReduction = stats.getStatTotalValue(StatIds.EARTH_ELEMENT_REDUCTION);
               fireElementReduction = stats.getStatTotalValue(StatIds.FIRE_ELEMENT_REDUCTION);
               waterElementReduction = stats.getStatTotalValue(StatIds.WATER_ELEMENT_REDUCTION);
               airElementReduction = stats.getStatTotalValue(StatIds.AIR_ELEMENT_REDUCTION);
               if(infos is GameFightCharacterInformations || infos is GameFightEntityInformation)
               {
                  this._stats["neutralPercent"] = neutralElementResistPercent > 50 ? 50 : neutralElementResistPercent;
                  this._stats["strengthPercent"] = earthElementResistPercent > 50 ? 50 : earthElementResistPercent;
                  this._stats["intelligencePercent"] = fireElementResistPercent > 50 ? 50 : fireElementResistPercent;
                  this._stats["chancePercent"] = waterElementResistPercent > 50 ? 50 : waterElementResistPercent;
                  this._stats["agilityPercent"] = airElementResistPercent > 50 ? 50 : airElementResistPercent;
                  this._stats["neutral"] = neutralElementReduction;
                  this._stats["strength"] = earthElementReduction;
                  this._stats["intelligence"] = fireElementReduction;
                  this._stats["chance"] = waterElementReduction;
                  this._stats["agility"] = airElementReduction;
               }
               else
               {
                  this._stats["neutralPercent"] = neutralElementResistPercent;
                  this._stats["strengthPercent"] = earthElementResistPercent;
                  this._stats["intelligencePercent"] = fireElementResistPercent;
                  this._stats["chancePercent"] = waterElementResistPercent;
                  this._stats["agilityPercent"] = airElementResistPercent;
                  this._stats["neutral"] = neutralElementReduction;
                  this._stats["strength"] = earthElementReduction;
                  this._stats["intelligence"] = fireElementReduction;
                  this._stats["chance"] = waterElementReduction;
                  this._stats["agility"] = airElementReduction;
               }
            }
            this.updateResistance();
            this.mainCtr.visible = true;
            if(this.entityDisplayer.look != this.fightApi.getFighterInformations(this._fighterId).look)
            {
               this.showEntityDisplayer();
            }
         }
         else
         {
            if(this.entityDisplayer.entity)
            {
               this.entityDisplayer.entity.stopAnimation();
            }
            bannerUi.gd_btnUis.mouseChildren = true;
            this.mainCtr.visible = false;
         }
      }
      
      private function updateLifePoints() : void
      {
         this.lbl_lifePoints.text = this._stats["lifePoints"] + " / " + this._stats["maxLifePoints"];
      }
      
      private function updateShieldPoints() : void
      {
         this.updateStatText(this.lbl_shieldPoints,this._stats["shieldPoints"]);
      }
      
      private function updateResistance() : void
      {
         this.updateStatText(this.lbl_neutralPercent,this._stats["neutralPercent"],true);
         this.updateStatText(this.lbl_strengthPercent,this._stats["strengthPercent"],true);
         this.updateStatText(this.lbl_intelligencePercent,this._stats["intelligencePercent"],true);
         this.updateStatText(this.lbl_chancePercent,this._stats["chancePercent"],true);
         this.updateStatText(this.lbl_agilityPercent,this._stats["agilityPercent"],true);
         this.updateStatText(this.lbl_neutral,this._stats["neutral"]);
         this.updateStatText(this.lbl_strength,this._stats["strength"]);
         this.updateStatText(this.lbl_intelligence,this._stats["intelligence"]);
         this.updateStatText(this.lbl_chance,this._stats["chance"]);
         this.updateStatText(this.lbl_agility,this._stats["agility"]);
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void
      {
         this.btn_spectatorPanel.selected = true;
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         this.btn_spectatorPanel.visible = false;
      }
      
      private function onSpectatorWantLeave() : void
      {
         this.btn_spectatorPanel.visible = false;
      }
   }
}
