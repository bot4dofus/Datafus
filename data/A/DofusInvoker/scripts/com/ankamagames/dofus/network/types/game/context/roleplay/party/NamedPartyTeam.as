package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class NamedPartyTeam implements INetworkType
   {
      
      public static const protocolId:uint = 3499;
       
      
      public var teamId:uint = 2;
      
      public var partyName:String = "";
      
      public function NamedPartyTeam()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3499;
      }
      
      public function initNamedPartyTeam(teamId:uint = 2, partyName:String = "") : NamedPartyTeam
      {
         this.teamId = teamId;
         this.partyName = partyName;
         return this;
      }
      
      public function reset() : void
      {
         this.teamId = 2;
         this.partyName = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_NamedPartyTeam(output);
      }
      
      public function serializeAs_NamedPartyTeam(output:ICustomDataOutput) : void
      {
         output.writeByte(this.teamId);
         output.writeUTF(this.partyName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NamedPartyTeam(input);
      }
      
      public function deserializeAs_NamedPartyTeam(input:ICustomDataInput) : void
      {
         this._teamIdFunc(input);
         this._partyNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NamedPartyTeam(tree);
      }
      
      public function deserializeAsyncAs_NamedPartyTeam(tree:FuncTree) : void
      {
         tree.addChild(this._teamIdFunc);
         tree.addChild(this._partyNameFunc);
      }
      
      private function _teamIdFunc(input:ICustomDataInput) : void
      {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of NamedPartyTeam.teamId.");
         }
      }
      
      private function _partyNameFunc(input:ICustomDataInput) : void
      {
         this.partyName = input.readUTF();
      }
   }
}
