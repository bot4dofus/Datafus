package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightReduceDamagesMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1547;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var amount:uint = 0;
      
      public function GameActionFightReduceDamagesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1547;
      }
      
      public function initGameActionFightReduceDamagesMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, amount:uint = 0) : GameActionFightReduceDamagesMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.amount = amount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.amount = 0;
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
         this.serializeAs_GameActionFightReduceDamagesMessage(output);
      }
      
      public function serializeAs_GameActionFightReduceDamagesMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarInt(this.amount);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightReduceDamagesMessage(input);
      }
      
      public function deserializeAs_GameActionFightReduceDamagesMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._amountFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightReduceDamagesMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightReduceDamagesMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._amountFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightReduceDamagesMessage.targetId.");
         }
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhInt();
         if(this.amount < 0)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of GameActionFightReduceDamagesMessage.amount.");
         }
      }
   }
}
