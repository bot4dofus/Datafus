package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMountsStableRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2507;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountsId:Vector.<int>;
      
      private var _mountsIdtree:FuncTree;
      
      public function ExchangeMountsStableRemoveMessage()
      {
         this.mountsId = new Vector.<int>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2507;
      }
      
      public function initExchangeMountsStableRemoveMessage(mountsId:Vector.<int> = null) : ExchangeMountsStableRemoveMessage
      {
         this.mountsId = mountsId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountsId = new Vector.<int>();
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
         this.serializeAs_ExchangeMountsStableRemoveMessage(output);
      }
      
      public function serializeAs_ExchangeMountsStableRemoveMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.mountsId.length);
         for(var _i1:uint = 0; _i1 < this.mountsId.length; _i1++)
         {
            output.writeVarInt(this.mountsId[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMountsStableRemoveMessage(input);
      }
      
      public function deserializeAs_ExchangeMountsStableRemoveMessage(input:ICustomDataInput) : void
      {
         var _val1:int = 0;
         var _mountsIdLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _mountsIdLen; _i1++)
         {
            _val1 = input.readVarInt();
            this.mountsId.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMountsStableRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMountsStableRemoveMessage(tree:FuncTree) : void
      {
         this._mountsIdtree = tree.addChild(this._mountsIdtreeFunc);
      }
      
      private function _mountsIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._mountsIdtree.addChild(this._mountsIdFunc);
         }
      }
      
      private function _mountsIdFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readVarInt();
         this.mountsId.push(_val);
      }
   }
}
