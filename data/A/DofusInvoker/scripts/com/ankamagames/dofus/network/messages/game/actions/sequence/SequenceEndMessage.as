package com.ankamagames.dofus.network.messages.game.actions.sequence
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SequenceEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1586;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actionId:uint = 0;
      
      public var authorId:Number = 0;
      
      public var sequenceType:int = 0;
      
      public function SequenceEndMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1586;
      }
      
      public function initSequenceEndMessage(actionId:uint = 0, authorId:Number = 0, sequenceType:int = 0) : SequenceEndMessage
      {
         this.actionId = actionId;
         this.authorId = authorId;
         this.sequenceType = sequenceType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actionId = 0;
         this.authorId = 0;
         this.sequenceType = 0;
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
         this.serializeAs_SequenceEndMessage(output);
      }
      
      public function serializeAs_SequenceEndMessage(output:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         output.writeVarShort(this.actionId);
         if(this.authorId < -9007199254740992 || this.authorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.authorId + ") on element authorId.");
         }
         output.writeDouble(this.authorId);
         output.writeByte(this.sequenceType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SequenceEndMessage(input);
      }
      
      public function deserializeAs_SequenceEndMessage(input:ICustomDataInput) : void
      {
         this._actionIdFunc(input);
         this._authorIdFunc(input);
         this._sequenceTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SequenceEndMessage(tree);
      }
      
      public function deserializeAsyncAs_SequenceEndMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionIdFunc);
         tree.addChild(this._authorIdFunc);
         tree.addChild(this._sequenceTypeFunc);
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readVarUhShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of SequenceEndMessage.actionId.");
         }
      }
      
      private function _authorIdFunc(input:ICustomDataInput) : void
      {
         this.authorId = input.readDouble();
         if(this.authorId < -9007199254740992 || this.authorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.authorId + ") on element of SequenceEndMessage.authorId.");
         }
      }
      
      private function _sequenceTypeFunc(input:ICustomDataInput) : void
      {
         this.sequenceType = input.readByte();
      }
   }
}
