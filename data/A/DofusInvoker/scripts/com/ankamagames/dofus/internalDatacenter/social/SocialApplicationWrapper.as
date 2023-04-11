package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.internalDatacenter.people.SocialApplicationPlayerDataWrapper;
   import com.ankamagames.dofus.network.types.game.social.application.ApplicationPlayerInformation;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   
   public class SocialApplicationWrapper
   {
       
      
      public var playerData:SocialApplicationPlayerDataWrapper = null;
      
      public var text:String = null;
      
      public var creationDate:Number = 0;
      
      public function SocialApplicationWrapper(playerData:SocialApplicationPlayerDataWrapper = null, text:String = null, editDate:Number = 0)
      {
         super();
         this.playerData = playerData;
         this.text = text;
         this.creationDate = editDate;
      }
      
      public static function wrap(info:SocialApplicationInformation) : SocialApplicationWrapper
      {
         var playerData:SocialApplicationPlayerDataWrapper = SocialApplicationPlayerDataWrapper.wrap(info.playerInfo);
         return new SocialApplicationWrapper(playerData,info.applyText,info.creationDate);
      }
      
      public function get playerId() : Number
      {
         return this.playerData !== null ? Number(this.playerData.playerId) : Number(0);
      }
      
      public function unwrap() : SocialApplicationInformation
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
         var message:SocialApplicationInformation = new SocialApplicationInformation();
         message.initSocialApplicationInformation(registerInfo,this.text !== null ? this.text : "",this.creationDate);
         return message;
      }
   }
}
