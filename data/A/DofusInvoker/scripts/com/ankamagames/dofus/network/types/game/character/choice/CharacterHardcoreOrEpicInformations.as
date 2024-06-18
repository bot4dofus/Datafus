package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterHardcoreOrEpicInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3983;
       
      
      public var deathState:uint = 0;
      
      public var deathCount:uint = 0;
      
      public var deathMaxLevel:uint = 0;
      
      public function CharacterHardcoreOrEpicInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3983;
      }
      
      public function initCharacterHardcoreOrEpicInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false, deathState:uint = 0, deathCount:uint = 0, deathMaxLevel:uint = 0) : CharacterHardcoreOrEpicInformations
      {
         super.initCharacterBaseInformations(id,name,level,entityLook,breed,sex);
         this.deathState = deathState;
         this.deathCount = deathCount;
         this.deathMaxLevel = deathMaxLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.deathState = 0;
         this.deathCount = 0;
         this.deathMaxLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterHardcoreOrEpicInformations(output);
      }
      
      public function serializeAs_CharacterHardcoreOrEpicInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterBaseInformations(output);
         output.writeByte(this.deathState);
         if(this.deathCount < 0)
         {
            throw new Error("Forbidden value (" + this.deathCount + ") on element deathCount.");
         }
         output.writeVarShort(this.deathCount);
         if(this.deathMaxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element deathMaxLevel.");
         }
         output.writeVarShort(this.deathMaxLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterHardcoreOrEpicInformations(input);
      }
      
      public function deserializeAs_CharacterHardcoreOrEpicInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._deathStateFunc(input);
         this._deathCountFunc(input);
         this._deathMaxLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterHardcoreOrEpicInformations(tree);
      }
      
      public function deserializeAsyncAs_CharacterHardcoreOrEpicInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._deathStateFunc);
         tree.addChild(this._deathCountFunc);
         tree.addChild(this._deathMaxLevelFunc);
      }
      
      private function _deathStateFunc(input:ICustomDataInput) : void
      {
         this.deathState = input.readByte();
         if(this.deathState < 0)
         {
            throw new Error("Forbidden value (" + this.deathState + ") on element of CharacterHardcoreOrEpicInformations.deathState.");
         }
      }
      
      private function _deathCountFunc(input:ICustomDataInput) : void
      {
         this.deathCount = input.readVarUhShort();
         if(this.deathCount < 0)
         {
            throw new Error("Forbidden value (" + this.deathCount + ") on element of CharacterHardcoreOrEpicInformations.deathCount.");
         }
      }
      
      private function _deathMaxLevelFunc(input:ICustomDataInput) : void
      {
         this.deathMaxLevel = input.readVarUhShort();
         if(this.deathMaxLevel < 0)
         {
            throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element of CharacterHardcoreOrEpicInformations.deathMaxLevel.");
         }
      }
   }
}
