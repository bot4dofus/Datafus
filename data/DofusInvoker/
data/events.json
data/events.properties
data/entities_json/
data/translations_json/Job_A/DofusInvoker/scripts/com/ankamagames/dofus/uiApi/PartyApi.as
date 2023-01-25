package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.arena.ArenaRankInfosWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class PartyApi implements IApi
   {
       
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      public function PartyApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(PartyApi));
         super();
      }
      
      private function get partyManagementFrame() : PartyManagementFrame
      {
         return Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
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
      
      public function getPartyMembers(typeId:int = 0) : Vector.<PartyMemberWrapper>
      {
         if(typeId == 1)
         {
            return this.partyManagementFrame.arenaPartyMembers;
         }
         return this.partyManagementFrame.partyMembers;
      }
      
      public function getPartyLeaderId(partyId:int) : Number
      {
         var pMember:PartyMemberWrapper = null;
         if(partyId == this.partyManagementFrame.arenaPartyId)
         {
            for each(pMember in this.partyManagementFrame.arenaPartyMembers)
            {
               if(pMember.isLeader)
               {
                  return pMember.id;
               }
            }
         }
         else if(partyId == this.partyManagementFrame.partyId)
         {
            for each(pMember in this.partyManagementFrame.partyMembers)
            {
               if(pMember.isLeader)
               {
                  return pMember.id;
               }
            }
         }
         return -1;
      }
      
      public function isInParty(pPlayerId:Number) : Boolean
      {
         var pMember:PartyMemberWrapper = null;
         for each(pMember in this.partyManagementFrame.partyMembers)
         {
            if(pPlayerId == pMember.id)
            {
               return true;
            }
         }
         for each(pMember in this.partyManagementFrame.arenaPartyMembers)
         {
            if(pPlayerId == pMember.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getPartyId() : int
      {
         return this.partyManagementFrame.partyId;
      }
      
      public function isArenaRegistered() : Boolean
      {
         return this.partyManagementFrame.isArenaRegistered;
      }
      
      public function getArenaCurrentStatus() : int
      {
         return this.partyManagementFrame.arenaCurrentStatus;
      }
      
      public function getArenaPartyId() : int
      {
         return this.partyManagementFrame.arenaPartyId;
      }
      
      public function getArenaLeader() : PartyMemberWrapper
      {
         return this.partyManagementFrame.arenaLeader;
      }
      
      public function getArenaReadyPartyMemberIds() : Array
      {
         return this.partyManagementFrame.arenaReadyPartyMemberIds;
      }
      
      public function getArenaAlliesIds() : Array
      {
         return this.partyManagementFrame.arenaAlliesIds;
      }
      
      public function getArenaRankSoloInfos() : ArenaRankInfosWrapper
      {
         return this.partyManagementFrame.arenaRankSoloInfos;
      }
      
      public function getArenaRankGroupInfos() : ArenaRankInfosWrapper
      {
         return this.partyManagementFrame.arenaRankGroupInfos;
      }
      
      public function getArenaRankDuelInfos() : ArenaRankInfosWrapper
      {
         return this.partyManagementFrame.arenaRankDuelInfos;
      }
      
      public function getAllMemberFollowPlayerId(partyId:int) : Number
      {
         return this.partyManagementFrame.allMemberFollowPlayerId;
      }
      
      public function getPartyLoyalty(partyId:int) : Boolean
      {
         return this.partyManagementFrame.partyLoyalty;
      }
      
      public function getAllSubscribedDungeons() : Vector.<uint>
      {
         return this.partyManagementFrame.subscribedDungeons;
      }
   }
}
