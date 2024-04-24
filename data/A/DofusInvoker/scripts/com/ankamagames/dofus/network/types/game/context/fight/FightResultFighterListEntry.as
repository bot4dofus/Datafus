package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultFighterListEntry extends FightResultListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 8223;
       
      
      public var id:Number = 0;
      
      public var alive:Boolean = false;
      
      public function FightResultFighterListEntry()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8223;
      }
      
      public function initFightResultFighterListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null, id:Number = 0, alive:Boolean = false) : FightResultFighterListEntry
      {
         super.initFightResultListEntry(outcome,wave,rewards);
         this.id = id;
         this.alive = alive;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
         this.alive = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultFighterListEntry(output);
      }
      
      public function serializeAs_FightResultFighterListEntry(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultListEntry(output);
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         output.writeBoolean(this.alive);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultFighterListEntry(input);
      }
      
      public function deserializeAs_FightResultFighterListEntry(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._idFunc(input);
         this._aliveFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultFighterListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultFighterListEntry(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._idFunc);
         tree.addChild(this._aliveFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of FightResultFighterListEntry.id.");
         }
      }
      
      private function _aliveFunc(input:ICustomDataInput) : void
      {
         this.alive = input.readBoolean();
      }
   }
}
