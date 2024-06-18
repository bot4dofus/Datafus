package com.ankamagames.dofus.network.messages.game.surrender.vote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SurrenderVoteStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6177;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alreadyCastedVote:Boolean = false;
      
      public var numberOfParticipants:int = 0;
      
      public var castedVoteNumber:int = 0;
      
      public var voteDuration:int = 0;
      
      public function SurrenderVoteStartMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6177;
      }
      
      public function initSurrenderVoteStartMessage(alreadyCastedVote:Boolean = false, numberOfParticipants:int = 0, castedVoteNumber:int = 0, voteDuration:int = 0) : SurrenderVoteStartMessage
      {
         this.alreadyCastedVote = alreadyCastedVote;
         this.numberOfParticipants = numberOfParticipants;
         this.castedVoteNumber = castedVoteNumber;
         this.voteDuration = voteDuration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alreadyCastedVote = false;
         this.numberOfParticipants = 0;
         this.castedVoteNumber = 0;
         this.voteDuration = 0;
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
         this.serializeAs_SurrenderVoteStartMessage(output);
      }
      
      public function serializeAs_SurrenderVoteStartMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.alreadyCastedVote);
         output.writeInt(this.numberOfParticipants);
         output.writeInt(this.castedVoteNumber);
         output.writeInt(this.voteDuration);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderVoteStartMessage(input);
      }
      
      public function deserializeAs_SurrenderVoteStartMessage(input:ICustomDataInput) : void
      {
         this._alreadyCastedVoteFunc(input);
         this._numberOfParticipantsFunc(input);
         this._castedVoteNumberFunc(input);
         this._voteDurationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderVoteStartMessage(tree);
      }
      
      public function deserializeAsyncAs_SurrenderVoteStartMessage(tree:FuncTree) : void
      {
         tree.addChild(this._alreadyCastedVoteFunc);
         tree.addChild(this._numberOfParticipantsFunc);
         tree.addChild(this._castedVoteNumberFunc);
         tree.addChild(this._voteDurationFunc);
      }
      
      private function _alreadyCastedVoteFunc(input:ICustomDataInput) : void
      {
         this.alreadyCastedVote = input.readBoolean();
      }
      
      private function _numberOfParticipantsFunc(input:ICustomDataInput) : void
      {
         this.numberOfParticipants = input.readInt();
      }
      
      private function _castedVoteNumberFunc(input:ICustomDataInput) : void
      {
         this.castedVoteNumber = input.readInt();
      }
      
      private function _voteDurationFunc(input:ICustomDataInput) : void
      {
         this.voteDuration = input.readInt();
      }
   }
}
