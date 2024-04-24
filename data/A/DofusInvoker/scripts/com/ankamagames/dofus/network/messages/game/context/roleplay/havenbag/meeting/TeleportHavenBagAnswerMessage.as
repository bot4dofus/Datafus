package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportHavenBagAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4601;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accept:Boolean = false;
      
      public function TeleportHavenBagAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4601;
      }
      
      public function initTeleportHavenBagAnswerMessage(accept:Boolean = false) : TeleportHavenBagAnswerMessage
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
         this.serializeAs_TeleportHavenBagAnswerMessage(output);
      }
      
      public function serializeAs_TeleportHavenBagAnswerMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportHavenBagAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportHavenBagAnswerMessage(input:ICustomDataInput) : void
      {
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportHavenBagAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportHavenBagAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptFunc);
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}
