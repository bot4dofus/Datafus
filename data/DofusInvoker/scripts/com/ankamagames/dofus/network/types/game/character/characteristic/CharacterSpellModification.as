package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterSpellModification implements INetworkType
   {
      
      public static const protocolId:uint = 2905;
       
      
      public var modificationType:uint = 0;
      
      public var spellId:uint = 0;
      
      public var value:CharacterCharacteristicDetailed;
      
      private var _valuetree:FuncTree;
      
      public function CharacterSpellModification()
      {
         this.value = new CharacterCharacteristicDetailed();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2905;
      }
      
      public function initCharacterSpellModification(modificationType:uint = 0, spellId:uint = 0, value:CharacterCharacteristicDetailed = null) : CharacterSpellModification
      {
         this.modificationType = modificationType;
         this.spellId = spellId;
         this.value = value;
         return this;
      }
      
      public function reset() : void
      {
         this.modificationType = 0;
         this.spellId = 0;
         this.value = new CharacterCharacteristicDetailed();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterSpellModification(output);
      }
      
      public function serializeAs_CharacterSpellModification(output:ICustomDataOutput) : void
      {
         output.writeByte(this.modificationType);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         output.writeVarShort(this.spellId);
         this.value.serializeAs_CharacterCharacteristicDetailed(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSpellModification(input);
      }
      
      public function deserializeAs_CharacterSpellModification(input:ICustomDataInput) : void
      {
         this._modificationTypeFunc(input);
         this._spellIdFunc(input);
         this.value = new CharacterCharacteristicDetailed();
         this.value.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterSpellModification(tree);
      }
      
      public function deserializeAsyncAs_CharacterSpellModification(tree:FuncTree) : void
      {
         tree.addChild(this._modificationTypeFunc);
         tree.addChild(this._spellIdFunc);
         this._valuetree = tree.addChild(this._valuetreeFunc);
      }
      
      private function _modificationTypeFunc(input:ICustomDataInput) : void
      {
         this.modificationType = input.readByte();
         if(this.modificationType < 0)
         {
            throw new Error("Forbidden value (" + this.modificationType + ") on element of CharacterSpellModification.modificationType.");
         }
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readVarUhShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of CharacterSpellModification.spellId.");
         }
      }
      
      private function _valuetreeFunc(input:ICustomDataInput) : void
      {
         this.value = new CharacterCharacteristicDetailed();
         this.value.deserializeAsync(this._valuetree);
      }
   }
}
