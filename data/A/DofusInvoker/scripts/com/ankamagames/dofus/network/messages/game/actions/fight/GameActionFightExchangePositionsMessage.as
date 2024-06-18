package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightExchangePositionsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8976;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var casterCellId:int = 0;
      
      public var targetCellId:int = 0;
      
      public function GameActionFightExchangePositionsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8976;
      }
      
      public function initGameActionFightExchangePositionsMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, casterCellId:int = 0, targetCellId:int = 0) : GameActionFightExchangePositionsMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.casterCellId = casterCellId;
         this.targetCellId = targetCellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.casterCellId = 0;
         this.targetCellId = 0;
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
         this.serializeAs_GameActionFightExchangePositionsMessage(output);
      }
      
      public function serializeAs_GameActionFightExchangePositionsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.casterCellId < -1 || this.casterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element casterCellId.");
         }
         output.writeShort(this.casterCellId);
         if(this.targetCellId < -1 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
         }
         output.writeShort(this.targetCellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightExchangePositionsMessage(input);
      }
      
      public function deserializeAs_GameActionFightExchangePositionsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._casterCellIdFunc(input);
         this._targetCellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightExchangePositionsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightExchangePositionsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._casterCellIdFunc);
         tree.addChild(this._targetCellIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightExchangePositionsMessage.targetId.");
         }
      }
      
      private function _casterCellIdFunc(input:ICustomDataInput) : void
      {
         this.casterCellId = input.readShort();
         if(this.casterCellId < -1 || this.casterCellId > 559)
         {
            throw new Error("Forbidden value (" + this.casterCellId + ") on element of GameActionFightExchangePositionsMessage.casterCellId.");
         }
      }
      
      private function _targetCellIdFunc(input:ICustomDataInput) : void
      {
         this.targetCellId = input.readShort();
         if(this.targetCellId < -1 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameActionFightExchangePositionsMessage.targetCellId.");
         }
      }
   }
}
