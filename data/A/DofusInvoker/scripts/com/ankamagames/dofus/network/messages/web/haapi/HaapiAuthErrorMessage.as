package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiAuthErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1892;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public function HaapiAuthErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1892;
      }
      
      public function initHaapiAuthErrorMessage(type:uint = 0) : HaapiAuthErrorMessage
      {
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_HaapiAuthErrorMessage(output);
      }
      
      public function serializeAs_HaapiAuthErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiAuthErrorMessage(input);
      }
      
      public function deserializeAs_HaapiAuthErrorMessage(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiAuthErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiAuthErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of HaapiAuthErrorMessage.type.");
         }
      }
   }
}
