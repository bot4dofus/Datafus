package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatSmileyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2649;
       
      
      private var _isInitialized:Boolean = false;
      
      public var smileyId:uint = 0;
      
      public function ChatSmileyRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2649;
      }
      
      public function initChatSmileyRequestMessage(smileyId:uint = 0) : ChatSmileyRequestMessage
      {
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.smileyId = 0;
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
         this.serializeAs_ChatSmileyRequestMessage(output);
      }
      
      public function serializeAs_ChatSmileyRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         output.writeVarShort(this.smileyId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatSmileyRequestMessage(input);
      }
      
      public function deserializeAs_ChatSmileyRequestMessage(input:ICustomDataInput) : void
      {
         this._smileyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatSmileyRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatSmileyRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._smileyIdFunc);
      }
      
      private function _smileyIdFunc(input:ICustomDataInput) : void
      {
         this.smileyId = input.readVarUhShort();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyRequestMessage.smileyId.");
         }
      }
   }
}
