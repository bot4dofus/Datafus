package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 762;
       
      
      private var _isInitialized:Boolean = false;
      
      public var invitationState:uint = 0;
      
      public function GuildInvitationStateRecrutedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 762;
      }
      
      public function initGuildInvitationStateRecrutedMessage(invitationState:uint = 0) : GuildInvitationStateRecrutedMessage
      {
         this.invitationState = invitationState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.invitationState = 0;
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
         this.serializeAs_GuildInvitationStateRecrutedMessage(output);
      }
      
      public function serializeAs_GuildInvitationStateRecrutedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.invitationState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInvitationStateRecrutedMessage(input);
      }
      
      public function deserializeAs_GuildInvitationStateRecrutedMessage(input:ICustomDataInput) : void
      {
         this._invitationStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInvitationStateRecrutedMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInvitationStateRecrutedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._invitationStateFunc);
      }
      
      private function _invitationStateFunc(input:ICustomDataInput) : void
      {
         this.invitationState = input.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of GuildInvitationStateRecrutedMessage.invitationState.");
         }
      }
   }
}
