package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SellerBuyerDescriptor implements INetworkType
   {
      
      public static const protocolId:uint = 780;
       
      
      public var quantities:Vector.<uint>;
      
      public var types:Vector.<uint>;
      
      public var taxPercentage:Number = 0;
      
      public var taxModificationPercentage:Number = 0;
      
      public var maxItemLevel:uint = 0;
      
      public var maxItemPerAccount:uint = 0;
      
      public var npcContextualId:int = 0;
      
      public var unsoldDelay:uint = 0;
      
      private var _quantitiestree:FuncTree;
      
      private var _typestree:FuncTree;
      
      public function SellerBuyerDescriptor()
      {
         this.quantities = new Vector.<uint>();
         this.types = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 780;
      }
      
      public function initSellerBuyerDescriptor(quantities:Vector.<uint> = null, types:Vector.<uint> = null, taxPercentage:Number = 0, taxModificationPercentage:Number = 0, maxItemLevel:uint = 0, maxItemPerAccount:uint = 0, npcContextualId:int = 0, unsoldDelay:uint = 0) : SellerBuyerDescriptor
      {
         this.quantities = quantities;
         this.types = types;
         this.taxPercentage = taxPercentage;
         this.taxModificationPercentage = taxModificationPercentage;
         this.maxItemLevel = maxItemLevel;
         this.maxItemPerAccount = maxItemPerAccount;
         this.npcContextualId = npcContextualId;
         this.unsoldDelay = unsoldDelay;
         return this;
      }
      
      public function reset() : void
      {
         this.quantities = new Vector.<uint>();
         this.types = new Vector.<uint>();
         this.taxPercentage = 0;
         this.taxModificationPercentage = 0;
         this.maxItemLevel = 0;
         this.maxItemPerAccount = 0;
         this.npcContextualId = 0;
         this.unsoldDelay = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SellerBuyerDescriptor(output);
      }
      
      public function serializeAs_SellerBuyerDescriptor(output:ICustomDataOutput) : void
      {
         output.writeShort(this.quantities.length);
         for(var _i1:uint = 0; _i1 < this.quantities.length; _i1++)
         {
            if(this.quantities[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.quantities[_i1] + ") on element 1 (starting at 1) of quantities.");
            }
            output.writeVarInt(this.quantities[_i1]);
         }
         output.writeShort(this.types.length);
         for(var _i2:uint = 0; _i2 < this.types.length; _i2++)
         {
            if(this.types[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.types[_i2] + ") on element 2 (starting at 1) of types.");
            }
            output.writeVarInt(this.types[_i2]);
         }
         output.writeFloat(this.taxPercentage);
         output.writeFloat(this.taxModificationPercentage);
         if(this.maxItemLevel < 0 || this.maxItemLevel > 255)
         {
            throw new Error("Forbidden value (" + this.maxItemLevel + ") on element maxItemLevel.");
         }
         output.writeByte(this.maxItemLevel);
         if(this.maxItemPerAccount < 0)
         {
            throw new Error("Forbidden value (" + this.maxItemPerAccount + ") on element maxItemPerAccount.");
         }
         output.writeVarInt(this.maxItemPerAccount);
         output.writeInt(this.npcContextualId);
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element unsoldDelay.");
         }
         output.writeVarShort(this.unsoldDelay);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SellerBuyerDescriptor(input);
      }
      
      public function deserializeAs_SellerBuyerDescriptor(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _quantitiesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _quantitiesLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of quantities.");
            }
            this.quantities.push(_val1);
         }
         var _typesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _typesLen; _i2++)
         {
            _val2 = input.readVarUhInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of types.");
            }
            this.types.push(_val2);
         }
         this._taxPercentageFunc(input);
         this._taxModificationPercentageFunc(input);
         this._maxItemLevelFunc(input);
         this._maxItemPerAccountFunc(input);
         this._npcContextualIdFunc(input);
         this._unsoldDelayFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SellerBuyerDescriptor(tree);
      }
      
      public function deserializeAsyncAs_SellerBuyerDescriptor(tree:FuncTree) : void
      {
         this._quantitiestree = tree.addChild(this._quantitiestreeFunc);
         this._typestree = tree.addChild(this._typestreeFunc);
         tree.addChild(this._taxPercentageFunc);
         tree.addChild(this._taxModificationPercentageFunc);
         tree.addChild(this._maxItemLevelFunc);
         tree.addChild(this._maxItemPerAccountFunc);
         tree.addChild(this._npcContextualIdFunc);
         tree.addChild(this._unsoldDelayFunc);
      }
      
      private function _quantitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._quantitiestree.addChild(this._quantitiesFunc);
         }
      }
      
      private function _quantitiesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of quantities.");
         }
         this.quantities.push(_val);
      }
      
      private function _typestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._typestree.addChild(this._typesFunc);
         }
      }
      
      private function _typesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of types.");
         }
         this.types.push(_val);
      }
      
      private function _taxPercentageFunc(input:ICustomDataInput) : void
      {
         this.taxPercentage = input.readFloat();
      }
      
      private function _taxModificationPercentageFunc(input:ICustomDataInput) : void
      {
         this.taxModificationPercentage = input.readFloat();
      }
      
      private function _maxItemLevelFunc(input:ICustomDataInput) : void
      {
         this.maxItemLevel = input.readUnsignedByte();
         if(this.maxItemLevel < 0 || this.maxItemLevel > 255)
         {
            throw new Error("Forbidden value (" + this.maxItemLevel + ") on element of SellerBuyerDescriptor.maxItemLevel.");
         }
      }
      
      private function _maxItemPerAccountFunc(input:ICustomDataInput) : void
      {
         this.maxItemPerAccount = input.readVarUhInt();
         if(this.maxItemPerAccount < 0)
         {
            throw new Error("Forbidden value (" + this.maxItemPerAccount + ") on element of SellerBuyerDescriptor.maxItemPerAccount.");
         }
      }
      
      private function _npcContextualIdFunc(input:ICustomDataInput) : void
      {
         this.npcContextualId = input.readInt();
      }
      
      private function _unsoldDelayFunc(input:ICustomDataInput) : void
      {
         this.unsoldDelay = input.readVarUhShort();
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element of SellerBuyerDescriptor.unsoldDelay.");
         }
      }
   }
}
