package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeSelectionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5920;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeId:uint = 0;
      
      public function ChallengeSelectionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5920;
      }
      
      public function initChallengeSelectionMessage(challengeId:uint = 0) : ChallengeSelectionMessage
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
         this.serializeAs_ChallengeSelectionMessage(output);
      }
      
      public function serializeAs_ChallengeSelectionMessage(output:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         output.writeVarInt(this.challengeId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeSelectionMessage(input);
      }
      
      public function deserializeAs_ChallengeSelectionMessage(input:ICustomDataInput) : void
      {
         this._challengeIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeSelectionMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeSelectionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeIdFunc);
      }
      
      private function _challengeIdFunc(input:ICustomDataInput) : void
      {
         this.challengeId = input.readVarUhInt();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeSelectionMessage.challengeId.");
         }
      }
   }
}
