package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultMutantListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 5503;
       
      
      public var level:uint = 0;
      
      public function FightResultMutantListEntry()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5503;
      }
      
      public function initFightResultMutantListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null, id:Number = 0, alive:Boolean = false, level:uint = 0) : FightResultMutantListEntry
      {
         super.initFightResultFighterListEntry(outcome,wave,rewards,id,alive);
         this.level = level;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultMutantListEntry(output);
      }
      
      public function serializeAs_FightResultMutantListEntry(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(output);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultMutantListEntry(input);
      }
      
      public function deserializeAs_FightResultMutantListEntry(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._levelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultMutantListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultMutantListEntry(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultMutantListEntry.level.");
         }
      }
   }
}
