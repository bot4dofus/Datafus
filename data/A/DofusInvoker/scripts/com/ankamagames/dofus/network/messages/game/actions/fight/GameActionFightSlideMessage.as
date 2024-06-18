package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightSlideMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7006;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var startCellId:int = 0;
      
      public var endCellId:int = 0;
      
      public function GameActionFightSlideMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7006;
      }
      
      public function initGameActionFightSlideMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, startCellId:int = 0, endCellId:int = 0) : GameActionFightSlideMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.startCellId = startCellId;
         this.endCellId = endCellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.targetId = 0;
         this.startCellId = 0;
         this.endCellId = 0;
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
         this.serializeAs_GameActionFightSlideMessage(output);
      }
      
      public function serializeAs_GameActionFightSlideMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.startCellId < -1 || this.startCellId > 559)
         {
            throw new Error("Forbidden value (" + this.startCellId + ") on element startCellId.");
         }
         output.writeShort(this.startCellId);
         if(this.endCellId < -1 || this.endCellId > 559)
         {
            throw new Error("Forbidden value (" + this.endCellId + ") on element endCellId.");
         }
         output.writeShort(this.endCellId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightSlideMessage(input);
      }
      
      public function deserializeAs_GameActionFightSlideMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._startCellIdFunc(input);
         this._endCellIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightSlideMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightSlideMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._startCellIdFunc);
         tree.addChild(this._endCellIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightSlideMessage.targetId.");
         }
      }
      
      private function _startCellIdFunc(input:ICustomDataInput) : void
      {
         this.startCellId = input.readShort();
         if(this.startCellId < -1 || this.startCellId > 559)
         {
            throw new Error("Forbidden value (" + this.startCellId + ") on element of GameActionFightSlideMessage.startCellId.");
         }
      }
      
      private function _endCellIdFunc(input:ICustomDataInput) : void
      {
         this.endCellId = input.readShort();
         if(this.endCellId < -1 || this.endCellId > 559)
         {
            throw new Error("Forbidden value (" + this.endCellId + ") on element of GameActionFightSlideMessage.endCellId.");
         }
      }
   }
}
