package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShowCellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3414;
       
      
      private var _isInitialized:Boolean = false;
      
      public var sourceId:Number = 0;
      
      public var cellId:uint = 0;
      
      public function ShowCellMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3414;
      }
      
      public function initShowCellMessage(sourceId:Number = 0, cellId:uint = 0) : ShowCellMessage
      {
         this.sourceId = sourceId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.sourceId = 0;
         this.cellId = 0;
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
         this.serializeAs_ShowCellMessage(output);
      }
      
      public function serializeAs_ShowCellMessage(output:ICustomDataOutput) : void
      {
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element sourceId.");
         }
         output.writeDouble(this.sourceId);
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShowCellMessage(input);
      }
      
      public function deserializeAs_ShowCellMessage(input:ICustomDataInput) : void
      {
         this._sourceIdFunc(input);
         this._cellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShowCellMessage(tree);
      }
      
      public function deserializeAsyncAs_ShowCellMessage(tree:FuncTree) : void
      {
         tree.addChild(this._sourceIdFunc);
         tree.addChild(this._cellIdFunc);
      }
      
      private function _sourceIdFunc(input:ICustomDataInput) : void
      {
         this.sourceId = input.readDouble();
         if(this.sourceId < -9007199254740992 || this.sourceId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sourceId + ") on element of ShowCellMessage.sourceId.");
         }
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ShowCellMessage.cellId.");
         }
      }
   }
}
