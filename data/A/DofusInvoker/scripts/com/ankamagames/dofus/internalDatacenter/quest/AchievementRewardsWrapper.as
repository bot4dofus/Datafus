package com.ankamagames.dofus.internalDatacenter.quest
{
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AchievementRewardsWrapper extends AchievementReward implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AchievementRewardsWrapper));
       
      
      public var rewardsList:Vector.<AchievementReward>;
      
      public var rewardTruncated:Boolean = false;
      
      public function AchievementRewardsWrapper()
      {
         this.rewardsList = new Vector.<AchievementReward>();
         super();
      }
      
      public static function create(rewards:Vector.<AchievementReward>, id:uint, characterRewardsTruncated:Boolean = false) : AchievementRewardsWrapper
      {
         var i:int = 0;
         var mergedRewards:AchievementRewardsWrapper = new AchievementRewardsWrapper();
         mergedRewards.rewardsList = rewards;
         mergedRewards.rewardTruncated = characterRewardsTruncated;
         mergedRewards.achievementId = id;
         mergedRewards.itemsReward = new Vector.<uint>();
         mergedRewards.itemsQuantityReward = new Vector.<uint>();
         mergedRewards.emotesReward = new Vector.<uint>();
         mergedRewards.spellsReward = new Vector.<uint>();
         mergedRewards.titlesReward = new Vector.<uint>();
         mergedRewards.ornamentsReward = new Vector.<uint>();
         var rewardsCount:int = rewards.length;
         for(i = 0; i < rewardsCount; i++)
         {
            if(rewards[i].kamasRatio)
            {
               mergedRewards.kamasRatio = rewards[i].kamasRatio;
               mergedRewards.kamasScaleWithPlayerLevel = rewards[i].kamasScaleWithPlayerLevel;
            }
            if(rewards[i].experienceRatio)
            {
               mergedRewards.experienceRatio = rewards[i].experienceRatio;
            }
            if(rewards[i].guildPoints)
            {
               mergedRewards.guildPoints = rewards[i].guildPoints;
            }
            mergedRewards.itemsReward = mergedRewards.itemsReward.concat(rewards[i].itemsReward);
            mergedRewards.itemsQuantityReward = mergedRewards.itemsQuantityReward.concat(rewards[i].itemsQuantityReward);
            mergedRewards.emotesReward = mergedRewards.emotesReward.concat(rewards[i].emotesReward);
            mergedRewards.spellsReward = mergedRewards.spellsReward.concat(rewards[i].spellsReward);
            mergedRewards.titlesReward = mergedRewards.titlesReward.concat(rewards[i].titlesReward);
            mergedRewards.ornamentsReward = mergedRewards.ornamentsReward.concat(rewards[i].ornamentsReward);
         }
         return mergedRewards;
      }
      
      public function update(rewards:Vector.<AchievementReward>, characterRewardsTruncated:Boolean = false) : void
      {
         var i:int = 0;
         this.rewardsList = rewards;
         this.rewardTruncated = characterRewardsTruncated;
         if(rewards != null && rewards.length > 0)
         {
            this.achievementId = rewards[0].achievementId;
         }
         this.itemsReward = new Vector.<uint>();
         this.itemsQuantityReward = new Vector.<uint>();
         this.emotesReward = new Vector.<uint>();
         this.spellsReward = new Vector.<uint>();
         this.titlesReward = new Vector.<uint>();
         this.ornamentsReward = new Vector.<uint>();
         var rewardsCount:int = rewards.length;
         for(i = 0; i < rewardsCount; i++)
         {
            if(rewards[i].kamasRatio)
            {
               this.kamasRatio = rewards[i].kamasRatio;
               this.kamasScaleWithPlayerLevel = rewards[i].kamasScaleWithPlayerLevel;
            }
            if(rewards[i].experienceRatio)
            {
               this.experienceRatio = rewards[i].experienceRatio;
            }
            if(rewards[i].guildPoints)
            {
               this.guildPoints = rewards[i].guildPoints;
            }
            this.itemsReward = this.itemsReward.concat(rewards[i].itemsReward);
            this.itemsQuantityReward = this.itemsQuantityReward.concat(rewards[i].itemsQuantityReward);
            this.emotesReward = this.emotesReward.concat(rewards[i].emotesReward);
            this.spellsReward = this.spellsReward.concat(rewards[i].spellsReward);
            this.titlesReward = this.titlesReward.concat(rewards[i].titlesReward);
            this.ornamentsReward = this.ornamentsReward.concat(rewards[i].ornamentsReward);
         }
      }
   }
}
