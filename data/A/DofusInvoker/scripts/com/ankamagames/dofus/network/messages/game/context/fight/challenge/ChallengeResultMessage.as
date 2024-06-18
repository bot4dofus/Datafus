package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5894;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeId:uint = 0;
      
      public var success:Boolean = false;
      
      public function ChallengeResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5894;
      }
      
      public function initChallengeResultMessage(challengeId:uint = 0, success:Boolean = false) : ChallengeResultMessage
      {
         this.challengeId = challengeId;
         this.success = success;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeId = 0;
         this.success = false;
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
         this.serializeAs_ChallengeResultMessage(output);
      }
      
      public function serializeAs_ChallengeResultMessage(output:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         output.writeVarInt(this.challengeId);
         output.writeBoolean(this.success);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeResultMessage(input);
      }
      
      public function deserializeAs_ChallengeResultMessage(input:ICustomDataInput) : void
      {
         this._challengeIdFunc(input);
         this._successFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeResultMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeIdFunc);
         tree.addChild(this._successFunc);
      }
      
      private function _challengeIdFunc(input:ICustomDataInput) : void
      {
         this.challengeId = input.readVarUhInt();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeResultMessage.challengeId.");
         }
      }
      
      private function _successFunc(input:ICustomDataInput) : void
      {
         this.success = input.readBoolean();
      }
   }
}
