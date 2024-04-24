package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatAbstractClientMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4180;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var content:String = "";
      
      public function ChatAbstractClientMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4180;
      }
      
      public function initChatAbstractClientMessage(content:String = "") : ChatAbstractClientMessage
      {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = "";
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
         this.serializeAs_ChatAbstractClientMessage(output);
      }
      
      public function serializeAs_ChatAbstractClientMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.content);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatAbstractClientMessage(input);
      }
      
      public function deserializeAs_ChatAbstractClientMessage(input:ICustomDataInput) : void
      {
         this._contentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatAbstractClientMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatAbstractClientMessage(tree:FuncTree) : void
      {
         tree.addChild(this._contentFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
   }
}
