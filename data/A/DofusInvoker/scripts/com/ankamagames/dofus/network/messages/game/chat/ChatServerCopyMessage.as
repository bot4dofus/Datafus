package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatServerCopyMessage extends ChatAbstractServerMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7820;
       
      
      private var _isInitialized:Boolean = false;
      
      public var receiverId:Number = 0;
      
      [Transient]
      public var receiverName:String = "";
      
      public function ChatServerCopyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7820;
      }
      
      public function initChatServerCopyMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "", receiverId:Number = 0, receiverName:String = "") : ChatServerCopyMessage
      {
         super.initChatAbstractServerMessage(channel,content,timestamp,fingerprint);
         this.receiverId = receiverId;
         this.receiverName = receiverName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.receiverId = 0;
         this.receiverName = "";
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
         this.serializeAs_ChatServerCopyMessage(output);
      }
      
      public function serializeAs_ChatServerCopyMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatAbstractServerMessage(output);
         if(this.receiverId < 0 || this.receiverId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.receiverId + ") on element receiverId.");
         }
         output.writeVarLong(this.receiverId);
         output.writeUTF(this.receiverName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatServerCopyMessage(input);
      }
      
      public function deserializeAs_ChatServerCopyMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._receiverIdFunc(input);
         this._receiverNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatServerCopyMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatServerCopyMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._receiverIdFunc);
         tree.addChild(this._receiverNameFunc);
      }
      
      private function _receiverIdFunc(input:ICustomDataInput) : void
      {
         this.receiverId = input.readVarUhLong();
         if(this.receiverId < 0 || this.receiverId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.receiverId + ") on element of ChatServerCopyMessage.receiverId.");
         }
      }
      
      private function _receiverNameFunc(input:ICustomDataInput) : void
      {
         this.receiverName = input.readUTF();
      }
   }
}
