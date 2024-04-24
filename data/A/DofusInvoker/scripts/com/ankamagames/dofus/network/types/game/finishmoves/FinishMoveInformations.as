package com.ankamagames.dofus.network.types.game.finishmoves
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FinishMoveInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7706;
       
      
      public var finishMoveId:uint = 0;
      
      public var finishMoveState:Boolean = false;
      
      public function FinishMoveInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7706;
      }
      
      public function initFinishMoveInformations(finishMoveId:uint = 0, finishMoveState:Boolean = false) : FinishMoveInformations
      {
         this.finishMoveId = finishMoveId;
         this.finishMoveState = finishMoveState;
         return this;
      }
      
      public function reset() : void
      {
         this.finishMoveId = 0;
         this.finishMoveState = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FinishMoveInformations(output);
      }
      
      public function serializeAs_FinishMoveInformations(output:ICustomDataOutput) : void
      {
         if(this.finishMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.finishMoveId + ") on element finishMoveId.");
         }
         output.writeInt(this.finishMoveId);
         output.writeBoolean(this.finishMoveState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FinishMoveInformations(input);
      }
      
      public function deserializeAs_FinishMoveInformations(input:ICustomDataInput) : void
      {
         this._finishMoveIdFunc(input);
         this._finishMoveStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FinishMoveInformations(tree);
      }
      
      public function deserializeAsyncAs_FinishMoveInformations(tree:FuncTree) : void
      {
         tree.addChild(this._finishMoveIdFunc);
         tree.addChild(this._finishMoveStateFunc);
      }
      
      private function _finishMoveIdFunc(input:ICustomDataInput) : void
      {
         this.finishMoveId = input.readInt();
         if(this.finishMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.finishMoveId + ") on element of FinishMoveInformations.finishMoveId.");
         }
      }
      
      private function _finishMoveStateFunc(input:ICustomDataInput) : void
      {
         this.finishMoveState = input.readBoolean();
      }
   }
}
