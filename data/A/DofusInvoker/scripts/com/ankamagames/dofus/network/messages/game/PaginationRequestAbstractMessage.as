package com.ankamagames.dofus.network.messages.game
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaginationRequestAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8327;
       
      
      private var _isInitialized:Boolean = false;
      
      public var offset:Number = 0;
      
      public var count:uint = 0;
      
      public function PaginationRequestAbstractMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8327;
      }
      
      public function initPaginationRequestAbstractMessage(offset:Number = 0, count:uint = 0) : PaginationRequestAbstractMessage
      {
         this.offset = offset;
         this.count = count;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.offset = 0;
         this.count = 0;
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
         this.serializeAs_PaginationRequestAbstractMessage(output);
      }
      
      public function serializeAs_PaginationRequestAbstractMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaginationRequestAbstractMessage(input);
      }
      
      public function deserializeAs_PaginationRequestAbstractMessage(input:ICustomDataInput) : void
      {
         this._offsetFunc(input);
         this._countFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaginationRequestAbstractMessage(tree);
      }
      
      public function deserializeAsyncAs_PaginationRequestAbstractMessage(tree:FuncTree) : void
      {
         tree.addChild(this._offsetFunc);
         tree.addChild(this._countFunc);
      }
      
      private function _offsetFunc(input:ICustomDataInput) : void
      {
         this.offset = input.readDouble();
         if(this.offset < 0 || this.offset > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.offset + ") on element of PaginationRequestAbstractMessage.offset.");
         }
      }
      
      private function _countFunc(input:ICustomDataInput) : void
      {
         this.count = input.readUnsignedInt();
         if(this.count < 0 || this.count > 4294967295)
         {
            throw new Error("Forbidden value (" + this.count + ") on element of PaginationRequestAbstractMessage.count.");
         }
      }
   }
}
