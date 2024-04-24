package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LocalizedChatSmileyMessage extends ChatSmileyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9190;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cellId:uint = 0;
      
      public function LocalizedChatSmileyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9190;
      }
      
      public function initLocalizedChatSmileyMessage(entityId:Number = 0, smileyId:uint = 0, accountId:uint = 0, cellId:uint = 0) : LocalizedChatSmileyMessage
      {
         super.initChatSmileyMessage(entityId,smileyId,accountId);
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cellId = 0;
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
         this.serializeAs_LocalizedChatSmileyMessage(output);
      }
      
      public function serializeAs_LocalizedChatSmileyMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ChatSmileyMessage(output);
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LocalizedChatSmileyMessage(input);
      }
      
      public function deserializeAs_LocalizedChatSmileyMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._cellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LocalizedChatSmileyMessage(tree);
      }
      
      public function deserializeAsyncAs_LocalizedChatSmileyMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._cellIdFunc);
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of LocalizedChatSmileyMessage.cellId.");
         }
      }
   }
}
