package com.ankamagames.dofus.network.messages.game.finishmoves
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FinishMoveSetRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6930;
       
      
      private var _isInitialized:Boolean = false;
      
      public var finishMoveId:uint = 0;
      
      public var finishMoveState:Boolean = false;
      
      public function FinishMoveSetRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6930;
      }
      
      public function initFinishMoveSetRequestMessage(finishMoveId:uint = 0, finishMoveState:Boolean = false) : FinishMoveSetRequestMessage
      {
         this.finishMoveId = finishMoveId;
         this.finishMoveState = finishMoveState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishMoveId = 0;
         this.finishMoveState = false;
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
         this.serializeAs_FinishMoveSetRequestMessage(output);
      }
      
      public function serializeAs_FinishMoveSetRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.finishMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.finishMoveId + ") on element finishMoveId.");
         }
         output.writeInt(this.finishMoveId);
         output.writeBoolean(this.finishMoveState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FinishMoveSetRequestMessage(input);
      }
      
      public function deserializeAs_FinishMoveSetRequestMessage(input:ICustomDataInput) : void
      {
         this._finishMoveIdFunc(input);
         this._finishMoveStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FinishMoveSetRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_FinishMoveSetRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._finishMoveIdFunc);
         tree.addChild(this._finishMoveStateFunc);
      }
      
      private function _finishMoveIdFunc(input:ICustomDataInput) : void
      {
         this.finishMoveId = input.readInt();
         if(this.finishMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.finishMoveId + ") on element of FinishMoveSetRequestMessage.finishMoveId.");
         }
      }
      
      private function _finishMoveStateFunc(input:ICustomDataInput) : void
      {
         this.finishMoveState = input.readBoolean();
      }
   }
}
