package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2087;
       
      
      public var uniqueId:Number = 0;
      
      public var firtNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var additionalInfos:AdditionalTaxCollectorInformations;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var state:uint = 0;
      
      public var look:EntityLook;
      
      public var complements:Vector.<TaxCollectorComplementaryInformations>;
      
      private var _additionalInfostree:FuncTree;
      
      private var _looktree:FuncTree;
      
      private var _complementstree:FuncTree;
      
      public function TaxCollectorInformations()
      {
         this.additionalInfos = new AdditionalTaxCollectorInformations();
         this.look = new EntityLook();
         this.complements = new Vector.<TaxCollectorComplementaryInformations>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2087;
      }
      
      public function initTaxCollectorInformations(uniqueId:Number = 0, firtNameId:uint = 0, lastNameId:uint = 0, additionalInfos:AdditionalTaxCollectorInformations = null, worldX:int = 0, worldY:int = 0, subAreaId:uint = 0, state:uint = 0, look:EntityLook = null, complements:Vector.<TaxCollectorComplementaryInformations> = null) : TaxCollectorInformations
      {
         this.uniqueId = uniqueId;
         this.firtNameId = firtNameId;
         this.lastNameId = lastNameId;
         this.additionalInfos = additionalInfos;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.state = state;
         this.look = look;
         this.complements = complements;
         return this;
      }
      
      public function reset() : void
      {
         this.uniqueId = 0;
         this.firtNameId = 0;
         this.lastNameId = 0;
         this.additionalInfos = new AdditionalTaxCollectorInformations();
         this.worldY = 0;
         this.subAreaId = 0;
         this.state = 0;
         this.look = new EntityLook();
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
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element firtNameId.");
         }
         output.writeVarShort(this.firtNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
         this.additionalInfos.serializeAs_AdditionalTaxCollectorInformations(output);
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
         for(var _i10:uint = 0; _i10 < this.complements.length; _i10++)
         {
            output.writeShort((this.complements[_i10] as TaxCollectorComplementaryInformations).getTypeId());
            (this.complements[_i10] as TaxCollectorComplementaryInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorInformations(input);
      }
      
      public function deserializeAs_TaxCollectorInformations(input:ICustomDataInput) : void
      {
         var _id10:uint = 0;
         var _item10:TaxCollectorComplementaryInformations = null;
         this._uniqueIdFunc(input);
         this._firtNameIdFunc(input);
         this._lastNameIdFunc(input);
         this.additionalInfos = new AdditionalTaxCollectorInformations();
         this.additionalInfos.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._subAreaIdFunc(input);
         this._stateFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
         var _complementsLen:uint = input.readUnsignedShort();
         for(var _i10:uint = 0; _i10 < _complementsLen; _i10++)
         {
            _id10 = input.readUnsignedShort();
            _item10 = ProtocolTypeManager.getInstance(TaxCollectorComplementaryInformations,_id10);
            _item10.deserialize(input);
            this.complements.push(_item10);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorInformations(tree:FuncTree) : void
      {
         tree.addChild(this._uniqueIdFunc);
         tree.addChild(this._firtNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         this._additionalInfostree = tree.addChild(this._additionalInfostreeFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._stateFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
         this._complementstree = tree.addChild(this._complementstreeFunc);
      }
      
      private function _uniqueIdFunc(input:ICustomDataInput) : void
      {
         this.uniqueId = input.readDouble();
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element of TaxCollectorInformations.uniqueId.");
         }
      }
      
      private function _firtNameIdFunc(input:ICustomDataInput) : void
      {
         this.firtNameId = input.readVarUhShort();
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element of TaxCollectorInformations.firtNameId.");
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
      
      private function _additionalInfostreeFunc(input:ICustomDataInput) : void
      {
         this.additionalInfos = new AdditionalTaxCollectorInformations();
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
   }
}
