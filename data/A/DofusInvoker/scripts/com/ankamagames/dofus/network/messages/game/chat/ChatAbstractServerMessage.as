package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatAbstractServerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1770;
       
      
      private var _isInitialized:Boolean = false;
      
      public var channel:uint = 0;
      
      [Transient]
      public var content:String = "";
      
      public var timestamp:uint = 0;
      
      public var fingerprint:String = "";
      
      public function ChatAbstractServerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1770;
      }
      
      public function initChatAbstractServerMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "") : ChatAbstractServerMessage
      {
         this.channel = channel;
         this.content = content;
         this.timestamp = timestamp;
         this.fingerprint = fingerprint;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.channel = 0;
         this.content = "";
         this.timestamp = 0;
         this.fingerprint = "";
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
         this.serializeAs_ChatAbstractServerMessage(output);
      }
      
      public function serializeAs_ChatAbstractServerMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.channel);
         output.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         output.writeInt(this.timestamp);
         output.writeUTF(this.fingerprint);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatAbstractServerMessage(input);
      }
      
      public function deserializeAs_ChatAbstractServerMessage(input:ICustomDataInput) : void
      {
         this._channelFunc(input);
         this._contentFunc(input);
         this._timestampFunc(input);
         this._fingerprintFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatAbstractServerMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatAbstractServerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._channelFunc);
         tree.addChild(this._contentFunc);
         tree.addChild(this._timestampFunc);
         tree.addChild(this._fingerprintFunc);
      }
      
      private function _channelFunc(input:ICustomDataInput) : void
      {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChatAbstractServerMessage.channel.");
         }
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
      
      private function _timestampFunc(input:ICustomDataInput) : void
      {
         this.timestamp = input.readInt();
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of ChatAbstractServerMessage.timestamp.");
         }
      }
      
      private function _fingerprintFunc(input:ICustomDataInput) : void
      {
         this.fingerprint = input.readUTF();
      }
   }
}
