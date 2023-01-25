package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceInformation;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceOnlineInformation;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ContactWrapper extends SocialCharacterWrapper implements IDataCenter
   {
       
      
      public var moodSmileyId:int = 0;
      
      public var statusId:uint = 0;
      
      public var awayMessage:String = "";
      
      public var realGuildName:String = "";
      
      public var guildId:int = 0;
      
      public var guildUpEmblem:EmblemWrapper = null;
      
      public var guildBackEmblem:EmblemWrapper = null;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public var havenbagShared:Boolean = false;
      
      public function ContactWrapper(o:AcquaintanceInformation)
      {
         super(o.accountTag.nickname,o.accountTag.tagNumber,o.accountId);
         e_category = SocialCharacterCategoryEnum.CATEGORY_CONTACT;
         state = o.playerState;
         if(o is AcquaintanceOnlineInformation)
         {
            playerName = AcquaintanceOnlineInformation(o).playerName;
            playerId = AcquaintanceOnlineInformation(o).playerId;
            this.moodSmileyId = AcquaintanceOnlineInformation(o).moodSmileyId;
            this.statusId = AcquaintanceOnlineInformation(o).status.statusId;
            if(AcquaintanceOnlineInformation(o).status is PlayerStatusExtended)
            {
               this.awayMessage = PlayerStatusExtended(AcquaintanceOnlineInformation(o).status).message;
            }
            online = true;
         }
      }
   }
}
