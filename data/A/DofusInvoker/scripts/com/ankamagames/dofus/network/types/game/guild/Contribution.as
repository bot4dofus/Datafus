package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Contribution implements INetworkType
   {
      
      public static const protocolId:uint = 7492;
       
      
      public var contributorId:Number = 0;
      
      public var contributorName:String = "";
      
      public var amount:Number = 0;
      
      public function Contribution()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7492;
      }
      
      public function initContribution(contributorId:Number = 0, contributorName:String = "", amount:Number = 0) : Contribution
      {
         this.contributorId = contributorId;
         this.contributorName = contributorName;
         this.amount = amount;
         return this;
      }
      
      public function reset() : void
      {
         this.contributorId = 0;
         this.contributorName = "";
         this.amount = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Contribution(output);
      }
      
      public function serializeAs_Contribution(output:ICustomDataOutput) : void
      {
         if(this.contributorId < 0 || this.contributorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.contributorId + ") on element contributorId.");
         }
         output.writeVarLong(this.contributorId);
         output.writeUTF(this.contributorName);
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarLong(this.amount);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Contribution(input);
      }
      
      public function deserializeAs_Contribution(input:ICustomDataInput) : void
      {
         this._contributorIdFunc(input);
         this._contributorNameFunc(input);
         this._amountFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Contribution(tree);
      }
      
      public function deserializeAsyncAs_Contribution(tree:FuncTree) : void
      {
         tree.addChild(this._contributorIdFunc);
         tree.addChild(this._contributorNameFunc);
         tree.addChild(this._amountFunc);
      }
      
      private function _contributorIdFunc(input:ICustomDataInput) : void
      {
         this.contributorId = input.readVarUhLong();
         if(this.contributorId < 0 || this.contributorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.contributorId + ") on element of Contribution.contributorId.");
         }
      }
      
      private function _contributorNameFunc(input:ICustomDataInput) : void
      {
         this.contributorName = input.readUTF();
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhLong();
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of Contribution.amount.");
         }
      }
   }
}
