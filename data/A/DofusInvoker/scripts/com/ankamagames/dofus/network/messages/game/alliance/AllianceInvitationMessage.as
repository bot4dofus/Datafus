package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInvitationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5856;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public function AllianceInvitationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5856;
      }
      
      public function initAllianceInvitationMessage(targetId:Number = 0) : AllianceInvitationMessage
      {
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
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
         this.serializeAs_AllianceInvitationMessage(output);
      }
      
      public function serializeAs_AllianceInvitationMessage(output:ICustomDataOutput) : void
      {
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeVarLong(this.targetId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitationMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationMessage(input:ICustomDataInput) : void
      {
         this._targetIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInvitationMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInvitationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readVarUhLong();
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of AllianceInvitationMessage.targetId.");
         }
      }
   }
}
