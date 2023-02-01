package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class QuestObjectiveMultiFightMonster extends QuestObjective implements IDataCenter
   {
       
      
      private var _monster:Monster;
      
      private var _text:String;
      
      public function QuestObjectiveMultiFightMonster()
      {
         super();
      }
      
      public function get monsterId() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get monster() : Monster
      {
         if(!this._monster)
         {
            this._monster = Monster.getMonsterById(this.monsterId);
         }
         return this._monster;
      }
      
      public function get quantity() : uint
      {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[1];
      }
      
      override public function get text() : String
      {
         if(!this._text)
         {
            this._text = PatternDecoder.getDescription(this.type.name,["{chatmonster," + this.monsterId + "}",this.quantity]);
         }
         return this._text;
      }
   }
}
