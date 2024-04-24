package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionFightUnmarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6447;
       
      
      private var _isInitialized:Boolean = false;
      
      public var markId:int = 0;
      
      public function GameActionFightUnmarkCellsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6447;
      }
      
      public function initGameActionFightUnmarkCellsMessage(actionId:uint = 0, sourceId:Number = 0, markId:int = 0) : GameActionFightUnmarkCellsMessage
      {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.markId = markId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.markId = 0;
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
         this.serializeAs_GameActionFightUnmarkCellsMessage(output);
      }
      
      public function serializeAs_GameActionFightUnmarkCellsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.markId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightUnmarkCellsMessage(input);
      }
      
      public function deserializeAs_GameActionFightUnmarkCellsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._markIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionFightUnmarkCellsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionFightUnmarkCellsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._markIdFunc);
      }
      
      private function _markIdFunc(input:ICustomDataInput) : void
      {
         this.markId = input.readShort();
      }
   }
}
