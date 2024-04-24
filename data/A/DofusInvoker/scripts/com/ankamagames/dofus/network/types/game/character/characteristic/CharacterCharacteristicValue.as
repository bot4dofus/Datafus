package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristicValue extends CharacterCharacteristic implements INetworkType
   {
      
      public static const protocolId:uint = 9684;
       
      
      public var total:int = 0;
      
      public function CharacterCharacteristicValue()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9684;
      }
      
      public function initCharacterCharacteristicValue(characteristicId:int = 0, total:int = 0) : CharacterCharacteristicValue
      {
         super.initCharacterCharacteristic(characteristicId);
         this.total = total;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.total = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristicValue(output);
      }
      
      public function serializeAs_CharacterCharacteristicValue(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterCharacteristic(output);
         output.writeInt(this.total);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristicValue(input);
      }
      
      public function deserializeAs_CharacterCharacteristicValue(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._totalFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristicValue(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristicValue(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._totalFunc);
      }
      
      private function _totalFunc(input:ICustomDataInput) : void
      {
         this.total = input.readInt();
      }
   }
}
