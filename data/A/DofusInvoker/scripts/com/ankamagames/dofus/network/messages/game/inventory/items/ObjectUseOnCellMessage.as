package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectUseOnCellMessage extends ObjectUseMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4046;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cells:uint = 0;
      
      public function ObjectUseOnCellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4046;
      }
      
      public function initObjectUseOnCellMessage(objectUID:uint = 0, cells:uint = 0) : ObjectUseOnCellMessage
      {
         super.initObjectUseMessage(objectUID);
         this.cells = cells;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cells = 0;
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
         this.serializeAs_ObjectUseOnCellMessage(output);
      }
      
      public function serializeAs_ObjectUseOnCellMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectUseMessage(output);
         if(this.cells < 0 || this.cells > 559)
         {
            throw new Error("Forbidden value (" + this.cells + ") on element cells.");
         }
         output.writeVarShort(this.cells);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectUseOnCellMessage(input);
      }
      
      public function deserializeAs_ObjectUseOnCellMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._cellsFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectUseOnCellMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectUseOnCellMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._cellsFunc);
      }
      
      private function _cellsFunc(input:ICustomDataInput) : void
      {
         this.cells = input.readVarUhShort();
         if(this.cells < 0 || this.cells > 559)
         {
            throw new Error("Forbidden value (" + this.cells + ") on element of ObjectUseOnCellMessage.cells.");
         }
      }
   }
}
