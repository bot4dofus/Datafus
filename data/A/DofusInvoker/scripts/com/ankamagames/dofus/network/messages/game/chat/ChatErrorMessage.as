package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6523;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 0;
      
      public function ChatErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6523;
      }
      
      public function initChatErrorMessage(reason:uint = 0) : ChatErrorMessage
      {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.reason = 0;
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
         this.serializeAs_ChatErrorMessage(output);
      }
      
      public function serializeAs_ChatErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatErrorMessage(input);
      }
      
      public function deserializeAs_ChatErrorMessage(input:ICustomDataInput) : void
      {
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._reasonFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of ChatErrorMessage.reason.");
         }
      }
   }
}
