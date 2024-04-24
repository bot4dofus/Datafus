package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionAcknowledgementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6232;
       
      
      private var _isInitialized:Boolean = false;
      
      public var valid:Boolean = false;
      
      public var actionId:int = 0;
      
      public function GameActionAcknowledgementMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6232;
      }
      
      public function initGameActionAcknowledgementMessage(valid:Boolean = false, actionId:int = 0) : GameActionAcknowledgementMessage
      {
         this.valid = valid;
         this.actionId = actionId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.valid = false;
         this.actionId = 0;
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
         this.serializeAs_GameActionAcknowledgementMessage(output);
      }
      
      public function serializeAs_GameActionAcknowledgementMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.valid);
         output.writeByte(this.actionId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionAcknowledgementMessage(input);
      }
      
      public function deserializeAs_GameActionAcknowledgementMessage(input:ICustomDataInput) : void
      {
         this._validFunc(input);
         this._actionIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionAcknowledgementMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionAcknowledgementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._validFunc);
         tree.addChild(this._actionIdFunc);
      }
      
      private function _validFunc(input:ICustomDataInput) : void
      {
         this.valid = input.readBoolean();
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readByte();
      }
   }
}
