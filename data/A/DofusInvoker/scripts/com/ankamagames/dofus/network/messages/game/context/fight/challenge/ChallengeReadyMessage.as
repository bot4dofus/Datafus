package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6427;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeMod:uint = 0;
      
      public function ChallengeReadyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6427;
      }
      
      public function initChallengeReadyMessage(challengeMod:uint = 0) : ChallengeReadyMessage
      {
         this.challengeMod = challengeMod;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeMod = 0;
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
         this.serializeAs_ChallengeReadyMessage(output);
      }
      
      public function serializeAs_ChallengeReadyMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.challengeMod);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeReadyMessage(input);
      }
      
      public function deserializeAs_ChallengeReadyMessage(input:ICustomDataInput) : void
      {
         this._challengeModFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeReadyMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeReadyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeModFunc);
      }
      
      private function _challengeModFunc(input:ICustomDataInput) : void
      {
         this.challengeMod = input.readByte();
         if(this.challengeMod < 0)
         {
            throw new Error("Forbidden value (" + this.challengeMod + ") on element of ChallengeReadyMessage.challengeMod.");
         }
      }
   }
}
