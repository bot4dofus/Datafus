package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterGrade implements IDataCenter
   {
       
      
      public var grade:uint;
      
      public var monsterId:int;
      
      public var level:uint;
      
      public var vitality:int;
      
      public var paDodge:int;
      
      public var pmDodge:int;
      
      public var wisdom:int;
      
      public var earthResistance:int;
      
      public var airResistance:int;
      
      public var fireResistance:int;
      
      public var waterResistance:int;
      
      public var neutralResistance:int;
      
      public var gradeXp:int;
      
      public var lifePoints:int;
      
      public var actionPoints:int;
      
      public var movementPoints:int;
      
      public var damageReflect:int;
      
      public var hiddenLevel:uint;
      
      public var strength:int;
      
      public var intelligence:int;
      
      public var chance:int;
      
      public var agility:int;
      
      public var bonusRange:int;
      
      public var startingSpellId:int;
      
      public var bonusCharacteristics:MonsterBonusCharacteristics = null;
      
      private var _monster:Monster;
      
      public function MonsterGrade()
      {
         super();
      }
      
      public function get monster() : Monster
      {
         if(!this._monster)
         {
            this._monster = Monster.getMonsterById(this.monsterId);
         }
         return this._monster;
      }
      
      public function get static() : Boolean
      {
         return this.movementPoints == -1;
      }
   }
}
