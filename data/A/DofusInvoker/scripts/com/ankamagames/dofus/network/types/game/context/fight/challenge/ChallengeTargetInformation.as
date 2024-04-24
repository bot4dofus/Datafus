package com.ankamagames.dofus.network.types.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ChallengeTargetInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8948;
       
      
      public var targetId:Number = 0;
      
      public var targetCell:int = 0;
      
      public function ChallengeTargetInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8948;
      }
      
      public function initChallengeTargetInformation(targetId:Number = 0, targetCell:int = 0) : ChallengeTargetInformation
      {
         this.targetId = targetId;
         this.targetCell = targetCell;
         return this;
      }
      
      public function reset() : void
      {
         this.targetId = 0;
         this.targetCell = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ChallengeTargetInformation(output);
      }
      
      public function serializeAs_ChallengeTargetInformation(output:ICustomDataOutput) : void
      {
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.targetCell < -1 || this.targetCell > 559)
         {
            throw new Error("Forbidden value (" + this.targetCell + ") on element targetCell.");
         }
         output.writeShort(this.targetCell);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetInformation(input);
      }
      
      public function deserializeAs_ChallengeTargetInformation(input:ICustomDataInput) : void
      {
         this._targetIdFunc(input);
         this._targetCellFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeTargetInformation(tree);
      }
      
      public function deserializeAsyncAs_ChallengeTargetInformation(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._targetCellFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of ChallengeTargetInformation.targetId.");
         }
      }
      
      private function _targetCellFunc(input:ICustomDataInput) : void
      {
         this.targetCell = input.readShort();
         if(this.targetCell < -1 || this.targetCell > 559)
         {
            throw new Error("Forbidden value (" + this.targetCell + ") on element of ChallengeTargetInformation.targetCell.");
         }
      }
   }
}
