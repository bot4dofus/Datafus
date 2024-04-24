package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameMapNoMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6782;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cellX:int = 0;
      
      public var cellY:int = 0;
      
      public function GameMapNoMovementMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6782;
      }
      
      public function initGameMapNoMovementMessage(cellX:int = 0, cellY:int = 0) : GameMapNoMovementMessage
      {
         this.cellX = cellX;
         this.cellY = cellY;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cellX = 0;
         this.cellY = 0;
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
         this.serializeAs_GameMapNoMovementMessage(output);
      }
      
      public function serializeAs_GameMapNoMovementMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.cellX);
         output.writeShort(this.cellY);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapNoMovementMessage(input);
      }
      
      public function deserializeAs_GameMapNoMovementMessage(input:ICustomDataInput) : void
      {
         this._cellXFunc(input);
         this._cellYFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapNoMovementMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapNoMovementMessage(tree:FuncTree) : void
      {
         tree.addChild(this._cellXFunc);
         tree.addChild(this._cellYFunc);
      }
      
      private function _cellXFunc(input:ICustomDataInput) : void
      {
         this.cellX = input.readShort();
      }
      
      private function _cellYFunc(input:ICustomDataInput) : void
      {
         this.cellY = input.readShort();
      }
   }
}
