package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInvitationAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5328;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accept:Boolean = false;
      
      public function GuildInvitationAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5328;
      }
      
      public function initGuildInvitationAnswerMessage(accept:Boolean = false) : GuildInvitationAnswerMessage
      {
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accept = false;
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
         this.serializeAs_GuildInvitationAnswerMessage(output);
      }
      
      public function serializeAs_GuildInvitationAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInvitationAnswerMessage(input);
      }
      
      public function deserializeAs_GuildInvitationAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInvitationAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInvitationAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptFunc);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
