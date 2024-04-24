package com.ankamagames.dofus.network.messages.game.finishmoves
{
   import com.ankamagames.dofus.network.types.game.finishmoves.FinishMoveInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FinishMoveListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4314;
       
      
      private var _isInitialized:Boolean = false;
      
      public var finishMoves:Vector.<FinishMoveInformations>;
      
      private var _finishMovestree:FuncTree;
      
      public function FinishMoveListMessage()
      {
         this.finishMoves = new Vector.<FinishMoveInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4314;
      }
      
      public function initFinishMoveListMessage(finishMoves:Vector.<FinishMoveInformations> = null) : FinishMoveListMessage
      {
         this.finishMoves = finishMoves;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishMoves = new Vector.<FinishMoveInformations>();
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
         this.serializeAs_FinishMoveListMessage(output);
      }
      
      public function serializeAs_FinishMoveListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.finishMoves.length);
         for(var _i1:uint = 0; _i1 < this.finishMoves.length; _i1++)
         {
            (this.finishMoves[_i1] as FinishMoveInformations).serializeAs_FinishMoveInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FinishMoveListMessage(input);
      }
      
      public function deserializeAs_FinishMoveListMessage(input:ICustomDataInput) : void
      {
         var _item1:FinishMoveInformations = null;
         var _finishMovesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _finishMovesLen; _i1++)
         {
            _item1 = new FinishMoveInformations();
            _item1.deserialize(input);
            this.finishMoves.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FinishMoveListMessage(tree);
      }
      
      public function deserializeAsyncAs_FinishMoveListMessage(tree:FuncTree) : void
      {
         this._finishMovestree = tree.addChild(this._finishMovestreeFunc);
      }
      
      private function _finishMovestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._finishMovestree.addChild(this._finishMovesFunc);
         }
      }
      
      private function _finishMovesFunc(input:ICustomDataInput) : void
      {
         var _item:FinishMoveInformations = new FinishMoveInformations();
         _item.deserialize(input);
         this.finishMoves.push(_item);
      }
   }
}
