package com.ankamagames.dofus.network.messages.game.actions
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameActionSpamMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6901;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cells:Vector.<int>;
      
      private var _cellstree:FuncTree;
      
      public function GameActionSpamMessage()
      {
         this.cells = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6901;
      }
      
      public function initGameActionSpamMessage(cells:Vector.<int> = null) : GameActionSpamMessage
      {
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cells = new Vector.<int>();
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
         this.serializeAs_GameActionSpamMessage(output);
      }
      
      public function serializeAs_GameActionSpamMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.cells.length);
         for(var _i1:uint = 0; _i1 < this.cells.length; _i1++)
         {
            output.writeShort(this.cells[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionSpamMessage(input);
      }
      
      public function deserializeAs_GameActionSpamMessage(input:ICustomDataInput) : void
      {
         var _val1:int = 0;
         var _cellsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _cellsLen; _i1++)
         {
            _val1 = input.readShort();
            this.cells.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionSpamMessage(tree);
      }
      
      public function deserializeAsyncAs_GameActionSpamMessage(tree:FuncTree) : void
      {
         this._cellstree = tree.addChild(this._cellstreeFunc);
      }
      
      private function _cellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._cellstree.addChild(this._cellsFunc);
         }
      }
      
      private function _cellsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readShort();
         this.cells.push(_val);
      }
   }
}
