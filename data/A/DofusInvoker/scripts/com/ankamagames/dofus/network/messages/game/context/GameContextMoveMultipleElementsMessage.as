package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.context.EntityMovementInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextMoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7545;
       
      
      private var _isInitialized:Boolean = false;
      
      public var movements:Vector.<EntityMovementInformations>;
      
      private var _movementstree:FuncTree;
      
      public function GameContextMoveMultipleElementsMessage()
      {
         this.movements = new Vector.<EntityMovementInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7545;
      }
      
      public function initGameContextMoveMultipleElementsMessage(movements:Vector.<EntityMovementInformations> = null) : GameContextMoveMultipleElementsMessage
      {
         this.movements = movements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.movements = new Vector.<EntityMovementInformations>();
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
         this.serializeAs_GameContextMoveMultipleElementsMessage(output);
      }
      
      public function serializeAs_GameContextMoveMultipleElementsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.movements.length);
         for(var _i1:uint = 0; _i1 < this.movements.length; _i1++)
         {
            (this.movements[_i1] as EntityMovementInformations).serializeAs_EntityMovementInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextMoveMultipleElementsMessage(input);
      }
      
      public function deserializeAs_GameContextMoveMultipleElementsMessage(input:ICustomDataInput) : void
      {
         var _item1:EntityMovementInformations = null;
         var _movementsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _movementsLen; _i1++)
         {
            _item1 = new EntityMovementInformations();
            _item1.deserialize(input);
            this.movements.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextMoveMultipleElementsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextMoveMultipleElementsMessage(tree:FuncTree) : void
      {
         this._movementstree = tree.addChild(this._movementstreeFunc);
      }
      
      private function _movementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._movementstree.addChild(this._movementsFunc);
         }
      }
      
      private function _movementsFunc(input:ICustomDataInput) : void
      {
         var _item:EntityMovementInformations = new EntityMovementInformations();
         _item.deserialize(input);
         this.movements.push(_item);
      }
   }
}
