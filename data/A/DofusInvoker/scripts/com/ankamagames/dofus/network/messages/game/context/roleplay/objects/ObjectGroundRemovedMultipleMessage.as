package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectGroundRemovedMultipleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7894;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cells:Vector.<uint>;
      
      private var _cellstree:FuncTree;
      
      public function ObjectGroundRemovedMultipleMessage()
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
         return 7894;
      }
      
      public function initObjectGroundRemovedMultipleMessage(cells:Vector.<uint> = null) : ObjectGroundRemovedMultipleMessage
      {
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_ObjectGroundRemovedMultipleMessage(output);
      }
      
      public function serializeAs_ObjectGroundRemovedMultipleMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.cells.length);
         for(var _i1:uint = 0; _i1 < this.cells.length; _i1++)
         {
            if(this.cells[_i1] < 0 || this.cells[_i1] > 559)
            {
               throw new Error("Forbidden value (" + this.cells[_i1] + ") on element 1 (starting at 1) of cells.");
            }
            output.writeVarShort(this.cells[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectGroundRemovedMultipleMessage(input);
      }
      
      public function deserializeAs_ObjectGroundRemovedMultipleMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _cellsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _cellsLen; _i1++)
         {
            _val1 = input.readVarUhShort();
            if(_val1 < 0 || _val1 > 559)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of cells.");
            }
            this.cells.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectGroundRemovedMultipleMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectGroundRemovedMultipleMessage(tree:FuncTree) : void
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
         var _val:uint = input.readVarUhShort();
         if(_val < 0 || _val > 559)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of cells.");
         }
         this.cells.push(_val);
      }
   }
}
