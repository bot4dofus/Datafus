package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterUsableCharacteristicDetailed extends CharacterCharacteristicDetailed implements INetworkType
   {
      
      public static const protocolId:uint = 1943;
       
      
      public var used:uint = 0;
      
      public function CharacterUsableCharacteristicDetailed()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1943;
      }
      
      public function initCharacterUsableCharacteristicDetailed(characteristicId:int = 0, base:int = 0, additional:int = 0, objectsAndMountBonus:int = 0, alignGiftBonus:int = 0, contextModif:int = 0, used:uint = 0) : CharacterUsableCharacteristicDetailed
      {
         super.initCharacterCharacteristicDetailed(characteristicId,base,additional,objectsAndMountBonus,alignGiftBonus,contextModif);
         this.used = used;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.used = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterUsableCharacteristicDetailed(output);
      }
      
      public function serializeAs_CharacterUsableCharacteristicDetailed(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterCharacteristicDetailed(output);
         if(this.used < 0)
         {
            throw new Error("Forbidden value (" + this.used + ") on element used.");
         }
         output.writeVarInt(this.used);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterUsableCharacteristicDetailed(input);
      }
      
      public function deserializeAs_CharacterUsableCharacteristicDetailed(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._usedFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterUsableCharacteristicDetailed(tree);
      }
      
      public function deserializeAsyncAs_CharacterUsableCharacteristicDetailed(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._usedFunc);
      }
      
      private function _usedFunc(input:ICustomDataInput) : void
      {
         this.used = input.readVarUhInt();
         if(this.used < 0)
         {
            throw new Error("Forbidden value (" + this.used + ") on element of CharacterUsableCharacteristicDetailed.used.");
         }
      }
   }
}
