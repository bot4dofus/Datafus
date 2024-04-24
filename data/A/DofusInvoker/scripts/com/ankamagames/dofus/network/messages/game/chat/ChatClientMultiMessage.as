package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatClientMultiMessage extends ChatAbstractClientMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2972;
       
      
      private var _isInitialized:Boolean = false;
      
      public var channel:uint = 0;
      
      public function ChatClientMultiMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2972;
      }
      
      public function initChatClientMultiMessage(content:String = "", channel:uint = 0) : ChatClientMultiMessage
      {
         super.initChatAbstractClientMessage(content);
         this.channel = channel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.channel = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ChatClientMultiMessage(output);
      }
      
      public function serializeAs_ChatClientMultiMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatAbstractClientMessage(output);
         output.writeByte(this.channel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatClientMultiMessage(input);
      }
      
      public function deserializeAs_ChatClientMultiMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._channelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatClientMultiMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatClientMultiMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._channelFunc);
      }
      
      private function _channelFunc(input:ICustomDataInput) : void
      {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChatClientMultiMessage.channel.");
         }
      }
   }
}
