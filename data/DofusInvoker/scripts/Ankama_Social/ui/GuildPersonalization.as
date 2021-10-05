package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.utils.Dictionary;
   
   public class GuildPersonalization
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _allowModifyBoosts:Boolean;
      
      private var _boostPoints:uint = 0;
      
      private var _stats:Array;
      
      private var _compsBtnSpellUpgrade:Dictionary;
      
      private var _compsSpellSlot:Dictionary;
      
      public var gd_spell:Grid;
      
      public var btn_taxCollectorProspecting:ButtonContainer;
      
      public var btn_taxCollectorWisdom:ButtonContainer;
      
      public var btn_taxCollectorPods:ButtonContainer;
      
      public var btn_maxTaxCollectorsCount:ButtonContainer;
      
      public var lbl_boostPoints:Label;
      
      public var gd_stat:Grid;
      
      public var ed_pony:EntityDisplayer;
      
      public function GuildPersonalization()
      {
         this._compsBtnSpellUpgrade = new Dictionary(true);
         this._compsSpellSlot = new Dictionary(true);
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(SocialHookList.GuildInfosUpgrade,this.onGuildInfosUpgrade);
         this.sysApi.addHook(SocialHookList.GuildMembershipUpdated,this.onGuildMembershipUpdated);
         this.uiApi.addComponentHook(this.btn_taxCollectorProspecting,"onRelease");
         this.uiApi.addComponentHook(this.btn_taxCollectorProspecting,"onRollOver");
         this.uiApi.addComponentHook(this.btn_taxCollectorProspecting,"onRollOut");
         this.uiApi.addComponentHook(this.btn_taxCollectorWisdom,"onRelease");
         this.uiApi.addComponentHook(this.btn_taxCollectorWisdom,"onRollOver");
         this.uiApi.addComponentHook(this.btn_taxCollectorWisdom,"onRollOut");
         this.uiApi.addComponentHook(this.btn_taxCollectorPods,"onRelease");
         this.uiApi.addComponentHook(this.btn_taxCollectorPods,"onRollOver");
         this.uiApi.addComponentHook(this.btn_taxCollectorPods,"onRollOut");
         this.uiApi.addComponentHook(this.btn_maxTaxCollectorsCount,"onRelease");
         this.uiApi.addComponentHook(this.btn_maxTaxCollectorsCount,"onRollOver");
         this.uiApi.addComponentHook(this.btn_maxTaxCollectorsCount,"onRollOut");
         this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_BOOSTS]));
         var guild:GuildWrapper = this.socialApi.getGuild();
         this._allowModifyBoosts = guild.manageGuildBoosts;
         this.displayBtnBoost();
         var ponyLook:String = "{714|";
         ponyLook += this.dataApi.getEmblemSymbol(guild.upEmblem.idEmblem).skinId + "|";
         ponyLook += "7=" + guild.backEmblem.color + ",8=" + guild.upEmblem.color + "|110}";
         this.ed_pony.look = this.sysApi.getEntityLookFromString(ponyLook);
      }
      
      public function updateStatLine(data:*, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.lbl_title.text = data.text;
            components.lbl_value.text = data.value;
         }
         else
         {
            components.lbl_title.text = "";
            components.lbl_value.text = "";
         }
      }
      
      public function updateSpellLine(data:*, components:*, selected:Boolean) : void
      {
         var spell:Object = null;
         if(!this._compsBtnSpellUpgrade[components.btn_spellUpgrade.name])
         {
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsBtnSpellUpgrade[components.btn_spellUpgrade.name] = data;
         if(!this._compsSpellSlot[components.slot_icon.name])
         {
            this.uiApi.addComponentHook(components.slot_icon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_icon,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsSpellSlot[components.slot_icon.name] = data;
         if(data != null)
         {
            spell = this.dataApi.getSpell(data.spell.id);
            components.slot_icon.data = data.spell;
            components.lbl_spellName.text = spell.name;
            components.lbl_spellLevel.text = data.baseLevel;
            if(data.displayUpgrade && this._allowModifyBoosts)
            {
               components.btn_spellUpgrade.visible = true;
            }
            else
            {
               components.btn_spellUpgrade.visible = false;
            }
         }
         else
         {
            components.slot_icon = null;
            components.lbl_spellName.text = "";
            components.lbl_spellLevel.text = "";
            components.btn_spellUpgrade.visible = false;
         }
      }
      
      private function displayBtnBoost() : void
      {
         this.btn_taxCollectorProspecting.visible = this._boostPoints > 0 && this._allowModifyBoosts;
         this.btn_taxCollectorWisdom.visible = this._boostPoints > 0 && this._allowModifyBoosts;
         this.btn_taxCollectorPods.visible = this._boostPoints > 0 && this._allowModifyBoosts;
         this.btn_maxTaxCollectorsCount.visible = this._boostPoints > 9 && this._allowModifyBoosts;
      }
      
      private function onGuildInfosUpgrade(boostPoints:uint, maxTaxCollectorsCount:uint, spellId:Object, spellLevel:Object, taxCollectorDamagesBonuses:uint, taxCollectorLifePoints:uint, taxCollectorPods:uint, taxCollectorProspecting:uint, taxCollectorsCount:uint, taxCollectorWisdom:uint) : void
      {
         var baseLevel:int = 0;
         var level:int = 0;
         var showUpgradeBtn:* = false;
         var spellSize:int = spellId.length;
         var spellList:Array = new Array(spellSize);
         for(var s:int = 0; s < spellSize; s++)
         {
            baseLevel = spellLevel[s];
            level = baseLevel;
            showUpgradeBtn = boostPoints > 0;
            if(level == 0)
            {
               level = 1;
            }
            if(level == 5)
            {
               showUpgradeBtn = false;
            }
            spellList[s] = {
               "displayUpgrade":showUpgradeBtn,
               "spell":this.dataApi.getSpellWrapper(spellId[s],level),
               "baseLevel":baseLevel
            };
         }
         this.gd_spell.dataProvider = spellList;
         this.lbl_boostPoints.text = boostPoints.toString();
         this._stats = new Array();
         this._stats.push({
            "text":this.uiApi.getText("ui.common.lifePoints"),
            "value":taxCollectorLifePoints
         });
         this._stats.push({
            "text":this.uiApi.getText("ui.social.damagesBonus"),
            "value":taxCollectorDamagesBonuses
         });
         this._stats.push({
            "text":this.uiApi.getText("ui.social.discernment"),
            "value":taxCollectorProspecting
         });
         this._stats.push({
            "text":this.uiApi.getText("ui.stats.wisdom"),
            "value":taxCollectorWisdom
         });
         this._stats.push({
            "text":this.uiApi.getText("ui.common.weight"),
            "value":taxCollectorPods
         });
         this._stats.push({
            "text":this.uiApi.getText("ui.social.taxCollectorCount"),
            "value":maxTaxCollectorsCount
         });
         this.gd_stat.dataProvider = this._stats;
         this._boostPoints = boostPoints;
         this.displayBtnBoost();
      }
      
      private function onGuildMembershipUpdated(hasGuild:Boolean) : void
      {
         var myGuild:GuildWrapper = null;
         if(hasGuild)
         {
            myGuild = this.socialApi.getGuild();
            this._allowModifyBoosts = myGuild.manageGuildBoosts;
         }
         else
         {
            this._allowModifyBoosts = false;
         }
         this.displayBtnBoost();
         this.gd_spell.updateItems();
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         if(target == this.btn_taxCollectorPods)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequestAction([0]));
         }
         else if(target == this.btn_taxCollectorProspecting)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequestAction([1]));
         }
         else if(target == this.btn_taxCollectorWisdom)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequestAction([2]));
         }
         else if(target == this.btn_maxTaxCollectorsCount)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequestAction([3]));
         }
         else if(target.name.indexOf("btn_spellUpgrade") != -1)
         {
            data = this._compsBtnSpellUpgrade[target.name];
            this.sysApi.sendAction(new GuildSpellUpgradeRequestAction([data.spell.id]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:Object = null;
         var textTooltip:* = "";
         if(target == this.btn_taxCollectorProspecting)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,1,500);
         }
         else if(target == this.btn_taxCollectorWisdom)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,1,400);
         }
         else if(target == this.btn_taxCollectorPods)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,20,5000);
         }
         else if(target == this.btn_maxTaxCollectorsCount)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",10,1,50);
         }
         else if(target.name.indexOf("btn_spellUpgrade") != -1)
         {
            textTooltip = this.uiApi.getText("ui.common.cost") + this.uiApi.getText("ui.common.colon") + "5";
         }
         else if(target.name.indexOf("slot_icon") != -1)
         {
            data = this._compsSpellSlot[target.name];
            if(target != null && data != null)
            {
               this.uiApi.showTooltip(data.spell as SpellWrapper,target,false,"standard",2,0,0);
            }
         }
         if(textTooltip != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",6,0,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
