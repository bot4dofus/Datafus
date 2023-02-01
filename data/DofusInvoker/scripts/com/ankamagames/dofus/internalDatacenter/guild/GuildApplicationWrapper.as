package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.dofus.internalDatacenter.people.GuildApplicationPlayerDataWrapper;
   import com.ankamagames.dofus.network.types.game.guild.application.ApplicationPlayerInformation;
   import com.ankamagames.dofus.network.types.game.guild.application.GuildApplicationInformation;
   
   public class GuildApplicationWrapper
   {
       
      
      public var playerData:GuildApplicationPlayerDataWrapper = null;
      
      public var text:String = null;
      
      public var creationDate:Number = 0;
      
      public function GuildApplicationWrapper(playerData:GuildApplicationPlayerDataWrapper = null, text:String = null, editDate:Number = 0)
      {
         super();
         this.playerData = playerData;
         this.text = text;
         this.creationDate = editDate;
      }
      
      public static function wrap(info:GuildApplicationInformation) : GuildApplicationWrapper
      {
         var playerData:GuildApplicationPlayerDataWrapper = GuildApplicationPlayerDataWrapper.wrap(info.playerInfo);
         return new GuildApplicationWrapper(playerData,info.applyText,info.creationDate);
      }
      
      public function get playerId() : Number
      {
         return this.playerData !== null ? Number(this.playerData.playerId) : Number(0);
      }
      
      public function unwrap() : GuildApplicationInformation
      {
         var registerInfo:ApplicationPlayerInformation = new ApplicationPlayerInformation();
         if(this.playerData === null)
         {
            registerInfo = new ApplicationPlayerInformation();
         }
         else
         {
            registerInfo = this.playerData.unwrap();
         }
         var message:GuildApplicationInformation = new GuildApplicationInformation();
         message.initGuildApplicationInformation(registerInfo,this.text !== null ? this.text : "",this.creationDate);
         return message;
      }
   }
}
