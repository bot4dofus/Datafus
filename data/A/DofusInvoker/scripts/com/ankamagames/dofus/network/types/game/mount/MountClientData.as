package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MountClientData implements INetworkType
   {
      
      public static const protocolId:uint = 4446;
       
      
      public var id:Number = 0;
      
      public var model:uint = 0;
      
      public var ancestor:Vector.<uint>;
      
      public var behaviors:Vector.<uint>;
      
      public var name:String = "";
      
      public var sex:Boolean = false;
      
      public var ownerId:uint = 0;
      
      public var experience:Number = 0;
      
      public var experienceForLevel:Number = 0;
      
      public var experienceForNextLevel:Number = 0;
      
      public var level:uint = 0;
      
      public var isRideable:Boolean = false;
      
      public var maxPods:uint = 0;
      
      public var isWild:Boolean = false;
      
      public var stamina:uint = 0;
      
      public var staminaMax:uint = 0;
      
      public var maturity:uint = 0;
      
      public var maturityForAdult:uint = 0;
      
      public var energy:uint = 0;
      
      public var energyMax:uint = 0;
      
      public var serenity:int = 0;
      
      public var aggressivityMax:int = 0;
      
      public var serenityMax:uint = 0;
      
      public var love:uint = 0;
      
      public var loveMax:uint = 0;
      
      public var fecondationTime:int = 0;
      
      public var isFecondationReady:Boolean = false;
      
      public var boostLimiter:uint = 0;
      
      public var boostMax:Number = 0;
      
      public var reproductionCount:int = 0;
      
      public var reproductionCountMax:uint = 0;
      
      public var harnessGID:uint = 0;
      
      public var useHarnessColors:Boolean = false;
      
      public var effectList:Vector.<ObjectEffectInteger>;
      
      private var _ancestortree:FuncTree;
      
      private var _behaviorstree:FuncTree;
      
      private var _effectListtree:FuncTree;
      
      public function MountClientData()
      {
         this.ancestor = new Vector.<uint>();
         this.behaviors = new Vector.<uint>();
         this.effectList = new Vector.<ObjectEffectInteger>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4446;
      }
      
      public function initMountClientData(id:Number = 0, model:uint = 0, ancestor:Vector.<uint> = null, behaviors:Vector.<uint> = null, name:String = "", sex:Boolean = false, ownerId:uint = 0, experience:Number = 0, experienceForLevel:Number = 0, experienceForNextLevel:Number = 0, level:uint = 0, isRideable:Boolean = false, maxPods:uint = 0, isWild:Boolean = false, stamina:uint = 0, staminaMax:uint = 0, maturity:uint = 0, maturityForAdult:uint = 0, energy:uint = 0, energyMax:uint = 0, serenity:int = 0, aggressivityMax:int = 0, serenityMax:uint = 0, love:uint = 0, loveMax:uint = 0, fecondationTime:int = 0, isFecondationReady:Boolean = false, boostLimiter:uint = 0, boostMax:Number = 0, reproductionCount:int = 0, reproductionCountMax:uint = 0, harnessGID:uint = 0, useHarnessColors:Boolean = false, effectList:Vector.<ObjectEffectInteger> = null) : MountClientData
      {
         this.id = id;
         this.model = model;
         this.ancestor = ancestor;
         this.behaviors = behaviors;
         this.name = name;
         this.sex = sex;
         this.ownerId = ownerId;
         this.experience = experience;
         this.experienceForLevel = experienceForLevel;
         this.experienceForNextLevel = experienceForNextLevel;
         this.level = level;
         this.isRideable = isRideable;
         this.maxPods = maxPods;
         this.isWild = isWild;
         this.stamina = stamina;
         this.staminaMax = staminaMax;
         this.maturity = maturity;
         this.maturityForAdult = maturityForAdult;
         this.energy = energy;
         this.energyMax = energyMax;
         this.serenity = serenity;
         this.aggressivityMax = aggressivityMax;
         this.serenityMax = serenityMax;
         this.love = love;
         this.loveMax = loveMax;
         this.fecondationTime = fecondationTime;
         this.isFecondationReady = isFecondationReady;
         this.boostLimiter = boostLimiter;
         this.boostMax = boostMax;
         this.reproductionCount = reproductionCount;
         this.reproductionCountMax = reproductionCountMax;
         this.harnessGID = harnessGID;
         this.useHarnessColors = useHarnessColors;
         this.effectList = effectList;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.model = 0;
         this.ancestor = new Vector.<uint>();
         this.behaviors = new Vector.<uint>();
         this.name = "";
         this.sex = false;
         this.ownerId = 0;
         this.experience = 0;
         this.experienceForLevel = 0;
         this.experienceForNextLevel = 0;
         this.level = 0;
         this.isRideable = false;
         this.maxPods = 0;
         this.isWild = false;
         this.stamina = 0;
         this.staminaMax = 0;
         this.maturity = 0;
         this.maturityForAdult = 0;
         this.energy = 0;
         this.energyMax = 0;
         this.serenity = 0;
         this.aggressivityMax = 0;
         this.serenityMax = 0;
         this.love = 0;
         this.loveMax = 0;
         this.fecondationTime = 0;
         this.isFecondationReady = false;
         this.boostLimiter = 0;
         this.boostMax = 0;
         this.reproductionCount = 0;
         this.reproductionCountMax = 0;
         this.harnessGID = 0;
         this.useHarnessColors = false;
         this.effectList = new Vector.<ObjectEffectInteger>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MountClientData(output);
      }
      
      public function serializeAs_MountClientData(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isRideable);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.isWild);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isFecondationReady);
         _box0 = BooleanByteWrapper.setFlag(_box0,4,this.useHarnessColors);
         output.writeByte(_box0);
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element model.");
         }
         output.writeVarInt(this.model);
         output.writeShort(this.ancestor.length);
         for(var _i3:uint = 0; _i3 < this.ancestor.length; _i3++)
         {
            if(this.ancestor[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.ancestor[_i3] + ") on element 3 (starting at 1) of ancestor.");
            }
            output.writeInt(this.ancestor[_i3]);
         }
         output.writeShort(this.behaviors.length);
         for(var _i4:uint = 0; _i4 < this.behaviors.length; _i4++)
         {
            if(this.behaviors[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.behaviors[_i4] + ") on element 4 (starting at 1) of behaviors.");
            }
            output.writeInt(this.behaviors[_i4]);
         }
         output.writeUTF(this.name);
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
         }
         output.writeInt(this.ownerId);
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         output.writeVarLong(this.experience);
         if(this.experienceForLevel < 0 || this.experienceForLevel > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForLevel + ") on element experienceForLevel.");
         }
         output.writeVarLong(this.experienceForLevel);
         if(this.experienceForNextLevel < -9007199254740992 || this.experienceForNextLevel > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForNextLevel + ") on element experienceForNextLevel.");
         }
         output.writeDouble(this.experienceForNextLevel);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
         if(this.maxPods < 0)
         {
            throw new Error("Forbidden value (" + this.maxPods + ") on element maxPods.");
         }
         output.writeVarInt(this.maxPods);
         if(this.stamina < 0)
         {
            throw new Error("Forbidden value (" + this.stamina + ") on element stamina.");
         }
         output.writeVarInt(this.stamina);
         if(this.staminaMax < 0)
         {
            throw new Error("Forbidden value (" + this.staminaMax + ") on element staminaMax.");
         }
         output.writeVarInt(this.staminaMax);
         if(this.maturity < 0)
         {
            throw new Error("Forbidden value (" + this.maturity + ") on element maturity.");
         }
         output.writeVarInt(this.maturity);
         if(this.maturityForAdult < 0)
         {
            throw new Error("Forbidden value (" + this.maturityForAdult + ") on element maturityForAdult.");
         }
         output.writeVarInt(this.maturityForAdult);
         if(this.energy < 0)
         {
            throw new Error("Forbidden value (" + this.energy + ") on element energy.");
         }
         output.writeVarInt(this.energy);
         if(this.energyMax < 0)
         {
            throw new Error("Forbidden value (" + this.energyMax + ") on element energyMax.");
         }
         output.writeVarInt(this.energyMax);
         output.writeInt(this.serenity);
         output.writeInt(this.aggressivityMax);
         if(this.serenityMax < 0)
         {
            throw new Error("Forbidden value (" + this.serenityMax + ") on element serenityMax.");
         }
         output.writeVarInt(this.serenityMax);
         if(this.love < 0)
         {
            throw new Error("Forbidden value (" + this.love + ") on element love.");
         }
         output.writeVarInt(this.love);
         if(this.loveMax < 0)
         {
            throw new Error("Forbidden value (" + this.loveMax + ") on element loveMax.");
         }
         output.writeVarInt(this.loveMax);
         output.writeInt(this.fecondationTime);
         if(this.boostLimiter < 0)
         {
            throw new Error("Forbidden value (" + this.boostLimiter + ") on element boostLimiter.");
         }
         output.writeInt(this.boostLimiter);
         if(this.boostMax < -9007199254740992 || this.boostMax > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.boostMax + ") on element boostMax.");
         }
         output.writeDouble(this.boostMax);
         output.writeInt(this.reproductionCount);
         if(this.reproductionCountMax < 0)
         {
            throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element reproductionCountMax.");
         }
         output.writeVarInt(this.reproductionCountMax);
         if(this.harnessGID < 0)
         {
            throw new Error("Forbidden value (" + this.harnessGID + ") on element harnessGID.");
         }
         output.writeVarInt(this.harnessGID);
         output.writeShort(this.effectList.length);
         for(var _i34:uint = 0; _i34 < this.effectList.length; _i34++)
         {
            (this.effectList[_i34] as ObjectEffectInteger).serializeAs_ObjectEffectInteger(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountClientData(input);
      }
      
      public function deserializeAs_MountClientData(input:ICustomDataInput) : void
      {
         var _val3:uint = 0;
         var _val4:uint = 0;
         var _item34:ObjectEffectInteger = null;
         this.deserializeByteBoxes(input);
         this._idFunc(input);
         this._modelFunc(input);
         var _ancestorLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _ancestorLen; _i3++)
         {
            _val3 = input.readInt();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of ancestor.");
            }
            this.ancestor.push(_val3);
         }
         var _behaviorsLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _behaviorsLen; _i4++)
         {
            _val4 = input.readInt();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of behaviors.");
            }
            this.behaviors.push(_val4);
         }
         this._nameFunc(input);
         this._ownerIdFunc(input);
         this._experienceFunc(input);
         this._experienceForLevelFunc(input);
         this._experienceForNextLevelFunc(input);
         this._levelFunc(input);
         this._maxPodsFunc(input);
         this._staminaFunc(input);
         this._staminaMaxFunc(input);
         this._maturityFunc(input);
         this._maturityForAdultFunc(input);
         this._energyFunc(input);
         this._energyMaxFunc(input);
         this._serenityFunc(input);
         this._aggressivityMaxFunc(input);
         this._serenityMaxFunc(input);
         this._loveFunc(input);
         this._loveMaxFunc(input);
         this._fecondationTimeFunc(input);
         this._boostLimiterFunc(input);
         this._boostMaxFunc(input);
         this._reproductionCountFunc(input);
         this._reproductionCountMaxFunc(input);
         this._harnessGIDFunc(input);
         var _effectListLen:uint = input.readUnsignedShort();
         for(var _i34:uint = 0; _i34 < _effectListLen; _i34++)
         {
            _item34 = new ObjectEffectInteger();
            _item34.deserialize(input);
            this.effectList.push(_item34);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountClientData(tree);
      }
      
      public function deserializeAsyncAs_MountClientData(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._idFunc);
         tree.addChild(this._modelFunc);
         this._ancestortree = tree.addChild(this._ancestortreeFunc);
         this._behaviorstree = tree.addChild(this._behaviorstreeFunc);
         tree.addChild(this._nameFunc);
         tree.addChild(this._ownerIdFunc);
         tree.addChild(this._experienceFunc);
         tree.addChild(this._experienceForLevelFunc);
         tree.addChild(this._experienceForNextLevelFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._maxPodsFunc);
         tree.addChild(this._staminaFunc);
         tree.addChild(this._staminaMaxFunc);
         tree.addChild(this._maturityFunc);
         tree.addChild(this._maturityForAdultFunc);
         tree.addChild(this._energyFunc);
         tree.addChild(this._energyMaxFunc);
         tree.addChild(this._serenityFunc);
         tree.addChild(this._aggressivityMaxFunc);
         tree.addChild(this._serenityMaxFunc);
         tree.addChild(this._loveFunc);
         tree.addChild(this._loveMaxFunc);
         tree.addChild(this._fecondationTimeFunc);
         tree.addChild(this._boostLimiterFunc);
         tree.addChild(this._boostMaxFunc);
         tree.addChild(this._reproductionCountFunc);
         tree.addChild(this._reproductionCountMaxFunc);
         tree.addChild(this._harnessGIDFunc);
         this._effectListtree = tree.addChild(this._effectListtreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.isRideable = BooleanByteWrapper.getFlag(_box0,1);
         this.isWild = BooleanByteWrapper.getFlag(_box0,2);
         this.isFecondationReady = BooleanByteWrapper.getFlag(_box0,3);
         this.useHarnessColors = BooleanByteWrapper.getFlag(_box0,4);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of MountClientData.id.");
         }
      }
      
      private function _modelFunc(input:ICustomDataInput) : void
      {
         this.model = input.readVarUhInt();
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element of MountClientData.model.");
         }
      }
      
      private function _ancestortreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._ancestortree.addChild(this._ancestorFunc);
         }
      }
      
      private function _ancestorFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of ancestor.");
         }
         this.ancestor.push(_val);
      }
      
      private function _behaviorstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._behaviorstree.addChild(this._behaviorsFunc);
         }
      }
      
      private function _behaviorsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of behaviors.");
         }
         this.behaviors.push(_val);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _ownerIdFunc(input:ICustomDataInput) : void
      {
         this.ownerId = input.readInt();
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element of MountClientData.ownerId.");
         }
      }
      
      private function _experienceFunc(input:ICustomDataInput) : void
      {
         this.experience = input.readVarUhLong();
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of MountClientData.experience.");
         }
      }
      
      private function _experienceForLevelFunc(input:ICustomDataInput) : void
      {
         this.experienceForLevel = input.readVarUhLong();
         if(this.experienceForLevel < 0 || this.experienceForLevel > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForLevel + ") on element of MountClientData.experienceForLevel.");
         }
      }
      
      private function _experienceForNextLevelFunc(input:ICustomDataInput) : void
      {
         this.experienceForNextLevel = input.readDouble();
         if(this.experienceForNextLevel < -9007199254740992 || this.experienceForNextLevel > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForNextLevel + ") on element of MountClientData.experienceForNextLevel.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readByte();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of MountClientData.level.");
         }
      }
      
      private function _maxPodsFunc(input:ICustomDataInput) : void
      {
         this.maxPods = input.readVarUhInt();
         if(this.maxPods < 0)
         {
            throw new Error("Forbidden value (" + this.maxPods + ") on element of MountClientData.maxPods.");
         }
      }
      
      private function _staminaFunc(input:ICustomDataInput) : void
      {
         this.stamina = input.readVarUhInt();
         if(this.stamina < 0)
         {
            throw new Error("Forbidden value (" + this.stamina + ") on element of MountClientData.stamina.");
         }
      }
      
      private function _staminaMaxFunc(input:ICustomDataInput) : void
      {
         this.staminaMax = input.readVarUhInt();
         if(this.staminaMax < 0)
         {
            throw new Error("Forbidden value (" + this.staminaMax + ") on element of MountClientData.staminaMax.");
         }
      }
      
      private function _maturityFunc(input:ICustomDataInput) : void
      {
         this.maturity = input.readVarUhInt();
         if(this.maturity < 0)
         {
            throw new Error("Forbidden value (" + this.maturity + ") on element of MountClientData.maturity.");
         }
      }
      
      private function _maturityForAdultFunc(input:ICustomDataInput) : void
      {
         this.maturityForAdult = input.readVarUhInt();
         if(this.maturityForAdult < 0)
         {
            throw new Error("Forbidden value (" + this.maturityForAdult + ") on element of MountClientData.maturityForAdult.");
         }
      }
      
      private function _energyFunc(input:ICustomDataInput) : void
      {
         this.energy = input.readVarUhInt();
         if(this.energy < 0)
         {
            throw new Error("Forbidden value (" + this.energy + ") on element of MountClientData.energy.");
         }
      }
      
      private function _energyMaxFunc(input:ICustomDataInput) : void
      {
         this.energyMax = input.readVarUhInt();
         if(this.energyMax < 0)
         {
            throw new Error("Forbidden value (" + this.energyMax + ") on element of MountClientData.energyMax.");
         }
      }
      
      private function _serenityFunc(input:ICustomDataInput) : void
      {
         this.serenity = input.readInt();
      }
      
      private function _aggressivityMaxFunc(input:ICustomDataInput) : void
      {
         this.aggressivityMax = input.readInt();
      }
      
      private function _serenityMaxFunc(input:ICustomDataInput) : void
      {
         this.serenityMax = input.readVarUhInt();
         if(this.serenityMax < 0)
         {
            throw new Error("Forbidden value (" + this.serenityMax + ") on element of MountClientData.serenityMax.");
         }
      }
      
      private function _loveFunc(input:ICustomDataInput) : void
      {
         this.love = input.readVarUhInt();
         if(this.love < 0)
         {
            throw new Error("Forbidden value (" + this.love + ") on element of MountClientData.love.");
         }
      }
      
      private function _loveMaxFunc(input:ICustomDataInput) : void
      {
         this.loveMax = input.readVarUhInt();
         if(this.loveMax < 0)
         {
            throw new Error("Forbidden value (" + this.loveMax + ") on element of MountClientData.loveMax.");
         }
      }
      
      private function _fecondationTimeFunc(input:ICustomDataInput) : void
      {
         this.fecondationTime = input.readInt();
      }
      
      private function _boostLimiterFunc(input:ICustomDataInput) : void
      {
         this.boostLimiter = input.readInt();
         if(this.boostLimiter < 0)
         {
            throw new Error("Forbidden value (" + this.boostLimiter + ") on element of MountClientData.boostLimiter.");
         }
      }
      
      private function _boostMaxFunc(input:ICustomDataInput) : void
      {
         this.boostMax = input.readDouble();
         if(this.boostMax < -9007199254740992 || this.boostMax > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.boostMax + ") on element of MountClientData.boostMax.");
         }
      }
      
      private function _reproductionCountFunc(input:ICustomDataInput) : void
      {
         this.reproductionCount = input.readInt();
      }
      
      private function _reproductionCountMaxFunc(input:ICustomDataInput) : void
      {
         this.reproductionCountMax = input.readVarUhInt();
         if(this.reproductionCountMax < 0)
         {
            throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element of MountClientData.reproductionCountMax.");
         }
      }
      
      private function _harnessGIDFunc(input:ICustomDataInput) : void
      {
         this.harnessGID = input.readVarUhInt();
         if(this.harnessGID < 0)
         {
            throw new Error("Forbidden value (" + this.harnessGID + ") on element of MountClientData.harnessGID.");
         }
      }
      
      private function _effectListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectListtree.addChild(this._effectListFunc);
         }
      }
      
      private function _effectListFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectEffectInteger = new ObjectEffectInteger();
         _item.deserialize(input);
         this.effectList.push(_item);
      }
   }
}
