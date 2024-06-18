package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightLifePointsGainMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6590;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var delta:uint = 0;
      
      public function GameActionFightLifePointsGainMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6590;
      }
      
      public function initGameActionFightLifePointsGainMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, delta:uint = 0) : GameActionFightLifePointsGainMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.delta = delta;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.delta = 0;
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
         this.serializeAs_GameActionFightLifePointsGainMessage(output);
      }
      
      public function serializeAs_GameActionFightLifePointsGainMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.delta < 0)
         {
            throw new Error("Forbidden value (" + this.delta + ") on element delta.");
         }
         output.writeVarInt(this.delta);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightLifePointsGainMessage(input);
      }
      
      public function deserializeAs_GameActionFightLifePointsGainMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._deltaFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightLifePointsGainMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightLifePointsGainMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._deltaFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightLifePointsGainMessage.targetId.");
         }
      }
      
      private function _deltaFunc(input:ICustomDataInput) : void
      {
         this.delta = input.readVarUhInt();
         if(this.delta < 0)
         {
            throw new Error("Forbidden value (" + this.delta + ") on element of GameActionFightLifePointsGainMessage.delta.");
         }
      }
   }
}
