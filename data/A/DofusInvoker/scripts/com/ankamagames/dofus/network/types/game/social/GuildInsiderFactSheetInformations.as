package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.guild.recruitment.GuildRecruitmentInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildInsiderFactSheetInformations extends GuildFactSheetInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7914;
       
      
      public var leaderName:String = "";
      
      public function GuildInsiderFactSheetInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7914;
      }
      
      public function initGuildInsiderFactSheetInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:SocialEmblem = null, leaderId:Number = 0, nbMembers:uint = 0, lastActivityDay:uint = 0, recruitment:GuildRecruitmentInformation = null, nbPendingApply:uint = 0, leaderName:String = "") : GuildInsiderFactSheetInformations
      {
         super.initGuildFactSheetInformations(guildId,guildName,guildLevel,guildEmblem,leaderId,nbMembers,lastActivityDay,recruitment,nbPendingApply);
         this.leaderName = leaderName;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.leaderName = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildInsiderFactSheetInformations(output);
      }
      
      public function serializeAs_GuildInsiderFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildFactSheetInformations(output);
         output.writeUTF(this.leaderName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInsiderFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildInsiderFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._leaderNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInsiderFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildInsiderFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._leaderNameFunc);
      }
      
      private function _leaderNameFunc(input:ICustomDataInput) : void
      {
         this.leaderName = input.readUTF();
      }
   }
}
