package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.utils.FormulaHandler;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.LuaApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import damageCalculation.tools.StatIds;
   import flash.geom.ColorTransform;
   
   public class BreachMonstersGroupTooltipUi
   {
      
      private static const WAVE_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,1,202,173,-13);
      
      private static const WAVE_SIZE:uint = 4;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="RoleplayApi")]
      public var roleplayApi:RoleplayApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="LuaApi")]
      public var luaApi:LuaApi;
      
      private var _monsters:Vector.<MonsterInGroupLightInformations>;
      
      private var _mainMonstersCount:uint;
      
      private var _formulaGroupMembers:Array;
      
      private var _playerData;
      
      private var _isInParty:Boolean;
      
      private var _score:int;
      
      private var _relativeScore:int;
      
      private var _expMultiplier:Number;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_wave:GraphicContainer;
      
      public var ctr_xp:GraphicContainer;
      
      public var ctr_back:GraphicContainer;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_header:GraphicContainer;
      
      public var ctr_separatorXp:GraphicContainer;
      
      public var lbl_level:Label;
      
      public var lbl_monsterList:Label;
      
      public var lbl_nbWaves:Label;
      
      public var lbl_monsterXp:Label;
      
      public var tx_wave:Texture;
      
      public function BreachMonstersGroupTooltipUi()
      {
         super();
      }
      
      public function main(oParams:* = null) : void
      {
         var monster:Monster = null;
         var id:uint = 0;
         var waveXpSolo:Number = NaN;
         var waveXpGroup:Number = NaN;
         var waveData:MonstersGroupData = null;
         var wavesCount:uint = 0;
         var currentWaveCount:uint = 0;
         var currentWaveMonstersIds:Vector.<MonsterInGroupLightInformations> = null;
         this._monsters = oParams.data.monsterGroup;
         this._score = oParams.data.score;
         this._relativeScore = oParams.data.relativeScore;
         if(this._monsters.length <= 5)
         {
            this._mainMonstersCount = this._monsters.length;
         }
         else if(this._monsters.length % WAVE_SIZE != 0)
         {
            this._mainMonstersCount = 5;
         }
         else
         {
            this._mainMonstersCount = 4;
         }
         var mainMonsters:Vector.<MonsterInGroupLightInformations> = this._monsters.concat().splice(0,this._mainMonstersCount);
         var waveMonsters:Vector.<MonsterInGroupLightInformations> = this._monsters.concat().splice(this._mainMonstersCount,this._monsters.length - this._mainMonstersCount);
         this.ctr_back.width = 1;
         this.ctr_wave.height = 1;
         this.lbl_monsterList.width = 1;
         this.lbl_monsterXp.width = 1;
         this.ctr_header.width = 1;
         this.ctr_separatorXp.width = 1;
         this._expMultiplier = this.luaApi.getFightExpMultiplier(this.breachApi.getFloor(),this._score,this._relativeScore);
         this.setPlayerData();
         var groupData:MonstersGroupData = this.getBreachMonstersGroupData(mainMonsters,this._playerData,this._formulaGroupMembers);
         this.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + groupData.level;
         var xpText:String = "";
         var textList:String = "";
         var grp:Vector.<uint> = this.sortMonsters();
         for each(id in grp)
         {
            monster = this.dataApi.getMonsterFromId(id);
            textList += "\n" + monster.name + " (" + this.breachApi.getFloor() + ")";
         }
         if(textList)
         {
            textList = textList.substr(1);
         }
         this._isInParty = this._formulaGroupMembers.length > 0;
         if(this._monsters.length > this._mainMonstersCount)
         {
            this.tx_wave.colorTransform = WAVE_COLOR_TRANSFORM;
            this.ctr_wave.visible = true;
            this.lbl_nbWaves.text = "x " + (Math.floor(waveMonsters.length / WAVE_SIZE) + 1);
            this.lbl_nbWaves.fullWidthAndHeight();
            this.ctr_wave.height = this.lbl_nbWaves.height;
            waveXpSolo = groupData.xpSolo;
            waveXpGroup = groupData.xpGroup;
            wavesCount = waveMonsters.length / WAVE_SIZE;
            for(currentWaveCount = 0; currentWaveCount < wavesCount; currentWaveCount++)
            {
               currentWaveMonstersIds = waveMonsters.splice(0,WAVE_SIZE);
               waveData = this.getBreachMonstersGroupData(currentWaveMonstersIds,this._playerData,this._formulaGroupMembers);
               waveXpSolo += waveData.xpSolo;
               waveXpGroup += waveData.xpGroup;
            }
            xpText += this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(int(waveXpSolo * this._expMultiplier)));
            if(this._isInParty)
            {
               xpText += "\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(int(waveXpGroup * this._expMultiplier)));
            }
         }
         else
         {
            this.hideBloc(this.ctr_wave);
            xpText += this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(int(groupData.xpSolo * this._expMultiplier)));
            if(this._isInParty)
            {
               xpText += "\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(int(groupData.xpGroup * this._expMultiplier)));
            }
         }
         this.lbl_monsterXp.text = xpText;
         this.lbl_monsterList.text = textList;
         this.resizeLabels();
         this.tooltipApi.place(oParams.position,oParams.showDirectionalArrow,oParams.point,oParams.relativePoint,oParams.offset,true);
      }
      
      private function setPlayerData() : void
      {
         var member:PartyMemberWrapper = null;
         var i:uint = 0;
         var currentPlayerStats:EntityStats = null;
         var wisdom:int = 0;
         var nbCompanions:int = 0;
         var partyMembers:Vector.<PartyMemberWrapper> = this.breachApi.getBreachGroupPlayers();
         var currentPlayerLevel:uint = Math.min(this.playerApi.getPlayedCharacterInfo().level,ProtocolConstantsEnum.MAX_LEVEL);
         var currentPlayerCharac:CharacterCharacteristicsInformations = this.playerApi.characteristics();
         this._formulaGroupMembers = [];
         if(partyMembers.length == 0 && this.playerApi.hasCompanion())
         {
            this._formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel));
            this._formulaGroupMembers.push(FormulaHandler.createGroupMember(currentPlayerLevel,true));
         }
         else
         {
            for each(member in partyMembers)
            {
               this._formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(200,member.level)));
               nbCompanions = member.companions.length;
               for(i = 0; i < nbCompanions; i++)
               {
                  this._formulaGroupMembers.push(FormulaHandler.createGroupMember(Math.min(200,member.level),true));
               }
            }
         }
         currentPlayerStats = StatsManager.getInstance().getStats(this.playerApi.id());
         wisdom = currentPlayerStats !== null ? int(currentPlayerStats.getStatTotalValue(StatIds.WISDOM)) : 0;
         var pg:GuildMember = this.getPlayerGuild(this.playerApi.getPlayedCharacterInfo().id);
         this._playerData = FormulaHandler.createPlayerData(currentPlayerLevel,wisdom,this.playerApi.getExperienceBonusPercent(),this.playerApi.getMount() != null && this.playerApi.isRidding() ? Number(this.playerApi.getMount().xpRatio) : Number(0),pg != null ? Number(pg.experienceGivenPercent) : Number(0));
      }
      
      private function getBreachMonstersGroupData(monsters:Vector.<MonsterInGroupLightInformations>, pPlayerData:*, pGroupMembersData:Array) : MonstersGroupData
      {
         var monsterInfo:MonsterInGroupLightInformations = null;
         var monster:Monster = null;
         var formulaMobs:Array = null;
         var m:Object = null;
         var numFirstMonsters:uint = 0;
         var idolsExpBonusTotalPercentSolo:uint = 0;
         var idolsExpBonusTotalPercentGroup:uint = 0;
         var groupData:MonstersGroupData = null;
         var level:uint = 0;
         var grp:Array = [];
         var totalLevel:uint = 0;
         for each(monsterInfo in monsters)
         {
            level = this.breachApi.getFloor();
            monster = this.dataApi.getMonsterFromId(monsterInfo.genericId);
            totalLevel += level;
            grp.push({
               "monsterId":monsterInfo.genericId,
               "level":monsterInfo.level,
               "hiddenLevel":this.luaApi.getMonsterHiddenLevel(monsterInfo.level,monster),
               "xp":this.luaApi.getCurrentMonsterXp(this.breachApi.getFloor(),monster.isBoss)
            });
         }
         formulaMobs = [];
         for each(m in grp)
         {
            formulaMobs.push(FormulaHandler.createMonsterData(m.level,m.xp * this.roleplayApi.getMonsterXpBoostMultiplier(m.monsterId) * this.roleplayApi.getAlmanaxMonsterXpBonusMultiplier(m.monsterId),m.hiddenLevel));
         }
         numFirstMonsters = formulaMobs.length;
         idolsExpBonusTotalPercentSolo = this.getIdolsExpBonusPercent(this.playerApi.getSoloIdols(),numFirstMonsters,grp,0);
         idolsExpBonusTotalPercentGroup = this.getIdolsExpBonusPercent(!this.playerApi.isInParty() && pGroupMembersData.length ? this.playerApi.getSoloIdols() : this.playerApi.getPartyIdols(),numFirstMonsters,grp,pGroupMembersData.length);
         FormulaHandler.getInstance().initXpFormula(pPlayerData,formulaMobs,pGroupMembersData,0,idolsExpBonusTotalPercentSolo,idolsExpBonusTotalPercentGroup);
         return new MonstersGroupData(totalLevel,grp,FormulaHandler.getInstance().xpSolo,FormulaHandler.getInstance().xpGroup);
      }
      
      private function sortMonsters() : Vector.<uint>
      {
         var uId:Vector.<uint> = null;
         var sortFunc:Function = function(a:MonsterInGroupLightInformations, b:MonsterInGroupLightInformations):Number
         {
            var mA:Monster = dataApi.getMonsterFromId(a.genericId);
            var mB:Monster = dataApi.getMonsterFromId(b.genericId);
            if(mA.isBoss != mB.isBoss)
            {
               return !!mA.isBoss ? Number(-1) : Number(1);
            }
            if(mA.isMiniBoss != mB.isMiniBoss)
            {
               return !!mA.isBoss ? Number(-1) : Number(1);
            }
            return 0;
         };
         uId = new Vector.<uint>();
         var removeFunc:Function = function(a:MonsterInGroupLightInformations, index:int, vector:Vector.<MonsterInGroupLightInformations>):void
         {
            if(uId.indexOf(a.genericId) == -1 || _monsters.length <= _mainMonstersCount)
            {
               uId.push(a.genericId);
            }
         };
         this._monsters.sort(sortFunc).forEach(removeFunc);
         return uId;
      }
      
      private function getIdolsExpBonusPercent(pIdolsList:Object, pNumFirstMonsters:uint, pMonsters:Array, pNbAllies:uint) : uint
      {
         var i:int = 0;
         var coeff:Number = NaN;
         var idol:Idol = null;
         var incompatibleIdol:Boolean = false;
         var monster:Monster = null;
         var m:Object = null;
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
      
      private function getIdolCoeff(pIdol:Idol, pIdolsList:Object) : Number
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
      
      private function hideBloc(ctr:GraphicContainer) : void
      {
         ctr.height = 0;
         ctr.visible = false;
      }
      
      private function getMaxWidth() : int
      {
         var maxValue:int = 0;
         if(this.lbl_level.width > this.lbl_monsterList.width && this.lbl_level.width > this.lbl_monsterXp.width)
         {
            maxValue = this.lbl_level.width;
         }
         else if(this.lbl_monsterXp.visible && this.lbl_monsterXp.width > this.lbl_monsterList.width && this.lbl_monsterXp.width > this.lbl_level.width)
         {
            maxValue = this.lbl_monsterXp.width;
         }
         else
         {
            maxValue = this.lbl_monsterList.width;
         }
         return maxValue;
      }
      
      private function resizeLabels() : void
      {
         this.lbl_monsterList.fullWidthAndHeight();
         this.lbl_monsterXp.fullWidthAndHeight();
         this.lbl_level.fullWidthAndHeight();
         var maxWidth:int = this.getMaxWidth();
         this.lbl_monsterList.width = maxWidth;
         this.lbl_monsterXp.width = maxWidth;
         this.lbl_level.width = maxWidth;
         this.ctr_xp.width = maxWidth;
         this.ctr_header.width = maxWidth;
         this.ctr_main.width = maxWidth;
         this.ctr_separatorXp.width = maxWidth;
         if(this.ctr_wave.visible)
         {
            this.tx_wave.x = maxWidth / 2 - (this.tx_wave.width + this.lbl_nbWaves.width) / 2;
            this.lbl_nbWaves.x = this.tx_wave.x + this.tx_wave.width;
            this.ctr_wave.y = this.ctr_header.y + this.ctr_header.contentHeight;
            this.ctr_xp.y = this.ctr_wave.y + this.ctr_wave.contentHeight;
         }
         else
         {
            this.ctr_xp.y = this.ctr_header.y + this.ctr_header.contentHeight;
         }
         this.ctr_separatorXp.y = this.ctr_xp.y + this.ctr_xp.contentHeight;
         this.lbl_monsterList.y = this.ctr_separatorXp.y + this.ctr_separatorXp.height;
         this.ctr_back.width = maxWidth + 8;
         var firstInit:* = this.ctr_back.height == 0;
         var backHeight:Number = this.ctr_main.height;
         var th:int = this.ctr_separatorXp.y + this.lbl_monsterList.height;
         if(backHeight < th)
         {
            backHeight = th;
         }
         if(firstInit)
         {
            if(this._isInParty)
            {
               backHeight += 21;
            }
         }
         this.ctr_back.height = backHeight + 8;
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
