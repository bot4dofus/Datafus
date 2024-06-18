package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristicDetailed extends CharacterCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 901;
       
      
      public var base:int = 0;
      
      public var additional:int = 0;
      
      public var objectsAndMountBonus:int = 0;
      
      public var alignGiftBonus:int = 0;
      
      public var contextModif:int = 0;
      
      public function CharacterCharacteristicDetailed()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 901;
      }
      
      public function initCharacterCharacteristicDetailed(characteristicId:int = 0, base:int = 0, additional:int = 0, objectsAndMountBonus:int = 0, alignGiftBonus:int = 0, contextModif:int = 0) : CharacterCharacteristicDetailed
      {
         super.initCharacterCharacteristic(characteristicId);
         this.base = base;
         this.additional = additional;
         this.objectsAndMountBonus = objectsAndMountBonus;
         this.alignGiftBonus = alignGiftBonus;
         this.contextModif = contextModif;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.base = 0;
         this.additional = 0;
         this.objectsAndMountBonus = 0;
         this.alignGiftBonus = 0;
         this.contextModif = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristicDetailed(output);
      }
      
      public function serializeAs_CharacterCharacteristicDetailed(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterCharacteristic(output);
         output.writeVarInt(this.base);
         output.writeVarInt(this.additional);
         output.writeVarInt(this.objectsAndMountBonus);
         output.writeVarInt(this.alignGiftBonus);
         output.writeVarInt(this.contextModif);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristicDetailed(input);
      }
      
      public function deserializeAs_CharacterCharacteristicDetailed(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._baseFunc(input);
         this._additionalFunc(input);
         this._objectsAndMountBonusFunc(input);
         this._alignGiftBonusFunc(input);
         this._contextModifFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristicDetailed(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristicDetailed(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._baseFunc);
         tree.addChild(this._additionalFunc);
         tree.addChild(this._objectsAndMountBonusFunc);
         tree.addChild(this._alignGiftBonusFunc);
         tree.addChild(this._contextModifFunc);
      }
      
      private function _baseFunc(input:ICustomDataInput) : void
      {
         this.base = input.readVarInt();
      }
      
      private function _additionalFunc(input:ICustomDataInput) : void
      {
         this.additional = input.readVarInt();
      }
      
      private function _objectsAndMountBonusFunc(input:ICustomDataInput) : void
      {
         this.objectsAndMountBonus = input.readVarInt();
      }
      
      private function _alignGiftBonusFunc(input:ICustomDataInput) : void
      {
         this.alignGiftBonus = input.readVarInt();
      }
      
      private function _contextModifFunc(input:ICustomDataInput) : void
      {
         this.contextModif = input.readVarInt();
      }
   }
}
