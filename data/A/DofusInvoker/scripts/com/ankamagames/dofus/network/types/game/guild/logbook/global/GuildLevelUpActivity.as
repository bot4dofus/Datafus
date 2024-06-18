package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildLevelUpActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 3398;
       
      
      public var newGuildLevel:uint = 0;
      
      public function GuildLevelUpActivity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3398;
      }
      
      public function initGuildLevelUpActivity(id:uint = 0, date:Number = 0, newGuildLevel:uint = 0) : GuildLevelUpActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         this.newGuildLevel = newGuildLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.newGuildLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildLevelUpActivity(output);
      }
      
      public function serializeAs_GuildLevelUpActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
         if(this.newGuildLevel < 0 || this.newGuildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.newGuildLevel + ") on element newGuildLevel.");
         }
         output.writeByte(this.newGuildLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildLevelUpActivity(input);
      }
      
      public function deserializeAs_GuildLevelUpActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._newGuildLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildLevelUpActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildLevelUpActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._newGuildLevelFunc);
      }
      
      private function _newGuildLevelFunc(input:ICustomDataInput) : void
      {
         this.newGuildLevel = input.readUnsignedByte();
         if(this.newGuildLevel < 0 || this.newGuildLevel > 255)
         {
            throw new Error("Forbidden value (" + this.newGuildLevel + ") on element of GuildLevelUpActivity.newGuildLevel.");
         }
      }
   }
}
