package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristics;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4158;
       
      
      public var uniqueId:Number = 0;
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var allianceIdentity:AllianceInformation;
      
      public var additionalInfos:AdditionalTaxCollectorInformation;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var state:uint = 0;
      
      public var look:EntityLook;
      
      public var complements:Vector.<TaxCollectorComplementaryInformations>;
      
      public var characteristics:CharacterCharacteristics;
      
      public var equipments:Vector.<ObjectItem>;
      
      public var spells:Vector.<TaxCollectorOrderedSpell>;
      
      private var _allianceIdentitytree:FuncTree;
      
      private var _additionalInfostree:FuncTree;
      
      private var _looktree:FuncTree;
      
      private var _complementstree:FuncTree;
      
      private var _characteristicstree:FuncTree;
      
      private var _equipmentstree:FuncTree;
      
      private var _spellstree:FuncTree;
      
      public function TaxCollectorInformations()
      {
         this.allianceIdentity = new AllianceInformation();
         this.additionalInfos = new AdditionalTaxCollectorInformation();
         this.look = new EntityLook();
         this.complements = new Vector.<TaxCollectorComplementaryInformations>();
         this.characteristics = new CharacterCharacteristics();
         this.equipments = new Vector.<ObjectItem>();
         this.spells = new Vector.<TaxCollectorOrderedSpell>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4158;
      }
      
      public function initTaxCollectorInformations(uniqueId:Number = 0, firstNameId:uint = 0, lastNameId:uint = 0, allianceIdentity:AllianceInformation = null, additionalInfos:AdditionalTaxCollectorInformation = null, worldX:int = 0, worldY:int = 0, subAreaId:uint = 0, state:uint = 0, look:EntityLook = null, complements:Vector.<TaxCollectorComplementaryInformations> = null, characteristics:CharacterCharacteristics = null, equipments:Vector.<ObjectItem> = null, spells:Vector.<TaxCollectorOrderedSpell> = null) : TaxCollectorInformations
      {
         this.uniqueId = uniqueId;
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.allianceIdentity = allianceIdentity;
         this.additionalInfos = additionalInfos;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.state = state;
         this.look = look;
         this.complements = complements;
         this.characteristics = characteristics;
         this.equipments = equipments;
         this.spells = spells;
         return this;
      }
      
      public function reset() : void
      {
         this.uniqueId = 0;
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.allianceIdentity = new AllianceInformation();
         this.worldY = 0;
         this.subAreaId = 0;
         this.state = 0;
         this.look = new EntityLook();
         this.characteristics = new CharacterCharacteristics();
         this.spells = new Vector.<TaxCollectorOrderedSpell>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorInformations(output);
      }
      
      public function serializeAs_TaxCollectorInformations(output:ICustomDataOutput) : void
      {
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element uniqueId.");
         }
         output.writeDouble(this.uniqueId);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         output.writeVarShort(this.firstNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
         this.allianceIdentity.serializeAs_AllianceInformation(output);
         this.additionalInfos.serializeAs_AdditionalTaxCollectorInformation(output);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeByte(this.state);
         this.look.serializeAs_EntityLook(output);
         output.writeShort(this.complements.length);
         for(var _i11:uint = 0; _i11 < this.complements.length; _i11++)
         {
            output.writeShort((this.complements[_i11] as TaxCollectorComplementaryInformations).getTypeId());
            (this.complements[_i11] as TaxCollectorComplementaryInformations).serialize(output);
         }
         this.characteristics.serializeAs_CharacterCharacteristics(output);
         output.writeShort(this.equipments.length);
         for(var _i13:uint = 0; _i13 < this.equipments.length; _i13++)
         {
            (this.equipments[_i13] as ObjectItem).serializeAs_ObjectItem(output);
         }
         output.writeShort(this.spells.length);
         for(var _i14:uint = 0; _i14 < this.spells.length; _i14++)
         {
            (this.spells[_i14] as TaxCollectorOrderedSpell).serializeAs_TaxCollectorOrderedSpell(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorInformations(input);
      }
      
      public function deserializeAs_TaxCollectorInformations(input:ICustomDataInput) : void
      {
         var _id11:uint = 0;
         var _item11:TaxCollectorComplementaryInformations = null;
         var _item13:ObjectItem = null;
         var _item14:TaxCollectorOrderedSpell = null;
         this._uniqueIdFunc(input);
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
         this.allianceIdentity = new AllianceInformation();
         this.allianceIdentity.deserialize(input);
         this.additionalInfos = new AdditionalTaxCollectorInformation();
         this.additionalInfos.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._subAreaIdFunc(input);
         this._stateFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
         var _complementsLen:uint = input.readUnsignedShort();
         for(var _i11:uint = 0; _i11 < _complementsLen; _i11++)
         {
            _id11 = input.readUnsignedShort();
            _item11 = ProtocolTypeManager.getInstance(TaxCollectorComplementaryInformations,_id11);
            _item11.deserialize(input);
            this.complements.push(_item11);
         }
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserialize(input);
         var _equipmentsLen:uint = input.readUnsignedShort();
         for(var _i13:uint = 0; _i13 < _equipmentsLen; _i13++)
         {
            _item13 = new ObjectItem();
            _item13.deserialize(input);
            this.equipments.push(_item13);
         }
         var _spellsLen:uint = input.readUnsignedShort();
         for(var _i14:uint = 0; _i14 < _spellsLen; _i14++)
         {
            _item14 = new TaxCollectorOrderedSpell();
            _item14.deserialize(input);
            this.spells.push(_item14);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorInformations(tree:FuncTree) : void
      {
         tree.addChild(this._uniqueIdFunc);
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         this._allianceIdentitytree = tree.addChild(this._allianceIdentitytreeFunc);
         this._additionalInfostree = tree.addChild(this._additionalInfostreeFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._stateFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
         this._complementstree = tree.addChild(this._complementstreeFunc);
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
         this._equipmentstree = tree.addChild(this._equipmentstreeFunc);
         this._spellstree = tree.addChild(this._spellstreeFunc);
      }
      
      private function _uniqueIdFunc(input:ICustomDataInput) : void
      {
         this.uniqueId = input.readDouble();
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element of TaxCollectorInformations.uniqueId.");
         }
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorInformations.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorInformations.lastNameId.");
         }
      }
      
      private function _allianceIdentitytreeFunc(input:ICustomDataInput) : void
      {
         this.allianceIdentity = new AllianceInformation();
         this.allianceIdentity.deserializeAsync(this._allianceIdentitytree);
      }
      
      private function _additionalInfostreeFunc(input:ICustomDataInput) : void
      {
         this.additionalInfos = new AdditionalTaxCollectorInformation();
         this.additionalInfos.deserializeAsync(this._additionalInfostree);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorInformations.worldY.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorInformations.subAreaId.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of TaxCollectorInformations.state.");
         }
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
      
      private function _complementstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._complementstree.addChild(this._complementsFunc);
         }
      }
      
      private function _complementsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:TaxCollectorComplementaryInformations = ProtocolTypeManager.getInstance(TaxCollectorComplementaryInformations,_id);
         _item.deserialize(input);
         this.complements.push(_item);
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserializeAsync(this._characteristicstree);
      }
      
      private function _equipmentstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._equipmentstree.addChild(this._equipmentsFunc);
         }
      }
      
      private function _equipmentsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.equipments.push(_item);
      }
      
      private function _spellstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellstree.addChild(this._spellsFunc);
         }
      }
      
      private function _spellsFunc(input:ICustomDataInput) : void
      {
         var _item:TaxCollectorOrderedSpell = new TaxCollectorOrderedSpell();
         _item.deserialize(input);
         this.spells.push(_item);
      }
   }
}
