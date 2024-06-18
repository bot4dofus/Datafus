package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class EntityLook implements INetworkType
   {
      
      public static const protocolId:uint = 6640;
       
      
      public var bonesId:uint = 0;
      
      public var skins:Vector.<uint>;
      
      public var indexedColors:Vector.<int>;
      
      public var scales:Vector.<int>;
      
      public var subentities:Vector.<SubEntity>;
      
      private var _skinstree:FuncTree;
      
      private var _indexedColorstree:FuncTree;
      
      private var _scalestree:FuncTree;
      
      private var _subentitiestree:FuncTree;
      
      public function EntityLook()
      {
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6640;
      }
      
      public function initEntityLook(bonesId:uint = 0, skins:Vector.<uint> = null, indexedColors:Vector.<int> = null, scales:Vector.<int> = null, subentities:Vector.<SubEntity> = null) : EntityLook
      {
         this.bonesId = bonesId;
         this.skins = skins;
         this.indexedColors = indexedColors;
         this.scales = scales;
         this.subentities = subentities;
         return this;
      }
      
      public function reset() : void
      {
         this.bonesId = 0;
         this.skins = new Vector.<uint>();
         this.indexedColors = new Vector.<int>();
         this.scales = new Vector.<int>();
         this.subentities = new Vector.<SubEntity>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_EntityLook(output);
      }
      
      public function serializeAs_EntityLook(output:ICustomDataOutput) : void
      {
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element bonesId.");
         }
         output.writeVarShort(this.bonesId);
         output.writeShort(this.skins.length);
         for(var _i2:uint = 0; _i2 < this.skins.length; _i2++)
         {
            if(this.skins[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.skins[_i2] + ") on element 2 (starting at 1) of skins.");
            }
            output.writeVarShort(this.skins[_i2]);
         }
         output.writeShort(this.indexedColors.length);
         for(var _i3:uint = 0; _i3 < this.indexedColors.length; _i3++)
         {
            output.writeInt(this.indexedColors[_i3]);
         }
         output.writeShort(this.scales.length);
         for(var _i4:uint = 0; _i4 < this.scales.length; _i4++)
         {
            output.writeVarShort(this.scales[_i4]);
         }
         output.writeShort(this.subentities.length);
         for(var _i5:uint = 0; _i5 < this.subentities.length; _i5++)
         {
            (this.subentities[_i5] as SubEntity).serializeAs_SubEntity(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EntityLook(input);
      }
      
      public function deserializeAs_EntityLook(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         var _val3:int = 0;
         var _val4:int = 0;
         var _item5:SubEntity = null;
         this._bonesIdFunc(input);
         var _skinsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _skinsLen; _i2++)
         {
            _val2 = input.readVarUhShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of skins.");
            }
            this.skins.push(_val2);
         }
         var _indexedColorsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _indexedColorsLen; _i3++)
         {
            _val3 = input.readInt();
            this.indexedColors.push(_val3);
         }
         var _scalesLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _scalesLen; _i4++)
         {
            _val4 = input.readVarShort();
            this.scales.push(_val4);
         }
         var _subentitiesLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _subentitiesLen; _i5++)
         {
            _item5 = new SubEntity();
            _item5.deserialize(input);
            this.subentities.push(_item5);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EntityLook(tree);
      }
      
      public function deserializeAsyncAs_EntityLook(tree:FuncTree) : void
      {
         tree.addChild(this._bonesIdFunc);
         this._skinstree = tree.addChild(this._skinstreeFunc);
         this._indexedColorstree = tree.addChild(this._indexedColorstreeFunc);
         this._scalestree = tree.addChild(this._scalestreeFunc);
         this._subentitiestree = tree.addChild(this._subentitiestreeFunc);
      }
      
      private function _bonesIdFunc(input:ICustomDataInput) : void
      {
         this.bonesId = input.readVarUhShort();
         if(this.bonesId < 0)
         {
            throw new Error("Forbidden value (" + this.bonesId + ") on element of EntityLook.bonesId.");
         }
      }
      
      private function _skinstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._skinstree.addChild(this._skinsFunc);
         }
      }
      
      private function _skinsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of skins.");
         }
         this.skins.push(_val);
      }
      
      private function _indexedColorstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._indexedColorstree.addChild(this._indexedColorsFunc);
         }
      }
      
      private function _indexedColorsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readInt();
         this.indexedColors.push(_val);
      }
      
      private function _scalestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._scalestree.addChild(this._scalesFunc);
         }
      }
      
      private function _scalesFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readVarShort();
         this.scales.push(_val);
      }
      
      private function _subentitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._subentitiestree.addChild(this._subentitiesFunc);
         }
      }
      
      private function _subentitiesFunc(input:ICustomDataInput) : void
      {
         var _item:SubEntity = new SubEntity();
         _item.deserialize(input);
         this.subentities.push(_item);
      }
   }
}
