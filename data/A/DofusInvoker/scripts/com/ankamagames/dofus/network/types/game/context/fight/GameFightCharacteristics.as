package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristics;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightCharacteristics implements INetworkType
   {
      
      public static const protocolId:uint = 3605;
       
      
      public var characteristics:CharacterCharacteristics;
      
      public var summoner:Number = 0;
      
      public var summoned:Boolean = false;
      
      public var invisibilityState:uint = 0;
      
      private var _characteristicstree:FuncTree;
      
      public function GameFightCharacteristics()
      {
         this.characteristics = new CharacterCharacteristics();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3605;
      }
      
      public function initGameFightCharacteristics(characteristics:CharacterCharacteristics = null, summoner:Number = 0, summoned:Boolean = false, invisibilityState:uint = 0) : GameFightCharacteristics
      {
         this.characteristics = characteristics;
         this.summoner = summoner;
         this.summoned = summoned;
         this.invisibilityState = invisibilityState;
         return this;
      }
      
      public function reset() : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.summoned = false;
         this.invisibilityState = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightCharacteristics(output);
      }
      
      public function serializeAs_GameFightCharacteristics(output:ICustomDataOutput) : void
      {
         this.characteristics.serializeAs_CharacterCharacteristics(output);
         if(this.summoner < -9007199254740992 || this.summoner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.summoner + ") on element summoner.");
         }
         output.writeDouble(this.summoner);
         output.writeBoolean(this.summoned);
         output.writeByte(this.invisibilityState);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightCharacteristics(input);
      }
      
      public function deserializeAs_GameFightCharacteristics(input:ICustomDataInput) : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserialize(input);
         this._summonerFunc(input);
         this._summonedFunc(input);
         this._invisibilityStateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightCharacteristics(tree);
      }
      
      public function deserializeAsyncAs_GameFightCharacteristics(tree:FuncTree) : void
      {
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
         tree.addChild(this._summonerFunc);
         tree.addChild(this._summonedFunc);
         tree.addChild(this._invisibilityStateFunc);
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserializeAsync(this._characteristicstree);
      }
      
      private function _summonerFunc(input:ICustomDataInput) : void
      {
         this.summoner = input.readDouble();
         if(this.summoner < -9007199254740992 || this.summoner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.summoner + ") on element of GameFightCharacteristics.summoner.");
         }
      }
      
      private function _summonedFunc(input:ICustomDataInput) : void
      {
         this.summoned = input.readBoolean();
      }
      
      private function _invisibilityStateFunc(input:ICustomDataInput) : void
      {
         this.invisibilityState = input.readByte();
         if(this.invisibilityState < 0)
         {
            throw new Error("Forbidden value (" + this.invisibilityState + ") on element of GameFightCharacteristics.invisibilityState.");
         }
      }
   }
}
