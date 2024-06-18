package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HelloConnectMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5586;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var salt:String = "";
      
      public var key:Vector.<int>;
      
      private var _keytree:FuncTree;
      
      public function HelloConnectMessage()
      {
         this.key = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5586;
      }
      
      public function initHelloConnectMessage(salt:String = "", key:Vector.<int> = null) : HelloConnectMessage
      {
         this.salt = salt;
         this.key = key;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.salt = "";
         this.key = new Vector.<int>();
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
         this.serializeAs_HelloConnectMessage(output);
      }
      
      public function serializeAs_HelloConnectMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.salt);
         output.writeVarInt(this.key.length);
         for(var _i2:uint = 0; _i2 < this.key.length; _i2++)
         {
            output.writeByte(this.key[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HelloConnectMessage(input);
      }
      
      public function deserializeAs_HelloConnectMessage(input:ICustomDataInput) : void
      {
         var _val2:int = 0;
         this._saltFunc(input);
         var _keyLen:uint = input.readVarInt();
         for(var _i2:uint = 0; _i2 < _keyLen; _i2++)
         {
            _val2 = input.readByte();
            this.key.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HelloConnectMessage(tree);
      }
      
      public function deserializeAsyncAs_HelloConnectMessage(tree:FuncTree) : void
      {
         tree.addChild(this._saltFunc);
         this._keytree = tree.addChild(this._keytreeFunc);
      }
      
      private function _saltFunc(input:ICustomDataInput) : void
      {
         this.salt = input.readUTF();
      }
      
      private function _keytreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readVarInt();
         for(var i:uint = 0; i < length; i++)
         {
            this._keytree.addChild(this._keyFunc);
         }
      }
      
      private function _keyFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readByte();
         this.key.push(_val);
      }
   }
}
