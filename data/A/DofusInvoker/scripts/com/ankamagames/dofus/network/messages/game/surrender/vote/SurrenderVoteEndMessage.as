package com.ankamagames.dofus.network.messages.game.surrender.vote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SurrenderVoteEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6083;
       
      
      private var _isInitialized:Boolean = false;
      
      public var voteResult:Boolean = false;
      
      public function SurrenderVoteEndMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6083;
      }
      
      public function initSurrenderVoteEndMessage(voteResult:Boolean = false) : SurrenderVoteEndMessage
      {
         this.voteResult = voteResult;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.voteResult = false;
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
         this.serializeAs_SurrenderVoteEndMessage(output);
      }
      
      public function serializeAs_SurrenderVoteEndMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.voteResult);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderVoteEndMessage(input);
      }
      
      public function deserializeAs_SurrenderVoteEndMessage(input:ICustomDataInput) : void
      {
         this._voteResultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderVoteEndMessage(tree);
      }
      
      public function deserializeAsyncAs_SurrenderVoteEndMessage(tree:FuncTree) : void
      {
         tree.addChild(this._voteResultFunc);
      }
      
      private function _voteResultFunc(input:ICustomDataInput) : void
      {
         this.voteResult = input.readBoolean();
      }
   }
}
