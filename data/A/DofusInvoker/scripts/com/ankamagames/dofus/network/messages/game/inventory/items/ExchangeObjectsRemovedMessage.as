package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectsRemovedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4341;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUID:Vector.<uint>;
      
      private var _objectUIDtree:FuncTree;
      
      public function ExchangeObjectsRemovedMessage()
      {
         this.objectUID = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4341;
      }
      
      public function initExchangeObjectsRemovedMessage(remote:Boolean = false, objectUID:Vector.<uint> = null) : ExchangeObjectsRemovedMessage
      {
         super.initExchangeObjectMessage(remote);
         this.objectUID = objectUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objectUID = new Vector.<uint>();
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
         this.serializeAs_ExchangeObjectsRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectsRemovedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(output);
         output.writeShort(this.objectUID.length);
         for(var _i1:uint = 0; _i1 < this.objectUID.length; _i1++)
         {
            if(this.objectUID[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUID[_i1] + ") on element 1 (starting at 1) of objectUID.");
            }
            output.writeVarInt(this.objectUID[_i1]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectsRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectsRemovedMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         super.deserialize(input);
         var _objectUIDLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectUIDLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objectUID.");
            }
            this.objectUID.push(_val1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectsRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectsRemovedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._objectUIDtree = tree.addChild(this._objectUIDtreeFunc);
      }
      
      private function _objectUIDtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectUIDtree.addChild(this._objectUIDFunc);
         }
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of objectUID.");
         }
         this.objectUID.push(_val);
      }
   }
}
