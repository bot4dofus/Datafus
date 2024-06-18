package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightResumeSlaveInfo implements INetworkType
   {
      
      public static const protocolId:uint = 6502;
       
      
      public var slaveId:Number = 0;
      
      public var spellCooldowns:Vector.<GameFightSpellCooldown>;
      
      public var summonCount:uint = 0;
      
      public var bombCount:uint = 0;
      
      private var _spellCooldownstree:FuncTree;
      
      public function GameFightResumeSlaveInfo()
      {
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6502;
      }
      
      public function initGameFightResumeSlaveInfo(slaveId:Number = 0, spellCooldowns:Vector.<GameFightSpellCooldown> = null, summonCount:uint = 0, bombCount:uint = 0) : GameFightResumeSlaveInfo
      {
         this.slaveId = slaveId;
         this.spellCooldowns = spellCooldowns;
         this.summonCount = summonCount;
         this.bombCount = bombCount;
         return this;
      }
      
      public function reset() : void
      {
         this.slaveId = 0;
         this.spellCooldowns = new Vector.<GameFightSpellCooldown>();
         this.summonCount = 0;
         this.bombCount = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightResumeSlaveInfo(output);
      }
      
      public function serializeAs_GameFightResumeSlaveInfo(output:ICustomDataOutput) : void
      {
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element slaveId.");
         }
         output.writeDouble(this.slaveId);
         output.writeShort(this.spellCooldowns.length);
         for(var _i2:uint = 0; _i2 < this.spellCooldowns.length; _i2++)
         {
            (this.spellCooldowns[_i2] as GameFightSpellCooldown).serializeAs_GameFightSpellCooldown(output);
         }
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element summonCount.");
         }
         output.writeByte(this.summonCount);
         if(this.bombCount < 0)
         {
            throw new Error("Forbidden value (" + this.bombCount + ") on element bombCount.");
         }
         output.writeByte(this.bombCount);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightResumeSlaveInfo(input);
      }
      
      public function deserializeAs_GameFightResumeSlaveInfo(input:ICustomDataInput) : void
      {
         var _item2:GameFightSpellCooldown = null;
         this._slaveIdFunc(input);
         var _spellCooldownsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _spellCooldownsLen; _i2++)
         {
            _item2 = new GameFightSpellCooldown();
            _item2.deserialize(input);
            this.spellCooldowns.push(_item2);
         }
         this._summonCountFunc(input);
         this._bombCountFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightResumeSlaveInfo(tree);
      }
      
      public function deserializeAsyncAs_GameFightResumeSlaveInfo(tree:FuncTree) : void
      {
         tree.addChild(this._slaveIdFunc);
         this._spellCooldownstree = tree.addChild(this._spellCooldownstreeFunc);
         tree.addChild(this._summonCountFunc);
         tree.addChild(this._bombCountFunc);
      }
      
      private function _slaveIdFunc(input:ICustomDataInput) : void
      {
         this.slaveId = input.readDouble();
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element of GameFightResumeSlaveInfo.slaveId.");
         }
      }
      
      private function _spellCooldownstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._spellCooldownstree.addChild(this._spellCooldownsFunc);
         }
      }
      
      private function _spellCooldownsFunc(input:ICustomDataInput) : void
      {
         var _item:GameFightSpellCooldown = new GameFightSpellCooldown();
         _item.deserialize(input);
         this.spellCooldowns.push(_item);
      }
      
      private function _summonCountFunc(input:ICustomDataInput) : void
      {
         this.summonCount = input.readByte();
         if(this.summonCount < 0)
         {
            throw new Error("Forbidden value (" + this.summonCount + ") on element of GameFightResumeSlaveInfo.summonCount.");
         }
      }
      
      private function _bombCountFunc(input:ICustomDataInput) : void
      {
         this.bombCount = input.readByte();
         if(this.bombCount < 0)
         {
            throw new Error("Forbidden value (" + this.bombCount + ") on element of GameFightResumeSlaveInfo.bombCount.");
         }
      }
   }
}
