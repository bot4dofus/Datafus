package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildJoinedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7531;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildInfo:GuildInformations;
      
      public var rankId:uint = 0;
      
      private var _guildInfotree:FuncTree;
      
      public function GuildJoinedMessage()
      {
         this.guildInfo = new GuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7531;
      }
      
      public function initGuildJoinedMessage(guildInfo:GuildInformations = null, rankId:uint = 0) : GuildJoinedMessage
      {
         this.guildInfo = guildInfo;
         this.rankId = rankId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildInfo = new GuildInformations();
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
         this.serializeAs_GuildJoinedMessage(output);
      }
      
      public function serializeAs_GuildJoinedMessage(output:ICustomDataOutput) : void
      {
         this.guildInfo.serializeAs_GuildInformations(output);
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element rankId.");
         }
         output.writeVarInt(this.rankId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildJoinedMessage(input);
      }
      
      public function deserializeAs_GuildJoinedMessage(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserialize(input);
         this._rankIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildJoinedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildJoinedMessage(tree:FuncTree) : void
      {
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
         tree.addChild(this._rankIdFunc);
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new GuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of GuildJoinedMessage.rankId.");
         }
      }
   }
}
