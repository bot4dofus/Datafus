package com.ankamagames.dofus.network.messages.game
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaginationAnswerAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1468;
       
      
      private var _isInitialized:Boolean = false;
      
      public var offset:Number = 0;
      
      public var count:uint = 0;
      
      public var total:uint = 0;
      
      public function PaginationAnswerAbstractMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1468;
      }
      
      public function initPaginationAnswerAbstractMessage(offset:Number = 0, count:uint = 0, total:uint = 0) : PaginationAnswerAbstractMessage
      {
         this.offset = offset;
         this.count = count;
         this.total = total;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.offset = 0;
         this.count = 0;
         this.total = 0;
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
         this.serializeAs_PaginationAnswerAbstractMessage(output);
      }
      
      public function serializeAs_PaginationAnswerAbstractMessage(output:ICustomDataOutput) : void
      {
         if(this.offset < 0 || this.offset > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.offset + ") on element offset.");
         }
         output.writeDouble(this.offset);
         if(this.count < 0 || this.count > 4294967295)
         {
            throw new Error("Forbidden value (" + this.count + ") on element count.");
         }
         output.writeUnsignedInt(this.count);
         if(this.total < 0 || this.total > 4294967295)
         {
            throw new Error("Forbidden value (" + this.total + ") on element total.");
         }
         output.writeUnsignedInt(this.total);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaginationAnswerAbstractMessage(input);
      }
      
      public function deserializeAs_PaginationAnswerAbstractMessage(input:ICustomDataInput) : void
      {
         this._offsetFunc(input);
         this._countFunc(input);
         this._totalFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaginationAnswerAbstractMessage(tree);
      }
      
      public function deserializeAsyncAs_PaginationAnswerAbstractMessage(tree:FuncTree) : void
      {
         tree.addChild(this._offsetFunc);
         tree.addChild(this._countFunc);
         tree.addChild(this._totalFunc);
      }
      
      private function _offsetFunc(input:ICustomDataInput) : void
      {
         this.offset = input.readDouble();
         if(this.offset < 0 || this.offset > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.offset + ") on element of PaginationAnswerAbstractMessage.offset.");
         }
      }
      
      private function _countFunc(input:ICustomDataInput) : void
      {
         this.count = input.readUnsignedInt();
         if(this.count < 0 || this.count > 4294967295)
         {
            throw new Error("Forbidden value (" + this.count + ") on element of PaginationAnswerAbstractMessage.count.");
         }
      }
      
      private function _totalFunc(input:ICustomDataInput) : void
      {
         this.total = input.readUnsignedInt();
         if(this.total < 0 || this.total > 4294967295)
         {
            throw new Error("Forbidden value (" + this.total + ") on element of PaginationAnswerAbstractMessage.total.");
         }
      }
   }
}
