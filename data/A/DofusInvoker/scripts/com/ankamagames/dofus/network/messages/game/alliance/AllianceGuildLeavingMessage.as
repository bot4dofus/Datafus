package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceGuildLeavingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1732;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kicked:Boolean = false;
      
      public var guildId:uint = 0;
      
      public function AllianceGuildLeavingMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1732;
      }
      
      public function initAllianceGuildLeavingMessage(kicked:Boolean = false, guildId:uint = 0) : AllianceGuildLeavingMessage
      {
         this.kicked = kicked;
         this.guildId = guildId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kicked = false;
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
         this.serializeAs_AllianceGuildLeavingMessage(output);
      }
      
      public function serializeAs_AllianceGuildLeavingMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.kicked);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceGuildLeavingMessage(input);
      }
      
      public function deserializeAs_AllianceGuildLeavingMessage(input:ICustomDataInput) : void
      {
         this._kickedFunc(input);
         this._guildIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceGuildLeavingMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceGuildLeavingMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kickedFunc);
         tree.addChild(this._guildIdFunc);
      }
      
      private function _kickedFunc(input:ICustomDataInput) : void
      {
         this.kicked = input.readBoolean();
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of AllianceGuildLeavingMessage.guildId.");
         }
      }
   }
}
