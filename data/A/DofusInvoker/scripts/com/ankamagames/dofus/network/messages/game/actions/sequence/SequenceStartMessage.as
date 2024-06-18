package com.ankamagames.dofus.network.messages.game.actions.sequence
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SequenceStartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7231;
       
      
      private var _isInitialized:Boolean = false;
      
      public var sequenceType:int = 0;
      
      public var authorId:Number = 0;
      
      public function SequenceStartMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7231;
      }
      
      public function initSequenceStartMessage(sequenceType:int = 0, authorId:Number = 0) : SequenceStartMessage
      {
         this.sequenceType = sequenceType;
         this.authorId = authorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sequenceType = 0;
         this.authorId = 0;
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
         this.serializeAs_SequenceStartMessage(output);
      }
      
      public function serializeAs_SequenceStartMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.sequenceType);
         if(this.authorId < -9007199254740992 || this.authorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.authorId + ") on element authorId.");
         }
         output.writeDouble(this.authorId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SequenceStartMessage(input);
      }
      
      public function deserializeAs_SequenceStartMessage(input:ICustomDataInput) : void
      {
         this._sequenceTypeFunc(input);
         this._authorIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SequenceStartMessage(tree);
      }
      
      public function deserializeAsyncAs_SequenceStartMessage(tree:FuncTree) : void
      {
         tree.addChild(this._sequenceTypeFunc);
         tree.addChild(this._authorIdFunc);
      }
      
      private function _sequenceTypeFunc(input:ICustomDataInput) : void
      {
         this.sequenceType = input.readByte();
      }
      
      private function _authorIdFunc(input:ICustomDataInput) : void
      {
         this.authorId = input.readDouble();
         if(this.authorId < -9007199254740992 || this.authorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.authorId + ") on element of SequenceStartMessage.authorId.");
         }
      }
   }
}
