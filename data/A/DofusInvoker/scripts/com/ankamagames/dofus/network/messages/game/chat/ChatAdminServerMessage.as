package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatAdminServerMessage extends ChatServerMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2080;
       
      
      private var _isInitialized:Boolean = false;
      
      public function ChatAdminServerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2080;
      }
      
      public function initChatAdminServerMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "", senderId:Number = 0, senderName:String = "", prefix:String = "", senderAccountId:uint = 0) : ChatAdminServerMessage
      {
         super.initChatServerMessage(channel,content,timestamp,fingerprint,senderId,senderName,prefix,senderAccountId);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_ChatAdminServerMessage(output);
      }
      
      public function serializeAs_ChatAdminServerMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatServerMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatAdminServerMessage(input);
      }
      
      public function deserializeAs_ChatAdminServerMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatAdminServerMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatAdminServerMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
