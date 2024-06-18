package com.ankamagames.dofus.network.messages.game.surrender.vote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SurrenderVoteCastMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4209;
       
      
      private var _isInitialized:Boolean = false;
      
      public var vote:Boolean = false;
      
      public function SurrenderVoteCastMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4209;
      }
      
      public function initSurrenderVoteCastMessage(vote:Boolean = false) : SurrenderVoteCastMessage
      {
         this.vote = vote;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.vote = false;
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
         this.serializeAs_SurrenderVoteCastMessage(output);
      }
      
      public function serializeAs_SurrenderVoteCastMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.vote);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderVoteCastMessage(input);
      }
      
      public function deserializeAs_SurrenderVoteCastMessage(input:ICustomDataInput) : void
      {
         this._voteFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderVoteCastMessage(tree);
      }
      
      public function deserializeAsyncAs_SurrenderVoteCastMessage(tree:FuncTree) : void
      {
         tree.addChild(this._voteFunc);
      }
      
      private function _voteFunc(input:ICustomDataInput) : void
      {
         this.vote = input.readBoolean();
      }
   }
}
