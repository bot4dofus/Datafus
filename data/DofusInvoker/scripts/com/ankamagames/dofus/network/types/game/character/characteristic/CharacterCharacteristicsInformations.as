package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorExtendedAlignmentInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristicsInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9594;
       
      
      public var experience:Number = 0;
      
      public var experienceLevelFloor:Number = 0;
      
      public var experienceNextLevelFloor:Number = 0;
      
      public var experienceBonusLimit:Number = 0;
      
      public var kamas:Number = 0;
      
      public var alignmentInfos:ActorExtendedAlignmentInformations;
      
      public var criticalHitWeapon:uint = 0;
      
      public var characteristics:Vector.<CharacterCharacteristic>;
      
      public var spellModifications:Vector.<CharacterSpellModification>;
      
      public var probationTime:uint = 0;
      
      private var _alignmentInfostree:FuncTree;
      
      private var _characteristicstree:FuncTree;
      
      private var _spellModificationstree:FuncTree;
      
      public function CharacterCharacteristicsInformations()
      {
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.characteristics = new Vector.<CharacterCharacteristic>();
         this.spellModifications = new Vector.<CharacterSpellModification>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9594;
      }
      
      public function initCharacterCharacteristicsInformations(experience:Number = 0, experienceLevelFloor:Number = 0, experienceNextLevelFloor:Number = 0, experienceBonusLimit:Number = 0, kamas:Number = 0, alignmentInfos:ActorExtendedAlignmentInformations = null, criticalHitWeapon:uint = 0, characteristics:Vector.<CharacterCharacteristic> = null, spellModifications:Vector.<CharacterSpellModification> = null, probationTime:uint = 0) : CharacterCharacteristicsInformations
      {
         this.experience = experience;
         this.experienceLevelFloor = experienceLevelFloor;
         this.experienceNextLevelFloor = experienceNextLevelFloor;
         this.experienceBonusLimit = experienceBonusLimit;
         this.kamas = kamas;
         this.alignmentInfos = alignmentInfos;
         this.criticalHitWeapon = criticalHitWeapon;
         this.characteristics = characteristics;
         this.spellModifications = spellModifications;
         this.probationTime = probationTime;
         return this;
      }
      
      public function reset() : void
      {
         this.experience = 0;
         this.experienceLevelFloor = 0;
         this.experienceNextLevelFloor = 0;
         this.experienceBonusLimit = 0;
         this.kamas = 0;
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.characteristics = new Vector.<CharacterCharacteristic>();
         this.spellModifications = new Vector.<CharacterSpellModification>();
         this.probationTime = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristicsInformations(output);
      }
      
      public function serializeAs_CharacterCharacteristicsInformations(output:ICustomDataOutput) : void
      {
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         output.writeVarLong(this.experience);
         if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element experienceLevelFloor.");
         }
         output.writeVarLong(this.experienceLevelFloor);
         if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element experienceNextLevelFloor.");
         }
         output.writeVarLong(this.experienceNextLevelFloor);
         if(this.experienceBonusLimit < 0 || this.experienceBonusLimit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceBonusLimit + ") on element experienceBonusLimit.");
         }
         output.writeVarLong(this.experienceBonusLimit);
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
         this.alignmentInfos.serializeAs_ActorExtendedAlignmentInformations(output);
         if(this.criticalHitWeapon < 0)
         {
            throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element criticalHitWeapon.");
         }
         output.writeVarShort(this.criticalHitWeapon);
         output.writeShort(this.characteristics.length);
         for(var _i8:uint = 0; _i8 < this.characteristics.length; _i8++)
         {
            output.writeShort((this.characteristics[_i8] as CharacterCharacteristic).getTypeId());
            (this.characteristics[_i8] as CharacterCharacteristic).serialize(output);
         }
         output.writeShort(this.spellModifications.length);
         for(var _i9:uint = 0; _i9 < this.spellModifications.length; _i9++)
         {
            (this.spellModifications[_i9] as CharacterSpellModification).serializeAs_CharacterSpellModification(output);
         }
         if(this.probationTime < 0)
         {
            throw new Error("Forbidden value (" + this.probationTime + ") on element probationTime.");
         }
         output.writeInt(this.probationTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristicsInformations(input);
      }
      
      public function deserializeAs_CharacterCharacteristicsInformations(input:ICustomDataInput) : void
      {
         var _id8:uint = 0;
         var _item8:CharacterCharacteristic = null;
         var _item9:CharacterSpellModification = null;
         this._experienceFunc(input);
         this._experienceLevelFloorFunc(input);
         this._experienceNextLevelFloorFunc(input);
         this._experienceBonusLimitFunc(input);
         this._kamasFunc(input);
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.alignmentInfos.deserialize(input);
         this._criticalHitWeaponFunc(input);
         var _characteristicsLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _characteristicsLen; _i8++)
         {
            _id8 = input.readUnsignedShort();
            _item8 = ProtocolTypeManager.getInstance(CharacterCharacteristic,_id8);
            _item8.deserialize(input);
            this.characteristics.push(_item8);
         }
         var _spellModificationsLen:uint = input.readUnsignedShort();
         for(var _i9:uint = 0; _i9 < _spellModificationsLen; _i9++)
         {
            _item9 = new CharacterSpellModification();
            _item9.deserialize(input);
            this.spellModifications.push(_item9);
         }
         this._probationTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristicsInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristicsInformations(tree:FuncTree) : void
      {
         tree.addChild(this._experienceFunc);
         tree.addChild(this._experienceLevelFloorFunc);
         tree.addChild(this._experienceNextLevelFloorFunc);
         tree.addChild(this._experienceBonusLimitFunc);
         tree.addChild(this._kamasFunc);
         this._alignmentInfostree = tree.addChild(this._alignmentInfostreeFunc);
         tree.addChild(this._criticalHitWeaponFunc);
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
         this._spellModificationstree = tree.addChild(this._spellModificationstreeFunc);
         tree.addChild(this._probationTimeFunc);
      }
      
      private function _experienceFunc(input:ICustomDataInput) : void
      {
         this.experience = input.readVarUhLong();
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of CharacterCharacteristicsInformations.experience.");
         }
      }
      
      private function _experienceLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.experienceLevelFloor = input.readVarUhLong();
         if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceLevelFloor.");
         }
      }
      
      private function _experienceNextLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.experienceNextLevelFloor = input.readVarUhLong();
         if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element of CharacterCharacteristicsInformations.experienceNextLevelFloor.");
         }
      }
      
      private function _experienceBonusLimitFunc(input:ICustomDataInput) : void
      {
         this.experienceBonusLimit = input.readVarUhLong();
         if(this.experienceBonusLimit < 0 || this.experienceBonusLimit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceBonusLimit + ") on element of CharacterCharacteristicsInformations.experienceBonusLimit.");
         }
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of CharacterCharacteristicsInformations.kamas.");
         }
      }
      
      private function _alignmentInfostreeFunc(input:ICustomDataInput) : void
      {
         this.alignmentInfos = new ActorExtendedAlignmentInformations();
         this.alignmentInfos.deserializeAsync(this._alignmentInfostree);
      }
      
      private function _criticalHitWeaponFunc(input:ICustomDataInput) : void
      {
         this.criticalHitWeapon = input.readVarUhShort();
         if(this.criticalHitWeapon < 0)
         {
            throw new Error("Forbidden value (" + this.criticalHitWeapon + ") on element of CharacterCharacteristicsInformations.criticalHitWeapon.");
         }
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._characteristicstree.addChild(this._characteristicsFunc);
         }
      }
      
      private function _characteristicsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterCharacteristic = ProtocolTypeManager.getInstance(CharacterCharacteristic,_id);
         _item.deserialize(input);
         this.characteristics.push(_item);
      }
      
      private function _spellModificationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellModificationstree.addChild(this._spellModificationsFunc);
         }
      }
      
      private function _spellModificationsFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterSpellModification = new CharacterSpellModification();
         _item.deserialize(input);
         this.spellModifications.push(_item);
      }
      
      private function _probationTimeFunc(input:ICustomDataInput) : void
      {
         this.probationTime = input.readInt();
         if(this.probationTime < 0)
         {
            throw new Error("Forbidden value (" + this.probationTime + ") on element of CharacterCharacteristicsInformations.probationTime.");
         }
      }
   }
}
