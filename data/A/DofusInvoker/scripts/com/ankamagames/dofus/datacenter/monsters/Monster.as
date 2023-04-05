package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.IPostInit;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Monster implements IDataCenter, IPostInit
   {
      
      public static const MODULE:String = "Monsters";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMonsterById,getMonsters);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var gfxId:uint;
      
      public var race:int;
      
      public var grades:Vector.<MonsterGrade>;
      
      public var look:String;
      
      public var useSummonSlot:Boolean;
      
      public var useBombSlot:Boolean;
      
      public var canPlay:Boolean;
      
      public var canTackle:Boolean;
      
      public var animFunList:Vector.<AnimFunMonsterData>;
      
      public var isBoss:Boolean;
      
      public var drops:Vector.<MonsterDrop>;
      
      public var temporisDrops:Vector.<MonsterDrop>;
      
      public var subareas:Vector.<uint>;
      
      public var spells:Vector.<uint>;
      
      public var spellGrades:Vector.<String>;
      
      public var favoriteSubareaId:int;
      
      public var isMiniBoss:Boolean;
      
      public var isQuestMonster:Boolean;
      
      public var correspondingMiniBossId:uint;
      
      public var speedAdjust:Number = 0.0;
      
      public var creatureBoneId:int;
      
      public var canBePushed:Boolean;
      
      public var canBeCarried:Boolean;
      
      public var canUsePortal:Boolean;
      
      public var canSwitchPos:Boolean;
      
      public var canSwitchPosOnTarget:Boolean;
      
      public var fastAnimsFun:Boolean;
      
      public var incompatibleIdols:Vector.<uint>;
      
      public var allIdolsDisabled:Boolean;
      
      public var incompatibleChallenges:Vector.<uint>;
      
      public var useRaceValues:Boolean;
      
      public var aggressiveZoneSize:int;
      
      public var aggressiveLevelDiff:int;
      
      public var aggressiveImmunityCriterion:String;
      
      public var aggressiveAttackDelay:int;
      
      public var scaleGradeRef:int;
      
      public var characRatios:Vector.<Vector.<Number>>;
      
      private var _name:String;
      
      private var _undiatricalName:String;
      
      public function Monster()
      {
         super();
      }
      
      public static function getMonsterById(id:uint) : Monster
      {
         return GameData.getObject(MODULE,id) as Monster;
      }
      
      public static function getMonsters() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get undiatricalName() : String
      {
         if(!this._undiatricalName)
         {
            this._undiatricalName = I18n.getUnDiacriticalText(this.nameId);
         }
         return this._undiatricalName;
      }
      
      public function get type() : MonsterRace
      {
         return MonsterRace.getMonsterRaceById(this.race);
      }
      
      public function get isAggressive() : Boolean
      {
         return this.aggressiveZoneSize > 0;
      }
      
      public function get canAttack() : Boolean
      {
         var criterions:GroupItemCriterion = null;
         if(this.aggressiveImmunityCriterion)
         {
            criterions = new GroupItemCriterion(this.aggressiveImmunityCriterion);
            if(criterions.isRespected)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getMonsterGrade(grade:uint) : MonsterGrade
      {
         if(grade < 1 || grade > this.grades.length)
         {
            grade = this.grades.length;
         }
         return this.grades[grade - 1] as MonsterGrade;
      }
      
      public function getAggressionLevel(grade:uint) : int
      {
         return this.grades[grade - 1].level - this.aggressiveLevelDiff;
      }
      
      public function toString() : String
      {
         return this.name;
      }
      
      public function postInit() : void
      {
         this.name;
         this.undiatricalName;
      }
      
      public function getCharacRatio(characId:uint) : Number
      {
         var charac:Vector.<Number> = null;
         for each(charac in this.characRatios)
         {
            if(characId == uint(charac[0]))
            {
               return charac[1];
            }
         }
         return 1;
      }
   }
}
