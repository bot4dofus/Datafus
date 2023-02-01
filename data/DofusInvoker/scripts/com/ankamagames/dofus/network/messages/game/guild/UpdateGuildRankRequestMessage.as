package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateGuildRankRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7592;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rank:GuildRankInformation;
      
      private var _ranktree:FuncTree;
      
      public function UpdateGuildRankRequestMessage()
      {
         this.rank = new GuildRankInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7592;
      }
      
      public function initUpdateGuildRankRequestMessage(rank:GuildRankInformation = null) : UpdateGuildRankRequestMessage
      {
         this.rank = rank;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rank = new GuildRankInformation();
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
         this.serializeAs_UpdateGuildRankRequestMessage(output);
      }
      
      public function serializeAs_UpdateGuildRankRequestMessage(output:ICustomDataOutput) : void
      {
         this.rank.serializeAs_GuildRankInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateGuildRankRequestMessage(input);
      }
      
      public function deserializeAs_UpdateGuildRankRequestMessage(input:ICustomDataInput) : void
      {
         this.rank = new GuildRankInformation();
         this.rank.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateGuildRankRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateGuildRankRequestMessage(tree:FuncTree) : void
      {
         this._ranktree = tree.addChild(this._ranktreeFunc);
      }
      
      private function _ranktreeFunc(input:ICustomDataInput) : void
      {
         this.rank = new GuildRankInformation();
         this.rank.deserializeAsync(this._ranktree);
      }
   }
}
