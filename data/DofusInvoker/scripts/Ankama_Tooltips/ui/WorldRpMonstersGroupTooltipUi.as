package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.utils.FormulaHandler;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AlternativeMonstersInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterWaveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GroupMonsterStaticInformationsWithAlternatives;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.LuaApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import damageCalculation.tools.StatIds;
   import flash.geom.ColorTransform;
   
   public class WorldRpMonstersGroupTooltipUi
   {
      
      private static const WAVE_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,1,202,173,-13);
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="RoleplayApi")]
      public var roleplayApi:RoleplayApi;
      
      [Api(name="LuaApi")]
      public var luaApi:LuaApi;
      
      private var _monstersInfo:GroupMonsterStaticInformations;
      
      private var _useScale:Boolean = false;
      
      private var _disposition:EntityDispositionInformations;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_wave:GraphicContainer;
      
      public var ctr_xp:GraphicContainer;
      
      public var ctr_malusDropArena:GraphicContainer;
      
      public var ctr_back:GraphicContainer;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_groupOptimal:GraphicContainer;
      
      public var ctr_malusDrop:GraphicContainer;
      
      public var ctr_header:GraphicContainer;
      
      public var ctr_separatorMalus:GraphicContainer;
      
      public var ctr_separatorXp:GraphicContainer;
      
      public var lbl_level:Label;
      
      public var lbl_monsterList:Label;
      
      public var lbl_disabledMonsterList:Label;
      
      public var lbl_nbWaves:Label;
      
      public var lbl_monsterXp:Label;
      
      public var lbl_groupOptimal:Label;
      
      public var lbl_malusDrop:Label;
      
      public var tx_wave:Texture;
      
      public var tx_sword:TextureBitmap;
      
      public function WorldRpMonstersGroupTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var monster:Monster = null;
         var member:PartyMemberWrapper = null;
         var wisdom:int = 0;
         var pg:GuildMember = null;
         var xpAlliancePrismBonus:Number = NaN;
         var m:Object = null;
         var nbCompanions:int = 0;
         var i:int = 0;
         var prismInfo:PrismSubAreaWrapper = null;
         var waves:Object = null;
         var waveInfo:GroupMonsterStaticInformations = null;
         var waveXpSolo:Number = NaN;
         var waveXpGroup:Number = NaN;
         var waveData:MonstersGroupData = null;
         var malus:int = 0;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         var data:Object = oParam.data;
         if(data.hasOwnProperty("useScale"))
         {
            this._useScale = data.useScale;
            this._monstersInfo = data.monsterGroupInfos.staticInfos;
            this._disposition = data.monsterGroupInfos.disposition;
         }
         else
         {
            this._monstersInfo = data.staticInfos;
            this._disposition = data.disposition;
         }
         this.ctr_back.width = 1;
         this.ctr_wave.height = 1;
         this.lbl_monsterList.width = 1;
         this.lbl_monsterXp.width = 1;
         this.lbl_disabledMonsterList.width = 1;
         this.ctr_header.width = 1;
         this.ctr_groupOptimal.width = 1;
         this.ctr_malusDrop.width = 1;
         this.ctr_separatorMalus.width = 1;
         this.ctr_separatorXp.width = 1;
         this.ctr_malusDropArena.height = 1;
         if(data.alignmentSide == AlignmentSideEnum.ALIGNMENT_ANGEL)
         {
            this.lbl_monsterList.cssClass = "bonta";
            this.lbl_disabledMonsterList.cssClass = "bonta";
         }
         else if(data.alignmentSide == AlignmentSideEnum.ALIGNMENT_EVIL)
         {
            this.lbl_monsterList.cssClass = "brakmar";
            this.lbl_disabledMonsterList.cssClass = "brakmar";
         }
         else
         {
            this.lbl_monsterList.cssClass = "center";
            this.lbl_disabledMonsterList.cssClass = "center";
         }
         var partyMembers:Vector.<PartyMemberWrapper> = this.partyApi.getPartyMembers();
         var currentPlayerLevel:uint = Math.min(this.playerApi.getPlayedCharacterInfo().level,ProtocolConstantsEnum.MAX_LEVEL);
         var currentPlayerStats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         var formulaGroupMembers:Array = [];
         if(partyMembers.length == 0 && this.playerApi.hasCompanion())
         {
            formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel));
            formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel,true));
         }
         else
         {
            for each(member in partyMembers)
            {
               formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(member.level,ProtocolConstantsEnum.MAX_LEVEL)));
               nbCompanions = member.companions.length;
               for(i = 0; i < nbCompanions; i++)
               {
                  formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(member.level,ProtocolConstantsEnum.MAX_LEVEL),true));
               }
            }
         }
         wisdom = currentPlayerStats.getStatTotalValue(StatIds.WISDOM);
         pg = this.getPlayerGuild(this.playerApi.getPlayedCharacterInfo().id);
         if(this.socialApi.hasAlliance())
         {
            prismInfo = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id);
            if(this.socialApi.hasAlliance() && prismInfo && prismInfo.mapId != -1 && (!prismInfo.alliance || prismInfo.alliance && prismInfo.alliance.allianceId == this.socialApi.getAlliance().allianceId))
            {
               xpAlliancePrismBonus = 25;
            }
         }
         var playerData:* = FormulaHandler.createPlayerData(currentPlayerLevel,wisdom,this.playerApi.getExperienceBonusPercent(),this.playerApi.getMount() != null && this.playerApi.isRidding() ? Number(this.playerApi.getMount().xpRatio) : Number(0),pg != null ? Number(pg.experienceGivenPercent) : Number(0),xpAlliancePrismBonus);
         var groupData:MonstersGroupData = this.getMonstersGroupData(this._monstersInfo,playerData,formulaGroupMembers,this.mapApi.getMapTotalRewardRate());
         this.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + groupData.level;
         var textList:String = "";
         var textListDisabled:String = "";
         var grp:Array = groupData.group;
         for each(m in grp)
         {
            if(m.visible)
            {
               monster = this.dataApi.getMonsterFromId(m.monsterId);
               textList += "\n" + (!!monster.isMiniBoss ? "<b>" : "") + monster.name + " (" + m.level + ")" + (!!monster.isMiniBoss ? "</b>" : "");
            }
            else
            {
               monster = this.dataApi.getMonsterFromId(m.monsterId);
               textListDisabled += "\n" + monster.name + " (" + m.level + ")";
            }
         }
         if(textList)
         {
            textList = textList.substr(1);
         }
         var xpText:String = "";
         var inParty:* = formulaGroupMembers.length > 0;
         var grpgmwi:GameRolePlayGroupMonsterWaveInformations = data as GameRolePlayGroupMonsterWaveInformations;
         if(grpgmwi)
         {
            this.tx_wave.colorTransform = WAVE_COLOR_TRANSFORM;
            this.ctr_wave.visible = true;
            this.lbl_nbWaves.text = "x " + (grpgmwi.nbWaves + 1);
            this.lbl_nbWaves.fullWidthAndHeight();
            this.ctr_wave.height = this.lbl_nbWaves.height;
            waves = grpgmwi.alternatives;
            waveXpSolo = groupData.xpSolo;
            waveXpGroup = groupData.xpGroup;
            for each(waveInfo in waves)
            {
               waveData = this.getMonstersGroupData(waveInfo,playerData,formulaGroupMembers,this.mapApi.getMapTotalRewardRate());
               waveXpSolo += waveData.xpSolo;
               waveXpGroup += waveData.xpGroup;
            }
            xpText += this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(waveXpSolo));
            if(inParty)
            {
               xpText += "\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(waveXpGroup));
            }
         }
         else
         {
            this.hideBloc(this.ctr_wave);
            xpText += this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(groupData.xpSolo));
            if(inParty)
            {
               xpText += "\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(groupData.xpGroup));
            }
         }
         this.lbl_monsterXp.text = xpText;
         this.lbl_monsterList.text = textList;
         this.lbl_disabledMonsterList.visible = textListDisabled != "";
         this.lbl_disabledMonsterList.text = textListDisabled;
         this.lbl_monsterList.fullWidthAndHeight();
         this.lbl_disabledMonsterList.fullWidthAndHeight();
         this.lbl_monsterXp.fullWidthAndHeight();
         this.lbl_level.fullWidthAndHeight();
         if(data.lootShare != null && data.lootShare > 0)
         {
            malus = FormulaHandler.getArenaMalusDrop(data.lootShare,partyMembers.length);
            if(malus > 0)
            {
               this.ctr_separatorMalus.visible = true;
               this.lbl_groupOptimal.text = this.uiApi.getText("ui.tooltip.maxMemberParty",data.lootShare);
               this.lbl_groupOptimal.fullWidthAndHeight();
               this.lbl_malusDrop.text = this.uiApi.getText("ui.tooltip.arenaMalus",malus);
               this.lbl_malusDrop.fullWidthAndHeight();
               this.ctr_malusDropArena.visible = true;
            }
            else
            {
               this.ctr_separatorMalus.visible = false;
               this.hideBloc(this.ctr_malusDropArena);
            }
         }
         else
         {
            this.ctr_separatorMalus.visible = false;
            this.hideBloc(this.ctr_malusDropArena);
         }
         var maxWidth:int = this.getMaxWidth();
         this.lbl_monsterList.width = maxWidth;
         this.lbl_monsterXp.width = maxWidth;
         this.lbl_disabledMonsterList.width = maxWidth;
         this.ctr_xp.width = maxWidth;
         this.ctr_header.width = maxWidth;
         this.ctr_main.width = maxWidth;
         this.ctr_groupOptimal.width = maxWidth;
         this.ctr_malusDrop.width = maxWidth;
         this.ctr_malusDropArena.width = maxWidth;
         this.ctr_separatorMalus.width = maxWidth;
         this.ctr_separatorXp.width = maxWidth;
         if(this.ctr_wave.visible)
         {
            this.tx_wave.x = maxWidth / 2 - (this.tx_wave.width + this.lbl_nbWaves.width) / 2;
            this.lbl_nbWaves.x = this.tx_wave.x + this.tx_wave.width;
         }
         this.ctr_back.width = maxWidth + 8;
         if(this.ctr_malusDropArena.visible)
         {
            this.ctr_malusDropArena.height = this.lbl_groupOptimal.textHeight + this.lbl_malusDrop.textHeight;
         }
         var uiLoading:Boolean = this.uiApi.isUiLoading(this.uiApi.me().name);
         this.uiApi.me().render();
         if(!uiLoading)
         {
            this.onUiLoaded(this.uiApi.me().name);
         }
         var firstInit:* = this.ctr_back.height == 0;
         var backHeight:Number = this.ctr_main.height;
         if(!this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.CHARACTER_XP))
         {
            this.lbl_monsterXp.visible = false;
            this.ctr_separatorXp.y = -this.lbl_monsterXp.height;
            this.lbl_monsterList.y = -this.lbl_monsterXp.height;
            backHeight = this.ctr_main.height - this.lbl_monsterXp.height + 8;
         }
         var th:int = this.ctr_separatorXp.y + this.lbl_monsterList.height + this.lbl_disabledMonsterList.height - (!!this.lbl_disabledMonsterList.visible ? 25 : 0);
         if(backHeight < th)
         {
            backHeight = th;
         }
         if(firstInit)
         {
            if(inParty)
            {
               backHeight += 21;
            }
            if(this.ctr_wave.visible)
            {
               backHeight += 13;
            }
            else
            {
               backHeight -= 20;
            }
         }
         if(!firstInit && this.lbl_disabledMonsterList.visible)
         {
            backHeight += 8;
         }
         this.ctr_back.height = backHeight;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset,true,this._disposition.cellId);
      }
      
      private function getMaxWidth() : int
      {
         var maxValue:int = 0;
         if(this.lbl_level.width > this.lbl_monsterList.width && this.lbl_level.width > this.lbl_monsterXp.width && this.lbl_level.width > this.lbl_disabledMonsterList.width)
         {
            maxValue = this.lbl_level.width;
         }
         else if(this.lbl_groupOptimal.visible && this.lbl_groupOptimal.width > this.lbl_monsterList.width && this.lbl_groupOptimal.width > this.lbl_monsterXp.width && this.lbl_groupOptimal.width > this.lbl_disabledMonsterList.width && this.lbl_groupOptimal.width > this.lbl_level.width)
         {
            maxValue = this.lbl_groupOptimal.width;
         }
         else if(this.lbl_malusDrop.visible && this.lbl_malusDrop.width > this.lbl_monsterList.width && this.lbl_malusDrop.width > this.lbl_monsterXp.width && this.lbl_malusDrop.width > this.lbl_disabledMonsterList.width && this.lbl_malusDrop.width > this.lbl_level.width)
         {
            maxValue = this.lbl_malusDrop.width;
         }
         else if(this.lbl_disabledMonsterList.visible && this.lbl_disabledMonsterList.width > this.lbl_monsterXp.width && this.lbl_disabledMonsterList.width >= this.lbl_disabledMonsterList.width && this.lbl_disabledMonsterList.width > this.lbl_monsterList.width && this.lbl_disabledMonsterList.width > this.lbl_level.width)
         {
            maxValue = this.lbl_disabledMonsterList.width;
         }
         else if(this.lbl_monsterXp.visible && this.lbl_monsterXp.width > this.lbl_monsterList.width && this.lbl_monsterXp.width > this.lbl_disabledMonsterList.width && this.lbl_monsterXp.width > this.lbl_level.width)
         {
            maxValue = this.lbl_monsterXp.width;
         }
         else
         {
            maxValue = this.lbl_monsterList.width;
         }
         return maxValue;
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         var diff:Number = NaN;
         var offset:Number = NaN;
         if(uiName == this.uiApi.me().name)
         {
            if(this.roleplayApi.isMonstersGroupAttacking(this._monstersInfo))
            {
               this.tx_sword.x = this.lbl_level.x + this.lbl_level.width + 5;
               this.tx_sword.visible = true;
               diff = this.ctr_back.width - (this.tx_sword.x + this.tx_sword.width);
               if(diff < 8)
               {
                  offset = 8 - diff;
                  this.ctr_back.width += offset + 4;
               }
            }
            else
            {
               this.tx_sword.visible = false;
            }
         }
      }
      
      private function hideBloc(ctr:GraphicContainer) : void
      {
         ctr.height = 0;
         ctr.visible = false;
      }
      
      public function getRealMonsterGrade(realGroup:Array, creatureGenericId:int) : int
      {
         var mob:MonsterInGroupLightInformations = null;
         if(realGroup == null)
         {
            return 0;
         }
         for each(mob in realGroup)
         {
            if(mob.genericId == creatureGenericId)
            {
               realGroup.splice(realGroup.indexOf(mob),1);
               return mob.grade;
            }
         }
         return -1;
      }
      
      private function xtremAdvancedSortMonster(monsterA:Object, monsterB:Object) : Number
      {
         var result:int = 0;
         if(monsterA.monsterId == monsterB.monsterId)
         {
            if(monsterA.level > monsterB.level)
            {
               result = -1;
            }
            else if(monsterA.level < monsterB.level)
            {
               result = 1;
            }
            else
            {
               result = 0;
            }
         }
         else if(monsterA.maxLevel > monsterB.maxLevel)
         {
            result = -1;
         }
         else if(monsterA.maxLevel < monsterB.maxLevel)
         {
            result = 1;
         }
         else if(monsterA.totalLevel > monsterB.totalLevel)
         {
            result = -1;
         }
         else if(monsterA.totalLevel < monsterB.totalLevel)
         {
            result = 1;
         }
         else
         {
            result = 0;
         }
         return result;
      }
      
      private function truncate(val:Number) : int
      {
         var multiplier:uint = Math.pow(10,0);
         var truncatedVal:Number = val * multiplier;
         return int(truncatedVal) / multiplier;
      }
      
      private function getPlayerGuild(idPlayer:Number) : GuildMember
      {
         var mem:GuildMember = null;
         for each(mem in this.socialApi.getGuildMembers())
         {
            if(mem.id == idPlayer)
            {
               return mem;
            }
         }
         return null;
      }
      
      private function getMonstersGroupData(pStaticInfos:GroupMonsterStaticInformations, pPlayerData:*, pGroupMembersData:Array, pMapRewardRate:int) : MonstersGroupData
      {
         var groupData:MonstersGroupData = null;
         var mainCreatureLvl:int = 0;
         var monsterData:* = undefined;
         var member:PartyMemberWrapper = null;
         var monster:Monster = null;
         var lvlMonster:int = 0;
         var realMonstersList:Array = null;
         var totalLevel:Number = NaN;
         var mainMonsterGenericId:int = 0;
         var formulaMobs:Array = null;
         var m:Object = null;
         var numFirstMonsters:uint = 0;
         var idolsExpBonusTotalPercentSolo:uint = 0;
         var idolsExpBonusTotalPercentGroup:uint = 0;
         var members:int = 0;
         var realMonstersListObject:AlternativeMonstersInGroupLightInformations = null;
         var realGroup:AlternativeMonstersInGroupLightInformations = null;
         var val:MonsterInGroupLightInformations = null;
         var monstersLevel:Array = [];
         var maxMonsterLevel:Array = [];
         mainCreatureLvl = pStaticInfos.mainCreatureLightInfos.level;
         monstersLevel[pStaticInfos.mainCreatureLightInfos.genericId] = mainCreatureLvl;
         maxMonsterLevel[pStaticInfos.mainCreatureLightInfos.genericId] = mainCreatureLvl;
         var partyMembers:Vector.<PartyMemberWrapper> = this.partyApi.getPartyMembers();
         for each(monsterData in pStaticInfos.underlings)
         {
            monster = this.dataApi.getMonsterFromId(monsterData.genericId);
            lvlMonster = monsterData.level;
            if(monstersLevel[monsterData.genericId] && monstersLevel[monsterData.genericId] > 0)
            {
               monstersLevel[monsterData.genericId] += lvlMonster;
            }
            else
            {
               monstersLevel[monsterData.genericId] = lvlMonster;
            }
            if(maxMonsterLevel[monsterData.genericId] && maxMonsterLevel[monsterData.genericId] > 0)
            {
               if(maxMonsterLevel[monsterData.genericId] < lvlMonster)
               {
                  maxMonsterLevel[monsterData.genericId] = lvlMonster;
               }
            }
            else
            {
               maxMonsterLevel[monsterData.genericId] = lvlMonster;
            }
         }
         totalLevel = Number.NaN;
         mainMonsterGenericId = pStaticInfos.mainCreatureLightInfos.genericId;
         if(pStaticInfos is GroupMonsterStaticInformationsWithAlternatives)
         {
            realMonstersList = [];
            members = partyMembers.length;
            if(members == 0 && this.playerApi.hasCompanion())
            {
               members = 2;
            }
            else if(members > 0)
            {
               for each(member in partyMembers)
               {
                  members += member.companions.length;
               }
            }
            else
            {
               members = 1;
            }
            realMonstersListObject = null;
            for each(realGroup in (pStaticInfos as GroupMonsterStaticInformationsWithAlternatives).alternatives)
            {
               if(realMonstersListObject == null || realGroup.playerCount <= members)
               {
                  realMonstersListObject = realGroup;
               }
            }
            for each(val in realMonstersListObject.monsters)
            {
               realMonstersList.push(val);
               if(val.genericId === mainMonsterGenericId)
               {
                  totalLevel = val.level;
               }
            }
         }
         var grp:Array = [];
         var m1:Monster = this.dataApi.getMonsterFromId(pStaticInfos.mainCreatureLightInfos.genericId);
         var realMonsterGrade:int = this.getRealMonsterGrade(realMonstersList,pStaticInfos.mainCreatureLightInfos.genericId);
         if(isNaN(totalLevel))
         {
            totalLevel = pStaticInfos.mainCreatureLightInfos.level;
         }
         grp.push({
            "monsterId":mainMonsterGenericId,
            "level":totalLevel,
            "hiddenLevel":m1.grades[pStaticInfos.mainCreatureLightInfos.grade - 1].hiddenLevel,
            "gradeXp":this.getXp(pStaticInfos.mainCreatureLightInfos,m1,realMonsterGrade),
            "totalLevel":monstersLevel[pStaticInfos.mainCreatureLightInfos.genericId],
            "maxLevel":maxMonsterLevel[pStaticInfos.mainCreatureLightInfos.genericId],
            "visible":realMonsterGrade >= 0
         });
         for each(monsterData in pStaticInfos.underlings)
         {
            m1 = this.dataApi.getMonsterFromId(monsterData.genericId);
            realMonsterGrade = this.getRealMonsterGrade(realMonstersList,monsterData.genericId);
            lvlMonster = monsterData.level;
            if(realMonsterGrade >= 0)
            {
               totalLevel += lvlMonster;
            }
            grp.push({
               "monsterId":monsterData.genericId,
               "level":lvlMonster,
               "hiddenLevel":m1.grades[monsterData.grade - 1].hiddenLevel,
               "gradeXp":this.getXp(monsterData,m1,realMonsterGrade),
               "totalLevel":monstersLevel[monsterData.genericId],
               "maxLevel":maxMonsterLevel[monsterData.genericId],
               "visible":realMonsterGrade >= 0
            });
         }
         grp.sort(this.xtremAdvancedSortMonster);
         formulaMobs = [];
         for each(m in grp)
         {
            if(m.visible)
            {
               formulaMobs.push(FormulaHandler.createMonsterData(m.level,m.gradeXp * this.roleplayApi.getMonsterXpBoostMultiplier(m.monsterId) * this.roleplayApi.getAlmanaxMonsterXpBonusMultiplier(m.monsterId),m.hiddenLevel));
            }
         }
         numFirstMonsters = formulaMobs.length;
         idolsExpBonusTotalPercentSolo = this.getIdolsExpBonusPercent(this.playerApi.getSoloIdols(),numFirstMonsters,grp,0);
         idolsExpBonusTotalPercentGroup = this.getIdolsExpBonusPercent(!this.playerApi.isInParty() && pGroupMembersData.length ? this.playerApi.getSoloIdols() : this.playerApi.getPartyIdols(),numFirstMonsters,grp,pGroupMembersData.length);
         FormulaHandler.getInstance().initXpFormula(pPlayerData,formulaMobs,pGroupMembersData,pMapRewardRate,idolsExpBonusTotalPercentSolo,idolsExpBonusTotalPercentGroup);
         return new MonstersGroupData(totalLevel,grp,FormulaHandler.getInstance().xpSolo,FormulaHandler.getInstance().xpGroup);
      }
      
      private function getXp(monsterData:*, monster:Monster, realMonsterGrade:int) : int
      {
         if((this.playerApi.isInAnomaly() || this._useScale) && monsterData.level > 0)
         {
            return this.luaApi.getCurrentMonsterXp(monsterData.level,monster.isBoss);
         }
         return realMonsterGrade <= 0 ? int(monster.grades[monsterData.grade - 1].gradeXp) : int(monster.grades[realMonsterGrade - 1].gradeXp);
      }
      
      private function getIdolsExpBonusPercent(pIdolsList:Object, pNumFirstMonsters:uint, pMonsters:Array, pNbAllies:uint) : uint
      {
         var i:int = 0;
         var coeff:Number = NaN;
         var idol:Idol = null;
         var incompatibleIdol:Boolean = false;
         var monster:Monster = null;
         var m:Object = null;
         if(!FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.IDOL_XP_BONUS))
         {
            return 0;
         }
         var numIdols:uint = pIdolsList.length;
         var idolsExpBonusTotalPercent:uint = 0;
         var enabledIdols:Vector.<uint> = new Vector.<uint>(0);
         for(i = 0; i < numIdols; i++)
         {
            idol = this.dataApi.getIdol(pIdolsList[i]);
            incompatibleIdol = false;
            for each(m in pMonsters)
            {
               monster = this.dataApi.getMonsterFromId(m.monsterId);
               if(monster.incompatibleIdols.indexOf(idol.id) != -1)
               {
                  incompatibleIdol = true;
                  break;
               }
            }
            if(!(incompatibleIdol || idol.groupOnly && (pNbAllies < 4 || pNumFirstMonsters < 4)))
            {
               enabledIdols.push(pIdolsList[i]);
            }
         }
         numIdols = enabledIdols.length;
         for(i = 0; i < numIdols; i++)
         {
            idol = this.dataApi.getIdol(enabledIdols[i]);
            coeff = this.getIdolCoeff(idol,enabledIdols);
            idolsExpBonusTotalPercent += idol.experienceBonus * coeff;
         }
         return idolsExpBonusTotalPercent;
      }
      
      private function getIdolCoeff(pIdol:Idol, pIdolsList:Vector.<uint>) : Number
      {
         var i:int = 0;
         var j:int = 0;
         var coeff:Number = 1;
         var synergiesIds:Vector.<int> = pIdol.synergyIdolsIds;
         var synergiesCoeffs:Vector.<Number> = pIdol.synergyIdolsCoeff;
         var numSynergies:uint = synergiesIds.length;
         var numActiveIdols:uint = pIdolsList.length;
         for(i = 0; i < numActiveIdols; i++)
         {
            for(j = 0; j < numSynergies; j++)
            {
               if(synergiesIds[j] == pIdolsList[i])
               {
                  coeff *= synergiesCoeffs[j];
               }
            }
         }
         return coeff;
      }
      
      public function unload() : void
      {
      }
   }
}

class MonstersGroupData
{
    
   
   private var _level:int;
   
   private var _group:Array;
   
   private var _xpSolo:Number;
   
   private var _xpGroup:Number;
   
   function MonstersGroupData(pLevel:int, pGroup:Array, pXpSolo:Number, pXpGroup:Number)
   {
      super();
      this._level = pLevel;
      this._group = pGroup;
      this._xpSolo = pXpSolo;
      this._xpGroup = pXpGroup;
   }
   
   public function get level() : int
   {
      return this._level;
   }
   
   public function get group() : Array
   {
      return this._group;
   }
   
   public function get xpSolo() : Number
   {
      return this._xpSolo;
   }
   
   public function get xpGroup() : Number
   {
      return this._xpGroup;
   }
}
