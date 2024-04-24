package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceRankUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1250;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rank:RankInformation;
      
      private var _ranktree:FuncTree;
      
      public function AllianceRankUpdateRequestMessage()
      {
         this.rank = new RankInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1250;
      }
      
      public function initAllianceRankUpdateRequestMessage(rank:RankInformation = null) : AllianceRankUpdateRequestMessage
      {
         this.rank = rank;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rank = new RankInformation();
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
         this.serializeAs_AllianceRankUpdateRequestMessage(output);
      }
      
      public function serializeAs_AllianceRankUpdateRequestMessage(output:ICustomDataOutput) : void
      {
         this.rank.serializeAs_RankInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceRankUpdateRequestMessage(input);
      }
      
      public function deserializeAs_AllianceRankUpdateRequestMessage(input:ICustomDataInput) : void
      {
         this.rank = new RankInformation();
         this.rank.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceRankUpdateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceRankUpdateRequestMessage(tree:FuncTree) : void
      {
         this._ranktree = tree.addChild(this._ranktreeFunc);
      }
      
      private function _ranktreeFunc(input:ICustomDataInput) : void
      {
         this.rank = new RankInformation();
         this.rank.deserializeAsync(this._ranktree);
      }
   }
}
