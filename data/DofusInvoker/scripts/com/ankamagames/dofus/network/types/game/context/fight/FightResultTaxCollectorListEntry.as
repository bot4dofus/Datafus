package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 1141;
       
      
      public var level:uint = 0;
      
      public var guildInfo:BasicGuildInformations;
      
      public var experienceForGuild:int = 0;
      
      private var _guildInfotree:FuncTree;
      
      public function FightResultTaxCollectorListEntry()
      {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1141;
      }
      
      public function initFightResultTaxCollectorListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null, id:Number = 0, alive:Boolean = false, level:uint = 0, guildInfo:BasicGuildInformations = null, experienceForGuild:int = 0) : FightResultTaxCollectorListEntry
      {
         super.initFightResultFighterListEntry(outcome,wave,rewards,id,alive);
         this.level = level;
         this.guildInfo = guildInfo;
         this.experienceForGuild = experienceForGuild;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.level = 0;
         this.guildInfo = new BasicGuildInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultTaxCollectorListEntry(output);
      }
      
      public function serializeAs_FightResultTaxCollectorListEntry(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(output);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
         this.guildInfo.serializeAs_BasicGuildInformations(output);
         output.writeInt(this.experienceForGuild);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultTaxCollectorListEntry(input);
      }
      
      public function deserializeAs_FightResultTaxCollectorListEntry(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._levelFunc(input);
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserialize(input);
         this._experienceForGuildFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultTaxCollectorListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultTaxCollectorListEntry(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._levelFunc);
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
         tree.addChild(this._experienceForGuildFunc);
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readUnsignedByte();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightResultTaxCollectorListEntry.level.");
         }
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
      
      private function _experienceForGuildFunc(input:ICustomDataInput) : void
      {
         this.experienceForGuild = input.readInt();
      }
   }
}
