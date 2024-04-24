package com.ankamagames.dofus.network.messages.game.inventory
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectAveragePricesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9395;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ids:Vector.<uint>;
      
      public var avgPrices:Vector.<Number>;
      
      private var _idstree:FuncTree;
      
      private var _avgPricestree:FuncTree;
      
      public function ObjectAveragePricesMessage()
      {
         this.ids = new Vector.<uint>();
         this.avgPrices = new Vector.<Number>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9395;
      }
      
      public function initObjectAveragePricesMessage(ids:Vector.<uint> = null, avgPrices:Vector.<Number> = null) : ObjectAveragePricesMessage
      {
         this.ids = ids;
         this.avgPrices = avgPrices;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ids = new Vector.<uint>();
         this.avgPrices = new Vector.<Number>();
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
         this.serializeAs_ObjectAveragePricesMessage(output);
      }
      
      public function serializeAs_ObjectAveragePricesMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ids.length);
         for(var _i1:uint = 0; _i1 < this.ids.length; _i1++)
         {
            if(this.ids[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.ids[_i1] + ") on element 1 (starting at 1) of ids.");
            }
            output.writeVarInt(this.ids[_i1]);
         }
         output.writeShort(this.avgPrices.length);
         for(var _i2:uint = 0; _i2 < this.avgPrices.length; _i2++)
         {
            if(this.avgPrices[_i2] < 0 || this.avgPrices[_i2] > 9007199254740992)
            {
               throw new Error("Forbidden value (" + this.avgPrices[_i2] + ") on element 2 (starting at 1) of avgPrices.");
            }
            output.writeVarLong(this.avgPrices[_i2]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectAveragePricesMessage(input);
      }
      
      public function deserializeAs_ObjectAveragePricesMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:Number = NaN;
         var _idsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _idsLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of ids.");
            }
            this.ids.push(_val1);
         }
         var _avgPricesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _avgPricesLen; _i2++)
         {
            _val2 = input.readVarUhLong();
            if(_val2 < 0 || _val2 > 9007199254740992)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of avgPrices.");
            }
            this.avgPrices.push(_val2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectAveragePricesMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectAveragePricesMessage(tree:FuncTree) : void
      {
         this._idstree = tree.addChild(this._idstreeFunc);
         this._avgPricestree = tree.addChild(this._avgPricestreeFunc);
      }
      
      private function _idstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._idstree.addChild(this._idsFunc);
         }
      }
      
      private function _idsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ids.");
         }
         this.ids.push(_val);
      }
      
      private function _avgPricestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._avgPricestree.addChild(this._avgPricesFunc);
         }
      }
      
      private function _avgPricesFunc(input:ICustomDataInput) : void
      {
         var _val:Number = input.readVarUhLong();
         if(_val < 0 || _val > 9007199254740992)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of avgPrices.");
         }
         this.avgPrices.push(_val);
      }
   }
}
