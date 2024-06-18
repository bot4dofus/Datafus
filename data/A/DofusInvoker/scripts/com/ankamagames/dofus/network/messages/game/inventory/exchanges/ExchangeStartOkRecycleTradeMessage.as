package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkRecycleTradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1067;
       
      
      private var _isInitialized:Boolean = false;
      
      public var percentToPrism:uint = 0;
      
      public var percentToPlayer:uint = 0;
      
      public var adjacentSubareaPossessed:Vector.<uint>;
      
      public var adjacentSubareaUnpossessed:Vector.<uint>;
      
      private var _adjacentSubareaPossessedtree:FuncTree;
      
      private var _adjacentSubareaUnpossessedtree:FuncTree;
      
      public function ExchangeStartOkRecycleTradeMessage()
      {
         this.adjacentSubareaPossessed = new Vector.<uint>();
         this.adjacentSubareaUnpossessed = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1067;
      }
      
      public function initExchangeStartOkRecycleTradeMessage(percentToPrism:uint = 0, percentToPlayer:uint = 0, adjacentSubareaPossessed:Vector.<uint> = null, adjacentSubareaUnpossessed:Vector.<uint> = null) : ExchangeStartOkRecycleTradeMessage
      {
         this.percentToPrism = percentToPrism;
         this.percentToPlayer = percentToPlayer;
         this.adjacentSubareaPossessed = adjacentSubareaPossessed;
         this.adjacentSubareaUnpossessed = adjacentSubareaUnpossessed;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.percentToPrism = 0;
         this.percentToPlayer = 0;
         this.adjacentSubareaPossessed = new Vector.<uint>();
         this.adjacentSubareaUnpossessed = new Vector.<uint>();
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
         this.serializeAs_ExchangeStartOkRecycleTradeMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkRecycleTradeMessage(output:ICustomDataOutput) : void
      {
         if(this.percentToPrism < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPrism + ") on element percentToPrism.");
         }
         output.writeShort(this.percentToPrism);
         if(this.percentToPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPlayer + ") on element percentToPlayer.");
         }
         output.writeShort(this.percentToPlayer);
         output.writeShort(this.adjacentSubareaPossessed.length);
         for(var _i3:uint = 0; _i3 < this.adjacentSubareaPossessed.length; _i3++)
         {
            if(this.adjacentSubareaPossessed[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.adjacentSubareaPossessed[_i3] + ") on element 3 (starting at 1) of adjacentSubareaPossessed.");
            }
            output.writeInt(this.adjacentSubareaPossessed[_i3]);
         }
         output.writeShort(this.adjacentSubareaUnpossessed.length);
         for(var _i4:uint = 0; _i4 < this.adjacentSubareaUnpossessed.length; _i4++)
         {
            if(this.adjacentSubareaUnpossessed[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.adjacentSubareaUnpossessed[_i4] + ") on element 4 (starting at 1) of adjacentSubareaUnpossessed.");
            }
            output.writeInt(this.adjacentSubareaUnpossessed[_i4]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkRecycleTradeMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkRecycleTradeMessage(input:ICustomDataInput) : void
      {
         var _val3:uint = 0;
         var _val4:uint = 0;
         this._percentToPrismFunc(input);
         this._percentToPlayerFunc(input);
         var _adjacentSubareaPossessedLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _adjacentSubareaPossessedLen; _i3++)
         {
            _val3 = input.readInt();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of adjacentSubareaPossessed.");
            }
            this.adjacentSubareaPossessed.push(_val3);
         }
         var _adjacentSubareaUnpossessedLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _adjacentSubareaUnpossessedLen; _i4++)
         {
            _val4 = input.readInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of adjacentSubareaUnpossessed.");
            }
            this.adjacentSubareaUnpossessed.push(_val4);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkRecycleTradeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkRecycleTradeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._percentToPrismFunc);
         tree.addChild(this._percentToPlayerFunc);
         this._adjacentSubareaPossessedtree = tree.addChild(this._adjacentSubareaPossessedtreeFunc);
         this._adjacentSubareaUnpossessedtree = tree.addChild(this._adjacentSubareaUnpossessedtreeFunc);
      }
      
      private function _percentToPrismFunc(input:ICustomDataInput) : void
      {
         this.percentToPrism = input.readShort();
         if(this.percentToPrism < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPrism + ") on element of ExchangeStartOkRecycleTradeMessage.percentToPrism.");
         }
      }
      
      private function _percentToPlayerFunc(input:ICustomDataInput) : void
      {
         this.percentToPlayer = input.readShort();
         if(this.percentToPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPlayer + ") on element of ExchangeStartOkRecycleTradeMessage.percentToPlayer.");
         }
      }
      
      private function _adjacentSubareaPossessedtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._adjacentSubareaPossessedtree.addChild(this._adjacentSubareaPossessedFunc);
         }
      }
      
      private function _adjacentSubareaPossessedFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of adjacentSubareaPossessed.");
         }
         this.adjacentSubareaPossessed.push(_val);
      }
      
      private function _adjacentSubareaUnpossessedtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._adjacentSubareaUnpossessedtree.addChild(this._adjacentSubareaUnpossessedFunc);
         }
      }
      
      private function _adjacentSubareaUnpossessedFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of adjacentSubareaUnpossessed.");
         }
         this.adjacentSubareaUnpossessed.push(_val);
      }
   }
}
