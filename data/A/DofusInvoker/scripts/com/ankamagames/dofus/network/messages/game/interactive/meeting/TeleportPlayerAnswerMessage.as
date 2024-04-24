package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportPlayerAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9210;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accept:Boolean = false;
      
      public var requesterId:Number = 0;
      
      public function TeleportPlayerAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9210;
      }
      
      public function initTeleportPlayerAnswerMessage(accept:Boolean = false, requesterId:Number = 0) : TeleportPlayerAnswerMessage
      {
         this.accept = accept;
         this.requesterId = requesterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accept = false;
         this.requesterId = 0;
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
         this.serializeAs_TeleportPlayerAnswerMessage(output);
      }
      
      public function serializeAs_TeleportPlayerAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accept);
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element requesterId.");
         }
         output.writeVarLong(this.requesterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportPlayerAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportPlayerAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptFunc(input);
         this._requesterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportPlayerAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportPlayerAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptFunc);
         tree.addChild(this._requesterIdFunc);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
      
      private function _requesterIdFunc(input:ICustomDataInput) : void
      {
         this.requesterId = input.readVarUhLong();
         if(this.requesterId < 0 || this.requesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.requesterId + ") on element of TeleportPlayerAnswerMessage.requesterId.");
         }
      }
   }
}
