package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class DecraftedItemStackInfo implements INetworkType
   {
      
      public static const protocolId:uint = 9479;
       
      
      public var objectUID:uint = 0;
      
      public var bonusMin:Number = 0;
      
      public var bonusMax:Number = 0;
      
      public var runesId:Vector.<uint>;
      
      public var runesQty:Vector.<uint>;
      
      private var _runesIdtree:FuncTree;
      
      private var _runesQtytree:FuncTree;
      
      public function DecraftedItemStackInfo()
      {
         this.runesId = new Vector.<uint>();
         this.runesQty = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9479;
      }
      
      public function initDecraftedItemStackInfo(objectUID:uint = 0, bonusMin:Number = 0, bonusMax:Number = 0, runesId:Vector.<uint> = null, runesQty:Vector.<uint> = null) : DecraftedItemStackInfo
      {
         this.objectUID = objectUID;
         this.bonusMin = bonusMin;
         this.bonusMax = bonusMax;
         this.runesId = runesId;
         this.runesQty = runesQty;
         return this;
      }
      
      public function reset() : void
      {
         this.objectUID = 0;
         this.bonusMin = 0;
         this.bonusMax = 0;
         this.runesId = new Vector.<uint>();
         this.runesQty = new Vector.<uint>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_DecraftedItemStackInfo(output);
      }
      
      public function serializeAs_DecraftedItemStackInfo(output:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
         output.writeFloat(this.bonusMin);
         output.writeFloat(this.bonusMax);
         output.writeShort(this.runesId.length);
         for(var _i4:uint = 0; _i4 < this.runesId.length; _i4++)
         {
            if(this.runesId[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.runesId[_i4] + ") on element 4 (starting at 1) of runesId.");
            }
            output.writeVarInt(this.runesId[_i4]);
         }
         output.writeShort(this.runesQty.length);
         for(var _i5:uint = 0; _i5 < this.runesQty.length; _i5++)
         {
            if(this.runesQty[_i5] < 0)
            {
               throw new Error("Forbidden value (" + this.runesQty[_i5] + ") on element 5 (starting at 1) of runesQty.");
            }
            output.writeVarInt(this.runesQty[_i5]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DecraftedItemStackInfo(input);
      }
      
      public function deserializeAs_DecraftedItemStackInfo(input:ICustomDataInput) : void
      {
         var _val4:uint = 0;
         var _val5:uint = 0;
         this._objectUIDFunc(input);
         this._bonusMinFunc(input);
         this._bonusMaxFunc(input);
         var _runesIdLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _runesIdLen; _i4++)
         {
            _val4 = input.readVarUhInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of runesId.");
            }
            this.runesId.push(_val4);
         }
         var _runesQtyLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _runesQtyLen; _i5++)
         {
            _val5 = input.readVarUhInt();
            if(_val5 < 0)
            {
               throw new Error("Forbidden value (" + _val5 + ") on elements of runesQty.");
            }
            this.runesQty.push(_val5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DecraftedItemStackInfo(tree);
      }
      
      public function deserializeAsyncAs_DecraftedItemStackInfo(tree:FuncTree) : void
      {
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._bonusMinFunc);
         tree.addChild(this._bonusMaxFunc);
         this._runesIdtree = tree.addChild(this._runesIdtreeFunc);
         this._runesQtytree = tree.addChild(this._runesQtytreeFunc);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of DecraftedItemStackInfo.objectUID.");
         }
      }
      
      private function _bonusMinFunc(input:ICustomDataInput) : void
      {
         this.bonusMin = input.readFloat();
      }
      
      private function _bonusMaxFunc(input:ICustomDataInput) : void
      {
         this.bonusMax = input.readFloat();
      }
      
      private function _runesIdtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._runesIdtree.addChild(this._runesIdFunc);
         }
      }
      
      private function _runesIdFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of runesId.");
         }
         this.runesId.push(_val);
      }
      
      private function _runesQtytreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._runesQtytree.addChild(this._runesQtyFunc);
         }
      }
      
      private function _runesQtyFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of runesQty.");
         }
         this.runesQty.push(_val);
      }
   }
}
