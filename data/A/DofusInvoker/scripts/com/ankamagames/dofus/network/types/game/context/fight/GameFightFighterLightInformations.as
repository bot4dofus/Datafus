package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightFighterLightInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4794;
       
      
      public var id:Number = 0;
      
      public var wave:uint = 0;
      
      public var level:uint = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var alive:Boolean = false;
      
      public function GameFightFighterLightInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4794;
      }
      
      public function initGameFightFighterLightInformations(id:Number = 0, wave:uint = 0, level:uint = 0, breed:int = 0, sex:Boolean = false, alive:Boolean = false) : GameFightFighterLightInformations
      {
         this.id = id;
         this.wave = wave;
         this.level = level;
         this.breed = breed;
         this.sex = sex;
         this.alive = alive;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.wave = 0;
         this.level = 0;
         this.breed = 0;
         this.sex = false;
         this.alive = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightFighterLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterLightInformations(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.alive);
         output.writeByte(_box0);
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         output.writeByte(this.wave);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         output.writeByte(this.breed);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightFighterLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterLightInformations(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._idFunc(input);
         this._waveFunc(input);
         this._levelFunc(input);
         this._breedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightFighterLightInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightFighterLightInformations(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._idFunc);
         tree.addChild(this._waveFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._breedFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.alive = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameFightFighterLightInformations.id.");
         }
      }
      
      private function _waveFunc(input:ICustomDataInput) : void
      {
         this.wave = input.readByte();
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element of GameFightFighterLightInformations.wave.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameFightFighterLightInformations.level.");
         }
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
   }
}
