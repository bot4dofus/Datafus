package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 3594;
       
      
      public var outcome:uint = 0;
      
      public var wave:uint = 0;
      
      public var rewards:FightLoot;
      
      private var _rewardstree:FuncTree;
      
      public function FightResultListEntry()
      {
         this.rewards = new FightLoot();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3594;
      }
      
      public function initFightResultListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null) : FightResultListEntry
      {
         this.outcome = outcome;
         this.wave = wave;
         this.rewards = rewards;
         return this;
      }
      
      public function reset() : void
      {
         this.outcome = 0;
         this.wave = 0;
         this.rewards = new FightLoot();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultListEntry(output);
      }
      
      public function serializeAs_FightResultListEntry(output:ICustomDataOutput) : void
      {
         output.writeVarShort(this.outcome);
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element wave.");
         }
         output.writeByte(this.wave);
         this.rewards.serializeAs_FightLoot(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultListEntry(input);
      }
      
      public function deserializeAs_FightResultListEntry(input:ICustomDataInput) : void
      {
         this._outcomeFunc(input);
         this._waveFunc(input);
         this.rewards = new FightLoot();
         this.rewards.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultListEntry(tree:FuncTree) : void
      {
         tree.addChild(this._outcomeFunc);
         tree.addChild(this._waveFunc);
         this._rewardstree = tree.addChild(this._rewardstreeFunc);
      }
      
      private function _outcomeFunc(input:ICustomDataInput) : void
      {
         this.outcome = input.readVarUhShort();
         if(this.outcome < 0)
         {
            throw new Error("Forbidden value (" + this.outcome + ") on element of FightResultListEntry.outcome.");
         }
      }
      
      private function _waveFunc(input:ICustomDataInput) : void
      {
         this.wave = input.readByte();
         if(this.wave < 0)
         {
            throw new Error("Forbidden value (" + this.wave + ") on element of FightResultListEntry.wave.");
         }
      }
      
      private function _rewardstreeFunc(input:ICustomDataInput) : void
      {
         this.rewards = new FightLoot();
         this.rewards.deserializeAsync(this._rewardstree);
      }
   }
}
