package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildJoinAutomaticallyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2737;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildId:int = 0;
      
      public function GuildJoinAutomaticallyRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2737;
      }
      
      public function initGuildJoinAutomaticallyRequestMessage(guildId:int = 0) : GuildJoinAutomaticallyRequestMessage
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
         this.serializeAs_GuildJoinAutomaticallyRequestMessage(output);
      }
      
      public function serializeAs_GuildJoinAutomaticallyRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.guildId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildJoinAutomaticallyRequestMessage(input);
      }
      
      public function deserializeAs_GuildJoinAutomaticallyRequestMessage(input:ICustomDataInput) : void
      {
         this._guildIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildJoinAutomaticallyRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildJoinAutomaticallyRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guildIdFunc);
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readInt();
      }
   }
}
