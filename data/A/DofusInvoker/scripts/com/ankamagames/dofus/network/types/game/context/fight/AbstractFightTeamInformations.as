package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractFightTeamInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4798;
       
      
      public var teamId:uint = 2;
      
      public var leaderId:Number = 0;
      
      public var teamSide:int = 0;
      
      public var teamTypeId:uint = 0;
      
      public var nbWaves:uint = 0;
      
      public function AbstractFightTeamInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4798;
      }
      
      public function initAbstractFightTeamInformations(teamId:uint = 2, leaderId:Number = 0, teamSide:int = 0, teamTypeId:uint = 0, nbWaves:uint = 0) : AbstractFightTeamInformations
      {
         this.teamId = teamId;
         this.leaderId = leaderId;
         this.teamSide = teamSide;
         this.teamTypeId = teamTypeId;
         this.nbWaves = nbWaves;
         return this;
      }
      
      public function reset() : void
      {
         this.teamId = 2;
         this.leaderId = 0;
         this.teamSide = 0;
         this.teamTypeId = 0;
         this.nbWaves = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractFightTeamInformations(output);
      }
      
      public function serializeAs_AbstractFightTeamInformations(output:ICustomDataOutput) : void
      {
         output.writeByte(this.teamId);
         if(this.leaderId < -9007199254740992 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         output.writeDouble(this.leaderId);
         output.writeByte(this.teamSide);
         output.writeByte(this.teamTypeId);
         if(this.nbWaves < 0)
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element nbWaves.");
         }
         output.writeByte(this.nbWaves);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractFightTeamInformations(input);
      }
      
      public function deserializeAs_AbstractFightTeamInformations(input:ICustomDataInput) : void
      {
         this._teamIdFunc(input);
         this._leaderIdFunc(input);
         this._teamSideFunc(input);
         this._teamTypeIdFunc(input);
         this._nbWavesFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractFightTeamInformations(tree);
      }
      
      public function deserializeAsyncAs_AbstractFightTeamInformations(tree:FuncTree) : void
      {
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._leaderIdFunc);
         tree.addChild(this._teamSideFunc);
         tree.addChild(this._teamTypeIdFunc);
         tree.addChild(this._nbWavesFunc);
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of AbstractFightTeamInformations.teamId.");
         }
      }
      
      private function _leaderIdFunc(input:ICustomDataInput) : void
      {
         this.leaderId = input.readDouble();
         if(this.leaderId < -9007199254740992 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of AbstractFightTeamInformations.leaderId.");
         }
      }
      
      private function _teamSideFunc(input:ICustomDataInput) : void
      {
         this.teamSide = input.readByte();
      }
      
      private function _teamTypeIdFunc(input:ICustomDataInput) : void
      {
         this.teamTypeId = input.readByte();
         if(this.teamTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.teamTypeId + ") on element of AbstractFightTeamInformations.teamTypeId.");
         }
      }
      
      private function _nbWavesFunc(input:ICustomDataInput) : void
      {
         this.nbWaves = input.readByte();
         if(this.nbWaves < 0)
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element of AbstractFightTeamInformations.nbWaves.");
         }
      }
   }
}
