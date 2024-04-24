package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatSmileyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2775;
       
      
      private var _isInitialized:Boolean = false;
      
      public var entityId:Number = 0;
      
      public var smileyId:uint = 0;
      
      public var accountId:uint = 0;
      
      public function ChatSmileyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2775;
      }
      
      public function initChatSmileyMessage(entityId:Number = 0, smileyId:uint = 0, accountId:uint = 0) : ChatSmileyMessage
      {
         this.entityId = entityId;
         this.smileyId = smileyId;
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.entityId = 0;
         this.smileyId = 0;
         this.accountId = 0;
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
         this.serializeAs_ChatSmileyMessage(output);
      }
      
      public function serializeAs_ChatSmileyMessage(output:ICustomDataOutput) : void
      {
         if(this.entityId < -9007199254740992 || this.entityId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element entityId.");
         }
         output.writeDouble(this.entityId);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         output.writeVarShort(this.smileyId);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatSmileyMessage(input);
      }
      
      public function deserializeAs_ChatSmileyMessage(input:ICustomDataInput) : void
      {
         this._entityIdFunc(input);
         this._smileyIdFunc(input);
         this._accountIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatSmileyMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatSmileyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._entityIdFunc);
         tree.addChild(this._smileyIdFunc);
         tree.addChild(this._accountIdFunc);
      }
      
      private function _entityIdFunc(input:ICustomDataInput) : void
      {
         this.entityId = input.readDouble();
         if(this.entityId < -9007199254740992 || this.entityId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element of ChatSmileyMessage.entityId.");
         }
      }
      
      private function _smileyIdFunc(input:ICustomDataInput) : void
      {
         this.smileyId = input.readVarUhShort();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of ChatSmileyMessage.smileyId.");
         }
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of ChatSmileyMessage.accountId.");
         }
      }
   }
}
