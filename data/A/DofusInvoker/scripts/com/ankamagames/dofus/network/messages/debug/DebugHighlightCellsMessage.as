package com.ankamagames.dofus.network.messages.debug
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DebugHighlightCellsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9357;
       
      
      private var _isInitialized:Boolean = false;
      
      public var color:Number = 0;
      
      public var cells:Vector.<uint>;
      
      private var _cellstree:FuncTree;
      
      public function DebugHighlightCellsMessage()
      {
         this.cells = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9357;
      }
      
      public function initDebugHighlightCellsMessage(color:Number = 0, cells:Vector.<uint> = null) : DebugHighlightCellsMessage
      {
         this.color = color;
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.color = 0;
         this.cells = new Vector.<uint>();
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
         this.serializeAs_DebugHighlightCellsMessage(output);
      }
      
      public function serializeAs_DebugHighlightCellsMessage(output:ICustomDataOutput) : void
      {
         if(this.color < -9007199254740992 || this.color > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.color + ") on element color.");
         }
         output.writeDouble(this.color);
         output.writeShort(this.cells.length);
         for(var _i2:uint = 0; _i2 < this.cells.length; _i2++)
         {
            if(this.cells[_i2] < 0 || this.cells[_i2] > 559)
            {
               throw new Error("Forbidden value (" + this.cells[_i2] + ") on element 2 (starting at 1) of cells.");
            }
            output.writeVarShort(this.cells[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DebugHighlightCellsMessage(input);
      }
      
      public function deserializeAs_DebugHighlightCellsMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._colorFunc(input);
         var _cellsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _cellsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0 || _val2 > 559)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of cells.");
            }
            this.cells.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DebugHighlightCellsMessage(tree);
      }
      
      public function deserializeAsyncAs_DebugHighlightCellsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._colorFunc);
         this._cellstree = tree.addChild(this._cellstreeFunc);
      }
      
      private function _colorFunc(input:ICustomDataInput) : void
      {
         this.color = input.readDouble();
         if(this.color < -9007199254740992 || this.color > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.color + ") on element of DebugHighlightCellsMessage.color.");
         }
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
         var _val:uint = input.readVarUhShort();
         if(_val < 0 || _val > 559)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of cells.");
         }
         this.cells.push(_val);
      }
   }
}
