package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 3706;
       
      
      public var characteristicId:int = 0;
      
      public function CharacterCharacteristic()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3706;
      }
      
      public function initCharacterCharacteristic(characteristicId:int = 0) : CharacterCharacteristic
      {
         this.characteristicId = characteristicId;
         return this;
      }
      
      public function reset() : void
      {
         this.characteristicId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristic(output);
      }
      
      public function serializeAs_CharacterCharacteristic(output:ICustomDataOutput) : void
      {
         output.writeShort(this.characteristicId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristic(input);
      }
      
      public function deserializeAs_CharacterCharacteristic(input:ICustomDataInput) : void
      {
         this._characteristicIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristic(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristic(tree:FuncTree) : void
      {
         tree.addChild(this._characteristicIdFunc);
      }
      
      private function _characteristicIdFunc(input:ICustomDataInput) : void
      {
         this.characteristicId = input.readShort();
      }
   }
}
