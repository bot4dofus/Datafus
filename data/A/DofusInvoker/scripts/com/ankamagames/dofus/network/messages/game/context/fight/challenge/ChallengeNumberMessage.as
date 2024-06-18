package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeNumberMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2779;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeNumber:uint = 0;
      
      public function ChallengeNumberMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2779;
      }
      
      public function initChallengeNumberMessage(challengeNumber:uint = 0) : ChallengeNumberMessage
      {
         this.challengeNumber = challengeNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeNumber = 0;
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
         this.serializeAs_ChallengeNumberMessage(output);
      }
      
      public function serializeAs_ChallengeNumberMessage(output:ICustomDataOutput) : void
      {
         if(this.challengeNumber < 0)
         {
            throw new Error("Forbidden value (" + this.challengeNumber + ") on element challengeNumber.");
         }
         output.writeVarInt(this.challengeNumber);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeNumberMessage(input);
      }
      
      public function deserializeAs_ChallengeNumberMessage(input:ICustomDataInput) : void
      {
         this._challengeNumberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeNumberMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeNumberMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeNumberFunc);
      }
      
      private function _challengeNumberFunc(input:ICustomDataInput) : void
      {
         this.challengeNumber = input.readVarUhInt();
         if(this.challengeNumber < 0)
         {
            throw new Error("Forbidden value (" + this.challengeNumber + ") on element of ChallengeNumberMessage.challengeNumber.");
         }
      }
   }
}
