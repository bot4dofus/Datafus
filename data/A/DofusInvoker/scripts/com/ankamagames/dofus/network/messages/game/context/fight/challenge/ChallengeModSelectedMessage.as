package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChallengeModSelectedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4667;
       
      
      private var _isInitialized:Boolean = false;
      
      public var challengeMod:uint = 0;
      
      public function ChallengeModSelectedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4667;
      }
      
      public function initChallengeModSelectedMessage(challengeMod:uint = 0) : ChallengeModSelectedMessage
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
         this.serializeAs_ChallengeModSelectedMessage(output);
      }
      
      public function serializeAs_ChallengeModSelectedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.challengeMod);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeModSelectedMessage(input);
      }
      
      public function deserializeAs_ChallengeModSelectedMessage(input:ICustomDataInput) : void
      {
         this._challengeModFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChallengeModSelectedMessage(tree);
      }
      
      public function deserializeAsyncAs_ChallengeModSelectedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._challengeModFunc);
      }
      
      private function _challengeModFunc(input:ICustomDataInput) : void
      {
         this.challengeMod = input.readByte();
         if(this.challengeMod < 0)
         {
            throw new Error("Forbidden value (" + this.challengeMod + ") on element of ChallengeModSelectedMessage.challengeMod.");
         }
      }
   }
}
