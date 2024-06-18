package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightPointsVariationMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8927;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var delta:int = 0;
      
      public function GameActionFightPointsVariationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8927;
      }
      
      public function initGameActionFightPointsVariationMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0, delta:int = 0) : GameActionFightPointsVariationMessage
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
         this.serializeAs_GameActionFightPointsVariationMessage(output);
      }
      
      public function serializeAs_GameActionFightPointsVariationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         output.writeShort(this.delta);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightPointsVariationMessage(input);
      }
      
      public function deserializeAs_GameActionFightPointsVariationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetIdFunc(input);
         this._deltaFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightPointsVariationMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightPointsVariationMessage(tree:FuncTree) : void
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
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameActionFightPointsVariationMessage.targetId.");
         }
      }
      
      private function _deltaFunc(input:ICustomDataInput) : void
      {
         this.delta = input.readShort();
      }
   }
}
