package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeHandleMountsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3319;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actionType:int = 0;
      
      public var ridesId:Vector.<uint>;
      
      private var _ridesIdtree:FuncTree;
      
      public function ExchangeHandleMountsMessage()
      {
         this.ridesId = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3319;
      }
      
      public function initExchangeHandleMountsMessage(actionType:int = 0, ridesId:Vector.<uint> = null) : ExchangeHandleMountsMessage
      {
         this.actionType = actionType;
         this.ridesId = ridesId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actionType = 0;
         this.ridesId = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ExchangeHandleMountsMessage(output);
      }
      
      public function serializeAs_ExchangeHandleMountsMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.actionType);
         output.writeShort(this.ridesId.length);
         for(var _i2:uint = 0; _i2 < this.ridesId.length; _i2++)
         {
            if(this.ridesId[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.ridesId[_i2] + ") on element 2 (starting at 1) of ridesId.");
            }
            output.writeVarInt(this.ridesId[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeHandleMountsMessage(input);
      }
      
      public function deserializeAs_ExchangeHandleMountsMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._actionTypeFunc(input);
         var _ridesIdLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _ridesIdLen; _i2++)
         {
            _val2 = input.readVarUhInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of ridesId.");
            }
            this.ridesId.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeHandleMountsMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeHandleMountsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionTypeFunc);
         this._ridesIdtree = tree.addChild(this._ridesIdtreeFunc);
      }
      
      private function _actionTypeFunc(input:ICustomDataInput) : void
      {
         this.actionType = input.readByte();
      }
      
      private function _ridesIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._ridesIdtree.addChild(this._ridesIdFunc);
         }
      }
      
      private function _ridesIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ridesId.");
         }
         this.ridesId.push(_val);
      }
   }
}
