package Ankama_Tooltips.utils
{
   public class FormulaHandler
   {
      
      private static var _self:FormulaHandler;
      
      private static const XP_GROUP:Array = [1,1.1,1.5,2.3,3.1,3.6,4.2,4.7];
      
      private static const MAX_LEVEL_MALUS:Number = 4;
       
      
      private var _xpSolo:Number;
      
      private var _xpGroup:Number;
      
      public function FormulaHandler()
      {
         super();
         this.clearData();
      }
      
      public static function getInstance() : FormulaHandler
      {
         if(_self == null)
         {
            _self = new FormulaHandler();
         }
         return _self;
      }
      
      public static function createMonsterData(pLevel:int, pXp:int, pHiddenLevel:uint) : MonsterData
      {
         return new MonsterData(pLevel,pXp,pHiddenLevel);
      }
      
      public static function createGroupMember(pLevel:int, pIsCompanion:Boolean = false) : GroupMemberData
      {
         return new GroupMemberData(pLevel,pIsCompanion);
      }
      
      public static function createPlayerData(pLevel:int, pWisdom:int = 0, pXpBonus:Number = 0, pXpMount:Number = 0, pXpGuild:Number = 0, pXpAlliancePrismBonus:Number = 0) : PlayerData
      {
         return new PlayerData(pLevel,pWisdom,pXpBonus,pXpMount,pXpGuild,pXpAlliancePrismBonus);
      }
      
      public static function getArenaMalusDrop(pLootShare:int, pMembers:int) : int
      {
         var malus:int = Math.round(100 - pLootShare / pMembers * 100);
         return malus < 0 ? 0 : int(malus);
      }
      
      private function clearData() : void
      {
         this._xpSolo = 0;
         this._xpGroup = 0;
      }
      
      public function initXpFormula(pPlayerData:PlayerData, pMonstersList:Array, pMembersList:Array, pMapRewardRate:int = 0, pXpIdolsBonusPercentSolo:int = 0, pXpIdolsBonusPercentGroup:int = 0) : void
      {
         var mob:MonsterData = null;
         var lvlPlayers:uint = 0;
         var lvlMaxGroup:uint = 0;
         var totalPlayerForBonusGroup:uint = 0;
         var member:GroupMemberData = null;
         var coeffDiffLvlGroup:Number = NaN;
         var ratioXpMontureSolo:Number = NaN;
         var ratioXpMontureGroup:Number = NaN;
         var ratioXpGuildSolo:Number = NaN;
         var ratioXpGuildGroup:Number = NaN;
         var xpAlliancePrismBonus:Number = NaN;
         this.clearData();
         var xpBase:uint = 0;
         var maxLvlMonster:uint = 0;
         var lvlMonsters:uint = 0;
         var hiddenLvlMonsters:uint = 0;
         for each(mob in pMonstersList)
         {
            xpBase += mob.xp;
            lvlMonsters += mob.level;
            hiddenLvlMonsters += mob.hiddenLevel > 0 ? mob.hiddenLevel : mob.level;
            if(mob.level > maxLvlMonster)
            {
               maxLvlMonster = mob.level;
            }
         }
         lvlPlayers = 0;
         lvlMaxGroup = 0;
         totalPlayerForBonusGroup = 0;
         for each(member in pMembersList)
         {
            lvlPlayers += member.level;
            if(member.level > lvlMaxGroup)
            {
               lvlMaxGroup = member.level;
            }
         }
         for each(member in pMembersList)
         {
            if(!member.companion && member.level >= lvlMaxGroup / 3)
            {
               totalPlayerForBonusGroup++;
            }
         }
         coeffDiffLvlGroup = 1;
         if(lvlPlayers - 5 > lvlMonsters)
         {
            coeffDiffLvlGroup = lvlMonsters / lvlPlayers;
         }
         else if(lvlPlayers + 10 < lvlMonsters)
         {
            coeffDiffLvlGroup = (lvlPlayers + 10) / lvlMonsters;
         }
         var coeffDiffLvlSolo:Number = 1;
         if(pPlayerData.level - 5 > lvlMonsters)
         {
            coeffDiffLvlSolo = lvlMonsters / pPlayerData.level;
         }
         else if(pPlayerData.level + 10 < lvlMonsters)
         {
            coeffDiffLvlSolo = (pPlayerData.level + 10) / lvlMonsters;
         }
         var v:uint = Math.min(pPlayerData.level,this.truncate(2.5 * maxLvlMonster));
         var xpLimitMaxLvlSolo:Number = v / pPlayerData.level * 100;
         var xpLimitMaxLvlGroup:Number = v / lvlPlayers * 100;
         var xpGroupAlone:uint = this.truncate(xpBase * XP_GROUP[0] * coeffDiffLvlSolo);
         if(totalPlayerForBonusGroup == 0)
         {
            totalPlayerForBonusGroup = 1;
         }
         var xpGroup:uint = this.truncate(xpBase * XP_GROUP[totalPlayerForBonusGroup - 1] * coeffDiffLvlGroup);
         var xpNoSagesseAlone:uint = this.truncate(xpLimitMaxLvlSolo / 100 * xpGroupAlone);
         var xpNoSagesseGroup:uint = this.truncate(xpLimitMaxLvlGroup / 100 * xpGroup);
         var realMapRewardRate:Number = (100 + pMapRewardRate) / 100;
         var lvlMalusIdolsSolo:Number = Math.min(MAX_LEVEL_MALUS,hiddenLvlMonsters / pMonstersList.length / pPlayerData.level);
         lvlMalusIdolsSolo *= lvlMalusIdolsSolo;
         var lvlMalusIdolsGroup:Number = Math.min(MAX_LEVEL_MALUS,hiddenLvlMonsters / pMonstersList.length / lvlMaxGroup);
         lvlMalusIdolsGroup *= lvlMalusIdolsGroup;
         var idolsWisdomBonusSolo:int = this.truncate((100 + pPlayerData.level * 2.5) * this.truncate(pXpIdolsBonusPercentSolo * lvlMalusIdolsSolo) / 100);
         var idolsWisdomBonusGroup:int = this.truncate((100 + pPlayerData.level * 2.5) * this.truncate(pXpIdolsBonusPercentGroup * lvlMalusIdolsGroup) / 100);
         var totalWisdomSolo:uint = Math.max(pPlayerData.wisdom + idolsWisdomBonusSolo,0);
         var totalWisdomGroup:uint = Math.max(pPlayerData.wisdom + idolsWisdomBonusGroup,0);
         var xpTotalOnePlayer:uint = this.truncate(this.truncate(xpNoSagesseAlone * (100 + totalWisdomSolo) / 100) * realMapRewardRate);
         var xpTotalGroup:uint = this.truncate(this.truncate(xpNoSagesseGroup * (100 + totalWisdomGroup) / 100) * realMapRewardRate);
         var xpBonus:Number = 1 + pPlayerData.xpBonusPercent / 100;
         var tmpSolo:Number = xpTotalOnePlayer;
         var tmpGroup:Number = xpTotalGroup;
         if(pPlayerData.xpRatioMount > 0)
         {
            ratioXpMontureSolo = tmpSolo * pPlayerData.xpRatioMount / 100;
            ratioXpMontureGroup = tmpGroup * pPlayerData.xpRatioMount / 100;
            tmpSolo = this.truncate(tmpSolo - ratioXpMontureSolo);
            tmpGroup = this.truncate(tmpGroup - ratioXpMontureGroup);
         }
         tmpSolo *= xpBonus;
         tmpGroup *= xpBonus;
         if(pPlayerData.xpGuildGivenPercent > 0)
         {
            ratioXpGuildSolo = tmpSolo * pPlayerData.xpGuildGivenPercent / 100;
            ratioXpGuildGroup = tmpGroup * pPlayerData.xpGuildGivenPercent / 100;
            tmpSolo -= ratioXpGuildSolo;
            tmpGroup -= ratioXpGuildGroup;
         }
         if(pPlayerData.xpAlliancePrismBonusPercent > 0)
         {
            xpAlliancePrismBonus = 1 + pPlayerData.xpAlliancePrismBonusPercent / 100;
            tmpSolo *= xpAlliancePrismBonus;
            tmpGroup *= xpAlliancePrismBonus;
         }
         xpTotalOnePlayer = this.truncate(tmpSolo);
         xpTotalGroup = this.truncate(tmpGroup);
         this._xpSolo = xpBase > 0 ? Number(Math.max(xpTotalOnePlayer,1)) : Number(0);
         this._xpGroup = xpBase > 0 ? Number(Math.max(xpTotalGroup,1)) : Number(0);
      }
      
      private function truncate(val:Number) : int
      {
         var multiplier:uint = Math.pow(10,0);
         var truncatedVal:Number = val * multiplier;
         return int(truncatedVal) / multiplier;
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
}

class MonsterData
{
    
   
   public var xp:int;
   
   public var level:int;
   
   public var hiddenLevel:uint;
   
   function MonsterData(pLevel:int, pXp:int, pHiddenLevel:uint)
   {
      super();
      this.xp = pXp;
      this.level = pLevel;
      this.hiddenLevel = pHiddenLevel;
   }
}

class GroupMemberData
{
    
   
   public var level:int;
   
   public var companion:Boolean;
   
   function GroupMemberData(pLevel:int, pIsCompanion:Boolean)
   {
      super();
      this.level = pLevel;
      this.companion = pIsCompanion;
   }
}

class PlayerData
{
    
   
   public var level:int;
   
   public var wisdom:int;
   
   public var xpBonusPercent:Number;
   
   public var xpRatioMount:Number;
   
   public var xpGuildGivenPercent:Number;
   
   public var xpAlliancePrismBonusPercent:Number;
   
   function PlayerData(pLevel:int, pWisdom:int = 0, pXpBonus:Number = 0, pXpMount:Number = 0, pXpGuild:Number = 0, pXpAlliancePrismBonus:Number = 0)
   {
      super();
      this.level = pLevel;
      this.wisdom = pWisdom;
      this.xpBonusPercent = pXpBonus;
      this.xpRatioMount = pXpMount;
      this.xpGuildGivenPercent = pXpGuild;
      this.xpAlliancePrismBonusPercent = pXpAlliancePrismBonus;
   }
}
