package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.lua.GroupMemberLuaData;
   import com.ankamagames.dofus.internalDatacenter.lua.GuildLuaData;
   import com.ankamagames.dofus.internalDatacenter.lua.MonsterLuaData;
   import com.ankamagames.dofus.internalDatacenter.lua.MountLuaData;
   import com.ankamagames.dofus.internalDatacenter.lua.PlayerLuaData;
   import com.ankamagames.dofus.misc.utils.LuaScriptManager;
   import com.ankamagames.dofus.misc.utils.enums.LuaFormulasEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class LuaApi implements IApi
   {
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(DataApi));
       
      
      private var _module:UiModule;
      
      public function LuaApi()
      {
         super();
      }
      
      public static function createMonsterLuaData(pLevel:int, pXp:int, pHiddenLevel:uint, pBonusFamily:Number, pBonusAlmanac:Number, pAlive:Boolean = false) : MonsterLuaData
      {
         return new MonsterLuaData(pLevel,pXp,pHiddenLevel,pBonusFamily,pBonusAlmanac,pAlive);
      }
      
      public static function createGroupMemberLuaData(pLevel:int, pIsCompanion:Boolean = false, pIsStillAlive:Boolean = true) : GroupMemberLuaData
      {
         return new GroupMemberLuaData(pLevel,pIsCompanion,pIsStillAlive);
      }
      
      public static function createPlayerLuaData(pLevel:int, pWisdom:int, pXpBonusPercent:Number, pIsRiding:Boolean, pRideXpBonus:Number, pHasGuild:Boolean, pXpGuild:Number, pSharedXPCoefficient:Number, pUnsharedXPCoefficient:Number, pXpAlliancePrismBonus:Number = 1, pBonusAlmanac:Number = 1, pIsStillPresentInFight:Boolean = true) : PlayerLuaData
      {
         return new PlayerLuaData(pLevel,pIsStillPresentInFight,pWisdom,pXpAlliancePrismBonus,pBonusAlmanac,pXpBonusPercent,pIsRiding,pRideXpBonus,pHasGuild,pXpGuild,pSharedXPCoefficient,pUnsharedXPCoefficient);
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getCurrentMonsterXp(monsterLvl:uint, isBoss:Boolean) : uint
      {
         var params:Dictionary = new Dictionary();
         params["monster_level"] = monsterLvl;
         params["monster_is_boss"] = isBoss;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.MONSTER_XP,params) as uint;
      }
      
      public function getBaseFightXp(players:Vector.<GroupMemberLuaData>, monsters:Vector.<MonsterLuaData>, fightIsWin:Boolean, rewardRate:Number) : int
      {
         var playersString:String = "players";
         var monstersString:String = "monsters";
         var advancedParams:* = playersString + "={}\n";
         for(var i:int = 0; i < players.length; i++)
         {
            advancedParams += playersString + "[" + (i + 1) + "]={" + players[i].toString() + "}\n";
         }
         advancedParams += monstersString + "={}\n";
         for(i = 0; i < monsters.length; i++)
         {
            advancedParams += monstersString + "[" + (i + 1) + "]={" + monsters[i].toString() + "}\n";
         }
         var params:Dictionary = new Dictionary();
         params[playersString] = players;
         params[monstersString] = monsters;
         params["fightIsWin"] = fightIsWin;
         params["rewardRate"] = rewardRate;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.XP_BASE,params,advancedParams) as int;
      }
      
      public function getPlayerXp(xp:int, monsters:Vector.<MonsterLuaData>, player:PlayerLuaData, totalLevel:int, challengeCoefficient:int) : int
      {
         var monstersString:String = "monsters";
         var advancedParams:* = monstersString + "={}\n";
         for(var i:int = 0; i < monsters.length; i++)
         {
            advancedParams += monstersString + "[" + (i + 1) + "]={" + monsters[i].toString() + "}\n";
         }
         advancedParams += "player={" + player.toString() + "}\n";
         var params:Dictionary = new Dictionary();
         params["xp"] = xp;
         params["monsters"] = monsters;
         params["player"] = player;
         params["maxLevel"] = totalLevel;
         params["challengeCoefficient"] = challengeCoefficient;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.XP_PLAYER,params,advancedParams) as int;
      }
      
      public function getXpDistribution(xp:int, player:PlayerLuaData, ride:MountLuaData, guild:GuildLuaData, bonus:Boolean) : Object
      {
         var advancedParams:* = "player={" + player.toString() + "}\n";
         advancedParams += "ride={" + ride.toString() + "}\n";
         advancedParams += "guild={" + guild.toString() + "}\n";
         var params:Dictionary = new Dictionary();
         params["xp"] = xp;
         params["player"] = player;
         params["ride"] = ride;
         params["guild"] = guild;
         params["bonus"] = bonus;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.XP_DISTRIBUTION,params,advancedParams,true);
      }
      
      public function getMonsterLifeScale(monsterLvl:uint, monster:Monster, characteristicId:uint) : int
      {
         var params:Dictionary = new Dictionary();
         params["monster_level"] = monsterLvl;
         params["stat_ratio"] = monster.getCharacRatio(characteristicId);
         return LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characteristicId).scaleFormulaId,params) as int;
      }
      
      public function getMonsterMovementPointsScale(monster:Monster, monsterLevel:uint, characteristicId:uint) : int
      {
         var params:Dictionary = new Dictionary();
         params["monster_level"] = monsterLevel;
         params["monster_grade_hidden_level"] = monster.grades[monster.scaleGradeRef - 1].hiddenLevel;
         params["stat_base"] = this.getGradeStatValueById(monster,characteristicId);
         params["monster_grade_level"] = monster.grades[monster.scaleGradeRef - 1].level;
         return LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characteristicId).scaleFormulaId,params) as int;
      }
      
      public function getMonsterBonusRangeScale(monster:Monster, monsterLevel:uint, characteristicId:uint) : int
      {
         var params:Dictionary = new Dictionary();
         params["monster_level"] = monsterLevel;
         params["monster_grade_hidden_level"] = monster.grades[monster.scaleGradeRef - 1].hiddenLevel;
         params["stat_base"] = this.getGradeStatValueById(monster,characteristicId);
         params["monster_grade_level"] = monster.grades[monster.scaleGradeRef - 1].level;
         return LuaScriptManager.getInstance().executeLuaFormula(Characteristic.getCharacteristicById(characteristicId).scaleFormulaId,params) as int;
      }
      
      public function getGradeStatValueById(monster:Monster, characteristicId:uint) : int
      {
         switch(characteristicId)
         {
            case DataEnum.CHARAC_MOVEMENT_POINT_ID:
               return monster.grades[monster.scaleGradeRef - 1].movementPoints;
            case DataEnum.CHARAC_VITALITY_ID:
               return monster.grades[monster.scaleGradeRef - 1].vitality;
            case DataEnum.CHARAC_HEALTH_POINT_ID:
               return monster.grades[monster.scaleGradeRef - 1].lifePoints;
            case DataEnum.CHARAC_RANGE_ID:
               return monster.grades[monster.scaleGradeRef - 1].bonusRange;
            default:
               return 0;
         }
      }
      
      public function getScoreDifficulty(floor:int, score:int, relativeScore:int) : int
      {
         var params:Dictionary = new Dictionary();
         params["ib_floor"] = floor;
         params["ib_room_absolute_score"] = score;
         params["ib_room_relative_score"] = relativeScore;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_ROOM_DIFFICULTY,params) as int;
      }
      
      public function getFightExpMultiplier(floor:int, score:int, relativeScore:int) : Number
      {
         var params:Dictionary = new Dictionary();
         params["ib_floor"] = floor;
         params["ib_room_absolute_score"] = score;
         params["ib_room_relative_score"] = relativeScore;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_EXP_MULTIPLIER,params) as Number;
      }
      
      public function getMonsterHiddenLevel(monsterLevel:int, monster:Monster) : int
      {
         var params:Dictionary = new Dictionary();
         params["monster_level"] = monsterLevel;
         params["monster_grade_hidden_level"] = monster.grades[monster.scaleGradeRef - 1].hiddenLevel;
         params["monster_grade_level"] = monster.grades[monster.scaleGradeRef - 1].level;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.BREACH_MONSTER_HIDDEN_LEVEL,params) as int;
      }
      
      public function getXpToCharacterLevel(xp:Number) : Number
      {
         var params:Dictionary = new Dictionary();
         params["experience"] = xp;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.XP_TO_CHARACTER_LEVEL,params) as Number;
      }
      
      public function getCharacterLevelToXp(level:uint) : Number
      {
         var params:Dictionary = new Dictionary();
         params["level"] = level;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.CHARACTER_LEVEL_TO_XP,params) as Number;
      }
      
      public function getTempokenToXp(nbTempoken:uint) : Number
      {
         var params:Dictionary = new Dictionary();
         params["tempoken"] = nbTempoken;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.TEMPOKEN_TO_XP,params) as Number;
      }
      
      public function getMaxGuildMembers(guildLevel:uint) : Number
      {
         var params:Dictionary = new Dictionary();
         params["guild_level"] = guildLevel;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.MAX_GUILD_MEMBERS,params) as Number;
      }
      
      public function getProspectionScore(prospectionBonus:Number) : Number
      {
         var params:Dictionary = new Dictionary();
         params["prospection_bonus"] = prospectionBonus;
         return LuaScriptManager.getInstance().executeLuaFormula(LuaFormulasEnum.PROSPECTION_BONUS,params) as Number;
      }
   }
}
