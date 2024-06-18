package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NpcDialogReplyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4752;
       
      
      private var _isInitialized:Boolean = false;
      
      public var replyId:uint = 0;
      
      public function NpcDialogReplyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4752;
      }
      
      public function initNpcDialogReplyMessage(replyId:uint = 0) : NpcDialogReplyMessage
      {
         this.replyId = replyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.replyId = 0;
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
         this.serializeAs_NpcDialogReplyMessage(output);
      }
      
      public function serializeAs_NpcDialogReplyMessage(output:ICustomDataOutput) : void
      {
         if(this.replyId < 0)
         {
            throw new Error("Forbidden value (" + this.replyId + ") on element replyId.");
         }
         output.writeVarInt(this.replyId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NpcDialogReplyMessage(input);
      }
      
      public function deserializeAs_NpcDialogReplyMessage(input:ICustomDataInput) : void
      {
         this._replyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NpcDialogReplyMessage(tree);
      }
      
      public function deserializeAsyncAs_NpcDialogReplyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._replyIdFunc);
      }
      
      private function _replyIdFunc(input:ICustomDataInput) : void
      {
         this.replyId = input.readVarUhInt();
         if(this.replyId < 0)
         {
            throw new Error("Forbidden value (" + this.replyId + ") on element of NpcDialogReplyMessage.replyId.");
         }
      }
   }
}
