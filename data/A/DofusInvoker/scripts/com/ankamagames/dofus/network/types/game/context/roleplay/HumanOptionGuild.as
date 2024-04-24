package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOptionGuild extends HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 6319;
       
      
      public var guildInformations:GuildInformations;
      
      private var _guildInformationstree:FuncTree;
      
      public function HumanOptionGuild()
      {
         this.guildInformations = new GuildInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6319;
      }
      
      public function initHumanOptionGuild(guildInformations:GuildInformations = null) : HumanOptionGuild
      {
         this.guildInformations = guildInformations;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildInformations = new GuildInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionGuild(output);
      }
      
      public function serializeAs_HumanOptionGuild(output:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(output);
         this.guildInformations.serializeAs_GuildInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionGuild(input);
      }
      
      public function deserializeAs_HumanOptionGuild(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guildInformations = new GuildInformations();
         this.guildInformations.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanOptionGuild(tree);
      }
      
      public function deserializeAsyncAs_HumanOptionGuild(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildInformationstree = tree.addChild(this._guildInformationstreeFunc);
      }
      
      private function _guildInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.guildInformations = new GuildInformations();
         this.guildInformations.deserializeAsync(this._guildInformationstree);
      }
   }
}
