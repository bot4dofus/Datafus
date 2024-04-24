package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CheckIntegrityMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8109;
       
      
      private var _isInitialized:Boolean = false;
      
      public var data:Vector.<int>;
      
      private var _datatree:FuncTree;
      
      public function CheckIntegrityMessage()
      {
         this.data = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8109;
      }
      
      public function initCheckIntegrityMessage(data:Vector.<int> = null) : CheckIntegrityMessage
      {
         this.data = data;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.data = new Vector.<int>();
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
         this.serializeAs_CheckIntegrityMessage(output);
      }
      
      public function serializeAs_CheckIntegrityMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.data.length);
         for(var _i1:uint = 0; _i1 < this.data.length; _i1++)
         {
            output.writeByte(this.data[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CheckIntegrityMessage(input);
      }
      
      public function deserializeAs_CheckIntegrityMessage(input:ICustomDataInput) : void
      {
         var _val1:int = 0;
         var _dataLen:uint = input.readVarInt();
         for(var _i1:uint = 0; _i1 < _dataLen; _i1++)
         {
            _val1 = input.readByte();
            this.data.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CheckIntegrityMessage(tree);
      }
      
      public function deserializeAsyncAs_CheckIntegrityMessage(tree:FuncTree) : void
      {
         this._datatree = tree.addChild(this._datatreeFunc);
      }
      
      private function _datatreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readVarInt();
         for(var i:uint = 0; i < length; i++)
         {
            this._datatree.addChild(this._dataFunc);
         }
      }
      
      private function _dataFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readByte();
         this.data.push(_val);
      }
   }
}
