package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SequenceNumberMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9764;
       
      
      private var _isInitialized:Boolean = false;
      
      public var number:uint = 0;
      
      public function SequenceNumberMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9764;
      }
      
      public function initSequenceNumberMessage(number:uint = 0) : SequenceNumberMessage
      {
         this.number = number;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.number = 0;
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
         this.serializeAs_SequenceNumberMessage(output);
      }
      
      public function serializeAs_SequenceNumberMessage(output:ICustomDataOutput) : void
      {
         if(this.number < 0 || this.number > 65535)
         {
            throw new Error("Forbidden value (" + this.number + ") on element number.");
         }
         output.writeShort(this.number);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SequenceNumberMessage(input);
      }
      
      public function deserializeAs_SequenceNumberMessage(input:ICustomDataInput) : void
      {
         this._numberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SequenceNumberMessage(tree);
      }
      
      public function deserializeAsyncAs_SequenceNumberMessage(tree:FuncTree) : void
      {
         tree.addChild(this._numberFunc);
      }
      
      private function _numberFunc(input:ICustomDataInput) : void
      {
         this.number = input.readUnsignedShort();
         if(this.number < 0 || this.number > 65535)
         {
            throw new Error("Forbidden value (" + this.number + ") on element of SequenceNumberMessage.number.");
         }
      }
   }
}
