package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightLifePointsLostMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3266;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var loss:uint = 0;
      
      public var permanentDamages:uint = 0;
      
      public var elementId:int = 0;
      
      public function GameActionFightLifePointsLostMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3266;
      }
      
      public function initGameActionFightLifePointsLostMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, loss:uint = 0, permanentDamages:uint = 0, elementId:int = 0) : GameActionFightLifePointsLostMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.loss = loss;
         this.permanentDamages = permanentDamages;
         this.elementId = elementId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.loss = 0;
         this.permanentDamages = 0;
         this.elementId = 0;
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
         this.serializeAs_GameActionFightLifePointsLostMessage(output);
      }
      
      public function serializeAs_GameActionFightLifePointsLostMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element loss.");
         }
         output.writeVarInt(this.loss);
         if(this.permanentDamages < 0)
         {
            throw new Error("Forbidden value (" + this.permanentDamages + ") on element permanentDamages.");
         }
         output.writeVarInt(this.permanentDamages);
         output.writeVarInt(this.elementId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightLifePointsLostMessage(input);
      }
      
      public function deserializeAs_GameActionFightLifePointsLostMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._lossFunc(input);
         this._permanentDamagesFunc(input);
         this._elementIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightLifePointsLostMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightLifePointsLostMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._lossFunc);
         tree.addChild(this._permanentDamagesFunc);
         tree.addChild(this._elementIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightLifePointsLostMessage.targetId.");
         }
      }
      
      private function _lossFunc(input:ICustomDataInput) : void
      {
         this.loss = input.readVarUhInt();
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element of GameActionFightLifePointsLostMessage.loss.");
         }
      }
      
      private function _permanentDamagesFunc(input:ICustomDataInput) : void
      {
         this.permanentDamages = input.readVarUhInt();
         if(this.permanentDamages < 0)
         {
            throw new Error("Forbidden value (" + this.permanentDamages + ") on element of GameActionFightLifePointsLostMessage.permanentDamages.");
         }
      }
      
      private function _elementIdFunc(input:ICustomDataInput) : void
      {
         this.elementId = input.readVarInt();
      }
   }
}
