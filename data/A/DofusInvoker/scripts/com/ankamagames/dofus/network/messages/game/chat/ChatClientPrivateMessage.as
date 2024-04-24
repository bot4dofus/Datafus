package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatClientPrivateMessage extends ChatAbstractClientMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 12;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var receiver:AbstractPlayerSearchInformation;
      
      private var _receivertree:FuncTree;
      
      public function ChatClientPrivateMessage()
      {
         this.receiver = new AbstractPlayerSearchInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 12;
      }
      
      public function initChatClientPrivateMessage(content:String = "", receiver:AbstractPlayerSearchInformation = null) : ChatClientPrivateMessage
      {
         super.initChatAbstractClientMessage(content);
         this.receiver = receiver;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.receiver = new AbstractPlayerSearchInformation();
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
         this.serializeAs_ChatClientPrivateMessage(output);
      }
      
      public function serializeAs_ChatClientPrivateMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatAbstractClientMessage(output);
         output.writeShort(this.receiver.getTypeId());
         this.receiver.serialize(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatClientPrivateMessage(input);
      }
      
      public function deserializeAs_ChatClientPrivateMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.receiver = ProtocolTypeManager.getInstance(AbstractPlayerSearchInformation,_id1);
         this.receiver.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatClientPrivateMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatClientPrivateMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._receivertree = tree.addChild(this._receivertreeFunc);
      }
      
      private function _receivertreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.receiver = ProtocolTypeManager.getInstance(AbstractPlayerSearchInformation,_id);
         this.receiver.deserializeAsync(this._receivertree);
      }
   }
}
