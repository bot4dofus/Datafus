package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportBuddiesAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1318;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accept:Boolean = false;
      
      public function TeleportBuddiesAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1318;
      }
      
      public function initTeleportBuddiesAnswerMessage(accept:Boolean = false) : TeleportBuddiesAnswerMessage
      {
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accept = false;
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
         this.serializeAs_TeleportBuddiesAnswerMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportBuddiesAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportBuddiesAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportBuddiesAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptFunc);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
