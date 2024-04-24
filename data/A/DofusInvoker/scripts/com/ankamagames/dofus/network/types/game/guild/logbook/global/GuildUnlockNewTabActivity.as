package com.ankamagames.dofus.network.types.game.guild.logbook.global
{
   import com.ankamagames.dofus.network.types.game.guild.logbook.GuildLogbookEntryBasicInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildUnlockNewTabActivity extends GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 2028;
       
      
      public function GuildUnlockNewTabActivity()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2028;
      }
      
      public function initGuildUnlockNewTabActivity(id:uint = 0, date:Number = 0) : GuildUnlockNewTabActivity
      {
         super.initGuildLogbookEntryBasicInformation(id,date);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildUnlockNewTabActivity(output);
      }
      
      public function serializeAs_GuildUnlockNewTabActivity(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildLogbookEntryBasicInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildUnlockNewTabActivity(input);
      }
      
      public function deserializeAs_GuildUnlockNewTabActivity(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildUnlockNewTabActivity(tree);
      }
      
      public function deserializeAsyncAs_GuildUnlockNewTabActivity(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
