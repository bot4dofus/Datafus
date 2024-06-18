package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiCancelBidRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6447;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public var type:uint = 0;
      
      public function HaapiCancelBidRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6447;
      }
      
      public function initHaapiCancelBidRequestMessage(id:Number = 0, type:uint = 0) : HaapiCancelBidRequestMessage
      {
         this.id = id;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.type = 0;
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
         this.serializeAs_HaapiCancelBidRequestMessage(output);
      }
      
      public function serializeAs_HaapiCancelBidRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiCancelBidRequestMessage(input);
      }
      
      public function deserializeAs_HaapiCancelBidRequestMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiCancelBidRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiCancelBidRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._typeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of HaapiCancelBidRequestMessage.id.");
         }
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of HaapiCancelBidRequestMessage.type.");
         }
      }
   }
}
