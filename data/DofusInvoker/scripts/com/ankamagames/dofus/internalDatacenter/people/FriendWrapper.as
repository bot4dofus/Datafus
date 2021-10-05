package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FriendWrapper extends SocialCharacterWrapper implements IDataCenter
   {
       
      
      private var _item:FriendInformations;
      
      public var moodSmileyId:int = 0;
      
      public var realGuildName:String = "";
      
      public var guildId:int = 0;
      
      public var guildUpEmblem:EmblemWrapper;
      
      public var guildBackEmblem:EmblemWrapper;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public var statusId:uint = 0;
      
      public var awayMessage:String = "";
      
      public var havenbagShared:Boolean;
      
      public function FriendWrapper(o:FriendInformations)
      {
         super(o.accountTag.nickname,o.accountTag.tagNumber,o.accountId);
         e_category = SocialCharacterCategoryEnum.CATEGORY_FRIEND;
         this._item = o;
         state = o.playerState;
         lastConnection = o.lastConnection;
         achievementPoints = o.achievementPoints;
         this.leagueId = o.leagueId;
         this.ladderPosition = o.ladderPosition;
         if(o is FriendOnlineInformations)
         {
            playerName = FriendOnlineInformations(o).playerName;
            playerId = FriendOnlineInformations(o).playerId;
            level = FriendOnlineInformations(o).level;
            alignmentSide = FriendOnlineInformations(o).alignmentSide;
            breed = FriendOnlineInformations(o).breed;
            sex = !!FriendOnlineInformations(o).sex ? uint(1) : uint(0);
            if(FriendOnlineInformations(o).guildInfo.guildName == "#NONAME#")
            {
               guildName = I18n.getUiText("ui.guild.noName");
            }
            else
            {
               guildName = FriendOnlineInformations(o).guildInfo.guildName;
            }
            this.realGuildName = FriendOnlineInformations(o).guildInfo.guildName;
            this.guildId = FriendOnlineInformations(o).guildInfo.guildId;
            if(FriendOnlineInformations(o).guildInfo is GuildInformations && GuildInformations(FriendOnlineInformations(o).guildInfo).guildEmblem)
            {
               this.guildBackEmblem = EmblemWrapper.fromNetwork(GuildInformations(FriendOnlineInformations(o).guildInfo).guildEmblem,true);
               this.guildUpEmblem = EmblemWrapper.fromNetwork(GuildInformations(FriendOnlineInformations(o).guildInfo).guildEmblem,false);
            }
            this.moodSmileyId = FriendOnlineInformations(o).moodSmileyId;
            this.statusId = FriendOnlineInformations(o).status.statusId;
            if(FriendOnlineInformations(o).status is PlayerStatusExtended)
            {
               this.awayMessage = PlayerStatusExtended(FriendOnlineInformations(o).status).message;
            }
            online = true;
            this.havenbagShared = FriendOnlineInformations(o).havenBagShared;
         }
      }
   }
}
