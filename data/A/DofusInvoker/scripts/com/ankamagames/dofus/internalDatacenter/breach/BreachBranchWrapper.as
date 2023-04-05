package com.ankamagames.dofus.internalDatacenter.breach
{
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachBranch;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachReward;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.ExtendedBreachBranch;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.ExtendedLockedBreachBranch;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BreachBranchWrapper implements IDataCenter
   {
       
      
      public var room:uint = 0;
      
      public var element:uint = 0;
      
      public var bosses:Vector.<MonsterInGroupLightInformations>;
      
      public var monsters:Vector.<MonsterInGroupLightInformations>;
      
      public var rewards:Vector.<BreachRewardWrapper>;
      
      public var modifier:int = 0;
      
      public var modifierObj:SpellPair = null;
      
      public var prize:uint = 0;
      
      public var map:Number = 0;
      
      public var score:Number = 0;
      
      public var relativeScore:Number = 0;
      
      public var isLocked:Boolean = false;
      
      public var unlockPrice:Number = 0;
      
      public function BreachBranchWrapper(branch:BreachBranch)
      {
         var reward:BreachReward = null;
         this.bosses = new Vector.<MonsterInGroupLightInformations>();
         this.monsters = new Vector.<MonsterInGroupLightInformations>();
         this.rewards = new Vector.<BreachRewardWrapper>();
         super();
         this.room = branch.room;
         this.element = branch.element;
         this.bosses = branch.bosses;
         this.map = branch.map;
         this.score = branch.score;
         this.relativeScore = branch.relativeScore;
         this.monsters = branch.monsters;
         if(branch is ExtendedBreachBranch)
         {
            this.modifier = (branch as ExtendedBreachBranch).modifier;
            this.prize = (branch as ExtendedBreachBranch).prize;
            for each(reward in (branch as ExtendedBreachBranch).rewards)
            {
               this.rewards.push(new BreachRewardWrapper(reward));
            }
         }
         if(branch is ExtendedLockedBreachBranch)
         {
            this.isLocked = true;
            this.unlockPrice = (branch as ExtendedLockedBreachBranch).unlockPrice;
         }
      }
   }
}
