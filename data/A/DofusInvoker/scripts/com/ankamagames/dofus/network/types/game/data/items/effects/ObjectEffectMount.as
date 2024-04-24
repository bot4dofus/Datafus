package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectMount extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 7839;
       
      
      public var id:Number = 0;
      
      public var expirationDate:Number = 0;
      
      public var model:uint = 0;
      
      public var name:String = "";
      
      public var owner:String = "";
      
      public var level:uint = 0;
      
      public var sex:Boolean = false;
      
      public var isRideable:Boolean = false;
      
      public var isFeconded:Boolean = false;
      
      public var isFecondationReady:Boolean = false;
      
      public var reproductionCount:int = 0;
      
      public var reproductionCountMax:uint = 0;
      
      public var effects:Vector.<ObjectEffectInteger>;
      
      public var capacities:Vector.<uint>;
      
      private var _effectstree:FuncTree;
      
      private var _capacitiestree:FuncTree;
      
      public function ObjectEffectMount()
      {
         this.effects = new Vector.<ObjectEffectInteger>();
         this.capacities = new Vector.<uint>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7839;
      }
      
      public function initObjectEffectMount(actionId:uint = 0, id:Number = 0, expirationDate:Number = 0, model:uint = 0, name:String = "", owner:String = "", level:uint = 0, sex:Boolean = false, isRideable:Boolean = false, isFeconded:Boolean = false, isFecondationReady:Boolean = false, reproductionCount:int = 0, reproductionCountMax:uint = 0, effects:Vector.<ObjectEffectInteger> = null, capacities:Vector.<uint> = null) : ObjectEffectMount
      {
         super.initObjectEffect(actionId);
         this.id = id;
         this.expirationDate = expirationDate;
         this.model = model;
         this.name = name;
         this.owner = owner;
         this.level = level;
         this.sex = sex;
         this.isRideable = isRideable;
         this.isFeconded = isFeconded;
         this.isFecondationReady = isFecondationReady;
         this.reproductionCount = reproductionCount;
         this.reproductionCountMax = reproductionCountMax;
         this.effects = effects;
         this.capacities = capacities;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
         this.expirationDate = 0;
         this.model = 0;
         this.name = "";
         this.owner = "";
         this.level = 0;
         this.sex = false;
         this.isRideable = false;
         this.isFeconded = false;
         this.isFecondationReady = false;
         this.reproductionCount = 0;
         this.reproductionCountMax = 0;
         this.effects = new Vector.<ObjectEffectInteger>();
         this.capacities = new Vector.<uint>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectMount(output);
      }
      
      public function serializeAs_ObjectEffectMount(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isRideable);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.isFeconded);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isFecondationReady);
         output.writeByte(_box0);
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
         if(this.expirationDate < 0 || this.expirationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expirationDate + ") on element expirationDate.");
         }
         output.writeVarLong(this.expirationDate);
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element model.");
         }
         output.writeVarInt(this.model);
         output.writeUTF(this.name);
         output.writeUTF(this.owner);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
         output.writeVarInt(this.reproductionCount);
         if(this.reproductionCountMax < 0)
         {
            throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element reproductionCountMax.");
         }
         output.writeVarInt(this.reproductionCountMax);
         output.writeShort(this.effects.length);
         for(var _i13:uint = 0; _i13 < this.effects.length; _i13++)
         {
            (this.effects[_i13] as ObjectEffectInteger).serializeAs_ObjectEffectInteger(output);
         }
         output.writeShort(this.capacities.length);
         for(var _i14:uint = 0; _i14 < this.capacities.length; _i14++)
         {
            if(this.capacities[_i14] < 0)
            {
               throw new Error("Forbidden value (" + this.capacities[_i14] + ") on element 14 (starting at 1) of capacities.");
            }
            output.writeVarInt(this.capacities[_i14]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectMount(input);
      }
      
      public function deserializeAs_ObjectEffectMount(input:ICustomDataInput) : void
      {
         var _item13:ObjectEffectInteger = null;
         var _val14:uint = 0;
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._idFunc(input);
         this._expirationDateFunc(input);
         this._modelFunc(input);
         this._nameFunc(input);
         this._ownerFunc(input);
         this._levelFunc(input);
         this._reproductionCountFunc(input);
         this._reproductionCountMaxFunc(input);
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i13:uint = 0; _i13 < _effectsLen; _i13++)
         {
            _item13 = new ObjectEffectInteger();
            _item13.deserialize(input);
            this.effects.push(_item13);
         }
         var _capacitiesLen:uint = input.readUnsignedShort();
         for(var _i14:uint = 0; _i14 < _capacitiesLen; _i14++)
         {
            _val14 = input.readVarUhInt();
            if(_val14 < 0)
            {
               throw new Error("Forbidden value (" + _val14 + ") on elements of capacities.");
            }
            this.capacities.push(_val14);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectMount(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectMount(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._idFunc);
         tree.addChild(this._expirationDateFunc);
         tree.addChild(this._modelFunc);
         tree.addChild(this._nameFunc);
         tree.addChild(this._ownerFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._reproductionCountFunc);
         tree.addChild(this._reproductionCountMaxFunc);
         this._effectstree = tree.addChild(this._effectstreeFunc);
         this._capacitiestree = tree.addChild(this._capacitiestreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.isRideable = BooleanByteWrapper.getFlag(_box0,1);
         this.isFeconded = BooleanByteWrapper.getFlag(_box0,2);
         this.isFecondationReady = BooleanByteWrapper.getFlag(_box0,3);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ObjectEffectMount.id.");
         }
      }
      
      private function _expirationDateFunc(input:ICustomDataInput) : void
      {
         this.expirationDate = input.readVarUhLong();
         if(this.expirationDate < 0 || this.expirationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.expirationDate + ") on element of ObjectEffectMount.expirationDate.");
         }
      }
      
      private function _modelFunc(input:ICustomDataInput) : void
      {
         this.model = input.readVarUhInt();
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element of ObjectEffectMount.model.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _ownerFunc(input:ICustomDataInput) : void
      {
         this.owner = input.readUTF();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readByte();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of ObjectEffectMount.level.");
         }
      }
      
      private function _reproductionCountFunc(input:ICustomDataInput) : void
      {
         this.reproductionCount = input.readVarInt();
      }
      
      private function _reproductionCountMaxFunc(input:ICustomDataInput) : void
      {
         this.reproductionCountMax = input.readVarUhInt();
         if(this.reproductionCountMax < 0)
         {
            throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element of ObjectEffectMount.reproductionCountMax.");
         }
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectstree.addChild(this._effectsFunc);
         }
      }
      
      private function _effectsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectEffectInteger = new ObjectEffectInteger();
         _item.deserialize(input);
         this.effects.push(_item);
      }
      
      private function _capacitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._capacitiestree.addChild(this._capacitiesFunc);
         }
      }
      
      private function _capacitiesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of capacities.");
         }
         this.capacities.push(_val);
      }
   }
}
