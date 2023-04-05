package com.ankamagames.dofus.datacenter.monsters
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MonsterDrop implements IDataCenter
   {
       
      
      public var dropId:uint;
      
      public var monsterId:int;
      
      public var objectId:int;
      
      public var percentDropForGrade1:Number;
      
      public var percentDropForGrade2:Number;
      
      public var percentDropForGrade3:Number;
      
      public var percentDropForGrade4:Number;
      
      public var percentDropForGrade5:Number;
      
      public var count:int;
      
      public var criteria:String;
      
      public var hasCriteria:Boolean;
      
      public var hiddenIfInvalidCriteria:Boolean;
      
      public var specificDropCoefficient:Vector.<MonsterDropCoefficient>;
      
      private var _monster:Monster;
      
      private var _conditions:GroupItemCriterion;
      
      public function MonsterDrop()
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
      
      public function getSpecificDropCoeffByGrade(grade:uint) : MonsterDropCoefficient
      {
         var dropCoeff:MonsterDropCoefficient = null;
         for each(dropCoeff in this.specificDropCoefficient)
         {
            if(grade == dropCoeff.monsterGrade)
            {
               return dropCoeff;
            }
         }
         return null;
      }
   }
}
