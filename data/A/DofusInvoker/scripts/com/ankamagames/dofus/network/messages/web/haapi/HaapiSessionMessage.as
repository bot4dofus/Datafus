package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiSessionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 407;
       
      
      private var _isInitialized:Boolean = false;
      
      public var key:String = "";
      
      public var type:uint = 0;
      
      public function HaapiSessionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 407;
      }
      
      public function initHaapiSessionMessage(key:String = "", type:uint = 0) : HaapiSessionMessage
      {
         this.key = key;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.key = "";
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
         this.serializeAs_HaapiSessionMessage(output);
      }
      
      public function serializeAs_HaapiSessionMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.key);
         output.writeByte(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiSessionMessage(input);
      }
      
      public function deserializeAs_HaapiSessionMessage(input:ICustomDataInput) : void
      {
         this._keyFunc(input);
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiSessionMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiSessionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._keyFunc);
         tree.addChild(this._typeFunc);
      }
      
      private function _keyFunc(input:ICustomDataInput) : void
      {
         this.key = input.readUTF();
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of HaapiSessionMessage.type.");
         }
      }
   }
}
