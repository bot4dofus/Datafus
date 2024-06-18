package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInvitationStateRecrutedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7264;
       
      
      private var _isInitialized:Boolean = false;
      
      public var invitationState:uint = 0;
      
      public function AllianceInvitationStateRecrutedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7264;
      }
      
      public function initAllianceInvitationStateRecrutedMessage(invitationState:uint = 0) : AllianceInvitationStateRecrutedMessage
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
         this.serializeAs_AllianceInvitationStateRecrutedMessage(output);
      }
      
      public function serializeAs_AllianceInvitationStateRecrutedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.invitationState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitationStateRecrutedMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationStateRecrutedMessage(input:ICustomDataInput) : void
      {
         this._invitationStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInvitationStateRecrutedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInvitationStateRecrutedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._invitationStateFunc);
      }
      
      private function _invitationStateFunc(input:ICustomDataInput) : void
      {
         this.invitationState = input.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of AllianceInvitationStateRecrutedMessage.invitationState.");
         }
      }
   }
}
