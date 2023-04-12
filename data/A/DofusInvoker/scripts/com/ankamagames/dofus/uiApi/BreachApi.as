package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.misc.BreachPrize;
   import com.ankamagames.dofus.internalDatacenter.breach.BreachRewardWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class BreachApi implements IApi
   {
       
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      public function BreachApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(BreachApi));
         super();
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
      
      public function get breachFrame() : BreachFrame
      {
         return Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
      }
      
      public function getBudget() : uint
      {
         return this.breachFrame.budget;
      }
      
      public function getFloor() : uint
      {
         return this.breachFrame.floor;
      }
      
      public function getRoom() : uint
      {
         return this.breachFrame.room;
      }
      
      public function getOwnerId() : Number
      {
         return this.breachFrame.ownerId;
      }
      
      public function getBranches() : Dictionary
      {
         return this.breachFrame.branches;
      }
      
      public function getInfinityLevel() : uint
      {
         return this.breachFrame.infinityLevel;
      }
      
      public function getBreachPlayers() : Vector.<Number>
      {
         var breachFrame:BreachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
         if(breachFrame)
         {
            return breachFrame.breachCharacterList;
         }
         return new Vector.<Number>();
      }
      
      public function getBreachGroupPlayers() : Vector.<PartyMemberWrapper>
      {
         var partyMembers:Vector.<PartyMemberWrapper> = null;
         var player:Number = NaN;
         var partyPlayer:PartyMemberWrapper = null;
         var players:Vector.<Number> = new Vector.<Number>();
         var playersInPartyAndBreach:Vector.<PartyMemberWrapper> = new Vector.<PartyMemberWrapper>();
         var breachFrame:BreachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
         if(breachFrame)
         {
            players = breachFrame.breachCharacterList;
         }
         var partyFrame:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         if(partyFrame)
         {
            partyMembers = partyFrame.partyMembers;
            for each(player in players)
            {
               for each(partyPlayer in partyMembers)
               {
                  if(player == partyPlayer.id)
                  {
                     playersInPartyAndBreach.push(partyPlayer);
                     break;
                  }
               }
            }
         }
         return playersInPartyAndBreach;
      }
      
      public function isInBreach() : Boolean
      {
         return PlayedCharacterManager.getInstance().isInBreach;
      }
      
      public function sortByCurrency(firstReward:BreachRewardWrapper, secondReward:BreachRewardWrapper) : Number
      {
         var firstRewardCurrency:int = BreachPrize.getBreachPrizeById(firstReward.id).currency;
         var secondRewardCurrency:int = BreachPrize.getBreachPrizeById(secondReward.id).currency;
         if(firstRewardCurrency > secondRewardCurrency)
         {
            return 1;
         }
         if(firstRewardCurrency < secondRewardCurrency)
         {
            return -1;
         }
         return 0;
      }
      
      public function sortByPrice(firstReward:BreachRewardWrapper, secondReward:BreachRewardWrapper) : Number
      {
         var firstRewardPrice:int = firstReward.price;
         var secondRewardPrice:int = secondReward.price;
         if(firstRewardPrice > secondRewardPrice)
         {
            return 1;
         }
         if(firstRewardPrice < secondRewardPrice)
         {
            return -1;
         }
         return this.sortByName(firstReward,secondReward);
      }
      
      public function sortByName(firstReward:BreachRewardWrapper, secondReward:BreachRewardWrapper) : Number
      {
         var firstRewardName:String = BreachPrize.getBreachPrizeById(firstReward.id).name;
         var secondRewardName:String = BreachPrize.getBreachPrizeById(secondReward.id).name;
         if(firstRewardName > secondRewardName)
         {
            return 1;
         }
         if(firstRewardName < secondRewardName)
         {
            return -1;
         }
         return 0;
      }
      
      public function rewardSpecificSort(firstReward:BreachRewardWrapper, secondReward:BreachRewardWrapper) : Number
      {
         if(firstReward.remainingQty < 0)
         {
            return -1;
         }
         if(secondReward.remainingQty < 0)
         {
            return 1;
         }
         return this.sortByPriceDescending(firstReward,secondReward);
      }
      
      public function sortByPriceDescending(firstReward:BreachRewardWrapper, secondReward:BreachRewardWrapper) : Number
      {
         var firstPrice:int = firstReward.price;
         var secondPrice:int = secondReward.price;
         if(firstPrice > secondPrice)
         {
            return -1;
         }
         if(firstPrice < secondPrice)
         {
            return 1;
         }
         return 0;
      }
   }
}
