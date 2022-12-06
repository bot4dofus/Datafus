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
   
   public class GuildRanksMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1814;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ranks:Vector.<GuildRankInformation>;
      
      private var _rankstree:FuncTree;
      
      public function GuildRanksMessage()
      {
         this.ranks = new Vector.<GuildRankInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1814;
      }
      
      public function initGuildRanksMessage(ranks:Vector.<GuildRankInformation> = null) : GuildRanksMessage
      {
         this.ranks = ranks;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ranks = new Vector.<GuildRankInformation>();
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
         this.serializeAs_GuildRanksMessage(output);
      }
      
      public function serializeAs_GuildRanksMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ranks.length);
         for(var _i1:uint = 0; _i1 < this.ranks.length; _i1++)
         {
            (this.ranks[_i1] as GuildRankInformation).serializeAs_GuildRankInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildRanksMessage(input);
      }
      
      public function deserializeAs_GuildRanksMessage(input:ICustomDataInput) : void
      {
         var _item1:GuildRankInformation = null;
         var _ranksLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _ranksLen; _i1++)
         {
            _item1 = new GuildRankInformation();
            _item1.deserialize(input);
            this.ranks.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildRanksMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildRanksMessage(tree:FuncTree) : void
      {
         this._rankstree = tree.addChild(this._rankstreeFunc);
      }
      
      private function _rankstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._rankstree.addChild(this._ranksFunc);
         }
      }
      
      private function _ranksFunc(input:ICustomDataInput) : void
      {
         var _item:GuildRankInformation = new GuildRankInformation();
         _item.deserialize(input);
         this.ranks.push(_item);
      }
   }
}
