package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.guild.application.ApplicationPlayerInformation;
   
   public class GuildApplicationPlayerDataWrapper
   {
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = null;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public var accountId:uint = 0;
      
      public var accountTag:String = null;
      
      public var accountName:String = null;
      
      public var statusId:uint = 0;
      
      public var statusMessage:String = null;
      
      public function GuildApplicationPlayerDataWrapper(playerId:Number = 0, playerName:String = null, breed:int = 0, sex:Boolean = false, level:uint = 0, accountId:uint = 0, accountTag:String = null, accountName:String = null, statusId:uint = 0, statusMessage:String = null)
      {
         super();
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         this.level = level;
         this.accountId = accountId;
         this.accountTag = accountTag;
         this.accountName = accountName;
         this.statusId = statusId;
         this.statusMessage = statusMessage;
      }
      
      public static function wrap(info:ApplicationPlayerInformation) : GuildApplicationPlayerDataWrapper
      {
         return new GuildApplicationPlayerDataWrapper(info.playerId,info.playerName,info.breed,info.sex,info.level,info.accountId,info.accountTag,info.accountNickname,info.status.statusId,info.status is PlayerStatusExtended ? (info.status as PlayerStatusExtended).message : null);
      }
      
      public function unwrap() : ApplicationPlayerInformation
      {
         var status:PlayerStatus = null;
         var message:ApplicationPlayerInformation = new ApplicationPlayerInformation();
         if(this.statusMessage)
         {
            status = new PlayerStatusExtended();
            (status as PlayerStatusExtended).initPlayerStatusExtended(this.statusId,this.statusMessage);
         }
         else
         {
            status = new PlayerStatus();
            status.initPlayerStatus(this.statusId);
         }
         message.initApplicationPlayerInformation(this.playerId,this.playerName !== null ? this.playerName : "",this.breed,this.sex,this.level,this.accountId,this.accountTag !== null ? this.accountTag : "",this.accountName !== null ? this.accountName : "",status);
         return message;
      }
   }
}
