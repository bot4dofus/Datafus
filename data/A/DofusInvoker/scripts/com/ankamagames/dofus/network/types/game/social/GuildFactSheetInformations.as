package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.recruitment.GuildRecruitmentInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildFactSheetInformations extends GuildInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6548;
       
      
      public var leaderId:Number = 0;
      
      public var nbMembers:uint = 0;
      
      public var lastActivityDay:uint = 0;
      
      public var recruitment:GuildRecruitmentInformation;
      
      public var nbPendingApply:uint = 0;
      
      private var _recruitmenttree:FuncTree;
      
      public function GuildFactSheetInformations()
      {
         this.recruitment = new GuildRecruitmentInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6548;
      }
      
      public function initGuildFactSheetInformations(guildId:uint = 0, guildName:String = "", guildLevel:uint = 0, guildEmblem:SocialEmblem = null, leaderId:Number = 0, nbMembers:uint = 0, lastActivityDay:uint = 0, recruitment:GuildRecruitmentInformation = null, nbPendingApply:uint = 0) : GuildFactSheetInformations
      {
         super.initGuildInformations(guildId,guildName,guildLevel,guildEmblem);
         this.leaderId = leaderId;
         this.nbMembers = nbMembers;
         this.lastActivityDay = lastActivityDay;
         this.recruitment = recruitment;
         this.nbPendingApply = nbPendingApply;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.leaderId = 0;
         this.nbMembers = 0;
         this.lastActivityDay = 0;
         this.recruitment = new GuildRecruitmentInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildFactSheetInformations(output);
      }
      
      public function serializeAs_GuildFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildInformations(output);
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         output.writeVarLong(this.leaderId);
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeVarShort(this.nbMembers);
         if(this.lastActivityDay < 0)
         {
            throw new Error("Forbidden value (" + this.lastActivityDay + ") on element lastActivityDay.");
         }
         output.writeShort(this.lastActivityDay);
         this.recruitment.serializeAs_GuildRecruitmentInformation(output);
         if(this.nbPendingApply < 0)
         {
            throw new Error("Forbidden value (" + this.nbPendingApply + ") on element nbPendingApply.");
         }
         output.writeInt(this.nbPendingApply);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFactSheetInformations(input);
      }
      
      public function deserializeAs_GuildFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._leaderIdFunc(input);
         this._nbMembersFunc(input);
         this._lastActivityDayFunc(input);
         this.recruitment = new GuildRecruitmentInformation();
         this.recruitment.deserialize(input);
         this._nbPendingApplyFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_GuildFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._leaderIdFunc);
         tree.addChild(this._nbMembersFunc);
         tree.addChild(this._lastActivityDayFunc);
         this._recruitmenttree = tree.addChild(this._recruitmenttreeFunc);
         tree.addChild(this._nbPendingApplyFunc);
      }
      
      private function _leaderIdFunc(input:ICustomDataInput) : void
      {
         this.leaderId = input.readVarUhLong();
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of GuildFactSheetInformations.leaderId.");
         }
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readVarUhShort();
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of GuildFactSheetInformations.nbMembers.");
         }
      }
      
      private function _lastActivityDayFunc(input:ICustomDataInput) : void
      {
         this.lastActivityDay = input.readShort();
         if(this.lastActivityDay < 0)
         {
            throw new Error("Forbidden value (" + this.lastActivityDay + ") on element of GuildFactSheetInformations.lastActivityDay.");
         }
      }
      
      private function _recruitmenttreeFunc(input:ICustomDataInput) : void
      {
         this.recruitment = new GuildRecruitmentInformation();
         this.recruitment.deserializeAsync(this._recruitmenttree);
      }
      
      private function _nbPendingApplyFunc(input:ICustomDataInput) : void
      {
         this.nbPendingApply = input.readInt();
         if(this.nbPendingApply < 0)
         {
            throw new Error("Forbidden value (" + this.nbPendingApply + ") on element of GuildFactSheetInformations.nbPendingApply.");
         }
      }
   }
}
