package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ArenaFightAnswerAcknowledgementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2033;
       
      
      private var _isInitialized:Boolean = false;
      
      public var acknowledged:Boolean = false;
      
      public function ArenaFightAnswerAcknowledgementMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2033;
      }
      
      public function initArenaFightAnswerAcknowledgementMessage(acknowledged:Boolean = false) : ArenaFightAnswerAcknowledgementMessage
      {
         this.acknowledged = acknowledged;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.acknowledged = false;
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
         this.serializeAs_ArenaFightAnswerAcknowledgementMessage(output);
      }
      
      public function serializeAs_ArenaFightAnswerAcknowledgementMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.acknowledged);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaFightAnswerAcknowledgementMessage(input);
      }
      
      public function deserializeAs_ArenaFightAnswerAcknowledgementMessage(input:ICustomDataInput) : void
      {
         this._acknowledgedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaFightAnswerAcknowledgementMessage(tree);
      }
      
      public function deserializeAsyncAs_ArenaFightAnswerAcknowledgementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acknowledgedFunc);
      }
      
      private function _acknowledgedFunc(input:ICustomDataInput) : void
      {
         this.acknowledged = input.readBoolean();
      }
   }
}
