package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildInformations extends BasicGuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7125;
       
      
      public var guildEmblem:SocialEmblem;
      
      private var _guildEmblemtree:FuncTree;
      
      public function GuildInformations()
      {
         this.guildEmblem = new SocialEmblem();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7125;
      }
      
      public function initGuildInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:SocialEmblem = null) : GuildInformations
      {
         super.initBasicGuildInformations(guildId,guildName,guildLevel);
         this.guildEmblem = guildEmblem;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guildEmblem = new SocialEmblem();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildInformations(output);
      }
      
      public function serializeAs_GuildInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_BasicGuildInformations(output);
         this.guildEmblem.serializeAs_SocialEmblem(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformations(input);
      }
      
      public function deserializeAs_GuildInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guildEmblem = new SocialEmblem();
         this.guildEmblem.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildEmblemtree = tree.addChild(this._guildEmblemtreeFunc);
      }
      
      private function _guildEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.guildEmblem = new SocialEmblem();
         this.guildEmblem.deserializeAsync(this._guildEmblemtree);
      }
   }
}
