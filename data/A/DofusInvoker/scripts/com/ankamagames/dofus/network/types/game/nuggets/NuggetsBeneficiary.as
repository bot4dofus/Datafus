package com.ankamagames.dofus.network.types.game.nuggets
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class NuggetsBeneficiary implements INetworkType
   {
      
      public static const protocolId:uint = 7825;
       
      
      public var beneficiaryPlayerId:Number = 0;
      
      public var nuggetsQuantity:int = 0;
      
      public function NuggetsBeneficiary()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7825;
      }
      
      public function initNuggetsBeneficiary(beneficiaryPlayerId:Number = 0, nuggetsQuantity:int = 0) : NuggetsBeneficiary
      {
         this.beneficiaryPlayerId = beneficiaryPlayerId;
         this.nuggetsQuantity = nuggetsQuantity;
         return this;
      }
      
      public function reset() : void
      {
         this.beneficiaryPlayerId = 0;
         this.nuggetsQuantity = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_NuggetsBeneficiary(output);
      }
      
      public function serializeAs_NuggetsBeneficiary(output:ICustomDataOutput) : void
      {
         if(this.beneficiaryPlayerId < 0 || this.beneficiaryPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.beneficiaryPlayerId + ") on element beneficiaryPlayerId.");
         }
         output.writeVarLong(this.beneficiaryPlayerId);
         output.writeInt(this.nuggetsQuantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NuggetsBeneficiary(input);
      }
      
      public function deserializeAs_NuggetsBeneficiary(input:ICustomDataInput) : void
      {
         this._beneficiaryPlayerIdFunc(input);
         this._nuggetsQuantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NuggetsBeneficiary(tree);
      }
      
      public function deserializeAsyncAs_NuggetsBeneficiary(tree:FuncTree) : void
      {
         tree.addChild(this._beneficiaryPlayerIdFunc);
         tree.addChild(this._nuggetsQuantityFunc);
      }
      
      private function _beneficiaryPlayerIdFunc(input:ICustomDataInput) : void
      {
         this.beneficiaryPlayerId = input.readVarUhLong();
         if(this.beneficiaryPlayerId < 0 || this.beneficiaryPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.beneficiaryPlayerId + ") on element of NuggetsBeneficiary.beneficiaryPlayerId.");
         }
      }
      
      private function _nuggetsQuantityFunc(input:ICustomDataInput) : void
      {
         this.nuggetsQuantity = input.readInt();
      }
   }
}
