package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlliancedGuildFactSheetInformations extends GuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4861;
       
      
      public var allianceInfos:BasicNamedAllianceInformations;
      
      private var _allianceInfostree:FuncTree;
      
      public function AlliancedGuildFactSheetInformations()
      {
         this.allianceInfos = new BasicNamedAllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4861;
      }
      
      public function initAlliancedGuildFactSheetInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:GuildEmblem = null, allianceInfos:BasicNamedAllianceInformations = null) : AlliancedGuildFactSheetInformations
      {
         super.initGuildInformations(guildId,guildName,guildLevel,guildEmblem);
         this.allianceInfos = allianceInfos;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlliancedGuildFactSheetInformations(output);
      }
      
      public function serializeAs_AlliancedGuildFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildInformations(output);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancedGuildFactSheetInformations(input);
      }
      
      public function deserializeAs_AlliancedGuildFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlliancedGuildFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_AlliancedGuildFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
      }
      
      private function _allianceInfostreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserializeAsync(this._allianceInfostree);
      }
   }
}
