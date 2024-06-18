package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildMemberLeavingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7246;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kicked:Boolean = false;
      
      public var memberId:Number = 0;
      
      public function GuildMemberLeavingMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7246;
      }
      
      public function initGuildMemberLeavingMessage(kicked:Boolean = false, memberId:Number = 0) : GuildMemberLeavingMessage
      {
         this.kicked = kicked;
         this.memberId = memberId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kicked = false;
         this.memberId = 0;
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
         this.serializeAs_GuildMemberLeavingMessage(output);
      }
      
      public function serializeAs_GuildMemberLeavingMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.kicked);
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMemberLeavingMessage(input);
      }
      
      public function deserializeAs_GuildMemberLeavingMessage(input:ICustomDataInput) : void
      {
         this._kickedFunc(input);
         this._memberIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildMemberLeavingMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildMemberLeavingMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kickedFunc);
         tree.addChild(this._memberIdFunc);
      }
      
      private function _kickedFunc(input:ICustomDataInput) : void
      {
         this.kicked = input.readBoolean();
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildMemberLeavingMessage.memberId.");
         }
      }
   }
}
