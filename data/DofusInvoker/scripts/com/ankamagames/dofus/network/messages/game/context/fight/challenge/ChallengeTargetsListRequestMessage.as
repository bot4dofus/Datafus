package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeTargetsListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4133;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeId:uint = 0;
      
      public function ChallengeTargetsListRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4133;
      }
      
      public function initChallengeTargetsListRequestMessage(challengeId:uint = 0) : ChallengeTargetsListRequestMessage
      {
         this.challengeId = challengeId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ChallengeTargetsListRequestMessage(output);
      }
      
      public function serializeAs_ChallengeTargetsListRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         output.writeVarShort(this.challengeId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetsListRequestMessage(input);
      }
      
      public function deserializeAs_ChallengeTargetsListRequestMessage(input:ICustomDataInput) : void
      {
         this._challengeIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeTargetsListRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeTargetsListRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeIdFunc);
      }
      
      private function _challengeIdFunc(input:ICustomDataInput) : void
      {
         this.challengeId = input.readVarUhShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeTargetsListRequestMessage.challengeId.");
         }
      }
   }
}
