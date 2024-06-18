package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFactsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6650;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildId:uint = 0;
      
      public function GuildFactsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6650;
      }
      
      public function initGuildFactsRequestMessage(guildId:uint = 0) : GuildFactsRequestMessage
      {
         this.guildId = guildId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildId = 0;
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
         this.serializeAs_GuildFactsRequestMessage(output);
      }
      
      public function serializeAs_GuildFactsRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFactsRequestMessage(input);
      }
      
      public function deserializeAs_GuildFactsRequestMessage(input:ICustomDataInput) : void
      {
         this._guildIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFactsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFactsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guildIdFunc);
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildFactsRequestMessage.guildId.");
         }
      }
   }
}
