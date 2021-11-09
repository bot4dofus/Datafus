package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInvitationAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9944;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accept:Boolean = false;
      
      public function AllianceInvitationAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9944;
      }
      
      public function initAllianceInvitationAnswerMessage(accept:Boolean = false) : AllianceInvitationAnswerMessage
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
         this.serializeAs_AllianceInvitationAnswerMessage(output);
      }
      
      public function serializeAs_AllianceInvitationAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitationAnswerMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInvitationAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInvitationAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptFunc);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
