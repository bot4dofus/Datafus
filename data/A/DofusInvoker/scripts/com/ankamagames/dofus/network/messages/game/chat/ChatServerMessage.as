package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatServerMessage extends ChatAbstractServerMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1304;
       
      
      private var _isInitialized:Boolean = false;
      
      public var senderId:Number = 0;
      
      [Transient]
      public var senderName:String = "";
      
      public var prefix:String = "";
      
      public var senderAccountId:uint = 0;
      
      public function ChatServerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1304;
      }
      
      public function initChatServerMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "", senderId:Number = 0, senderName:String = "", prefix:String = "", senderAccountId:uint = 0) : ChatServerMessage
      {
         super.initChatAbstractServerMessage(channel,content,timestamp,fingerprint);
         this.senderId = senderId;
         this.senderName = senderName;
         this.prefix = prefix;
         this.senderAccountId = senderAccountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.senderId = 0;
         this.senderName = "";
         this.prefix = "";
         this.senderAccountId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ChatServerMessage(output);
      }
      
      public function serializeAs_ChatServerMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatAbstractServerMessage(output);
         if(this.senderId < -9007199254740992 || this.senderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.senderId + ") on element senderId.");
         }
         output.writeDouble(this.senderId);
         output.writeUTF(this.senderName);
         output.writeUTF(this.prefix);
         if(this.senderAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.senderAccountId + ") on element senderAccountId.");
         }
         output.writeInt(this.senderAccountId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatServerMessage(input);
      }
      
      public function deserializeAs_ChatServerMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._senderIdFunc(input);
         this._senderNameFunc(input);
         this._prefixFunc(input);
         this._senderAccountIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatServerMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatServerMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._senderIdFunc);
         tree.addChild(this._senderNameFunc);
         tree.addChild(this._prefixFunc);
         tree.addChild(this._senderAccountIdFunc);
      }
      
      private function _senderIdFunc(input:ICustomDataInput) : void
      {
         this.senderId = input.readDouble();
         if(this.senderId < -9007199254740992 || this.senderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.senderId + ") on element of ChatServerMessage.senderId.");
         }
      }
      
      private function _senderNameFunc(input:ICustomDataInput) : void
      {
         this.senderName = input.readUTF();
      }
      
      private function _prefixFunc(input:ICustomDataInput) : void
      {
         this.prefix = input.readUTF();
      }
      
      private function _senderAccountIdFunc(input:ICustomDataInput) : void
      {
         this.senderAccountId = input.readInt();
         if(this.senderAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.senderAccountId + ") on element of ChatServerMessage.senderAccountId.");
         }
      }
   }
}
