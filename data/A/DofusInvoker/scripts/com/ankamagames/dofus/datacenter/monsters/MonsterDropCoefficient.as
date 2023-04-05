package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterDropCoefficient implements IDataCenter
   {
       
      
      public var monsterId:uint;
      
      public var monsterGrade:uint;
      
      public var dropCoefficient:Number;
      
      public var criteria:String;
      
      private var _monster:Monster;
      
      private var _conditions:GroupItemCriterion;
      
      public function MonsterDropCoefficient()
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
      
      public function get conditions() : GroupItemCriterion
      {
         if(!this.criteria)
         {
            return null;
         }
         if(!this._conditions)
         {
            this._conditions = new GroupItemCriterion(this.criteria);
         }
         return this._conditions;
      }
   }
}
